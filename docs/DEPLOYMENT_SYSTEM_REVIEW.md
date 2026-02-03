# Deployment System Review — Westmark Talent Group

**Review date:** February 2026  
**Scope:** Deployment workflow, scripts, GitHub Actions, documentation, and protection layers.

**Fixes applied (post-review):** Block-direct-pushes job removed; all doc script paths updated to `./scripts/deploy.sh`; rollback and Deployment Commands sections updated for PR workflow; production-protection "Deploy to GitHub Pages" step removed (deploy.yml handles deploy on push); deploy.sh hardened (LOAD_TIME default, index.html check, rebase/cleanup comments); protection-system.sh header added; workflow vs script naming noted.

---

## 1. Executive Summary

The deployment system enforces a **development → deploy script → PR → merge** flow with multiple protection layers. It is well-intentioned and documented, but has **critical workflow bugs**, **documentation inconsistencies**, and **redundant or conflicting checks** that can block valid deploys or mislead contributors.

| Area | Status | Priority |
|------|--------|----------|
| Production-protection workflow (block on push) | 🔴 Fails on every PR merge | Critical |
| Documentation (script paths, rollback) | 🟡 Inconsistent | High |
| deploy.sh (backup ref, branch cleanup) | 🟡 Minor bugs / clarity | Medium |
| Script paths (deploy.sh location) | 🟡 Wrong in several docs | High |
| Redundant workflows / checks | 🟡 CI vs production-protection | Medium |
| development/ gitignored vs required | 🟢 Resolved for deploy-* | — |

---

## 2. Architecture Overview

### 2.1 Intended flow

1. **Develop** in `development/` (gitignored; not in repo).
2. **Validate** with `./scripts/protection-system.sh` (run from repo root; script `cd`s into `development/`).
3. **Deploy** with `./scripts/deploy.sh`: copies `development/` → root, backs up, commits, creates `deploy-*` branch, pushes.
4. **Open PR** from `deploy-*` to `main`.
5. **Merge** on GitHub (branch protection: PR + approval + status checks).
6. **GitHub Pages** deploys from `main` (via `deploy.yml` on push).

### 2.2 Protection layers

- **Local:** Pre-push hook blocks `git push origin main`.
- **Local:** `deploy.sh` runs protection-system + AI circumvention; only then copies and commits.
- **Remote:** Branch protection requires PR, approval, and “Westmark Production Protection” status.
- **Remote:** `production-protection.yml` validates PRs and (currently) blocks all pushes to `main`.

---

## 3. Critical Issues

### 3.1 🔴 Production-protection workflow fails on every PR merge

**File:** `.github/workflows/production-protection.yml`

**Behavior:**

- `block-direct-pushes` runs on **every** `push` to `main` and **exits 1**.
- Merging a PR creates a **push** to `main`, so this job runs and **fails**.
- Result: After every successful merge, the “Westmark Production Protection” workflow run is **red**, even though the merge and deploy are valid.

**Cause:** The workflow cannot distinguish “push from merged PR” vs “direct push”. Branch protection already blocks direct pushes to `main`, so the job is redundant and harmful.

**Recommendation:**

- **Option A (recommended):** Remove the `block-direct-pushes` job. Rely on GitHub branch protection to block direct pushes.
- **Option B:** Stop triggering on `push` and only run on `pull_request`; keep validation for PRs only.

**Example change (Option A):** Remove or comment out the entire `block-direct-pushes` job so the workflow only runs for `pull_request` and no longer fails merges.

---

### 3.2 🟡 “Deploy to GitHub Pages” in production-protection never runs

**File:** `.github/workflows/production-protection.yml`

```yaml
- name: Deploy to GitHub Pages (if PR is merged)
  if: github.event.action == 'closed' && github.event.pull_request.merged == true
  uses: peaceiris/actions-gh-pages@v3
```

This step runs in the **pull_request** workflow. When a PR is merged, GitHub sends `pull_request` with `action: closed` and `merged: true`, but the **default checkout** for that event is the **PR branch**, not `main`. So this step is misleading: deployment is already done by `deploy.yml` on **push** to `main`. Either remove this step or document that deployment is handled by `deploy.yml` and this is legacy/unused.

---

## 4. Documentation Inconsistencies

### 4.1 Deploy script location

- **Actual path:** `scripts/deploy.sh` (run from repo root: `./scripts/deploy.sh`).
- **Wrong in docs:**
  - `DEPLOYMENT_GUIDE.md` § “Single Deployment Script”: “**Location**: Root directory (`/deploy.sh`)”.
  - `AI_AGENT_WORKFLOW_RULES.md`: “**File Location**: `/Code/deploy.sh`”, “Usage: `./deploy.sh`”.
  - `PRODUCTION_WARNING.md`: “Run `./deploy.sh`”.
  - `DEPLOYMENT_GUIDE.md` § “Deployment Commands” and § “Rollback”: show `git push origin main` and manual `cp`/`git checkout` without mentioning branch protection or PRs.

