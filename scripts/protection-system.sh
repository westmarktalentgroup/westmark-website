#!/bin/bash

# WESTMARK PROTECTION SYSTEM
# Consolidated protection and workflow enforcement
# Replaces multiple individual scripts with a single, efficient system

echo "🔒 Westmark Protection System"
echo "============================"

# Check if development directory exists
if [ ! -d "development" ]; then
    echo "❌ Error: development/ directory not found!"
    echo "Please run this script from the repository root directory."
    exit 1
fi

# Change to development directory for all operations
cd development

# Documentation protection
echo "📋 Checking documentation compliance..."

# Check for prohibited documentation patterns
PROHIBITED_FILES=$(find . -name "*_SUMMARY.md" -o -name "*_CLEANUP.md" -o -name "*_COMPARISON.md" -o -name "*_IMPACT.md" -o -name "*_ANALYSIS.md" -o -name "*_COMPLETED.md" -o -name "*_OPTIMIZATION.md" -o -name "*_CONSOLIDATION.md" -o -name "*_EFFICIENCY.md" -o -name "PHASE_*.md")
if [ ! -z "$PROHIBITED_FILES" ]; then
    echo "❌ FAILED: Prohibited documentation patterns found:"
    echo "$PROHIBITED_FILES"
    echo "🚨 These file patterns are not allowed"
    echo "💡 Documentation must contain structural information only, not development summaries"
    exit 1
fi

# Check for prohibited content in documentation files
echo "📋 Checking documentation content compliance..."
PROHIBITED_CONTENT_FOUND=false

for doc_file in $(find . -name "*.md"); do
    # Check for development summary language
    if grep -q -i "this document summarizes\|we have successfully completed\|the following improvements were implemented\|analysis of the current system shows" "$doc_file"; then
        echo "❌ FAILED: Prohibited content found in $doc_file"
        echo "🚨 Documentation must contain structural information only"
        echo "💡 Remove development summaries and focus on specifications"
        PROHIBITED_CONTENT_FOUND=true
    fi
    
    # Check for step-by-step process language
    if grep -q -i "step [0-9]\|the process involves\|to implement this feature, follow these steps" "$doc_file"; then
        echo "❌ FAILED: Step-by-step process content found in $doc_file"
        echo "🚨 Documentation must contain specifications, not processes"
        echo "💡 Focus on structural information and reference material"
        PROHIBITED_CONTENT_FOUND=true
    fi
done

if [ "$PROHIBITED_CONTENT_FOUND" = true ]; then
    exit 1
fi

# Smart Documentation Management - Quality over Quantity
echo "📚 Analyzing documentation quality and necessity..."

# Count documentation files
TOTAL_DOCS=$(find . -name "*.md" | wc -l)
echo "  📊 Total documentation files: $TOTAL_DOCS"

# Check for duplicate or redundant documentation
REDUNDANT_DOCS=$(find . -name "*.md" -exec basename {} \; | sort | uniq -d)
if [ ! -z "$REDUNDANT_DOCS" ]; then
    echo "  ⚠️  WARNING: Duplicate documentation files found:"
    echo "$REDUNDANT_DOCS"
    echo "  💡 Consider consolidating duplicate documentation"
fi

# Check for essential documentation
ESSENTIAL_DOCS=("README.md" "ASSET_INVENTORY.md" "TECHNICAL_ARCHITECTURE.md" "VISUAL_STANDARDS.md" "COMPONENT_LIBRARY.md")
MISSING_ESSENTIAL=false

for doc in "${ESSENTIAL_DOCS[@]}"; do
    if [ ! -f "../docs/$doc" ] && [ ! -f "./$doc" ]; then
        echo "  ❌ MISSING: Essential documentation file: $doc"
        MISSING_ESSENTIAL=true
    fi
done

if [ "$MISSING_ESSENTIAL" = true ]; then
    echo "❌ FAILED: Essential documentation files are missing"
    echo "🚨 These files are required for project maintenance"
    exit 1
fi

# Check for documentation bloat (temporary files, duplicates, etc.)
BLOAT_PATTERNS=("*_SUMMARY.md" "*_CLEANUP.md" "*_COMPARISON.md" "*_IMPACT.md" "PHASE_*.md" "TEMP_*.md")
BLOAT_FOUND=false

