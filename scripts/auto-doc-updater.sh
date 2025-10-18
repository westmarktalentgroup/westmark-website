#!/bin/bash

# ==========================================================================
# WESTMARK TALENT GROUP - SMART DESIGN DOCUMENTATION UPDATER
# Updates design documentation only when there are actual changes
# Prevents endless cycles with intelligent change detection
# ==========================================================================

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
DOCS_DIR="docs"
DESIGN_SYSTEM="$DOCS_DIR/DESIGN_SYSTEM.md"
LAYOUT_GUIDELINES="$DOCS_DIR/LAYOUT_GUIDELINES.md"
DEPLOYMENT_CHANGELOG="$DOCS_DIR/DEPLOYMENT_CHANGELOG.md"
COMPONENT_LIBRARY="$DOCS_DIR/COMPONENT_LIBRARY.md"

# Change detection file
CHANGE_DETECTION_FILE=".doc-update-needed"

echo -e "${BLUE}🤖 Smart Design Documentation Updater${NC}"
echo "=============================================="

# Function to check if documentation update is needed
check_update_needed() {
    echo -e "${YELLOW}🔍 Checking if documentation update is needed...${NC}"
    
    # Check if change detection file exists
    if [ -f "$CHANGE_DETECTION_FILE" ]; then
        echo -e "${GREEN}✅ Documentation update needed (change detected)${NC}"
        return 0
    fi
    
    # Check for recent CSS changes
    CSS_CHANGES=$(git diff --name-only HEAD~1 HEAD | grep -E '\.(css|html)$' | wc -l)
    if [ "$CSS_CHANGES" -gt 0 ]; then
        echo -e "${GREEN}✅ Documentation update needed (CSS/HTML changes detected)${NC}"
        return 0
    fi
    
    echo -e "${BLUE}ℹ️  No documentation update needed${NC}"
    return 1
}

# Function to update deployment changelog
update_deployment_changelog() {
    local commit_hash="$1"
    local commit_message="$2"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    
    echo -e "${YELLOW}📝 Updating deployment changelog...${NC}"
    
    # Create changelog entry
    cat > /tmp/changelog_entry.md << EOF

## Deployment - $timestamp

**Commit:** \`$commit_hash\`
**Message:** $commit_message

### Changes Detected:
- CSS/HTML modifications detected
- Design system may need updates

### Status:
- ✅ Automated documentation update triggered
- 📝 Documentation synchronized with code changes

---
EOF

    # Prepend to changelog
    if [ -f "$DEPLOYMENT_CHANGELOG" ]; then
        cp "$DEPLOYMENT_CHANGELOG" "$DEPLOYMENT_CHANGELOG.backup"
        cat /tmp/changelog_entry.md "$DEPLOYMENT_CHANGELOG.backup" > "$DEPLOYMENT_CHANGELOG"
        rm "$DEPLOYMENT_CHANGELOG.backup"
    else
        cat /tmp/changelog_entry.md > "$DEPLOYMENT_CHANGELOG"
    fi
    
    rm /tmp/changelog_entry.md
    echo -e "${GREEN}✅ Deployment changelog updated${NC}"
}

# Function to update design system with recent changes
update_design_system() {
    echo -e "${YELLOW}📝 Updating design system documentation...${NC}"
    
    # Get recent CSS changes
    RECENT_CSS=$(git diff --name-only HEAD~1 HEAD | grep '\.css$' | head -5)
    
    if [ -n "$RECENT_CSS" ]; then
        echo -e "${BLUE}📋 Recent CSS changes detected:${NC}"
        echo "$RECENT_CSS"
        
        # Add a note about recent changes to design system
        TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
        cat >> "$DESIGN_SYSTEM" << EOF

---

## Recent Updates - $TIMESTAMP

### CSS Changes Detected:
$(echo "$RECENT_CSS" | sed 's/^/- /')

### Note:
This section was automatically updated based on recent code changes.
For detailed specifications, refer to the individual component sections above.

EOF
        echo -e "${GREEN}✅ Design system updated with recent changes${NC}"
    fi
}

# Function to run smart update
run_smart_update() {
    echo -e "${BLUE}🚀 Running smart documentation update...${NC}"
    
    # Check if update is needed
    if ! check_update_needed; then
        echo -e "${BLUE}ℹ️  Skipping documentation update - no changes detected${NC}"
        return 0
    fi
    
    # Get current commit info
    COMMIT_HASH=$(git rev-parse --short HEAD)
    COMMIT_MESSAGE=$(git log -1 --pretty=%B)
    
    # Update documentation
    update_deployment_changelog "$COMMIT_HASH" "$COMMIT_MESSAGE"
    update_design_system
    
    # Remove change detection file
    rm -f "$CHANGE_DETECTION_FILE"
    
    echo -e "${GREEN}✅ Smart documentation update complete${NC}"
}

# Function to mark that documentation update is needed
mark_update_needed() {
    echo -e "${YELLOW}📝 Marking documentation update as needed...${NC}"
    touch "$CHANGE_DETECTION_FILE"
    echo -e "${GREEN}✅ Documentation update marked as needed${NC}"
}

# Function to detect changes without updating
detect_changes() {
    echo -e "${YELLOW}🔍 Detecting changes that need documentation updates...${NC}"
    
    # Check for CSS changes
    CSS_CHANGES=$(git diff --name-only HEAD~1 HEAD | grep -E '\.(css|html)$')
    if [ -n "$CSS_CHANGES" ]; then
        echo -e "${GREEN}✅ CSS/HTML changes detected:${NC}"
        echo "$CSS_CHANGES"
    else
        echo -e "${BLUE}ℹ️  No CSS/HTML changes detected${NC}"
    fi
    
    # Check for new CSS classes
    NEW_CLASSES=$(find . -name "*.css" -exec grep -o '^\.[a-zA-Z0-9_-]*' {} \; | sed 's/^\.//' | sort -u | head -10)
    if [ -n "$NEW_CLASSES" ]; then
        echo -e "${GREEN}✅ CSS classes found:${NC}"
        echo "$NEW_CLASSES"
    fi
}

# Main script logic
case "${1:-help}" in
    "update")
        run_smart_update
        ;;
    "mark")
        mark_update_needed
        ;;
    "detect")
        detect_changes
        ;;
    "check")
        check_update_needed
        ;;
    "help")
        echo -e "${BLUE}Westmark Smart Design Documentation Updater${NC}"
        echo "=================================================="
        echo ""
        echo -e "${YELLOW}Usage:${NC}"
        echo "  $0 update  - Run smart documentation update"
        echo "  $0 mark    - Mark that documentation update is needed"
        echo "  $0 detect  - Detect changes without updating"
        echo "  $0 check   - Check if update is needed"
        echo "  $0 help    - Show this help"
        echo ""
        echo -e "${BLUE}Features:${NC}"
        echo "  • Smart change detection"
        echo "  • Prevents endless cycles"
        echo "  • Only updates when needed"
        echo "  • Safe and reliable"
        echo ""
        echo -e "${GREEN}✅ No Git hooks - prevents endless cycles${NC}"
        ;;
    *)
        echo -e "${RED}❌ Unknown command: $1${NC}"
        echo "Use '$0 help' for usage information"
        exit 1
        ;;
esac
