#!/bin/bash

# DOCUMENTATION EFFICIENCY ANALYZER
# Proactively analyzes and optimizes documentation for efficiency

echo "📊 Documentation Efficiency Analyzer"
echo "===================================="

# Check if we're in the right directory
if [[ "$PWD" != *"/development" ]]; then
    echo "❌ Error: Run this script from the development/ directory"
    exit 1
fi

EFFICIENCY_ISSUES_FOUND=false

# Function to analyze file efficiency
analyze_file_efficiency() {
    local file="$1"
    local lines=$(wc -l < "$file")
    local words=$(wc -w < "$file")
    local chars=$(wc -c < "$file")
    
    # Efficiency thresholds
    local max_lines=500
    local min_words_per_line=10
    local max_chars_per_line=100
    
    local words_per_line=$((words / lines))
    local chars_per_line=$((chars / lines))
    
    if [ "$lines" -gt "$max_lines" ]; then
        echo "  ⚠️  $file: Too long ($lines lines, max recommended: $max_lines)"
        echo "  💡 Consider splitting into smaller, focused documents"
        EFFICIENCY_ISSUES_FOUND=true
    fi
    
    if [ "$words_per_line" -lt "$min_words_per_line" ]; then
        echo "  ⚠️  $file: Low content density ($words_per_line words/line)"
        echo "  💡 Consider consolidating or adding more content"
        EFFICIENCY_ISSUES_FOUND=true
    fi
    
    if [ "$chars_per_line" -gt "$max_chars_per_line" ]; then
        echo "  ⚠️  $file: Lines too long ($chars_per_line chars/line)"
        echo "  💡 Consider breaking long lines for readability"
        EFFICIENCY_ISSUES_FOUND=true
    fi
}

# Function to detect redundancy
detect_redundancy() {
    echo "🔍 Analyzing for redundancy and overlapping content..."
    
    # Check for similar file names
    SIMILAR_FILES=$(find ../docs/ -name "*.md" -exec basename {} \; | sort | uniq -d)
    if [ ! -z "$SIMILAR_FILES" ]; then
        echo "  ⚠️  Duplicate file names found:"
        echo "$SIMILAR_FILES"
        echo "  💡 Consider consolidating duplicate files"
        EFFICIENCY_ISSUES_FOUND=true
    fi
    
    # Check for overlapping content patterns
    OVERLAP_PATTERNS=(
        "CSS.*architecture"
        "deployment.*guidelines"
        "visual.*standards"
        "component.*library"
        "prevention.*framework"
    )
    
    for pattern in "${OVERLAP_PATTERNS[@]}"; do
        MATCHING_FILES=$(grep -l "$pattern" ../docs/*.md 2>/dev/null | wc -l)
        if [ "$MATCHING_FILES" -gt 2 ]; then
            echo "  ⚠️  Potential content overlap detected for: $pattern"
            echo "  💡 Consider consolidating related content"
            EFFICIENCY_ISSUES_FOUND=true
        fi
    done
}

# Function to analyze documentation structure
analyze_structure() {
    echo "📋 Analyzing documentation structure..."
    
    # Check for essential documentation
    ESSENTIAL_DOCS=(
        "README.md"
        "TECHNICAL_ARCHITECTURE.md"
        "VISUAL_STANDARDS.md"
        "COMPONENT_LIBRARY.md"
        "ASSET_INVENTORY.md"
    )
    
    MISSING_ESSENTIAL=false
    for doc in "${ESSENTIAL_DOCS[@]}"; do
        if [ ! -f "../docs/$doc" ]; then
            echo "  ❌ Missing essential documentation: $doc"
            MISSING_ESSENTIAL=true
        fi
    done
    
    if [ "$MISSING_ESSENTIAL" = true ]; then
        echo "  💡 Essential documentation is required for project maintenance"
        EFFICIENCY_ISSUES_FOUND=true
    fi
    
    # Check for documentation bloat
    BLOAT_PATTERNS=(
        "*_SUMMARY.md"
        "*_CLEANUP.md"
        "*_COMPARISON.md"
        "*_IMPACT.md"
        "PHASE_*.md"
        "TEMP_*.md"
    )
    
    for pattern in "${BLOAT_PATTERNS[@]}"; do
        BLOAT_FILES=$(find ../docs/ -name "$pattern" 2>/dev/null)
        if [ ! -z "$BLOAT_FILES" ]; then
            echo "  🗑️  Documentation bloat detected: $BLOAT_FILES"
            echo "  💡 Consider removing temporary or redundant documentation"
            EFFICIENCY_ISSUES_FOUND=true
        fi
    done
}

# Function to suggest optimizations
suggest_optimizations() {
    echo "💡 Documentation Optimization Suggestions:"
    echo "========================================="
    
    echo "📊 Current Statistics:"
    echo "  - Files: $(find ../docs/ -name "*.md" | wc -l)"
    echo "  - Total lines: $(find ../docs/ -name "*.md" -exec wc -l {} \; | awk '{total += $1} END {print total}')"
    echo "  - Total words: $(find ../docs/ -name "*.md" -exec wc -w {} \; | awk '{total += $1} END {print total}')"
    echo "  - Total size: $(find ../docs/ -name "*.md" -exec wc -c {} \; | awk '{total += $1} END {print int(total/1024) " KB"}')"
    
    echo ""
    echo "🎯 Efficiency Recommendations:"
    echo "  1. Keep individual files under 500 lines for maintainability"
    echo "  2. Aim for 10+ words per line for content density"
    echo "  3. Break long lines for better readability"
    echo "  4. Consolidate overlapping content into focused documents"
    echo "  5. Remove temporary or redundant documentation"
    echo "  6. Use clear, descriptive file names"
    echo "  7. Maintain essential documentation coverage"
    
    echo ""
    echo "📈 Proactive Efficiency Measures:"
    echo "  ✅ Regular efficiency analysis (monthly)"
    echo "  ✅ Automated redundancy detection"
    echo "  ✅ Content density monitoring"
    echo "  ✅ Structure validation"
    echo "  ✅ Bloat prevention"
}

# Main analysis
echo "🔍 Starting comprehensive documentation efficiency analysis..."
echo ""

# Analyze individual files
echo "📄 Analyzing individual file efficiency..."
for file in ../docs/*.md; do
    if [ -f "$file" ]; then
        analyze_file_efficiency "$file"
    fi
done

echo ""

# Detect redundancy
detect_redundancy

echo ""

# Analyze structure
analyze_structure

echo ""

# Provide suggestions
suggest_optimizations

echo ""
if [ "$EFFICIENCY_ISSUES_FOUND" = true ]; then
    echo "⚠️  Documentation efficiency issues found"
    echo "💡 Review the suggestions above to improve efficiency"
    exit 1
else
    echo "✅ Documentation efficiency analysis passed"
    echo "🎯 Documentation is well-structured and efficient"
fi
