#!/bin/bash

# Quick Test Script for Touch ID Setup
# Run this after storing your GitHub token

echo "🧪 Quick Touch ID Test"
echo "====================="
echo ""

# Test Touch ID authentication
echo "Testing Touch ID authentication..."
if ./scripts/cursor-touchid-auth.sh >/dev/null 2>&1; then
    echo "✅ Touch ID authentication successful!"
    echo ""
    echo "🎉 Setup Complete!"
    echo "================="
    echo ""
    echo "You can now deploy with Touch ID using:"
    echo "  ./scripts/cursor-deploy.sh"
    echo ""
    echo "Touch ID will prompt you automatically!"
else
    echo "❌ Touch ID authentication failed"
    echo ""
    echo "Please make sure you've:"
    echo "1. Created a GitHub Personal Access Token"
    echo "2. Stored it in Keychain with the security command"
    echo "3. Authenticated with Touch ID when prompted"
    echo ""
    echo "Run this test again after completing the setup."
fi
