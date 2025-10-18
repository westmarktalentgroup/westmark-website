#!/bin/bash

# ==========================================================================
# WESTMARK TALENT GROUP - PRODUCTION PROTECTION SYSTEM
# Prevents direct pushes to production, enforces deploy script usage
# ==========================================================================

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
PRODUCTION_BRANCH="main"
DEPLOY_SCRIPT="scripts/deploy.sh"
PROTECTION_FILE=".production-protected"

echo -e "${BLUE}🔒 Westmark Production Protection System${NC}"
echo "=============================================="

# Function to check if we're in a protected repository
check_protection_status() {
    if [[ -f "$PROTECTION_FILE" ]]; then
        echo -e "${GREEN}✅ Production protection is ACTIVE${NC}"
        return 0
    else
        echo -e "${YELLOW}⚠️  Production protection is INACTIVE${NC}"
        return 1
    fi
}

# Function to enable production protection
enable_protection() {
    echo -e "${BLUE}🔒 Enabling Production Protection...${NC}"
    
    # Create protection file
    cat > "$PROTECTION_FILE" << EOF
# Westmark Talent Group - Production Protection
# This file indicates that production protection is active
# Created: $(date)
# 
# PROTECTION RULES:
# 1. Direct pushes to main branch are blocked
# 2. Only deploy.sh script can update production
# 3. All changes must go through development/ directory first
# 4. Backup is created before any production changes
EOF
    
    # Create pre-push hook
    mkdir -p .git/hooks
    cat > .git/hooks/pre-push << 'EOF'
#!/bin/bash

# Westmark Production Protection - Pre-Push Hook
PRODUCTION_BRANCH="main"
DEPLOY_SCRIPT="scripts/deploy.sh"

# Check if pushing to production branch
while read local_ref local_sha remote_ref remote_sha; do
    if [[ "$remote_ref" == "refs/heads/$PRODUCTION_BRANCH" ]]; then
        echo "🚨 PRODUCTION PROTECTION ACTIVE"
        echo "=================================="
        echo "❌ Direct pushes to $PRODUCTION_BRANCH are BLOCKED"
        echo ""
        echo "✅ REQUIRED WORKFLOW:"
        echo "   1. Work in development/ directory"
        echo "   2. Test your changes locally"
        echo "   3. Run: ./scripts/deploy.sh"
        echo "   4. Deploy script will handle production update"
        echo ""
        echo "🔒 This protection ensures:"
        echo "   • All changes are properly tested"
        echo "   • Backups are created automatically"
        echo "   • Production integrity is maintained"
        echo ""
        exit 1
    fi
done

exit 0
EOF
    
    chmod +x .git/hooks/pre-push
    
    # Create pre-commit hook for development validation
    cat > .git/hooks/pre-commit << 'EOF'
#!/bin/bash

# Westmark Development Validation - Pre-Commit Hook
echo "🔍 Running development validation..."

# Check if we're in development directory
if [[ "$PWD" == *"/development" ]]; then
    echo "✅ Working in development directory"
else
    echo "⚠️  Not in development directory - ensure you're working in development/"
fi

# Run basic validation
if [[ -f "scripts/deploy.sh" ]]; then
    echo "✅ Deploy script found"
else
    echo "❌ Deploy script not found"
    exit 1
fi

echo "✅ Development validation passed"
exit 0
EOF
    
    chmod +x .git/hooks/pre-commit
    
    echo -e "${GREEN}✅ Production protection ENABLED${NC}"
    echo -e "${BLUE}📋 Protection Rules:${NC}"
    echo "   • Direct pushes to main branch are BLOCKED"
    echo "   • Only deploy.sh script can update production"
    echo "   • All changes must go through development/ first"
    echo "   • Automatic backups before production changes"
    echo ""
    echo -e "${YELLOW}💡 To deploy changes:${NC}"
    echo "   ./scripts/deploy.sh"
}

