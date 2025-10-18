#!/bin/bash

# DOCUMENTATION MAINTENANCE SYSTEM
# Proactively maintains documentation efficiency and quality

echo "🔧 Documentation Maintenance System"
echo "==================================="

# Check if we're in the right directory
if [[ "$PWD" != *"/development" ]]; then
    echo "❌ Error: Run this script from the development/ directory"
    exit 1
fi

MAINTENANCE_NEEDED=false

# Function to check documentation freshness
check_freshness() {
    echo "📅 Checking documentation freshness..."
    
    # Check for files not updated in the last 30 days
    STALE_FILES=$(find ../docs/ -name "*.md" -mtime +30 2>/dev/null)
    
    if [ ! -z "$STALE_FILES" ]; then
        echo "  ⚠️  Stale documentation files (not updated in 30+ days):"
        echo "$STALE_FILES" | while read file; do
            echo "    - $(basename "$file") (last modified: $(date -r "$file" "+%Y-%m-%d"))"
        done
        echo "  💡 Consider reviewing and updating stale documentation"
        MAINTENANCE_NEEDED=true
    else
        echo "  ✅ All documentation files are recent"
    fi
}

# Function to check for broken links
check_links() {
    echo "🔗 Checking for broken links..."
    
    BROKEN_LINKS=false
    
    # Check for internal links
    for file in ../docs/*.md; do
        if [ -f "$file" ]; then
            # Check for links to other markdown files
            LINKS=$(grep -o '\[.*\](.*\.md)' "$file" 2>/dev/null)
            if [ ! -z "$LINKS" ]; then
                echo "$LINKS" | while read link; do
                    TARGET=$(echo "$link" | sed 's/.*(\(.*\))/\1/')
                    if [ ! -f "../docs/$TARGET" ] && [ ! -f "$TARGET" ]; then
                        echo "  ❌ Broken link in $(basename "$file"): $link"
                        BROKEN_LINKS=true
                    fi
                done
            fi
        fi
    done
    
    if [ "$BROKEN_LINKS" = false ]; then
        echo "  ✅ No broken internal links found"
    else
        echo "  💡 Fix broken links to maintain documentation integrity"
        MAINTENANCE_NEEDED=true
    fi
}

# Function to check for outdated content
check_outdated_content() {
    echo "📝 Checking for outdated content..."
    
    # Check for common outdated patterns
    OUTDATED_PATTERNS=(
        "TODO:"
        "FIXME:"
        "NOTE:.*deprecated"
        "WARNING:.*old"
        "Legacy"
        "Deprecated"
    )
    
    OUTDATED_FOUND=false
    for pattern in "${OUTDATED_PATTERNS[@]}"; do
        MATCHES=$(grep -r "$pattern" ../docs/ 2>/dev/null)
        if [ ! -z "$MATCHES" ]; then
            echo "  ⚠️  Potentially outdated content found:"
            echo "$MATCHES" | while read line; do
                echo "    - $line"
            done
            OUTDATED_FOUND=true
        fi
    done
    
    if [ "$OUTDATED_FOUND" = false ]; then
        echo "  ✅ No obviously outdated content found"
    else
        echo "  💡 Review and update outdated content"
        MAINTENANCE_NEEDED=true
    fi
}

# Function to check for consistency
check_consistency() {
    echo "🎯 Checking for consistency issues..."
    
    # Check for inconsistent naming
    INCONSISTENT_NAMING=false
    
    # Check for mixed case in file names
    MIXED_CASE=$(find ../docs/ -name "*[a-z]*[A-Z]*.md" 2>/dev/null)
    if [ ! -z "$MIXED_CASE" ]; then
        echo "  ⚠️  Mixed case file names found:"
        echo "$MIXED_CASE" | while read file; do
            echo "    - $(basename "$file")"
        done
        INCONSISTENT_NAMING=true
    fi
    
    # Check for inconsistent headers
    HEADER_STYLES=$(grep -r "^#" ../docs/ 2>/dev/null | head -20)
    if [ ! -z "$HEADER_STYLES" ]; then
        echo "  ℹ️  Header styles found (review for consistency):"
        echo "$HEADER_STYLES" | head -5
    fi
    
    if [ "$INCONSISTENT_NAMING" = false ]; then
        echo "  ✅ File naming is consistent"
    else
        echo "  💡 Standardize file naming conventions"
        MAINTENANCE_NEEDED=true
    fi
}

# Function to suggest maintenance actions
suggest_maintenance() {
    echo "🛠️  Suggested Maintenance Actions:"
    echo "================================="
    
    echo "📅 Regular Maintenance (Monthly):"
    echo "  1. Review and update stale documentation"
    echo "  2. Check for broken links and fix them"
    echo "  3. Remove outdated content and patterns"
    echo "  4. Ensure consistency in naming and formatting"
    echo "  5. Run efficiency analysis and consolidation checks"
    
    echo ""
    echo "📊 Efficiency Maintenance (Quarterly):"
    echo "  1. Run ./docs-efficiency-analyzer.sh"
    echo "  2. Run ./docs-consolidator.sh"
    echo "  3. Review consolidation opportunities"
    echo "  4. Optimize file sizes and content density"
    echo "  5. Update cross-references and links"
    
    echo ""
    echo "🎯 Quality Maintenance (As Needed):"
    echo "  1. Update content when system changes"
    echo "  2. Add new documentation for new features"
    echo "  3. Remove obsolete documentation"
    echo "  4. Ensure all essential documentation exists"
    echo "  5. Validate documentation completeness"
    
    echo ""
    echo "📈 Proactive Efficiency Measures:"
    echo "  ✅ Automated freshness checking"
    echo "  ✅ Link validation"
    echo "  ✅ Content consistency monitoring"
    echo "  ✅ Regular maintenance reminders"
    echo "  ✅ Efficiency analysis integration"
}

# Function to create maintenance schedule
create_maintenance_schedule() {
    echo "📅 Documentation Maintenance Schedule:"
    echo "======================================"
    
    echo "🔄 Daily (Automated):"
    echo "  ✅ Documentation validation on commits"
    echo "  ✅ Efficiency analysis on deployments"
    echo "  ✅ Quality checks on changes"
    
    echo ""
    echo "📊 Weekly (Manual):"
    echo "  📝 Review new documentation for quality"
    echo "  🔗 Check for broken links in new content"
    echo "  📋 Update documentation index if needed"
    
    echo ""
    echo "📅 Monthly (Manual):"
    echo "  🔍 Run comprehensive efficiency analysis"
    echo "  📚 Review and update stale documentation"
    echo "  🗑️  Remove outdated content and patterns"
    echo "  🎯 Check consistency and naming conventions"
    
    echo ""
    echo "📈 Quarterly (Manual):"
    echo "  📊 Run consolidation analysis"
    echo "  🔄 Implement consolidation recommendations"
    echo "  📋 Review overall documentation structure"
    echo "  🎯 Update maintenance procedures"
    
    echo ""
    echo "📝 As Needed (Manual):"
    echo "  🆕 Add documentation for new features"
    echo "  🗑️  Remove obsolete documentation"
    echo "  🔧 Fix broken links and references"
    echo "  📋 Update essential documentation"
}

# Main execution
echo "🔍 Starting documentation maintenance analysis..."
echo ""

# Check freshness
check_freshness

echo ""

# Check links
check_links

echo ""

# Check for outdated content
check_outdated_content

echo ""

# Check consistency
check_consistency

echo ""

# Suggest maintenance actions
suggest_maintenance

echo ""

# Create maintenance schedule
create_maintenance_schedule

echo ""
if [ "$MAINTENANCE_NEEDED" = true ]; then
    echo "⚠️  Documentation maintenance needed"
    echo "💡 Review the suggestions above and perform maintenance"
    echo "📅 Consider implementing the maintenance schedule"
else
    echo "✅ Documentation is well-maintained"
    echo "🎯 Continue with regular maintenance schedule"
fi
