#!/bin/bash

# DESIGN INTENT ENFORCER
# Prevents AI agents from violating documented design principles
# Runs automatically on every change to enforce documentation compliance

echo "🎯 Design Intent Enforcer"
echo "========================"

# Change to development directory
cd development

# Design Intent Validation Database
declare -A DESIGN_INTENTS

# Load documented design intents from CURRENT_DESIGN_IMPLEMENTATION.md
DESIGN_DOC="../docs/CURRENT_DESIGN_IMPLEMENTATION.md"

if [ ! -f "$DESIGN_DOC" ]; then
    echo "❌ FAILED: Design documentation missing: $DESIGN_DOC"
    exit 1
fi

echo "📋 Loading documented design intents..."

# Extract design intents from documentation
DESIGN_INTENTS["hero-gradient"]="minimal-contrast"
DESIGN_INTENTS["hero-overlay-opacity"]="15%-5%-transparent"
DESIGN_INTENTS["navigation-style"]="soap-bar-floating"
DESIGN_INTENTS["typography-hero"]="playfair-display-only"
DESIGN_INTENTS["button-style"]="primary-black-secondary-red"

echo "✅ Design intents loaded: ${#DESIGN_INTENTS[@]} principles"

# Function to validate CSS changes against design intent
validate_css_against_design_intent() {
    local css_file="$1"
    local violations=0
    
    echo "🔍 Validating CSS against documented design intents..."
    
    # Check hero gradient against documented minimal contrast
    if grep -q "\.hero-overlay" "$css_file"; then
        GRADIENT_LINE=$(grep -A 10 "\.hero-overlay" "$css_file" | grep "linear-gradient" | head -1)
        
        # Check if gradient violates minimal contrast principle
        if echo "$GRADIENT_LINE" | grep -q "rgba(0, 0, 0, 0\.[3-9][0-9]*)\|rgba(0, 0, 0, 0\.[4-9])"; then
            echo "❌ VIOLATION: Hero gradient exceeds documented minimal contrast (15% max)"
            echo "   Found: $GRADIENT_LINE"
            echo "   Expected: rgba(0, 0, 0, 0.15) maximum opacity"
            echo "   Design Intent: Minimal contrast gradient for text readability"
            violations=$((violations + 1))
        fi
    fi
    
    # Check for undocumented !important usage
    if grep -q "!important" "$css_file"; then
        IMPORTANT_COUNT=$(grep -c "!important" "$css_file")
        if [ "$IMPORTANT_COUNT" -gt 0 ]; then
            echo "❌ VIOLATION: !important anti-pattern detected ($IMPORTANT_COUNT instances)"
            echo "   Design Intent: Clean CSS without !important overrides"
            violations=$((violations + 1))
        fi
    fi
    
    # Check for hardcoded values that should use design tokens
    if grep -q "color:\s*#[0-9a-fA-F]\{3,6\}\|background:\s*#[0-9a-fA-F]\{3,6\}" "$css_file"; then
        echo "❌ VIOLATION: Hardcoded colors found (should use CSS custom properties)"
        echo "   Design Intent: Use design tokens for consistency"
        violations=$((violations + 1))
    fi
    
    return $violations
}

# Function to validate HTML changes against design intent
validate_html_against_design_intent() {
    local html_file="$1"
    local violations=0
    
    echo "🔍 Validating HTML against documented design intents..."
    
    # Check hero section structure
    if grep -q "hero-section" "$html_file"; then
        if ! grep -q "hero-overlay" "$html_file"; then
            echo "❌ VIOLATION: Hero section missing required overlay element"
            echo "   Design Intent: Hero section requires overlay for text readability"
            violations=$((violations + 1))
        fi
    fi
    
    # Check navigation structure
    if ! grep -q "soap-bar-nav" "$html_file"; then
        echo "❌ VIOLATION: Missing soap bar navigation structure"
        echo "   Design Intent: Floating soap bar navigation required"
        violations=$((violations + 1))
    fi
    
    return $violations
}

# Main validation logic
TOTAL_VIOLATIONS=0

echo "🎯 Running design intent validation..."

# Validate CSS files
for css_file in assets/css/*.css; do
    if [ -f "$css_file" ]; then
        validate_css_against_design_intent "$css_file"
        TOTAL_VIOLATIONS=$((TOTAL_VIOLATIONS + $?))
    fi
done

# Validate HTML files
for html_file in *.html; do
    if [ -f "$html_file" ]; then
        validate_html_against_design_intent "$html_file"
        TOTAL_VIOLATIONS=$((TOTAL_VIOLATIONS + $?))
    fi
done

# Check for documentation updates needed
echo "📚 Checking if design changes require documentation updates..."

# Check if CSS changes affect documented components
if git diff --name-only HEAD~1 HEAD 2>/dev/null | grep -q "\.css$"; then
    echo "  🔍 CSS changes detected - checking documentation coverage..."
    
    # Check if hero-related changes are documented
    if git diff HEAD~1 HEAD assets/css/*.css 2>/dev/null | grep -q "hero\|overlay\|gradient"; then
        if ! grep -q "Hero.*Gradient.*Minimal.*Contrast" "$DESIGN_DOC"; then
            echo "  ⚠️  WARNING: Hero-related changes detected but may not be documented"
        fi
    fi
fi

# Final validation
if [ "$TOTAL_VIOLATIONS" -gt 0 ]; then
    echo ""
    echo "🚨 DESIGN INTENT VIOLATIONS DETECTED: $TOTAL_VIOLATIONS"
    echo "=================================================="
    echo ""
    echo "💡 SOLUTIONS:"
    echo "  1. Review docs/CURRENT_DESIGN_IMPLEMENTATION.md"
    echo "  2. Align changes with documented design principles"
    echo "  3. Update documentation if design intent has changed"
    echo "  4. Use design tokens instead of hardcoded values"
    echo ""
    echo "📋 REQUIRED ACTIONS:"
    echo "  ✅ Fix violations to match documented design intent"
    echo "  ✅ Update documentation if design principles have changed"
    echo "  ✅ Re-run validation before committing"
    echo ""
    exit 1
else
    echo "✅ All design intent validations passed!"
    echo "🎯 Changes align with documented design principles"
fi

echo ""
echo "🚀 Design intent enforcement completed"
