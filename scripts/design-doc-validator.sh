#!/bin/bash

# DESIGN DOCUMENTATION VALIDATOR
# Proactively ensures design corrections are properly documented
# Captures intended design specifications, not just changes

echo "📋 Design Documentation Validator"
echo "================================="

# Check if we're in the right directory
if [[ "$PWD" != *"/development" ]]; then
    echo "❌ Error: Run this script from the development/ directory"
    exit 1
fi

DESIGN_ISSUES_FOUND=false

# Function to check if a design pattern is documented
check_design_documentation() {
    local pattern="$1"
    local doc_file="$2"
    local description="$3"
    
    if grep -r "$pattern" assets/css/ 2>/dev/null | grep -v "/*" >/dev/null; then
        if ! grep -q "$pattern" "../docs/$doc_file" 2>/dev/null; then
            echo "  ⚠️  WARNING: $description detected but not documented in $doc_file"
            echo "  💡 Consider adding design specifications for this pattern"
            DESIGN_ISSUES_FOUND=true
        fi
    fi
}

echo "🔍 Checking for undocumented design patterns..."

# Check for image aspect ratio patterns
check_design_documentation "padding-bottom.*100%" "VISUAL_STANDARDS.md" "Square aspect ratio implementation"

# Check for typography patterns
check_design_documentation "font-family.*var(--font-family-" "VISUAL_STANDARDS.md" "Typography system usage"

# Check for layout patterns
check_design_documentation "display.*flex\|display.*grid" "LAYOUT_GUIDELINES.md" "Flexbox/Grid layout patterns"

# Check for component patterns
check_design_documentation "\.item-img\|\.hero\|\.card" "COMPONENT_LIBRARY.md" "Component styling patterns"

# Check for responsive patterns
check_design_documentation "@media.*max-width\|@media.*min-width" "LAYOUT_GUIDELINES.md" "Responsive breakpoints"

# Check for color patterns
check_design_documentation "#[0-9a-fA-F]{6}\|#[0-9a-fA-F]{3}" "VISUAL_STANDARDS.md" "Color specifications"

echo ""
echo "🔍 Checking for missing component documentation..."

# Check for CSS classes that might need component documentation
CSS_CLASSES=$(find assets/ -name "*.css" -exec grep -h "^\." {} \; 2>/dev/null | grep -v "/*" | awk '{print $1}' | cut -d: -f2 | sort -u)

for class in $CSS_CLASSES; do
    if [[ "$class" =~ ^\.[a-zA-Z][a-zA-Z0-9_-]*$ ]]; then
        # Check if this class is documented in component library
        if ! grep -q "$class" "../docs/COMPONENT_LIBRARY.md" 2>/dev/null; then
            echo "  ⚠️  WARNING: CSS class $class may need component documentation"
            echo "  💡 Consider adding to COMPONENT_LIBRARY.md"
            DESIGN_ISSUES_FOUND=true
        fi
    fi
done

echo ""
echo "🔍 Checking for design specification completeness..."

# Check if key design elements are documented
KEY_DESIGN_ELEMENTS=(
    "Latest Opportunities.*square"
    "Typography.*Hierarchy"
    "Hero.*section"
    "Navigation.*styling"
    "Button.*styles"
    "Color.*palette"
)

for element in "${KEY_DESIGN_ELEMENTS[@]}"; do
    if ! grep -q "$element" "../docs/VISUAL_STANDARDS.md" 2>/dev/null; then
        echo "  ⚠️  WARNING: Design element '$element' may not be fully documented"
        echo "  💡 Consider adding comprehensive specifications"
        DESIGN_ISSUES_FOUND=true
    fi
done

echo ""
echo "🔍 Checking for technical implementation documentation..."

# Check if CSS techniques are documented
CSS_TECHNIQUES=(
    "clamp.*function"
    "CSS.*custom.*properties"
    "object-fit.*cover"
    "aspect-ratio"
    "flexbox"
    "grid"
)

for technique in "${CSS_TECHNIQUES[@]}"; do
    if grep -r "$technique" assets/css/ 2>/dev/null | grep -v "/*" >/dev/null; then
        if ! grep -q "$technique" "../docs/"*.md 2>/dev/null; then
            echo "  ⚠️  WARNING: CSS technique '$technique' used but not documented"
            echo "  💡 Consider adding technical implementation details"
            DESIGN_ISSUES_FOUND=true
        fi
    fi
done

echo ""
if [ "$DESIGN_ISSUES_FOUND" = true ]; then
    echo "📝 DESIGN DOCUMENTATION RECOMMENDATIONS:"
    echo "======================================="
    echo "Consider updating documentation to include:"
    echo "  ✅ Intended design specifications (not just changes)"
    echo "  ✅ Component behavior and styling requirements"
    echo "  ✅ Visual standards and guidelines"
    echo "  ✅ Technical implementation details"
    echo "  ✅ Responsive behavior specifications"
    echo "  ✅ Accessibility considerations"
    echo ""
    echo "💡 This ensures future developers understand the intended design!"
    echo ""
    echo "❌ Design documentation validation found issues"
    exit 1
else
    echo "✅ Design documentation validation passed"
    echo "🎯 All design patterns appear to be properly documented"
fi