for pattern in "${BLOAT_PATTERNS[@]}"; do
    BLOAT_FILES=$(find . -name "$pattern" 2>/dev/null)
    if [ ! -z "$BLOAT_FILES" ]; then
        echo "  🗑️  Documentation bloat detected: $BLOAT_FILES"
        echo "  💡 Consider removing temporary or redundant documentation"
        BLOAT_FOUND=true
    fi
done

if [ "$BLOAT_FOUND" = true ]; then
    echo "⚠️  WARNING: Documentation bloat detected"
    echo "💡 Focus on quality over quantity - remove redundant files"
fi

echo "  ✅ Documentation quality analysis completed"

# File structure validation
echo "📁 Validating file structure..."

# Check for required directories
REQUIRED_DIRS=("assets")
for dir in "${REQUIRED_DIRS[@]}"; do
    if [ ! -d "$dir" ]; then
        echo "❌ FAILED: Required directory missing: $dir"
        exit 1
    fi
done

# Check for docs directory in parent (root)
if [ ! -d "../docs" ]; then
    echo "❌ FAILED: Required directory missing: ../docs"
    exit 1
fi

# Check for essential files
ESSENTIAL_FILES=("index.html" "package.json")
for file in "${ESSENTIAL_FILES[@]}"; do
    if [ ! -f "$file" ]; then
        echo "❌ FAILED: Essential file missing: $file"
        exit 1
    fi
done

# Check for README.md in parent (root)
if [ ! -f "../README.md" ]; then
    echo "❌ FAILED: Essential file missing: ../README.md"
    exit 1
fi

# Asset validation
echo "🎨 Validating assets..."

# Check for empty asset directories
EMPTY_DIRS=$(find assets -type d -empty 2>/dev/null)
if [ ! -z "$EMPTY_DIRS" ]; then
    echo "⚠️  WARNING: Empty asset directories found:"
    echo "$EMPTY_DIRS"
    echo "Consider cleaning up unused directories"
fi

# Security check
echo "🔐 Running security checks..."

# Check for potential security issues
if grep -r "password\|secret\|key" . --include="*.html" --include="*.js" --include="*.css" >/dev/null 2>&1; then
    echo "⚠️  WARNING: Potential sensitive data found in files"
    echo "Review files for hardcoded credentials"
fi

# Duplicate script detection
echo "🔍 Checking for duplicate scripts..."
cd ..

# Check for duplicate deployment scripts
DEPLOY_SCRIPTS=$(find . -maxdepth 1 -name "*deploy*.sh" | wc -l)
if [ "$DEPLOY_SCRIPTS" -gt 1 ]; then
    echo "❌ FAILED: Multiple deployment scripts detected!"
    echo "🚨 Found $DEPLOY_SCRIPTS deployment scripts:"
    find . -maxdepth 1 -name "*deploy*.sh" -exec echo "  - {}" \;
    echo ""
    echo "💡 SOLUTION: Consolidate into single deploy.sh script"
    echo "   Remove duplicate scripts and enhance the main deploy.sh"
    exit 1
fi

# Check for duplicate protection scripts
cd development
PROTECTION_SCRIPTS=$(find . -name "*protection*.sh" -o -name "*guard*.sh" -o -name "*enforcer*.sh" | wc -l)
if [ "$PROTECTION_SCRIPTS" -gt 1 ]; then
    echo "❌ FAILED: Multiple protection scripts detected!"
    echo "🚨 Found $PROTECTION_SCRIPTS protection scripts:"
    find . -name "*protection*.sh" -o -name "*guard*.sh" -o -name "*enforcer*.sh" | while read script; do
        echo "  - $script"
    done
    echo ""
    echo "💡 SOLUTION: Use single protection-system.sh script"
    echo "   Remove duplicate protection scripts"
    exit 1
fi

echo "  ✅ No duplicate scripts found"

# Visual component validation
echo "🎨 Validating visual components..."

# Check hero section has required elements
if ! grep -q "hero-section" index.html; then
    echo "❌ FAILED: Hero section missing clean structure"
    exit 1
fi

if ! grep -q "hero-overlay" index.html; then
    echo "❌ FAILED: Hero section missing overlay element"
    exit 1