**Recommendation:** Global find/replace and doc pass: all references to “deploy” script should say `./scripts/deploy.sh` and “run from repository root”. Remove or rewrite any “push to main” / “rollback by push” instructions to match branch protection (e.g. “open a revert PR” or “use rollback script then deploy branch + PR”).

### 4.2 Rollback procedure

- **DEPLOYMENT_GUIDE.md** “Quick Rollback Process” uses `git checkout HEAD~1 ...` and `git push origin main`.
- **Reality:** Direct push to `main` is blocked; rollback must go through a branch + PR or a dedicated rollback flow that creates a deploy branch.

**Recommendation:** Update rollback section to: (1) use `scripts/rollback.sh` if applicable, and (2) describe “revert via PR” (revert commit on a branch, open PR, merge) so it aligns with branch protection.

### 4.3 Manual “Deployment Commands” section

- **DEPLOYMENT_GUIDE.md** still shows manual `cp development/...` and “Commit and push to GitHub Pages” with `git push origin main`.
- This contradicts the rest of the guide and AI workflow rules (use `./scripts/deploy.sh`, no direct push).

**Recommendation:** Remove or replace with “For reference only; always use `./scripts/deploy.sh` and merge via PR.”

---

## 5. deploy.sh — Robustness and Clarity

### 5.1 Backup reference when nothing is committed

When `git status --porcelain` is empty, the script skips the block that commits and creates the deploy branch but still runs:

```bash
echo "💡 Backup available in: $BACKUP_DIR"
```

`BACKUP_DIR` is set earlier, so this is **correct**. No bug here.

### 5.2 Branch cleanup logic

```bash
OLD_DEPLOY_BRANCHES=$(git branch -a | grep "deploy-" | sed 's/remotes\/origin\///' | sort -u | head -n -5)
```

- **Intent:** Keep the 5 most recent deploy branches, delete older ones.
- **Behavior:** `sort -u` + `head -n -5` keeps the last 5 lines after sort; order depends on `sort` (lexicographic), not date. So “last 5” is by name, not by creation time. If branch names include timestamps (e.g. `deploy-20260203-183230`), this is roughly “keep 5 newest by name”.
- **Suggestion:** Document that cleanup is “by branch name (timestamp)” or switch to explicit date ordering if you need true “last 5 by date”.

### 5.3 Rebase after commit

```bash
git rebase origin/main 2>/dev/null || true
```

Rebase is run **after** committing on `main`. If rebase fails, it’s ignored (`|| true`). If it succeeds, history is rewritten and the subsequent `checkout -b "$DEPLOY_BRANCH"` is from the rebased commit. This is workable but worth a short comment: “Rebase so deploy branch is based on latest main.”

### 5.4 Copy globs and missing files

- `cp development/*.html ./` — If `development/` has no `.html` files, the glob fails and, with `set -e`, the script would exit. Unlikely if structure is kept, but a check or “no HTML” path would harden.
- Same idea for `*.json`, `*.txt`, etc.: if any glob expands to nothing, `cp` can fail.

**Recommendation:** Add a guard (e.g. `shopt -s nullglob` or test that required files exist) before the first `cp` from `development/`.

### 5.5 Performance server and LOAD_TIME

The script starts a local server, then may run:

```bash
./scripts/deployment-notifications.sh success "$BACKUP_DIR" "$LOAD_TIME"
```

If the `curl` block didn’t run (e.g. `curl` missing), `LOAD_TIME` is unset and the notification script may see an empty second argument. Prefer: `LOAD_TIME=${LOAD_TIME:-0}` or similar before calling the notification script.

---

## 6. protection-system.sh

- **Run context:** Invoked as `./scripts/protection-system.sh` from repo root; script does `cd development` and then runs validations. So all paths inside the script are relative to `development/`.
- **Recent fix:** Integer expression errors from `grep -c` were addressed with `head -1` and `${VAR:-0}`.
- **Dependency:** Requires `development/` to exist. Failing that, deploy would be blocked; this is by design and matches the “development-first” rule.

**Suggestion:** In the script header, state explicitly: “Must be run from repository root; script changes into development/.”

---

## 7. AI Circumvention Protection

