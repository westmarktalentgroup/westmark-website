#!/bin/bash

# AI AGENT VALIDATION SYSTEM
# Validates that AI agents follow documented design principles
# Can be run by any AI agent before making changes

echo "🤖 AI Agent Design Validation System"
echo "===================================="

# Check if running in development directory
if [ ! -f "index.html" ]; then
    echo "❌ Error: Must run from development directory"
    exit 1
fi

# Design Intent Quick Reference
echo "📋 DESIGN INTENT QUICK REFERENCE:"
echo "================================"
echo "🎯 Hero Gradient: MINIMAL CONTRAST (15% → 5% → transparent)"
echo "🎯 Navigation: Soap bar floating style"
echo "🎯 Typography: Playfair Display ONLY for hero"
echo "🎯 Colors: Use CSS custom properties, not hardcoded values"
echo "🎯 CSS Quality: NO !important allowed"
echo ""

# Function to validate proposed changes
validate_proposed_change() {
    local change_type="$1"
    local change_description="$2"
    
    echo "🔍 Validating proposed change: $change_description"
    
    case "$change_type" in
        "hero-gradient")
            echo "  ⚠️  WARNING: Hero gradient changes detected!"
            echo "  📋 DOCUMENTED INTENT: Minimal contrast (15% max opacity)"
            echo "  ❓ QUESTION: Does this change align with 'minimal contrast' principle?"
            echo "  💡 SUGGESTION: Check docs/CURRENT_DESIGN_IMPLEMENTATION.md"
            return 1
            ;;
        "css-important")
            echo "  ❌ BLOCKED: !important usage detected!"
            echo "  📋 DOCUMENTED INTENT: Clean CSS without !important"
            echo "  💡 ALTERNATIVE: Use specific selectors or design tokens"
            return 1
            ;;
        "hardcoded-colors")
            echo "  ❌ BLOCKED: Hardcoded colors detected!"
            echo "  📋 DOCUMENTED INTENT: Use CSS custom properties"
            echo "  💡 ALTERNATIVE: Use var(--color-primary) instead of #000000"
            return 1
            ;;
        "typography-mixing")
            echo "  ⚠️  WARNING: Typography mixing detected!"
            echo "  📋 DOCUMENTED INTENT: Playfair Display ONLY for hero"
            echo "  💡 SUGGESTION: Use Manrope for all other text"
            return 1
            ;;
        "navigation-style")
            echo "  ⚠️  WARNING: Navigation style changes detected!"
            echo "  📋 DOCUMENTED INTENT: Soap bar floating navigation"
            echo "  💡 SUGGESTION: Maintain soap bar styling"
            return 1
            ;;
    esac
    
    return 0
}

# Function to check current state against documentation
check_current_state() {
    echo "🔍 Checking current implementation against documentation..."
    
    # Check hero gradient
    if grep -q "\.hero-overlay" assets/css/optimized.css; then
        GRADIENT_LINE=$(grep -A 5 "\.hero-overlay" assets/css/optimized.css | grep "linear-gradient")
        if echo "$GRADIENT_LINE" | grep -q "rgba(0, 0, 0, 0\.[3-9]"; then
            echo "  ❌ VIOLATION: Hero gradient exceeds documented minimal contrast"
            echo "  📋 Current: $GRADIENT_LINE"
            echo "  📋 Expected: rgba(0, 0, 0, 0.15) maximum"
            return 1
        fi
    fi
    
    # Check for !important
    if grep -q "!important" assets/css/optimized.css; then
        echo "  ❌ VIOLATION: !important usage detected"
        return 1
    fi
    
    # Check for hardcoded colors
    if grep -q "color:\s*#[0-9a-fA-F]" assets/css/optimized.css; then
        echo "  ❌ VIOLATION: Hardcoded colors detected"
        return 1
    fi
    
    echo "  ✅ Current implementation aligns with documentation"
    return 0
}

# Function to provide design guidance
provide_design_guidance() {
    local component="$1"
    
    echo "📚 DESIGN GUIDANCE for $component:"
    echo "================================"
    
    case "$component" in
        "hero-section")
            echo "  🎯 INTENT: Minimal contrast gradient for text readability"
            echo "  📋 SPECS: rgba(0, 0, 0, 0.15) → rgba(0, 0, 0, 0.05) → transparent"
            echo "  💡 PURPOSE: Provide just enough contrast without overwhelming image"
            ;;
        "navigation")
            echo "  🎯 INTENT: Floating soap bar navigation"
            echo "  📋 SPECS: Rounded corners, backdrop blur, content-aware width"
            echo "  💡 PURPOSE: Modern floating navigation that sizes to content"
            ;;
        "typography")
            echo "  🎯 INTENT: Playfair Display ONLY for hero text"
            echo "  📋 SPECS: Manrope for all other text elements"
            echo "  💡 PURPOSE: Clear typography hierarchy"
            ;;
        "buttons")
            echo "  🎯 INTENT: Primary black, secondary red color scheme"
            echo "  📋 SPECS: Use var(--color-primary) and var(--color-secondary)"
            echo "  💡 PURPOSE: Consistent brand colors"
            ;;
    esac
}

# Main validation
echo "🚀 Starting AI Agent validation..."

# Check current state
check_current_state
if [ $? -ne 0 ]; then
    echo ""
    echo "🚨 CURRENT STATE VIOLATIONS DETECTED"
    echo "===================================="
    echo "💡 SUGGESTIONS:"
    echo "  1. Review docs/CURRENT_DESIGN_IMPLEMENTATION.md"
    echo "  2. Align implementation with documented design intent"
    echo "  3. Use design tokens instead of hardcoded values"
    echo ""
fi

# Interactive guidance
echo "💬 AI Agent Guidance:"
echo "===================="
echo "Before making ANY design changes:"
echo "  1. 📚 Read docs/CURRENT_DESIGN_IMPLEMENTATION.md"
echo "  2. 🎯 Understand the documented design intent"
echo "  3. ❓ Ask user: 'Is this change intentional or should I follow documentation?'"
echo "  4. ✅ Validate changes against design principles"
echo "  5. 📝 Update documentation if design intent changes"
echo ""

echo "✅ AI Agent validation completed"
echo "🤖 Ready to work according to documentation"
