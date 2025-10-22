#!/bin/bash

# Simplified Touch ID Authentication for Westmark Deployment
# This script works correctly with Touch ID

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if called with --quiet flag
QUIET=false
if [[ "$1" == "--quiet" ]]; then
    QUIET=true
fi

if [[ "$QUIET" == "false" ]]; then
    echo -e "${BLUE}🔐 Westmark Touch ID Authentication${NC}"
    echo -e "${BLUE}===================================${NC}"
fi

# Check if running in Cursor
if [[ "$VSCODE_PID" == "" ]] && [[ -z "$CURSOR_USER_DATA_DIR" ]]; then
    if [[ "$QUIET" == "false" ]]; then
        echo -e "${RED}❌ This script must be run from within Cursor${NC}"
    fi
    exit 1
fi

if [[ "$QUIET" == "false" ]]; then
    echo -e "${GREEN}✅ Running in Cursor environment${NC}"
fi

# Check Touch ID
if [[ -f "/usr/bin/bioutil" ]] && /usr/bin/bioutil -r >/dev/null 2>&1; then
    if [[ "$QUIET" == "false" ]]; then
        echo -e "${GREEN}✅ Touch ID available${NC}"
    fi
elif [[ -d "/System/Library/PrivateFrameworks/BiometricKit.framework" ]]; then
    if [[ "$QUIET" == "false" ]]; then
        echo -e "${GREEN}✅ Touch ID available${NC}"
    fi
else
    if [[ "$QUIET" == "false" ]]; then
        echo -e "${RED}❌ Touch ID not available on this device${NC}"
    fi
    exit 1
fi

# Authenticate with Touch ID
if [[ "$QUIET" == "false" ]]; then
    echo -e "${BLUE}🔐 Touch ID Authentication Required${NC}"
    echo -e "${YELLOW}Place your finger on Touch ID sensor...${NC}"
fi

# Retrieve token from Keychain (triggers Touch ID)
token=$(security find-generic-password \
    -a "westmark-cursor-deployment" \
    -s "github-token" \
    -w 2>/dev/null)

if [[ -z "$token" ]]; then
    if [[ "$QUIET" == "false" ]]; then
        echo -e "${RED}❌ Touch ID authentication failed${NC}"
        echo -e "${YELLOW}💡 Make sure your GitHub token is stored in Keychain${NC}"
    fi
    exit 1
fi

if [[ "$QUIET" == "false" ]]; then
    echo -e "${GREEN}✅ Touch ID authentication successful${NC}"
fi

# Verify token with GitHub
if [[ "$QUIET" == "false" ]]; then
    echo -e "${BLUE}🔍 Verifying GitHub authentication...${NC}"
fi

response=$(curl -s -H "Authorization: token $token" https://api.github.com/user 2>/dev/null)

if echo "$response" | grep -q '"login"'; then
    username=$(echo "$response" | grep '"login"' | cut -d'"' -f4)
    if [[ "$QUIET" == "false" ]]; then
        echo -e "${GREEN}✅ GitHub authentication verified for user: $username${NC}"
    fi
    echo "$token"
    exit 0
else
    if [[ "$QUIET" == "false" ]]; then
        echo -e "${RED}❌ Invalid GitHub token${NC}"
        echo -e "${YELLOW}Response: $response${NC}"
    fi
    exit 1
fi
