#!/bin/bash

# ==========================================================================
# WESTMARK TALENT GROUP - SIMPLIFIED PROTECTION SYSTEM
# Essential protection rules only - no over-engineering
# ==========================================================================

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🛡️ Westmark Talent Group - Simplified Protection${NC}"
echo "=============================================="

# Function to enable protection
enable_protection() {
    echo -e "${BLUE}🔒 Enabling simplified protection...${NC}"
    
    # Create simple pre-push hook
    mkdir -p .git/hooks
    cat > .git/hooks/pre-push << 'EOF'
#!/bin/bash

# Simple pre-push hook - blocks direct pushes to main
while read local_ref local_sha remote_ref remote_sha; do
    branch_name=$(echo "$remote_ref" | sed 's/refs\/heads\///')
    
    if [[ "$branch_name" == "main" ]]; then
        echo "🚨 Direct pushes to main are blocked"
        echo "💡 Use: ./scripts/deploy.sh"
        exit 1
    fi
done

exit 0
EOF
    
    chmod +x .git/hooks/pre-push
    
    # Create protection marker
    cat > .protection-active << EOF
# Westmark Protection System - Simplified
# Created: $(date)
# 
# PROTECTION RULES:
# 1. No direct pushes to main branch
# 2. Use ./scripts/deploy.sh for deployments
# 3. All changes via Pull Requests
EOF
    
    echo -e "${GREEN}✅ Simplified protection enabled${NC}"
    echo -e "${BLUE}📋 Protection Rules:${NC}"
    echo "   • No direct pushes to main"
    echo "   • Use deploy script for deployments"
    echo "   • All changes via Pull Requests"
}

# Function to disable protection
disable_protection() {
    echo -e "${YELLOW}⚠️  Disabling protection...${NC}"
    
    rm -f .git/hooks/pre-push
    rm -f .protection-active
    
    echo -e "${YELLOW}⚠️  Protection disabled${NC}"
    echo -e "${RED}🚨 WARNING: Direct pushes to main are now allowed${NC}"
}

# Function to show status
show_status() {
    echo -e "${BLUE}📊 Protection Status${NC}"
    echo "====================="
    
    if [ -f ".protection-active" ]; then
        echo -e "${GREEN}🛡️  Protection: ACTIVE${NC}"
        echo -e "${GREEN}🔒 Direct pushes: BLOCKED${NC}"
        echo -e "${GREEN}✅ Deploy script: REQUIRED${NC}"
    else
        echo -e "${RED}🚨 Protection: INACTIVE${NC}"
        echo -e "${RED}⚠️  Direct pushes: ALLOWED${NC}"
        echo -e "${RED}❌ Deploy script: NOT REQUIRED${NC}"
    fi
    
    if [ -f ".git/hooks/pre-push" ]; then
        echo -e "${GREEN}✅ Pre-push hook: ACTIVE${NC}"
    else
        echo -e "${RED}❌ Pre-push hook: INACTIVE${NC}"
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
    *)
        echo -e "${BLUE}Westmark Simplified Protection System${NC}"
        echo "======================================"
        echo ""
        echo -e "${YELLOW}Usage:${NC}"
        echo "  $0 enable   - Enable protection"
        echo "  $0 disable  - Disable protection"
        echo "  $0 status   - Show protection status"
        echo ""
        echo -e "${BLUE}Protection Features:${NC}"
        echo "  • Blocks direct pushes to main branch"
        echo "  • Requires deploy script usage"
        echo "  • Simple and reliable"
        echo ""
        show_status
        ;;
esac

echo ""
echo -e "${GREEN}🛡️ Westmark Simplified Protection System${NC}"
echo -e "${BLUE}=============================================${NC}"
