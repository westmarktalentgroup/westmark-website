#!/bin/bash

# Auto-activation script that runs automatically
# This script activates protection without manual intervention

echo "🚀 AUTO-ACTIVATING DOCUMENTATION PROTECTION"
echo "==========================================="

# Check if protection is already active
if [ -f "/tmp/documentation-protection-active" ]; then
    echo "✅ Documentation protection already active"
    exit 0
fi

# Auto-install git hooks
if [ -d "../.git/hooks" ]; then
    cp pre-commit-hook ../.git/hooks/pre-commit 2>/dev/null
    chmod +x ../.git/hooks/pre-commit 2>/dev/null
    echo "✅ Git hooks auto-installed"
fi

# Auto-activate Cursor rules
cp .cursorrules ../ 2>/dev/null
echo "✅ Cursor AI rules auto-activated"

# Auto-setup CI/CD
mkdir -p ../.github/workflows 2>/dev/null
cp .github/workflows/documentation-check.yml ../.github/workflows/ 2>/dev/null
echo "✅ CI/CD protection auto-configured"

# Create activation marker
touch /tmp/documentation-protection-active
echo "✅ Protection auto-activation completed"

echo "🛡️  DOCUMENTATION PROTECTION AUTO-ACTIVATED"
