#!/bin/bash

# CSS SPECIFICITY VALIDATOR - EFFICIENT VERSION
# Optimized for performance with minimal output

# Parse arguments
QUIET_MODE=false
if [[ "$1" == "--quiet" ]] || [[ "$1" == "-q" ]]; then
    QUIET_MODE=true
fi

# Check directory
if [[ "$PWD" != *"/development" ]]; then
    echo "❌ Error: Run from development/ directory" >&2
    exit 1
fi

ISSUES_FOUND=false
ISSUE_COUNT=0

# Function to report issues efficiently
report_issue() {
    local type="$1"
    local file="$2"
    local line="$3"
    local content="$4"
    
    ISSUES_FOUND=true
    ((ISSUE_COUNT++))
    
    if [ "$QUIET_MODE" = false ]; then
        echo "❌ $type: $file:$line - $content"
    fi
}

# Check for generic selectors (main efficiency issue)
check_generic_selectors() {
    # Generic img selectors
    while IFS= read -r line; do
        if [ ! -z "$line" ]; then
            FILE=$(echo "$line" | cut -d: -f1)
            LINE_NUM=$(echo "$line" | cut -d: -f2)
            CONTENT=$(echo "$line" | cut -d: -f3-)
            if echo "$CONTENT" | grep -q "^[[:space:]]*img[[:space:]]*{"; then
                report_issue "Generic img selector" "$FILE" "$LINE_NUM" "$CONTENT"
            fi
        fi
    done < <(find assets/ -name "*.css" -exec grep -n "img {" {} + 2>/dev/null)
    
    # Generic div selectors
    while IFS= read -r line; do
        if [ ! -z "$line" ]; then
            FILE=$(echo "$line" | cut -d: -f1)
            LINE_NUM=$(echo "$line" | cut -d: -f2)
            CONTENT=$(echo "$line" | cut -d: -f3-)
            if echo "$CONTENT" | grep -q "^[[:space:]]*div[[:space:]]*{"; then
                report_issue "Generic div selector" "$FILE" "$LINE_NUM" "$CONTENT"
            fi
        fi
    done < <(find assets/ -name "*.css" -exec grep -n "div {" {} + 2>/dev/null)
    
    # Generic p selectors (excluding base CSS)
    while IFS= read -r line; do
        if [ ! -z "$line" ]; then
            FILE=$(echo "$line" | cut -d: -f1)
            LINE_NUM=$(echo "$line" | cut -d: -f2)
            CONTENT=$(echo "$line" | cut -d: -f3-)
            if echo "$CONTENT" | grep -q "^[[:space:]]*p[[:space:]]*{" && [[ "$FILE" != *"optimized.css"* ]]; then
                report_issue "Generic p selector" "$FILE" "$LINE_NUM" "$CONTENT"
            fi
        fi
    done < <(find assets/ -name "*.css" -exec grep -n "p {" {} + 2>/dev/null)
}

# Check for missing critical CSS rules
check_missing_css() {
    if ! grep -q "padding-bottom.*100%" assets/css/optimized.css; then
        report_issue "Missing CSS rule" "assets/css/optimized.css" "N/A" "Latest Opportunities square image styling"
    fi
    
    if ! grep -q "object-fit.*cover" assets/css/optimized.css; then
        report_issue "Missing CSS rule" "assets/css/optimized.css" "N/A" "Object-fit cover styling"
    fi
}

# Main execution
if [ "$QUIET_MODE" = false ]; then
    echo "🎯 CSS Specificity Validator (Efficient)"
    echo "========================================"
fi

check_generic_selectors
check_missing_css

# Summary output
if [ "$ISSUES_FOUND" = true ]; then
    if [ "$QUIET_MODE" = false ]; then
        echo ""
        echo "⚠️  CSS specificity issues found: $ISSUE_COUNT"
        echo "💡 Fix issues above to improve CSS architecture"
    fi
    exit 1
else
    if [ "$QUIET_MODE" = false ]; then
        echo "✅ CSS specificity validation passed"
    fi
    exit 0
fi
