#!/bin/bash

# GitHub Token Setup Script
# Sets up GitHub token for automated deployments

echo "🔑 GitHub Token Setup"
echo "===================="
echo ""

# Check if token is already set
if [ ! -z "$GITHUB_TOKEN" ]; then
    echo "✅ GITHUB_TOKEN is already set"
    echo "🔍 Testing token..."
    
    # Test the token
    RESPONSE=$(curl -s -H "Authorization: token $GITHUB_TOKEN" https://api.github.com/user)
    if echo "$RESPONSE" | grep -q '"login"'; then
        echo "✅ Token is valid and working!"
        echo "🚀 Ready for automated deployments"
        exit 0
    else
        echo "❌ Token appears to be invalid"
        echo "🔄 Please set a new token"
    fi
fi

echo "📋 Please follow these steps:"
echo ""
echo "1. Go to: https://github.com/settings/tokens"
echo "2. Click 'Generate new token (classic)'"
echo "3. Set Note: 'Westmark Website Auto-Deploy'"
echo "4. Set Expiration: 'No expiration' or '90 days'"
echo "5. Check scopes: ✅ repo, ✅ workflow"
echo "6. Click 'Generate token'"
echo "7. Copy the token (starts with 'ghp_' or 'github_pat_')"
echo ""
echo "⚠️  IMPORTANT: You won't see the token again after closing the page!"
echo ""

# Prompt for token
read -p "🔑 Paste your GitHub token here: " TOKEN

if [ -z "$TOKEN" ]; then
    echo "❌ No token provided. Exiting."
    exit 1
fi

# Test the token
echo "🔍 Testing token..."
RESPONSE=$(curl -s -H "Authorization: token $TOKEN" https://api.github.com/user)

if echo "$RESPONSE" | grep -q '"login"'; then
    echo "✅ Token is valid!"
    
    # Set environment variable for current session
    export GITHUB_TOKEN="$TOKEN"
    
    # Add to shell profile for permanent setup
    SHELL_PROFILE=""
    if [ -f "$HOME/.zshrc" ]; then
        SHELL_PROFILE="$HOME/.zshrc"
    elif [ -f "$HOME/.bash_profile" ]; then
        SHELL_PROFILE="$HOME/.bash_profile"
    elif [ -f "$HOME/.bashrc" ]; then
        SHELL_PROFILE="$HOME/.bashrc"
    fi
    
    if [ ! -z "$SHELL_PROFILE" ]; then
        echo "💾 Adding token to $SHELL_PROFILE for permanent setup..."
        
        # Remove old token if exists
        grep -v "GITHUB_TOKEN" "$SHELL_PROFILE" > "$SHELL_PROFILE.tmp" 2>/dev/null || true
        mv "$SHELL_PROFILE.tmp" "$SHELL_PROFILE" 2>/dev/null || true
        
        # Add new token
        echo "" >> "$SHELL_PROFILE"
        echo "# GitHub Token for Westmark Website Auto-Deploy" >> "$SHELL_PROFILE"
        echo "export GITHUB_TOKEN=\"$TOKEN\"" >> "$SHELL_PROFILE"
        
        echo "✅ Token saved to $SHELL_PROFILE"
        echo "🔄 Restart your terminal or run: source $SHELL_PROFILE"
    else
        echo "⚠️  Could not find shell profile. Token is set for current session only."
        echo "💡 To make permanent, add this to your shell profile:"
        echo "   export GITHUB_TOKEN=\"$TOKEN\""
    fi
    
    echo ""
    echo "🎉 Setup Complete!"
    echo "=================="
    echo "✅ GitHub token is set and working"
    echo "✅ Ready for automated deployments"
    echo ""
    echo "🚀 Test it now:"
    echo "   ./scripts/auto-pr-merge.sh"
    
else
    echo "❌ Token is invalid or has insufficient permissions"
    echo "🔍 Response: $RESPONSE"
    echo ""
    echo "💡 Make sure you:"
    echo "   - Copied the token correctly"
    echo "   - Selected 'repo' and 'workflow' scopes"
    echo "   - The token hasn't expired"
    exit 1
fi