fi

# Check for critical images
echo "🖼️  Checking critical visual elements..."
CRITICAL_IMAGES=(
    "pexels-apasaric-1437493-2000x1333.jpg"
    "westmark-logo-128x62-1.png"
)

for image in "${CRITICAL_IMAGES[@]}"; do
    if [ ! -f "assets/images/$image" ]; then
        echo "❌ FAILED: Critical image missing: $image"
        exit 1
    fi
done

# Check if referenced images exist
echo "🔗 Validating asset dependencies..."
grep -o "assets/images/[^\"';]*\.\(jpg\|jpeg\|png\|webp\|svg\)" index.html | while read image_path; do
    if [ ! -f "$image_path" ]; then
        echo "❌ FAILED: Referenced image missing: $image_path"
        exit 1
    fi
done

# Check hero background image
if ! grep -q "background.*image.*pexels-apasaric\|style.*background" index.html; then
    echo "⚠️  WARNING: Hero background image may be missing"
    echo "💡 Check if hero section has proper background styling"
fi

# Component styling validation
echo "🎨 Validating component styling..."

# Check for menu/navigation styling
if ! grep -q "\.soap-bar-nav\|\.nav-link" assets/css/optimized.css; then
    echo "❌ FAILED: Menu/navigation styling missing from CSS"
    echo "💡 SOLUTION: Add menu styling rules to optimized.css"
    exit 1
fi

# Check for Latest Opportunities image styling (critical for square images)
if ! grep -q "\.item-wrapper.*\.item-img.*img\|padding-bottom.*100%" assets/css/optimized.css; then
    echo "❌ FAILED: Latest Opportunities square image styling missing"
    echo "💡 SOLUTION: Add .item-wrapper .item-img img { padding-bottom: 100%; object-fit: cover; }"
    exit 1
fi

# COMPREHENSIVE HTML-CSS VALIDATION
echo "🔍 Validating ALL HTML classes have CSS definitions..."

