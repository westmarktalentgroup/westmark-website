#!/bin/bash
# Create PR for deploy-20260203-restore-westmark-logo (Westmark-logo.png restore)
set -e
BRANCH="deploy-20260203-restore-westmark-logo"
REPO="westmarktalentgroup/westmark-website"

if [ -z "$GITHUB_TOKEN" ]; then
  echo "❌ GITHUB_TOKEN not set. Set it and re-run, or create the PR manually:"
  echo "   https://github.com/$REPO/compare/main...$BRANCH"
  exit 1
fi

echo "📤 Creating Pull Request..."
RESPONSE=$(curl -s -w "\n%{http_code}" -X POST \
  -H "Authorization: token $GITHUB_TOKEN" \
  -H "Accept: application/vnd.github.v3+json" \
  "https://api.github.com/repos/$REPO/pulls" \
  -d "{
    \"title\": \"Deploy: Restore Westmark-logo.png for email signature\",
    \"head\": \"$BRANCH\",
    \"base\": \"main\",
    \"body\": \"## Restore Westmark-logo.png\\n\\n- Restores \`/Westmark-logo.png\` at site root for email signature use.\\n- Added to \`development/\` and \`deploy.sh\` copy step per project protocol.\\n- No other code changes.\\n\\n**Deployed via \`./scripts/deploy.sh\` (development → production).**\"
  }")

HTTP_CODE=$(echo "$RESPONSE" | tail -1)
BODY=$(echo "$RESPONSE" | sed '$d')
# Parse PR number (GitHub JSON may have "number": 12 with space)
PR_NUMBER=$(echo "$BODY" | grep -o '"number"[[:space:]]*:[[:space:]]*[0-9]*' | grep -o '[0-9]*' | head -1)

if [ -z "$PR_NUMBER" ] || [ "$HTTP_CODE" != "201" ]; then
  echo "❌ Failed to create PR (HTTP $HTTP_CODE)"
  echo "$BODY" | head -20
  exit 1
fi

echo "✅ Pull Request created: #$PR_NUMBER"
echo "🔗 https://github.com/$REPO/pull/$PR_NUMBER"
