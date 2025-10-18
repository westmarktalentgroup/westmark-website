#!/bin/bash

# SHELL SCRIPT EFFICIENCY ANALYZER
# Analyzes all shell scripts for efficiency, maintainability, and bloat

echo "🔍 Shell Script Efficiency Analyzer"
echo "===================================="

# Function to analyze a script
analyze_script() {
    local script="$1"
    local script_name=$(basename "$script")
    
    echo ""
    echo "📄 Analyzing: $script_name"
    echo "================================"
    
    # Basic metrics
    local lines=$(wc -l < "$script")
    local size=$(wc -c < "$script")
    local functions=$(grep -c "^[a-zA-Z_][a-zA-Z0-9_]*()" "$script" 2>/dev/null || echo "0")
    local comments=$(grep -c "^#" "$script" 2>/dev/null || echo "0")
    local echo_statements=$(grep -c "echo" "$script" 2>/dev/null || echo "0")
    
    echo "📊 Metrics:"
    echo "  Lines: $lines"
    echo "  Size: $((size / 1024)) KB"
    echo "  Functions: $functions"
    echo "  Comments: $comments"
    echo "  Echo statements: $echo_statements"
    
    # Efficiency analysis
    echo ""
    echo "⚡ Efficiency Analysis:"
    
    # Check for redundant code
    local duplicate_lines=$(sort "$script" | uniq -d | wc -l)
    if [ "$duplicate_lines" -gt 5 ]; then
        echo "  ⚠️  WARNING: $duplicate_lines duplicate lines detected"
        echo "  💡 Consider consolidating repeated code into functions"
    else
        echo "  ✅ No significant code duplication"
    fi
    
    # Check for long functions
    local long_functions=$(awk '/^[a-zA-Z_][a-zA-Z0-9_]*\(\)/,/^}/' "$script" | awk 'length > 50' | wc -l)
    if [ "$long_functions" -gt 10 ]; then
        echo "  ⚠️  WARNING: $long_functions long lines detected"
        echo "  💡 Consider breaking down complex functions"
    else
        echo "  ✅ Functions are reasonably sized"
    fi
    
    # Check for excessive output
    local output_ratio=$((echo_statements * 100 / lines))
    if [ "$output_ratio" -gt 30 ]; then
        echo "  ⚠️  WARNING: High output ratio ($output_ratio%)"
        echo "  💡 Consider reducing verbose output for efficiency"
    else
        echo "  ✅ Output ratio is reasonable ($output_ratio%)"
    fi
    
    # Maintainability analysis
    echo ""
    echo "🔧 Maintainability Analysis:"
    
    # Check for hardcoded values
    local hardcoded_paths=$(grep -c "/Users/\|/home/\|/tmp/" "$script" 2>/dev/null || echo "0")
    if [ "$hardcoded_paths" -gt 0 ]; then
        echo "  ⚠️  WARNING: $hardcoded_paths hardcoded paths detected"
        echo "  💡 Consider using variables or relative paths"
    else
        echo "  ✅ No hardcoded paths detected"
    fi
    
    # Check for error handling
    local error_handling=$(grep -c "set -e\|trap\|exit" "$script" 2>/dev/null || echo "0")
    if [ "$error_handling" -gt 0 ]; then
        echo "  ✅ Error handling present"
    else
        echo "  ⚠️  WARNING: Limited error handling detected"
        echo "  💡 Consider adding proper error handling"
    fi
    
    # Check for documentation
    local doc_ratio=$((comments * 100 / lines))
    if [ "$doc_ratio" -lt 10 ]; then
        echo "  ⚠️  WARNING: Low documentation ratio ($doc_ratio%)"
        echo "  💡 Consider adding more comments for maintainability"
    else
        echo "  ✅ Good documentation ratio ($doc_ratio%)"
    fi
    
    # Bloat analysis
    echo ""
    echo "📦 Bloat Analysis:"
    
    # Check for unused functions
    local defined_functions=$(grep -c "^[a-zA-Z_][a-zA-Z0-9_]*()" "$script" 2>/dev/null || echo "0")
    local called_functions=0
    if [ "$defined_functions" -gt 0 ]; then
        while read -r func; do
            if grep -q "$func" "$script"; then
                ((called_functions++))
            fi
        done < <(grep "^[a-zA-Z_][a-zA-Z0-9_]*()" "$script" 2>/dev/null | sed 's/()//')
        
        local unused_functions=$((defined_functions - called_functions))
        if [ "$unused_functions" -gt 0 ]; then
            echo "  ⚠️  WARNING: $unused_functions potentially unused functions"
            echo "  💡 Consider removing unused functions"
        else
            echo "  ✅ All functions appear to be used"
        fi
    fi
    
    # Check for excessive complexity
    local complexity_score=$((lines + functions * 5 + echo_statements * 2))
    if [ "$complexity_score" -gt 1000 ]; then
        echo "  ⚠️  WARNING: High complexity score ($complexity_score)"
        echo "  💡 Consider breaking down into smaller scripts"
    else
        echo "  ✅ Complexity score is reasonable ($complexity_score)"
    fi
    
    # Overall assessment
    echo ""
    echo "🎯 Overall Assessment:"
    if [ "$lines" -lt 100 ]; then
        echo "  ✅ Size: Excellent (under 100 lines)"
    elif [ "$lines" -lt 300 ]; then
        echo "  ✅ Size: Good (under 300 lines)"
    elif [ "$lines" -lt 500 ]; then
        echo "  ⚠️  Size: Moderate (under 500 lines)"
    else
        echo "  ❌ Size: Large (over 500 lines) - consider refactoring"
    fi
    
    if [ "$doc_ratio" -gt 15 ] && [ "$error_handling" -gt 0 ] && [ "$duplicate_lines" -lt 3 ]; then
        echo "  ✅ Maintainability: Excellent"
    elif [ "$doc_ratio" -gt 10 ] && [ "$error_handling" -gt 0 ]; then
        echo "  ✅ Maintainability: Good"
    else
        echo "  ⚠️  Maintainability: Needs improvement"
    fi
}

# Main analysis
echo "🔍 Starting comprehensive shell script analysis..."
echo ""

# Find all shell scripts
SCRIPTS=(
    "../deploy.sh"
    "protection-system.sh"
    "css-specificity-validator.sh"
    "design-doc-validator.sh"
    "docs-efficiency-analyzer.sh"
    "docs-consolidator.sh"
    "docs-maintenance.sh"
    "auto-activate.sh"
)

# Analyze each script
for script in "${SCRIPTS[@]}"; do
    if [ -f "$script" ]; then
        analyze_script "$script"
    else
        echo "⚠️  Script not found: $script"
    fi
done

# Summary
echo ""
echo "📊 SUMMARY & RECOMMENDATIONS"
echo "============================"
echo ""
echo "🎯 Efficiency Recommendations:"
echo "  1. Keep scripts under 300 lines when possible"
echo "  2. Use functions to avoid code duplication"
echo "  3. Minimize verbose output for better performance"
echo "  4. Add proper error handling to all scripts"
echo ""
echo "🔧 Maintainability Recommendations:"
echo "  1. Add comprehensive comments (15%+ ratio)"
echo "  2. Use variables instead of hardcoded values"
echo "  3. Implement proper error handling"
echo "  4. Break down complex scripts into modules"
echo ""
echo "📦 Bloat Prevention:"
echo "  1. Remove unused functions and code"
echo "  2. Consolidate similar functionality"
echo "  3. Use libraries for common operations"
echo "  4. Regular cleanup and refactoring"
echo ""
echo "✅ Analysis complete!"
