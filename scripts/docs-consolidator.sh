#!/bin/bash

# DOCUMENTATION CONSOLIDATOR
# Proactively consolidates and optimizes documentation for efficiency

echo "📚 Documentation Consolidator"
echo "============================="

# Check if we're in the right directory
if [[ "$PWD" != *"/development" ]]; then
    echo "❌ Error: Run this script from the development/ directory"
    exit 1
fi

CONSOLIDATION_NEEDED=false

# Function to suggest consolidation opportunities
suggest_consolidations() {
    echo "🔍 Analyzing consolidation opportunities..."
    
    # Check for files that could be consolidated
    echo "📋 Potential Consolidation Opportunities:"
    
    # CSS-related documentation
    CSS_FILES=$(find ../docs/ -name "*CSS*" -o -name "*css*" | wc -l)
    if [ "$CSS_FILES" -gt 2 ]; then
        echo "  📄 CSS Documentation ($CSS_FILES files):"
        find ../docs/ -name "*CSS*" -o -name "*css*" | while read file; do
            echo "    - $(basename "$file") ($(wc -l < "$file") lines)"
        done
        echo "  💡 Consider consolidating into a single CSS documentation file"
        CONSOLIDATION_NEEDED=true
    fi
    
    # Deployment-related documentation
    DEPLOY_FILES=$(find ../docs/ -name "*DEPLOYMENT*" -o -name "*deployment*" | wc -l)
    if [ "$DEPLOY_FILES" -gt 2 ]; then
        echo "  📄 Deployment Documentation ($DEPLOY_FILES files):"
        find ../docs/ -name "*DEPLOYMENT*" -o -name "*deployment*" | while read file; do
            echo "    - $(basename "$file") ($(wc -l < "$file") lines)"
        done
        echo "  💡 Consider consolidating into a single deployment guide"
        CONSOLIDATION_NEEDED=true
    fi
    
    # Prevention-related documentation
    PREVENTION_FILES=$(find ../docs/ -name "*PREVENTION*" -o -name "*prevention*" | wc -l)
    if [ "$PREVENTION_FILES" -gt 2 ]; then
        echo "  📄 Prevention Documentation ($PREVENTION_FILES files):"
        find ../docs/ -name "*PREVENTION*" -o -name "*prevention*" | while read file; do
            echo "    - $(basename "$file") ($(wc -l < "$file") lines)"
        done
        echo "  💡 Consider consolidating into a single prevention framework"
        CONSOLIDATION_NEEDED=true
    fi
    
    # Architecture-related documentation
    ARCH_FILES=$(find ../docs/ -name "*ARCHITECTURE*" -o -name "*architecture*" | wc -l)
    if [ "$ARCH_FILES" -gt 2 ]; then
        echo "  📄 Architecture Documentation ($ARCH_FILES files):"
        find ../docs/ -name "*ARCHITECTURE*" -o -name "*architecture*" | while read file; do
            echo "    - $(basename "$file") ($(wc -l < "$file") lines)"
        done
        echo "  💡 Consider consolidating into a single architecture document"
        CONSOLIDATION_NEEDED=true
    fi
}

# Function to identify oversized files
identify_oversized_files() {
    echo "📏 Identifying oversized files..."
    
    # Files over 500 lines
    OVERSIZED_FILES=$(find ../docs/ -name "*.md" -exec wc -l {} \; | awk '$1 > 500 {print $2 " (" $1 " lines)"}')
    
    if [ ! -z "$OVERSIZED_FILES" ]; then
        echo "  ⚠️  Files over 500 lines (consider splitting):"
        echo "$OVERSIZED_FILES"
        echo "  💡 Consider splitting large files into focused sections"
        CONSOLIDATION_NEEDED=true
    else
        echo "  ✅ No oversized files found"
    fi
}

# Function to identify underutilized files
identify_underutilized_files() {
    echo "📊 Identifying underutilized files..."
    
    # Files under 100 lines
    UNDERUTILIZED_FILES=$(find ../docs/ -name "*.md" -exec wc -l {} \; | awk '$1 < 100 {print $2 " (" $1 " lines)"}')
    
    if [ ! -z "$UNDERUTILIZED_FILES" ]; then
        echo "  ⚠️  Files under 100 lines (consider consolidating):"
        echo "$UNDERUTILIZED_FILES"
        echo "  💡 Consider consolidating small files into larger, comprehensive documents"
        CONSOLIDATION_NEEDED=true
    else
        echo "  ✅ No underutilized files found"
    fi
}