# Extract all unique class names from HTML files (improved regex)
HTML_CLASSES=$(grep -h 'class="[^"]*"' *.html development/*.html 2>/dev/null | \
    sed 's/.*class="\([^"]*\)".*/\1/' | \
    tr ' ' '\n' | \
    grep -v '^$' | \
    grep -E '^[a-zA-Z][a-zA-Z0-9_-]*$' | \
    sort | uniq)

# Extract all CSS class definitions
CSS_CLASSES=$(grep -o '^\.[a-zA-Z][a-zA-Z0-9_-]*' assets/css/optimized.css | \
    sed 's/^\.//' | sort | uniq)

# Check for missing CSS definitions
MISSING_CLASSES=""
for class in $HTML_CLASSES; do
    if ! echo "$CSS_CLASSES" | grep -q "^$class$"; then
        MISSING_CLASSES="$MISSING_CLASSES $class"
    fi
done

if [ ! -z "$MISSING_CLASSES" ]; then
    echo "❌ FAILED: HTML classes missing CSS definitions:"
    echo "$MISSING_CLASSES" | tr ' ' '\n' | grep -v '^$' | while read class; do
        echo "  - Missing: .$class"
    done
    echo "💡 SOLUTION: Add CSS definitions for missing classes to optimized.css"
    exit 1
fi

# Check for Mobirise references in code (should not exist)
MOBIRISE_CODE=$(grep -r -i "mbr-\|mobirise\|header[0-9]\|cid-uMOnIu" development/ 2>/dev/null | grep -v "Binary file" | wc -l)
if [ "$MOBIRISE_CODE" -gt 0 ]; then
    echo "❌ FAILED: Mobirise references detected in code:"
    grep -r -i "mbr-\|mobirise\|header[0-9]\|cid-uMOnIu" development/ 2>/dev/null | grep -v "Binary file" | while read line; do
        echo "  - $line"
    done
    echo "💡 SOLUTION: Remove all Mobirise references and use custom classes"
    exit 1
fi

# Check for Mobirise classes in documentation (should not exist)
MOBIRISE_DOCS=$(grep -r "menu2\|navbar-dropdown\|mobi-mbri\|cid-uMOnIucJDw\|\.header18\.cid-uMOnIuaQSz" docs/ 2>/dev/null | wc -l)
if [ "$MOBIRISE_DOCS" -gt 0 ]; then
    echo "❌ FAILED: Mobirise classes found in documentation files"
    echo "💡 SOLUTION: Remove all Mobirise class references from docs/"
    exit 1
fi

echo "✅ No Mobirise classes in documentation"

# Check for critical CSS classes in HTML
CRITICAL_COMPONENTS=(
    "soap-bar-nav"
    "hero-section"
    "hero-overlay"
    "nav-link"
)

for component in "${CRITICAL_COMPONENTS[@]}"; do
    if ! grep -q "$component" index.html; then
        echo "⚠️  WARNING: Critical component missing: $component"
    fi
done

# Check CSS file integrity
echo "📄 Validating CSS file integrity..."
if [ ! -f "assets/css/optimized.css" ]; then
    echo "❌ FAILED: Critical CSS file missing: optimized.css"
    exit 1
fi

# Check for minimum CSS content
CSS_SIZE=$(wc -c < "assets/css/optimized.css")
if [ "$CSS_SIZE" -lt 1000 ]; then
    echo "❌ FAILED: CSS file too small ($CSS_SIZE bytes) - may be corrupted"
    exit 1
fi

# CSS Quality Standards - Prevent !important Band-aid Solutions
echo "🎨 Validating CSS quality standards..."

# Check for excessive !important usage in custom CSS files
CUSTOM_CSS_FILES=(
    "assets/css/mobile-text-fixes.css"
    "assets/css/typography.css"
    "assets/css/spacing.css"
    "assets/css/mobile-responsive.css"
)

TOTAL_IMPORTANT=0
for css_file in "${CUSTOM_CSS_FILES[@]}"; do
    if [ -f "$css_file" ]; then
        IMPORTANT_COUNT=$(grep -c "!important" "$css_file" 2>/dev/null || echo "0" | head -1)
        IMPORTANT_COUNT=${IMPORTANT_COUNT:-0}
        if [ -z "$IMPORTANT_COUNT" ]; then
            IMPORTANT_COUNT=0
        fi
        TOTAL_IMPORTANT=$((TOTAL_IMPORTANT + IMPORTANT_COUNT))
        if [ "$IMPORTANT_COUNT" -gt 0 ]; then
            echo "  ⚠️  $css_file: $IMPORTANT_COUNT !important declarations"
        fi
    fi
done

# Check optimized.css for justified !important only
OPTIMIZED_IMPORTANT=$(grep -c "!important" "assets/css/optimized.css" 2>/dev/null || echo "0" | head -1)
OPTIMIZED_IMPORTANT=${OPTIMIZED_IMPORTANT:-0}
if [ "$OPTIMIZED_IMPORTANT" -gt 0 ] 2>/dev/null; then
    echo "❌ FAILED: !important anti-pattern detected: !important found in optimized.css"
    echo "🚨 Found $OPTIMIZED_IMPORTANT violations in custom CSS files"
    echo "💡 SOLUTION: Remove !important and use specific selectors"
    exit 1
fi

# Initialize TOTAL_IMPORTANT if not set
TOTAL_IMPORTANT=${TOTAL_IMPORTANT:-0}
TOTAL_IMPORTANT=$((TOTAL_IMPORTANT + OPTIMIZED_IMPORTANT))

if [ "$TOTAL_IMPORTANT" -gt 10 ] 2>/dev/null; then
    echo "❌ FAILED: Excessive !important usage detected ($TOTAL_IMPORTANT total)"
    echo "🚨 CSS Quality Standard: Maximum 10 !important declarations allowed"
    echo ""
    echo "📋 !important Usage Breakdown:"
    for css_file in "${CUSTOM_CSS_FILES[@]}"; do
        if [ -f "$css_file" ]; then
            IMPORTANT_COUNT=$(grep -c "!important" "$css_file" 2>/dev/null || echo "0" | head -1)
            IMPORTANT_COUNT=${IMPORTANT_COUNT:-0}
            if [ -z "$IMPORTANT_COUNT" ]; then
                IMPORTANT_COUNT=0
            fi
            if [ "$IMPORTANT_COUNT" -gt 0 ] 2>/dev/null; then
                echo "  ❌ $css_file: $IMPORTANT_COUNT !important (should be 0)"
            fi
        fi
    done
    echo "  📊 mbr-additional.css: $MBR_IMPORTANT !important (max 8 allowed)"
    echo ""
    echo "💡 SOLUTION: Remove unnecessary !important declarations"
    echo "✅ Use specific selectors and proper CSS cascade instead"
    echo "✅ Only use !important for framework overrides (mbr-additional.css)"
    exit 1
fi

# Check for specific !important anti-patterns
echo "🔍 Checking for !important anti-patterns..."

# Check for !important on basic properties that shouldn't need it
ANTI_PATTERNS=(
    "color.*!important"
    "background.*!important"
    "padding.*!important"
    "margin.*!important"
    "font-size.*!important"
    "font-weight.*!important"
)

for pattern in "${ANTI_PATTERNS[@]}"; do
    VIOLATIONS=$(grep -r "$pattern" assets/css/ 2>/dev/null | wc -l)
    if [ "$VIOLATIONS" -gt 0 ]; then
        echo "❌ FAILED: !important anti-pattern detected: $pattern"
        echo "🚨 Found $VIOLATIONS violations in custom CSS files"
        echo "💡 SOLUTION: Remove !important and use specific selectors"
        exit 1
    fi
done

echo "✅ CSS quality standards validated"

# CSS Specificity Validation
echo "🎯 Running CSS specificity validation..."

# Run specificity validator if available
if [ -f "css-specificity-validator.sh" ]; then
    ./css-specificity-validator.sh --quiet
    if [ $? -ne 0 ]; then
        echo "  ⚠️  WARNING: CSS specificity issues detected"
        echo "  💡 Run ./css-specificity-validator.sh for detailed analysis"
        echo "  📝 Consider fixing CSS selector specificity issues"
    else
        echo "  ✅ CSS specificity validation passed"
    fi
else
    echo "  ℹ️  CSS specificity validator not available"
fi

echo "✅ CSS specificity validation completed"

# Design Documentation Validation - Prevent Design Corrections Without Documentation
echo "📋 Validating design documentation completeness..."

# Check for design changes that might need documentation updates
DESIGN_CHANGES_DETECTED=false

# Check for new CSS classes or components that might need documentation
# Check for new CSS classes
NEW_CSS_CLASSES=$(grep -r "^\." assets/css/ 2>/dev/null | grep -v "/*" | grep -v "//" | awk '{print $1}' | cut -d: -f2 | sort -u)
DOCUMENTED_COMPONENTS=$(grep -r "### .*Component\|#### .*Component" ../docs/ 2>/dev/null | awk -F'### |#### ' '{print $2}' | awk -F' Component' '{print $1}' | sort -u)

# Check for image-related CSS changes
if grep -r "\.item-img\|\.hero\|\.card.*img\|aspect-ratio\|object-fit" assets/css/ 2>/dev/null | grep -v "/*" >/dev/null; then
    echo "  🔍 Image-related CSS changes detected"
    
    # Check if Latest Opportunities images are documented
    if ! grep -q "Latest Opportunities.*square\|1:1 aspect ratio" ../docs/VISUAL_STANDARDS.md 2>/dev/null; then
        echo "  ⚠️  WARNING: Image styling changes detected but Latest Opportunities specifications may not be documented"
        echo "  💡 Consider updating VISUAL_STANDARDS.md with image aspect ratio requirements"
        DESIGN_CHANGES_DETECTED=true
    fi
fi

# Check for typography changes
if grep -r "font-family\|font-size\|display-[0-9]" assets/css/ 2>/dev/null | grep -v "/*" >/dev/null; then
    echo "  🔍 Typography changes detected"
    
    # Check if typography hierarchy is documented
    if ! grep -q "display-1.*Playfair\|display-2.*Manrope\|Typography Hierarchy" ../docs/VISUAL_STANDARDS.md 2>/dev/null; then
        echo "  ⚠️  WARNING: Typography changes detected but hierarchy may not be documented"
        echo "  💡 Consider updating VISUAL_STANDARDS.md with typography specifications"
        DESIGN_CHANGES_DETECTED=true
    fi
fi

# Check for layout changes
if grep -r "grid\|flex\|width.*%\|height.*vh" assets/css/ 2>/dev/null | grep -v "/*" >/dev/null; then
    echo "  🔍 Layout changes detected"
    
    # Check if layout guidelines are documented
    if ! grep -q "Layout.*Guidelines\|Grid.*Layout\|Responsive.*Layout" ../docs/LAYOUT_GUIDELINES.md 2>/dev/null; then
        echo "  ⚠️  WARNING: Layout changes detected but guidelines may not be documented"
        echo "  💡 Consider updating LAYOUT_GUIDELINES.md with layout specifications"
        DESIGN_CHANGES_DETECTED=true
    fi
fi

# Check for new components
if find assets/ -name "*.css" -exec grep -l "^\." {} \; 2>/dev/null | xargs grep -h "^\\." 2>/dev/null | grep -v "/*" | awk '{print $1}' | sort -u | wc -l | xargs -I {} test {} -gt 10; then
    echo "  🔍 Multiple CSS classes detected"
    
    # Check if component library is up to date
    if ! grep -q "Latest Opportunities Component\|Content Cards\|Hero Component" ../docs/COMPONENT_LIBRARY.md 2>/dev/null; then
        echo "  ⚠️  WARNING: Multiple CSS classes detected but component library may not be complete"
        echo "  💡 Consider updating COMPONENT_LIBRARY.md with new component specifications"
        DESIGN_CHANGES_DETECTED=true
    fi
fi

if [ "$DESIGN_CHANGES_DETECTED" = true ]; then
    echo ""
    echo "📝 DESIGN DOCUMENTATION REMINDER:"
    echo "================================"
    echo "When making design corrections, ensure you update the documentation to capture:"
    echo "  ✅ The intended design specifications (not just the changes)"
    echo "  ✅ Component behavior and styling requirements"
    echo "  ✅ Visual standards and guidelines"
    echo "  ✅ Technical implementation details"
    echo ""
    echo "💡 This prevents future developers from having to guess the intended design!"
    echo ""
fi

echo "✅ Design documentation validation completed"

# Architectural Documentation Enforcement
echo "🏗️ Running architectural documentation enforcement..."

# Get the directory where this script is located and adjust for working directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# If we're running from development directory, go up one level to find scripts
if [[ "$PWD" == *"/development" ]]; then
    PROJECT_ROOT="$(dirname "$PWD")"
    ARCHITECTURAL_ENFORCER="$PROJECT_ROOT/scripts/architectural-enforcer.sh"
    WORKFLOW_ENFORCER="$PROJECT_ROOT/scripts/ai-agent-workflow-enforcer.sh"
else
    ARCHITECTURAL_ENFORCER="$SCRIPT_DIR/architectural-enforcer.sh"
    WORKFLOW_ENFORCER="$SCRIPT_DIR/ai-agent-workflow-enforcer.sh"
fi

if [ -f "$ARCHITECTURAL_ENFORCER" ]; then
    echo "🔍 Found architectural enforcer at: $ARCHITECTURAL_ENFORCER"
    "$ARCHITECTURAL_ENFORCER"
    if [ $? -ne 0 ]; then
        echo "❌ FAILED: Architectural documentation violations detected"
        echo "🚨 AI agent must update architectural blueprints"
        echo "💡 Run: $ARCHITECTURAL_ENFORCER"
        echo ""
        echo "🚨 DEPLOYMENT BLOCKED - Fix documentation violations first"
        exit 1
    fi
    echo "✅ Architectural documentation enforcement completed"
else
    echo "⚠️  WARNING: Architectural enforcer not found at: $ARCHITECTURAL_ENFORCER"
    echo "💡 Expected location: $ARCHITECTURAL_ENFORCER"
    echo "🚨 DEPLOYMENT BLOCKED - Architectural enforcer missing"
    exit 1
fi

# AI Agent Workflow Enforcement
echo "🤖 Running AI agent workflow enforcement..."
if [ -f "$WORKFLOW_ENFORCER" ]; then
    echo "🔍 Found workflow enforcer at: $WORKFLOW_ENFORCER"
    "$WORKFLOW_ENFORCER"
    if [ $? -ne 0 ]; then
        echo "❌ FAILED: AI agent workflow violations detected"
        echo "🚨 AI agent must follow mandatory workflow"
        echo "💡 Review: development/.ai-agent-workflow"
        echo ""
        echo "🚨 DEPLOYMENT BLOCKED - Fix workflow violations first"
        exit 1
    fi
    echo "✅ AI agent workflow enforcement completed"
else
    echo "⚠️  WARNING: AI agent workflow enforcer not found at: $WORKFLOW_ENFORCER"
    echo "💡 Expected location: $WORKFLOW_ENFORCER"
    echo "🚨 DEPLOYMENT BLOCKED - Workflow enforcer missing"
    exit 1
fi

# Design Intent Enforcement
echo "🎯 Running design intent enforcement..."

# Run design intent enforcer
if [ -f "design-intent-enforcer.sh" ]; then
    ./design-intent-enforcer.sh
    if [ $? -ne 0 ]; then
        echo "❌ FAILED: Design intent violations detected"
        echo "🚨 Changes violate documented design principles"
        echo "💡 Review docs/CURRENT_DESIGN_IMPLEMENTATION.md"
        exit 1
    fi
else
    echo "⚠️  WARNING: Design intent enforcer not available"
    echo "💡 Install: cp ../scripts/design-intent-enforcer.sh ."
fi

echo "✅ Design intent enforcement completed"

# Documentation Efficiency Analysis
echo "📊 Running documentation efficiency analysis..."

# Run efficiency analyzer if available
if [ -f "docs-efficiency-analyzer.sh" ]; then
    ./docs-efficiency-analyzer.sh >/dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo "  ⚠️  WARNING: Documentation efficiency issues detected"
        echo "  💡 Run ./docs-efficiency-analyzer.sh for detailed analysis"
        echo "  📝 Consider optimizing documentation structure and content"
    else
        echo "  ✅ Documentation efficiency analysis passed"
    fi
else
    echo "  ℹ️  Documentation efficiency analyzer not available"
fi

# Run consolidation analyzer if available
if [ -f "docs-consolidator.sh" ]; then
    ./docs-consolidator.sh >/dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo "  ⚠️  WARNING: Documentation consolidation opportunities detected"
        echo "  💡 Run ./docs-consolidator.sh for detailed analysis"
        echo "  📚 Consider consolidating overlapping or redundant content"
    else
        echo "  ✅ Documentation consolidation analysis passed"
    fi
else
    echo "  ℹ️  Documentation consolidator not available"
fi

# Run maintenance checker if available
if [ -f "docs-maintenance.sh" ]; then
    ./docs-maintenance.sh >/dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo "  ⚠️  WARNING: Documentation maintenance needed"
        echo "  💡 Run ./docs-maintenance.sh for detailed analysis"
        echo "  🔧 Consider performing routine documentation maintenance"
    else
        echo "  ✅ Documentation maintenance analysis passed"
    fi
else
    echo "  ℹ️  Documentation maintenance checker not available"
fi

echo "✅ Documentation efficiency analysis completed"

# Realistic HTML Structure Validation
echo "🏗️  Validating HTML structure..."

# Check hero section exists
if ! grep -q "hero-section" index.html; then
    echo "❌ FAILED: Hero section missing from HTML"
    exit 1
fi

# Check navigation exists
if ! grep -q "soap-bar-nav" index.html; then
    echo "❌ FAILED: Navigation missing from HTML"
    exit 1
fi

# Check hero overlay exists
if ! grep -q "hero-overlay" index.html; then
    echo "❌ FAILED: Hero overlay missing from HTML"
    exit 1
fi

echo "✅ HTML structure valid"

echo "✅ All checks passed!"
echo "🎯 System is ready for development"

# Optional: Auto-cleanup
if [ "$1" = "--cleanup" ]; then
    echo "🧹 Running cleanup..."
    
    # Remove empty directories
    find . -type d -empty -delete 2>/dev/null
    
    # Remove temporary files
    find . -name "*.tmp" -delete 2>/dev/null
    find . -name "*.bak" -delete 2>/dev/null
    
    echo "✅ Cleanup completed"
fi

echo ""
echo "🚀 Ready for development!"
echo "Use '../deploy.sh' when ready to deploy to production"
