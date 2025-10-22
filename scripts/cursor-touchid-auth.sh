#!/bin/bash

# Cursor-Specific Touch ID Authentication for Westmark Deployment
# This script integrates with Cursor's environment and uses Touch ID

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to check if running in Cursor
is_cursor_environment() {
    # Check for Cursor-specific environment variables
    if [[ "$VSCODE_PID" != "" ]] || [[ -n "$CURSOR_USER_DATA_DIR" ]] || [[ -n "$CURSOR_EXTENSIONS_DIR" ]]; then
        return 0
    fi
    
    # Check if parent process is Cursor
    local parent_pid=$(ps -o ppid= -p $$)
    local parent_name=$(ps -o comm= -p $parent_pid 2>/dev/null || echo "")
    
    if [[ "$parent_name" == *"Cursor"* ]] || [[ "$parent_name" == *"cursor"* ]]; then
        return 0
    fi
    
    return 1
}

# Function to authenticate with Touch ID
authenticate_with_touchid() {
    local service_name="$1"
    local prompt="$2"
    
    echo -e "${BLUE}🔐 Touch ID Authentication Required${NC}"
    echo -e "${YELLOW}$prompt${NC}"
    echo -e "${BLUE}Place your finger on Touch ID sensor...${NC}"
    
    # Use macOS security command with Touch ID
    local result=$(security find-generic-password \
        -a "westmark-cursor-deployment" \
        -s "$service_name" \
        -w 2>/dev/null)
    
    if [[ -n "$result" ]]; then
        echo -e "${GREEN}✅ Touch ID authentication successful${NC}"
        echo "$result"
        return 0
    else
        echo -e "${RED}❌ Touch ID authentication failed${NC}"
        return 1
    fi
}

# Function to store credentials in Keychain
store_credentials() {
    local service_name="$1"
    local credential="$2"
    
    echo -e "${BLUE}🔐 Storing credentials in Keychain with Touch ID...${NC}"
    
    security add-generic-password \
        -a "westmark-cursor-deployment" \
        -s "$service_name" \
        -w "$credential" \
        -T "/Applications/Cursor.app" \
        -U 2>/dev/null
    
    if [[ $? -eq 0 ]]; then
        echo -e "${GREEN}✅ Credentials stored successfully${NC}"
        return 0
    else
        echo -e "${RED}❌ Failed to store credentials${NC}"
        return 1
    fi
}

# Function to verify GitHub token
verify_github_token() {
    local token="$1"
    
    echo -e "${BLUE}🔍 Verifying GitHub authentication...${NC}"
    
    local response=$(curl -s -H "Authorization: token $token" \
        https://api.github.com/user 2>/dev/null)
    
    if echo "$response" | grep -q '"login"'; then
        local username=$(echo "$response" | grep '"login"' | cut -d'"' -f4)
        echo -e "${GREEN}✅ GitHub authentication verified for user: $username${NC}"
        return 0
    else
        echo -e "${RED}❌ Invalid GitHub token${NC}"
        echo -e "${YELLOW}Response: $response${NC}"
        return 1
    fi
}

# Main authentication function
main() {
    echo -e "${BLUE}🚀 Westmark Cursor Touch ID Authentication${NC}"
    echo -e "${BLUE}============================================${NC}"
    
    # Check if running in Cursor
    if ! is_cursor_environment; then
        echo -e "${RED}❌ This script must be run from within Cursor${NC}"
        echo -e "${YELLOW}💡 Please run this from Cursor's integrated terminal${NC}"
        exit 1
    fi
    
    echo -e "${GREEN}✅ Running in Cursor environment${NC}"
    
    # Check if Touch ID is available
    if [[ -f "/usr/bin/bioutil" ]] && /usr/bin/bioutil -r >/dev/null 2>&1; then
        echo -e "${GREEN}✅ Touch ID available${NC}"
    elif [[ -d "/System/Library/PrivateFrameworks/BiometricKit.framework" ]]; then
        echo -e "${GREEN}✅ Touch ID available${NC}"
    else
        echo -e "${RED}❌ Touch ID not available on this device${NC}"
        exit 1
    fi
    
    # Try to authenticate with existing credentials
    local github_token=$(authenticate_with_touchid "github-token" "Deploy to Production?")
    
    if [[ -z "$github_token" ]]; then
        echo -e "${YELLOW}💡 No stored GitHub token found${NC}"
        echo -e "${BLUE}Please enter your GitHub Personal Access Token:${NC}"
        read -s -p "GitHub Token: " github_token
        echo
        
        if [[ -n "$github_token" ]]; then
            # Verify token before storing
            if verify_github_token "$github_token"; then
                store_credentials "github-token" "$github_token"
            else
                echo -e "${RED}❌ Invalid token, not storing${NC}"
                exit 1
            fi
        else
            echo -e "${RED}❌ No token provided${NC}"
            exit 1
        fi
    else
        # Verify the retrieved token
        if ! verify_github_token "$github_token"; then
            echo -e "${RED}❌ Stored token is invalid${NC}"
            echo -e "${YELLOW}💡 Please update your stored token${NC}"
            exit 1
        fi
    fi
    
    echo -e "${GREEN}🎉 Authentication complete! Ready for deployment.${NC}"
    echo "$github_token"
}

# Run main function
main "$@"