# Function to suggest documentation structure
suggest_structure() {
    echo "🏗️  Suggested Documentation Structure:"
    echo "======================================"
    
    echo "📋 Core Documentation (Essential):"
    echo "  ✅ README.md - Project overview and quick start"
    echo "  ✅ TECHNICAL_ARCHITECTURE.md - System architecture and design"
    echo "  ✅ VISUAL_STANDARDS.md - Design system and visual guidelines"
    echo "  ✅ COMPONENT_LIBRARY.md - Reusable components and patterns"
    echo "  ✅ ASSET_INVENTORY.md - Asset management and optimization"
    
    echo ""
    echo "📋 Operational Documentation:"
    echo "  ✅ DEPLOYMENT_GUIDE.md - Complete deployment procedures"
    echo "  ✅ DEVELOPMENT_GUIDE.md - Development setup and workflows"
    echo "  ✅ TESTING_GUIDE.md - Testing procedures and standards"
    
    echo ""
    echo "📋 Quality Assurance Documentation:"
    echo "  ✅ PREVENTION_FRAMEWORK.md - Comprehensive prevention system"
    echo "  ✅ CSS_STANDARDS.md - CSS architecture and quality standards"
    echo "  ✅ DESIGN_GUIDELINES.md - Design system and documentation"
    
    echo ""
    echo "💡 Consolidation Recommendations:"
    echo "  1. Merge CSS_ARCHITECTURE.md + CSS_QUALITY_STANDARDS.md + CSS_ARCHITECTURE_PLAN.md → CSS_STANDARDS.md"
    echo "  2. Merge DEPLOYMENT_GUIDELINES.md + DEPLOYMENT_MAINTENANCE.md + GITHUB_PAGES_DEPLOYMENT_GUIDE.md → DEPLOYMENT_GUIDE.md"
    echo "  3. Merge all PREVENTION_*.md files → PREVENTION_FRAMEWORK.md"
    echo "  4. Merge DEVELOPMENT_TESTING_GUIDE.md + other testing docs → TESTING_GUIDE.md"
    echo "  5. Consolidate DESIGN_*.md files → DESIGN_GUIDELINES.md"
}

# Function to create consolidation plan
create_consolidation_plan() {
    echo "📝 Consolidation Plan:"
    echo "====================="
    
    echo "🎯 Phase 1: Core Consolidation"
    echo "  1. Create CSS_STANDARDS.md (merge CSS_ARCHITECTURE.md, CSS_QUALITY_STANDARDS.md, CSS_ARCHITECTURE_PLAN.md)"
    echo "  2. Create DEPLOYMENT_GUIDE.md (merge deployment-related files)"
    echo "  3. Create PREVENTION_FRAMEWORK.md (merge all prevention files)"
    
    echo ""
    echo "🎯 Phase 2: Structure Optimization"
    echo "  1. Create DEVELOPMENT_GUIDE.md (merge development-related files)"
    echo "  2. Create TESTING_GUIDE.md (merge testing-related files)"
    echo "  3. Create DESIGN_GUIDELINES.md (merge design-related files)"
    
    echo ""
    echo "🎯 Phase 3: Quality Assurance"
    echo "  1. Review and optimize remaining files"
    echo "  2. Ensure no content is lost during consolidation"
    echo "  3. Update cross-references and links"
    
    echo ""
    echo "📊 Expected Results:"
    echo "  - Reduce from 22 files to ~10-12 focused files"
    echo "  - Improve content organization and findability"
    echo "  - Eliminate redundancy and overlapping content"
    echo "  - Maintain comprehensive coverage"
}

# Main execution
echo "🔍 Starting documentation consolidation analysis..."
echo ""

# Analyze consolidation opportunities
suggest_consolidations

echo ""

# Identify oversized files
identify_oversized_files

echo ""

# Identify underutilized files
identify_underutilized_files

echo ""

# Suggest structure
suggest_structure

echo ""

# Create consolidation plan
create_consolidation_plan

echo ""
if [ "$CONSOLIDATION_NEEDED" = true ]; then
    echo "⚠️  Documentation consolidation opportunities identified"
    echo "💡 Review the suggestions above to improve efficiency"
    echo "📝 Consider implementing the consolidation plan"
else
    echo "✅ Documentation is well-organized and efficient"
    echo "🎯 No major consolidation needed"
fi
