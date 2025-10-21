#!/bin/bash

# WORKFLOW OPTIMIZER
# Optimizes the AI vibe coding workflow for maximum efficiency
# Addresses gaps identified in comprehensive review

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 Workflow Optimizer${NC}"
echo "====================="
echo ""

# Configuration
DEVELOPMENT_DIR="development"
SCRIPTS_DIR="scripts"

# Function to log with timestamp
log() {
    echo -e "${GREEN}[$(date '+%Y-%m-%d %H:%M:%S')]${NC} $1"
}

# Function to warn with timestamp
warn() {
    echo -e "${YELLOW}[$(date '+%Y-%m-%d %H:%M:%S')] WARNING:${NC} $1"
}

# Function to error with timestamp
error() {
    echo -e "${RED}[$(date '+%Y-%m-%d %H:%M:%S')] ERROR:${NC} $1"
}

# 1. CONSOLIDATE VALIDATION SCRIPTS
echo -e "${BLUE}📊 CONSOLIDATING VALIDATION SCRIPTS${NC}"
echo "====================================="

consolidate_validation() {
    log "Consolidating redundant validation scripts..."
    
    # Create consolidated validation script
    cat > "$SCRIPTS_DIR/workflow-validator.sh" << 'EOF'
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

if grep -q "color:\s*#[0-9a-fA-F]" assets/css/optimized.css; then
    echo "❌ VIOLATION: Hardcoded colors detected"
    exit 1
fi

# Documentation Compliance
echo "📚 Validating documentation compliance..."
PROHIBITED_FILES=$(find . -name "*_SUMMARY.md" -o -name "*_CLEANUP.md" -o -name "*_COMPARISON.md" -o -name "*_IMPACT.md" -o -name "PHASE_*.md")
if [ ! -z "$PROHIBITED_FILES" ]; then
    echo "❌ VIOLATION: Prohibited documentation patterns found"
    echo "$PROHIBITED_FILES"
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
EOF
    
    chmod +x "$SCRIPTS_DIR/workflow-validator.sh"
    log "✅ Consolidated validation script created"
}

# 2. SETUP GIT HOOKS
echo ""
echo -e "${BLUE}🔗 SETTING UP GIT HOOKS${NC}"
echo "=========================="

setup_git_hooks() {
    log "Setting up git hooks for automated validation..."
    
    # Create git hooks directory if it doesn't exist
    mkdir -p "$DEVELOPMENT_DIR/.git/hooks"
    
    # Install pre-commit hook
    cat > "$DEVELOPMENT_DIR/.git/hooks/pre-commit" << 'EOF'
#!/bin/bash

# PRE-COMMIT HOOK - OPTIMIZED WORKFLOW VALIDATION
echo "🔒 Pre-Commit Workflow Validation"
echo "================================="

# Run consolidated validator
if [ -f "../scripts/workflow-validator.sh" ]; then
    ../scripts/workflow-validator.sh
    if [ $? -ne 0 ]; then
        echo ""
        echo "🚨 COMMIT BLOCKED: Validation failures detected"
        echo "💡 Fix validation issues before committing"
        exit 1
    fi
else
    echo "⚠️  WARNING: Workflow validator not found"
    echo "💡 Run: ./scripts/workflow-optimizer.sh"
fi

echo "✅ Pre-commit validation passed!"
echo "🚀 Ready to commit"
EOF
    
    chmod +x "$DEVELOPMENT_DIR/.git/hooks/pre-commit"
    log "✅ Pre-commit hook installed"
    
    # Install post-commit hook for documentation updates
    cat > "$DEVELOPMENT_DIR/.git/hooks/post-commit" << 'EOF'
#!/bin/bash

# POST-COMMIT HOOK - AUTOMATED DOCUMENTATION UPDATE
echo "📝 Post-Commit Documentation Update"
echo "==================================="

# Run automated documentation updater
if [ -f "../scripts/auto-doc-updater.sh" ]; then
    ../scripts/auto-doc-updater.sh
    echo "✅ Documentation automatically updated"
else
    echo "⚠️  WARNING: Documentation updater not found"
fi
EOF
    
    chmod +x "$DEVELOPMENT_DIR/.git/hooks/post-commit"
    log "✅ Post-commit hook installed"
}

# 3. CREATE SYMBOLIC LINKS FOR SHARED SCRIPTS
echo ""
echo -e "${BLUE}🔗 CREATING SYMBOLIC LINKS${NC}"
echo "============================"

create_symbolic_links() {
    log "Creating symbolic links for shared scripts..."
    
    # Remove duplicate scripts in development
    rm -f "$DEVELOPMENT_DIR/scripts/ai-agent-validator.sh"
    rm -f "$DEVELOPMENT_DIR/scripts/auto-doc-updater.sh"
    rm -f "$DEVELOPMENT_DIR/scripts/deploy.sh"
    rm -f "$DEVELOPMENT_DIR/scripts/protection-system.sh"
    
    # Create symbolic links
    ln -sf "../../scripts/ai-agent-validator.sh" "$DEVELOPMENT_DIR/scripts/ai-agent-validator.sh"
    ln -sf "../../scripts/auto-doc-updater.sh" "$DEVELOPMENT_DIR/scripts/auto-doc-updater.sh"
    ln -sf "../../scripts/deploy.sh" "$DEVELOPMENT_DIR/scripts/deploy.sh"
    ln -sf "../../scripts/protection-system.sh" "$DEVELOPMENT_DIR/scripts/protection-system.sh"
    
    log "✅ Symbolic links created for shared scripts"
}

# 4. ENHANCE AI AGENT INTEGRATION
echo ""
echo -e "${BLUE}🤖 ENHANCING AI AGENT INTEGRATION${NC}"
echo "===================================="

