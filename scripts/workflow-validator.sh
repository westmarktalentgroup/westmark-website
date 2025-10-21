#!/bin/bash

# CONSOLIDATED WORKFLOW VALIDATOR
# Single comprehensive validation script replacing multiple individual validators

set -e

echo "🔍 Consolidated Workflow Validator"
echo "================================="

# Check if development directory exists
if [ ! -d "development" ]; then
    echo "❌ Error: development/ directory not found!"
    exit 1
fi

cd development

# Design Intent Validation
echo "🎯 Validating design intent compliance..."
if grep -q "!important" assets/css/optimized.css; then
    echo "❌ VIOLATION: !important usage detected"
    exit 1
fi

# Check for hardcoded colors (excluding valid cases like white, black in specific contexts)
if grep -q "color:\s*#[0-9a-fA-F]{6}" assets/css/optimized.css; then
    echo "❌ VIOLATION: Hardcoded hex colors detected (use CSS custom properties)"
    exit 1
fi

# Documentation Compliance
echo "📚 Validating documentation compliance..."
PROHIBITED_FILES=$(find . -name "*_SUMMARY.md" -o -name "*_CLEANUP.md" -o -name "*_COMPARISON.md" -o -name "*_IMPACT.md" -o -name "*_ANALYSIS.md" -o -name "*_COMPLETED.md" -o -name "*_OPTIMIZATION.md" -o -name "*_CONSOLIDATION.md" -o -name "*_EFFICIENCY.md" -o -name "PHASE_*.md")
if [ ! -z "$PROHIBITED_FILES" ]; then
    echo "❌ VIOLATION: Prohibited documentation patterns found"
    echo "$PROHIBITED_FILES"
    exit 1
fi

# Check for prohibited content in documentation
echo "📋 Validating documentation content..."
PROHIBITED_CONTENT_FOUND=false

for doc_file in $(find . -name "*.md"); do
    # Check for development summary language
    if grep -q -i "this document summarizes\|we have successfully completed\|the following improvements were implemented\|analysis of the current system shows" "$doc_file"; then
        echo "❌ VIOLATION: Development summary content found in $doc_file"
        echo "🚨 Documentation must contain structural information only"
        PROHIBITED_CONTENT_FOUND=true
    fi
    
    # Check for step-by-step process language
    if grep -q -i "step [0-9]\|the process involves\|to implement this feature, follow these steps" "$doc_file"; then
        echo "❌ VIOLATION: Step-by-step process content found in $doc_file"
        echo "🚨 Documentation must contain specifications, not processes"
        PROHIBITED_CONTENT_FOUND=true
    fi
done

if [ "$PROHIBITED_CONTENT_FOUND" = true ]; then
    exit 1
fi

# CSS Quality Validation
echo "🎨 Validating CSS quality..."
if grep -q "display:\s*none.*!important" assets/css/optimized.css; then
    echo "❌ VIOLATION: display:none !important detected"
    exit 1
fi

# File Structure Validation
echo "📁 Validating file structure..."
ESSENTIAL_FILES=("index.html" "assets/css/optimized.css" "assets/js/consolidated.js")
for file in "${ESSENTIAL_FILES[@]}"; do
    if [ ! -f "$file" ]; then
        echo "❌ VIOLATION: Essential file missing: $file"
        exit 1
    fi
done

echo "✅ All validations passed!"
exit 0
