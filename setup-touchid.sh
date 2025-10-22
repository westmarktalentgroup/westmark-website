#!/bin/bash

# Westmark Cursor Touch ID Setup Helper
# This script helps you set up the Touch ID deployment system

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 Westmark Cursor Touch ID Setup${NC}"
echo -e "${BLUE}=================================${NC}"
echo ""

# Check if running in Cursor
if [[ "$VSCODE_PID" == "" ]] && [[ -z "$CURSOR_USER_DATA_DIR" ]]; then
    echo -e "${RED}❌ This script must be run from within Cursor${NC}"
    echo -e "${YELLOW}💡 Please run this from Cursor's integrated terminal${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Running in Cursor environment${NC}"

# Check Touch ID
if [[ -f "/usr/bin/bioutil" ]] && /usr/bin/bioutil -r >/dev/null 2>&1; then
    echo -e "${GREEN}✅ Touch ID available${NC}"
elif [[ -d "/System/Library/PrivateFrameworks/BiometricKit.framework" ]]; then
    echo -e "${GREEN}✅ Touch ID available${NC}"
else
    echo -e "${RED}❌ Touch ID not available on this device${NC}"
    exit 1
fi

echo ""
echo -e "${BLUE}📋 Setup Steps:${NC}"
echo -e "${BLUE}==============${NC}"
echo ""

echo -e "${YELLOW}Step 1: Create GitHub Personal Access Token${NC}"
echo "1. Go to: https://github.com/settings/tokens"
echo "2. Click 'Generate new token (classic)'"
echo "3. Set expiration to 90 days"
echo "4. Select scope: 'repo' (full control)"
echo "5. Click 'Generate token'"
echo "6. Copy the token (starts with 'ghp_')"
echo ""

read -p "Press Enter when you have your GitHub token ready..."

echo ""
echo -e "${YELLOW}Step 2: Store Token in Keychain with Touch ID${NC}"
echo "Enter your GitHub token (it will be hidden for security):"
read -s github_token

if [[ -z "$github_token" ]]; then
    echo -e "${RED}❌ No token provided${NC}"
    exit 1
fi

echo ""
echo -e "${BLUE}🔐 Storing token in Keychain with Touch ID...${NC}"
echo -e "${YELLOW}Touch ID authentication will be required...${NC}"

# Store the token in Keychain
if security add-generic-password \
    -a "westmark-cursor-deployment" \
    -s "github-token" \
    -w "$github_token" \
    -T "/Applications/Cursor.app" \
    -U 2>/dev/null; then
    echo -e "${GREEN}✅ Token stored successfully in Keychain${NC}"
else
    echo -e "${RED}❌ Failed to store token in Keychain${NC}"
    echo -e "${YELLOW}💡 Make sure Touch ID authentication was successful${NC}"
    exit 1
fi

echo ""
echo -e "${YELLOW}Step 3: Verify Token with GitHub${NC}"
echo -e "${BLUE}🔍 Verifying GitHub authentication...${NC}"

# Verify the token
response=$(curl -s -H "Authorization: token $github_token" https://api.github.com/user 2>/dev/null)

if echo "$response" | grep -q '"login"'; then
    username=$(echo "$response" | grep '"login"' | cut -d'"' -f4)
    echo -e "${GREEN}✅ GitHub authentication verified for user: $username${NC}"
else
    echo -e "${RED}❌ Invalid GitHub token${NC}"
    echo -e "${YELLOW}💡 Please check your token and try again${NC}"
    exit 1
fi

echo ""
echo -e "${YELLOW}Step 4: Test Touch ID Authentication${NC}"
echo -e "${BLUE}🧪 Testing authentication system...${NC}"

# Test the authentication
if ./scripts/cursor-touchid-auth.sh >/dev/null 2>&1; then
    echo -e "${GREEN}✅ Touch ID authentication test successful${NC}"
else
    echo -e "${RED}❌ Touch ID authentication test failed${NC}"
    exit 1
fi

echo ""
echo -e "${GREEN}🎉 Setup Complete!${NC}"
echo -e "${GREEN}=================${NC}"
echo ""
echo -e "${BLUE}You can now deploy with Touch ID using:${NC}"
echo -e "${YELLOW}  ./scripts/cursor-deploy.sh${NC}"
echo ""
echo -e "${BLUE}Security Features Active:${NC}"
echo -e "${GREEN}  ✅ Cursor environment detection${NC}"
echo -e "${GREEN}  ✅ Touch ID authentication${NC}"
echo -e "${GREEN}  ✅ GitHub token verification${NC}"
echo -e "${GREEN}  ✅ Secure Keychain storage${NC}"
echo ""
echo -e "${BLUE}Next time you deploy, just run:${NC}"
echo -e "${YELLOW}  ./scripts/cursor-deploy.sh${NC}"
echo -e "${BLUE}Touch ID will prompt you automatically!${NC}"