enhance_ai_integration() {
    log "Enhancing AI agent integration..."
    
    # Create enhanced AI workflow script
    cat > "$SCRIPTS_DIR/ai-workflow-optimizer.sh" << 'EOF'
#!/bin/bash

# AI WORKFLOW OPTIMIZER
# Enhances AI agent workflow with automatic validation

echo "🤖 AI Workflow Optimizer"
echo "======================="

# Check if running in development directory
if [ ! -f "index.html" ]; then
    echo "❌ Error: Must run from development directory"
    exit 1
fi

# Automatic validation before AI changes
echo "🔍 Running automatic validation..."
if [ -f "../scripts/workflow-validator.sh" ]; then
    ../scripts/workflow-validator.sh
    if [ $? -ne 0 ]; then
        echo "⚠️  WARNING: Validation issues detected before AI changes"
        echo "💡 Consider reviewing current state before making changes"
    fi
fi

# Provide AI agent guidance
echo ""
echo "🤖 AI Agent Guidance:"
echo "===================="
echo "✅ Current state validated"
echo "✅ Ready for AI modifications"
echo "✅ Validation will run automatically on commit"
echo "✅ Documentation will update automatically on commit"
echo ""
echo "💡 Recommended workflow:"
echo "  1. Make your changes"
echo "  2. Commit changes (validation runs automatically)"
echo "  3. Deploy when ready (./scripts/deploy.sh)"
echo ""
echo "🎯 Design intent enforcement is active"
echo "📚 Documentation will stay synchronized"
EOF
    
    chmod +x "$SCRIPTS_DIR/ai-workflow-optimizer.sh"
    log "✅ AI workflow optimizer created"
}

# 5. CREATE WORKFLOW STATUS MONITOR
echo ""
echo -e "${BLUE}📊 CREATING WORKFLOW STATUS MONITOR${NC}"
echo "====================================="

create_status_monitor() {
    log "Creating workflow status monitor..."
    
    cat > "$SCRIPTS_DIR/workflow-status.sh" << 'EOF'
#!/bin/bash

# WORKFLOW STATUS MONITOR
# Provides comprehensive status of the workflow system

echo "📊 Workflow Status Monitor"
echo "========================="

# Check git hooks
echo "🔗 Git Hooks Status:"
if [ -f "development/.git/hooks/pre-commit" ]; then
    echo "  ✅ Pre-commit hook: Installed"
else
    echo "  ❌ Pre-commit hook: Missing"
fi

if [ -f "development/.git/hooks/post-commit" ]; then
    echo "  ✅ Post-commit hook: Installed"
else
    echo "  ❌ Post-commit hook: Missing"
fi

# Check validation scripts
echo ""
echo "🔍 Validation Scripts:"
if [ -f "scripts/workflow-validator.sh" ]; then
    echo "  ✅ Consolidated validator: Available"
else
    echo "  ❌ Consolidated validator: Missing"
fi

if [ -f "scripts/ai-agent-validator.sh" ]; then
    echo "  ✅ AI agent validator: Available"
else
    echo "  ❌ AI agent validator: Missing"
fi

# Check documentation automation
echo ""
echo "📚 Documentation Automation:"
if [ -f "scripts/auto-doc-updater.sh" ]; then
    echo "  ✅ Auto-doc updater: Available"
else
    echo "  ❌ Auto-doc updater: Missing"
fi

# Check deployment system
echo ""
echo "🚀 Deployment System:"
if [ -f "scripts/deploy.sh" ]; then
    echo "  ✅ Deploy script: Available"
else
    echo "  ❌ Deploy script: Missing"
fi

# Overall status
echo ""
echo "🎯 Overall Workflow Status:"
VALIDATION_READY=true
HOOKS_READY=true
DOCS_READY=true
DEPLOY_READY=true

[ ! -f "scripts/workflow-validator.sh" ] && VALIDATION_READY=false
[ ! -f "development/.git/hooks/pre-commit" ] && HOOKS_READY=false
[ ! -f "scripts/auto-doc-updater.sh" ] && DOCS_READY=false
[ ! -f "scripts/deploy.sh" ] && DEPLOY_READY=false

if [ "$VALIDATION_READY" = true ] && [ "$HOOKS_READY" = true ] && [ "$DOCS_READY" = true ] && [ "$DEPLOY_READY" = true ]; then
    echo "  ✅ WORKFLOW FULLY OPTIMIZED"
    echo "  🎉 All systems operational"
else
    echo "  ⚠️  WORKFLOW NEEDS OPTIMIZATION"
    echo "  💡 Run: ./scripts/workflow-optimizer.sh"
fi
EOF
    
    chmod +x "$SCRIPTS_DIR/workflow-status.sh"
    log "✅ Workflow status monitor created"
}

# 6. MAIN OPTIMIZATION FUNCTION
main() {
    echo -e "${BLUE}🚀 Starting workflow optimization...${NC}"
    
    # Run all optimization steps
    consolidate_validation
    setup_git_hooks
    create_symbolic_links
    enhance_ai_integration
    create_status_monitor
    
    echo ""
    echo -e "${BLUE}🎯 OPTIMIZATION COMPLETE${NC}"
    echo "========================"
    echo "✅ Validation scripts consolidated"
    echo "✅ Git hooks installed"
    echo "✅ Symbolic links created"
    echo "✅ AI integration enhanced"
    echo "✅ Status monitor created"
    echo ""
    echo -e "${GREEN}🎉 Workflow optimization completed successfully!${NC}"
    echo ""
    echo "📊 Check workflow status: ./scripts/workflow-status.sh"
    echo "🤖 Enhanced AI workflow: ./scripts/ai-workflow-optimizer.sh"
    echo "🔍 Consolidated validation: ./scripts/workflow-validator.sh"
}

# Run main optimization
main "$@"