- **Required scripts:** `scripts/protection-system.sh`, `scripts/ai-agent-workflow-enforcer.sh`, `scripts/architectural-enforcer.sh`, `scripts/production-protection.sh`. If any are missing, deploy is blocked.
- **production-protection.sh:** If this is a **local** script (e.g. in `scripts/`), name clashes with the **workflow** “Westmark Production Protection” and can confuse. Consider renaming the script (e.g. `scripts/local-production-guard.sh`) or documenting the difference clearly.
- **DEPLOYMENT_IN_PROGRESS:** Set by `deploy.sh` before calling the circumvention script; workflow enforcement correctly requires this so only the deploy script can “approve” a run.

---

## 8. GitHub Workflows — Redundancy and Naming

### 8.1 Multiple workflows on same events

- **ci.yml:** On `pull_request` and `push` to `main` — code quality, CSS, mobile, security.
- **deploy.yml:** On `pull_request` and `push` to `main` — “test” job always; deploy job only on push to `main`.
- **production-protection.yml:** On `pull_request` and `push` to `main` — validation on PR; block on push.

So for every PR and every push you run several workflows. Some overlap (e.g. security checks in ci vs deploy). Not wrong, but you could consolidate “test” and “CI” into one workflow and keep “production-protection” for policy and “deploy” for publish.

### 8.2 Status check name

Branch protection requires the check “Westmark Production Protection”. That name comes from the **workflow** `name:` in `.github/workflows/production-protection.yml`. The script `scripts/production-protection.sh` is a different thing (local guard); the workflow is what provides the required status check. If you remove or rename the workflow, update branch protection rules accordingly.

---

## 9. Pre-push hook

- **Behavior:** Blocks any push to `main` and tells the user to use `./scripts/deploy.sh`.
- **Correct:** Aligns with “no direct push to main”. Path in message could say `./scripts/deploy.sh` explicitly if not already.

---

## 10. development/ and .gitignore

- **development/** is in `.gitignore`, so it never enters the repo. Deploy branches therefore only contain the **result** of copying `development/` to root (plus scripts, etc.), not `development/` itself.
- **production-protection.yml** was updated so that for branches named `deploy-*` it does **not** require `development/` and allows production file changes. This matches how deploy branches are created and avoids false failures. No further change needed for this.

---

## 11. Recommendations Summary

### Critical (do first)

1. **Fix production-protection workflow:** Remove or disable the `block-direct-pushes` job so that merging a PR no longer fails the “Westmark Production Protection” workflow. Rely on branch protection to block direct pushes.

### High priority

2. **Docs: script path:** Replace every reference to `./deploy.sh` or “root `/deploy.sh`” with `./scripts/deploy.sh` (and “run from repo root”) in DEPLOYMENT_GUIDE, AI_AGENT_WORKFLOW_RULES, PRODUCTION_WARNING, and any other docs.
3. **Docs: rollback:** Rewrite “Quick Rollback” to use `scripts/rollback.sh` and/or “revert via PR” and remove `git push origin main` as the primary rollback method.
4. **Docs: “Deployment Commands”:** Remove or reframe the manual `cp` + `git push origin main` section so it doesn’t contradict the PR-based flow.

### Medium priority

5. **production-protection.yml:** Remove or document the “Deploy to GitHub Pages” step (deployment is handled by `deploy.yml` on push to `main`).
6. **deploy.sh:** Add a short comment above the rebase line; consider `LOAD_TIME=${LOAD_TIME:-0}` before calling deployment-notifications; optionally harden `development/` copy (nullglob or required-file checks).
7. **protection-system.sh:** Add a one-line header note: “Run from repository root; script changes into development/.”
8. **Naming:** Differentiate the script `production-protection.sh` from the workflow “Westmark Production Protection” in docs or by renaming the script.

### Low priority

9. **Branch cleanup:** Document that “keep last 5” is by branch name (timestamp) or refine to date-based if needed.
10. **Workflow consolidation:** Optionally merge CI and “test” steps into one workflow to reduce duplication and noise.

---

## 12. What’s Working Well

- **Single deploy path:** One script (`scripts/deploy.sh`) for “development → production copy + backup + branch + push.”
- **Branch protection:** PR + approval + status check enforce the desired flow.
- **Pre-push hook:** Prevents accidental direct push to `main` and points to the deploy script.
- **Deploy-branch handling:** Production-protection correctly treats `deploy-*` branches as allowed to change production and not require `development/` in the repo.
- **Documentation:** DEPLOYMENT_GUIDE and AI_AGENT_WORKFLOW_RULES give a clear mental model; fixing paths and rollback will make them accurate.
- **Backups and rollback script:** Backups and `rollback.sh` exist; tying rollback into the PR-based process in the docs will complete the story.

---

*End of deployment system review.*
