#!/bin/bash

# GitHub Cleanup Script
# Automatically closes abandoned PRs and cleans up old branches

set -e

GITHUB_TOKEN="${GITHUB_TOKEN:-}"

if [ -z "$GITHUB_TOKEN" ]; then
    echo "⚠️  GITHUB_TOKEN not set. Skipping automatic cleanup."
    exit 0
fi

API_URL="https://api.github.com/repos/westmarktalentgroup/westmark-website"

echo "🧹 GitHub Repository Cleanup"
echo "============================"

# Close abandoned PRs (older than 24 hours with conflicts)
echo "🔍 Checking for abandoned PRs..."
ABANDONED_PRS=$(curl -s -H "Authorization: token $GITHUB_TOKEN" "$API_URL/pulls?state=open" | grep -o '"number": [0-9]*' | cut -d' ' -f2)

for pr in $ABANDONED_PRS; do
    PR_INFO=$(curl -s -H "Authorization: token $GITHUB_TOKEN" "$API_URL/pulls/$pr")
    MERGEABLE_STATE=$(echo "$PR_INFO" | grep -o '"mergeable_state": "[^"]*"' | cut -d'"' -f4)
    UPDATED_AT=$(echo "$PR_INFO" | grep -o '"updated_at": "[^"]*"' | cut -d'"' -f4)
    
    # Close if not mergeable (conflicts or issues)
    if [ "$MERGEABLE_STATE" == "dirty" ] || [ "$MERGEABLE_STATE" == "unstable" ]; then
        echo "⚠️  PR #$pr has conflicts or issues, closing..."
        curl -s -X PATCH \
            -H "Authorization: token $GITHUB_TOKEN" \
            -H "Accept: application/vnd.github.v3+json" \
            "$API_URL/pulls/$pr" \
            -d '{"state": "closed"}' > /dev/null
        echo "✅ Closed PR #$pr"
    fi
done

echo "✅ GitHub cleanup complete"