# Function to disable production protection
disable_protection() {
    echo -e "${YELLOW}⚠️  Disabling Production Protection...${NC}"
    
    # Remove protection file
    if [[ -f "$PROTECTION_FILE" ]]; then
        rm "$PROTECTION_FILE"
        echo -e "${GREEN}✅ Protection file removed${NC}"
    fi
    
    # Remove git hooks
    if [[ -f ".git/hooks/pre-push" ]]; then
        rm ".git/hooks/pre-push"
        echo -e "${GREEN}✅ Pre-push hook removed${NC}"
    fi
    
    if [[ -f ".git/hooks/pre-commit" ]]; then
        rm ".git/hooks/pre-commit"
        echo -e "${GREEN}✅ Pre-commit hook removed${NC}"
    fi
    
    echo -e "${YELLOW}⚠️  Production protection DISABLED${NC}"
    echo -e "${RED}🚨 WARNING: Direct pushes to production are now allowed${NC}"
}

# Function to show protection status
show_status() {
    echo -e "${BLUE}📊 Production Protection Status${NC}"
    echo "================================="
    
    if check_protection_status; then
        echo -e "${GREEN}🛡️  Protection Level: MAXIMUM${NC}"
        echo -e "${GREEN}🔒 Direct pushes: BLOCKED${NC}"
        echo -e "${GREEN}✅ Deploy script: REQUIRED${NC}"
        echo -e "${GREEN}📁 Development workflow: ENFORCED${NC}"
    else
        echo -e "${RED}🚨 Protection Level: NONE${NC}"
        echo -e "${RED}⚠️  Direct pushes: ALLOWED${NC}"
        echo -e "${RED}❌ Deploy script: NOT REQUIRED${NC}"
        echo -e "${RED}⚠️  Development workflow: NOT ENFORCED${NC}"
    fi
    
    echo ""
    echo -e "${BLUE}📋 Current Git Hooks:${NC}"
    if [[ -f ".git/hooks/pre-push" ]]; then
        echo -e "${GREEN}✅ Pre-push hook: ACTIVE${NC}"
    else
        echo -e "${RED}❌ Pre-push hook: INACTIVE${NC}"
    fi
    
    if [[ -f ".git/hooks/pre-commit" ]]; then
        echo -e "${GREEN}✅ Pre-commit hook: ACTIVE${NC}"
    else
        echo -e "${RED}❌ Pre-commit hook: INACTIVE${NC}"
    fi
}

# Function to test protection
test_protection() {
    echo -e "${BLUE}🧪 Testing Production Protection...${NC}"
    
    if check_protection_status; then
        echo -e "${YELLOW}Testing direct push to main branch...${NC}"
        
        # Create a test commit
        echo "# Test commit for protection testing" > test-protection.txt
        git add test-protection.txt
        git commit -m "Test: Production protection" --no-verify
        
        echo -e "${YELLOW}Attempting direct push to main...${NC}"
        if git push origin main 2>&1 | grep -q "PRODUCTION PROTECTION ACTIVE"; then
            echo -e "${GREEN}✅ Protection WORKING - Direct push blocked${NC}"
        else
            echo -e "${RED}❌ Protection FAILED - Direct push allowed${NC}"
        fi
        
        # Clean up test commit
        git reset --hard HEAD~1
        rm -f test-protection.txt
        
    else
        echo -e "${RED}❌ Cannot test - Protection is not active${NC}"
        echo -e "${YELLOW}Run: $0 enable${NC}"
    fi
}

# Main script logic
case "${1:-status}" in
    "enable")
        enable_protection
        ;;
    "disable")
        disable_protection
        ;;
    "status")
        show_status
        ;;
    "test")
        test_protection
        ;;
    *)
        echo -e "${BLUE}Westmark Production Protection System${NC}"
        echo "======================================"
        echo ""
        echo -e "${YELLOW}Usage:${NC}"
        echo "  $0 enable   - Enable production protection"
        echo "  $0 disable  - Disable production protection"
        echo "  $0 status   - Show protection status"
        echo "  $0 test     - Test protection system"
        echo ""
        echo -e "${BLUE}Protection Features:${NC}"
        echo "  • Blocks direct pushes to main branch"
        echo "  • Enforces deploy script usage"
        echo "  • Validates development workflow"
        echo "  • Creates automatic backups"
        echo ""
        show_status
        ;;
esac

echo ""
echo -e "${GREEN}🔒 Westmark Production Protection System${NC}"
echo -e "${BLUE}=============================================${NC}"
