#!/bin/bash

# Architectural Documentation Enforcer
# Westmark Talent Group Website
# 
# This script FORCES AI agents to update architectural documentation
# when making changes to ensure project recreatability

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${RED}🏗️ ARCHITECTURAL DOCUMENTATION ENFORCER${NC}"
echo "============================================="
echo ""

# Configuration
# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

DEVELOPMENT_DIR="$PROJECT_ROOT/development"
DOCS_DIR="$PROJECT_ROOT/docs"
CSS_FILE="$DEVELOPMENT_DIR/assets/css/optimized.css"
HTML_FILES=("$DEVELOPMENT_DIR/index.html" "$DEVELOPMENT_DIR/clients.html" "$DEVELOPMENT_DIR/contact-us.html")

# Function to log with timestamp
log() {
    echo -e "${GREEN}[$(date '+%Y-%m-%d %H:%M:%S')]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Check for new CSS classes that need documentation
check_new_css_classes() {
    log "🔍 Checking for new CSS classes requiring documentation..."
    
    local new_classes=()
    local documented_classes=()
    
    # Extract all CSS classes from optimized.css
    local css_classes=$(grep -o '^\.[a-zA-Z][a-zA-Z0-9_-]*' "$CSS_FILE" | sort -u)
    
    # Check which classes are documented in COMPONENT_LIBRARY.md
    while IFS= read -r class; do
        class_name=${class#.} # Remove the dot
        if grep -q "$class_name" "$DOCS_DIR/COMPONENT_LIBRARY.md" 2>/dev/null; then
            documented_classes+=("$class_name")
        else
            new_classes+=("$class_name")
        fi
    done <<< "$css_classes"
    
    if [ ${#new_classes[@]} -gt 0 ]; then
        error "❌ UNDOCUMENTED CSS CLASSES DETECTED:"
        for class in "${new_classes[@]}"; do
            echo "   - .$class"
        done
        echo ""
        error "🚨 AI AGENT MUST DOCUMENT THESE CLASSES IN COMPONENT_LIBRARY.md"
        return 1
    else
        log "✅ All CSS classes are documented"
        return 0
    fi
}

# Check for new HTML structures that need documentation
check_new_html_structures() {
    log "🔍 Checking for new HTML structures requiring documentation..."
    
    local structural_changes=()
    
    # Check for new section types
    for html_file in "${HTML_FILES[@]}"; do
        if [ -f "$html_file" ]; then
            # Check for new section classes
            local sections=$(grep -o 'class="[^"]*section[^"]*"' "$html_file" | grep -o '[a-zA-Z][a-zA-Z0-9_-]*section' | sort -u)
            
            while IFS= read -r section; do
                if ! grep -q "$section" "$DOCS_DIR/COMPONENT_LIBRARY.md" 2>/dev/null; then
                    structural_changes+=("New section type: $section in $(basename "$html_file")")
                fi
            done <<< "$sections"
            
            # Check for new component patterns
            local components=$(grep -o 'class="[^"]*"' "$html_file" | grep -E '(faq-|cta-|btn-|panel-|card-|item-)' | sort -u)
            
            while IFS= read -r component; do
                component_clean=$(echo "$component" | grep -o '[a-zA-Z][a-zA-Z0-9_-]*')
                if ! grep -q "$component_clean" "$DOCS_DIR/COMPONENT_LIBRARY.md" 2>/dev/null; then
                    structural_changes+=("New component: $component_clean in $(basename "$html_file")")
                fi
            done <<< "$components"
        fi
    done
    
    if [ ${#structural_changes[@]} -gt 0 ]; then
        error "❌ UNDOCUMENTED HTML STRUCTURES DETECTED:"
        for change in "${structural_changes[@]}"; do
            echo "   - $change"
        done
        echo ""
        error "🚨 AI AGENT MUST DOCUMENT THESE STRUCTURES IN COMPONENT_LIBRARY.md"
        return 1
    else
        log "✅ All HTML structures are documented"
        return 0
    fi
}

# Check for design pattern changes
check_design_patterns() {
    log "🔍 Checking for design pattern changes requiring documentation..."
    
    local pattern_violations=()
    
    # Check for new color schemes
    if grep -q "background-color.*var(--color-primary)" "$CSS_FILE" && ! grep -q "black.*background" "$DOCS_DIR/DESIGN_SYSTEM.md" 2>/dev/null; then
        pattern_violations+=("New black background pattern detected")
    fi
    
    # Check for new border-radius patterns
    if grep -q "border-radius.*50px" "$CSS_FILE" && ! grep -q "50px.*border-radius" "$DOCS_DIR/CSS_STANDARDS.md" 2>/dev/null; then
        pattern_violations+=("New 50px border-radius pattern detected")
    fi
    
    # Check for new layout patterns
    if grep -q "faq-accordion" "$CSS_FILE" && ! grep -q "FAQ.*dropdown.*clean" "$DOCS_DIR/COMPONENT_LIBRARY.md" 2>/dev/null; then
        pattern_violations+=("New clean dropdown pattern detected")
    fi
    
    if [ ${#pattern_violations[@]} -gt 0 ]; then
        error "❌ NEW DESIGN PATTERNS DETECTED:"
        for violation in "${pattern_violations[@]}"; do
            echo "   - $violation"
        done
        echo ""
        error "🚨 AI AGENT MUST DOCUMENT THESE PATTERNS IN DESIGN_SYSTEM.md"
        return 1
    else
        log "✅ All design patterns are documented"
        return 0
    fi
}

# Check for architectural drift
check_architectural_drift() {
    log "🔍 Checking for architectural drift..."
    
    local drift_violations=()
    
    # Check if hero sections are only on homepage
    if grep -q "hero-section" "$DEVELOPMENT_DIR/clients.html" 2>/dev/null; then
        drift_violations+=("Hero section found on clients.html (should only be on homepage)")
    fi
    
    if grep -q "hero-section" "$DEVELOPMENT_DIR/contact-us.html" 2>/dev/null; then
        drift_violations+=("Hero section found on contact-us.html (should only be on homepage)")
    fi
    
    # Check for Mobirise references (should be removed)
    if grep -r -i "mbr-\|mobirise" "$DEVELOPMENT_DIR" --include="*.html" --include="*.css" 2>/dev/null | grep -v "Binary file" | grep -q .; then
        drift_violations+=("Mobirise references still present (should be removed)")
    fi
    
    if [ ${#drift_violations[@]} -gt 0 ]; then
        error "❌ ARCHITECTURAL DRIFT DETECTED:"
        for violation in "${drift_violations[@]}"; do
            echo "   - $violation"
        done
        echo ""
        error "🚨 AI AGENT MUST FIX ARCHITECTURAL VIOLATIONS"
        return 1
    else
        log "✅ No architectural drift detected"
        return 0
    fi
}

# Generate architectural documentation requirements
generate_documentation_requirements() {
    log "📋 Generating architectural documentation requirements..."
    
    echo ""
    echo -e "${BLUE}🏗️ REQUIRED ARCHITECTURAL UPDATES:${NC}"
    echo "=================================="
    echo ""
    
    echo "1. COMPONENT_LIBRARY.md must include:"
    echo "   - All new CSS classes with usage examples"
    echo "   - All new HTML structures with code samples"
    echo "   - Component interaction patterns"
    echo ""
    
    echo "2. CSS_STANDARDS.md must include:"
    echo "   - New design patterns (border-radius, colors, layouts)"
    echo "   - Component styling standards"
    echo "   - Responsive behavior specifications"
    echo ""
    
    echo "3. DESIGN_SYSTEM.md must include:"
    echo "   - Visual design patterns"
    echo "   - Color scheme specifications"
    echo "   - Layout architecture"
    echo ""
    
    echo "4. TECHNICAL_ARCHITECTURE.md must include:"
    echo "   - Page structure specifications"
    echo "   - Component hierarchy"
    echo "   - Design pattern enforcement"
    echo ""
}

# Main execution
main() {
    local violations=0
    
    # Run all checks
    check_new_css_classes || violations=$((violations + 1))
    check_new_html_structures || violations=$((violations + 1))
    check_design_patterns || violations=$((violations + 1))
    check_architectural_drift || violations=$((violations + 1))
    
    if [ $violations -gt 0 ]; then
        echo ""
        error "🚨 ARCHITECTURAL DOCUMENTATION VIOLATIONS DETECTED!"
        echo ""
        error "❌ AI AGENT MUST UPDATE ARCHITECTURAL DOCUMENTATION BEFORE COMMITTING"
        echo ""
        generate_documentation_requirements
        echo ""
        error "💥 DEPLOYMENT BLOCKED - Fix documentation violations first"
        exit 1
    else
        log "✅ All architectural documentation is current"
        log "✅ Project recreatability maintained"
        exit 0
    fi
}

# Run main function
main "$@"
