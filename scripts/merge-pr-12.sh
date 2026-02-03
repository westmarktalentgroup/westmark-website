#!/bin/bash
# Merge PR #12 (Restore Westmark-logo.png) via GitHub API - proper deployment completion
set -e
REPO="westmarktalentgroup/westmark-website"
PR_NUMBER=12

if [ -z "$GITHUB_TOKEN" ]; then
  echo "❌ GITHUB_TOKEN not set. Cannot merge PR."
  echo "   Merge manually: https://github.com/$REPO/pull/$PR_NUMBER"
  exit 1
fi

# Branch protection requires: approval from someone other than last pusher + Westmark Production Protection check.
# This script merges when those are satisfied; otherwise merge via GitHub UI.

echo "🔄 Merging PR #$PR_NUMBER..."
RESPONSE=$(curl -s -w "\n%{http_code}" -X PUT \
  -H "Authorization: token $GITHUB_TOKEN" \
  -H "Accept: application/vnd.github.v3+json" \
  "https://api.github.com/repos/$REPO/pulls/$PR_NUMBER/merge" \
  -d '{
    "commit_title": "Deploy: Restore Westmark-logo.png for email signature",
    "commit_message": "Restore /Westmark-logo.png at site root for email signature use. Deployed via scripts/deploy.sh per project protocol.",
    "merge_method": "squash"
  }')

HTTP_CODE=$(echo "$RESPONSE" | tail -1)
BODY=$(echo "$RESPONSE" | sed '$d')

if [ "$HTTP_CODE" != "200" ]; then
  echo "❌ Merge failed (HTTP $HTTP_CODE)"
  echo "$BODY" | head -30
  exit 1
fi

echo "✅ PR #$PR_NUMBER merged successfully."
echo "🌐 Westmark-logo.png will be live after GitHub Pages deploys (1–2 min): https://www.westmarktalentgroup.com/Westmark-logo.png"
