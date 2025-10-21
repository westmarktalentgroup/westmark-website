#!/bin/bash

# AI Agent Workflow Enforcer
# Westmark Talent Group Website
# 
# This script ENFORCES the mandatory AI agent workflow to ensure
# architectural documentation is always updated when making changes

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}🤖 AI AGENT WORKFLOW ENFORCER${NC}"
echo "================================="
echo ""

# Configuration
DEVELOPMENT_DIR="development"
DOCS_DIR="docs"

# Function to log with timestamp
log() {
    echo -e "${GREEN}[$(date '+%Y-%m-%d %H:%M:%S')]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Check if AI agent followed mandatory workflow
check_mandatory_workflow() {
    log "🔍 Checking if AI agent followed mandatory workflow..."
    
    local workflow_violations=()
    
    # Check if architectural enforcer was run
    if ! grep -q "ARCHITECTURAL DOCUMENTATION ENFORCER" "$DEVELOPMENT_DIR/.last-workflow-check" 2>/dev/null; then
        workflow_violations+=("Architectural enforcer not run before changes")
    fi
    
    # Check if documentation was updated after changes
    local last_doc_change=$(stat -c %Y "$DOCS_DIR/COMPONENT_LIBRARY.md" 2>/dev/null || echo "0")
    local last_code_change=$(find "$DEVELOPMENT_DIR" -name "*.html" -o -name "*.css" -o -name "*.js" | xargs stat -c %Y 2>/dev/null | sort -n | tail -1 || echo "0")
    
    if [ "$last_doc_change" -lt "$last_code_change" ]; then
        workflow_violations+=("Documentation not updated after code changes")
    fi
    
    if [ ${#workflow_violations[@]} -gt 0 ]; then
        error "❌ MANDATORY WORKFLOW VIOLATIONS:"
        for violation in "${workflow_violations[@]}"; do
            echo "   - $violation"
        done
        return 1
    else
        log "✅ Mandatory workflow followed correctly"
        return 0
    fi
}

# Enforce mandatory AI agent workflow
enforce_mandatory_workflow() {
    log "🚨 ENFORCING MANDATORY AI AGENT WORKFLOW"
    echo ""
    
    echo -e "${RED}🤖 MANDATORY AI AGENT WORKFLOW:${NC}"
    echo "================================"
    echo ""
    echo "1. 📋 BEFORE MAKING ANY CHANGES:"
    echo "   - Run: ./scripts/architectural-enforcer.sh"
    echo "   - Fix any architectural violations"
    echo "   - Understand current architecture"
    echo ""
    echo "2. 🔧 WHILE MAKING CHANGES:"
    echo "   - Document new CSS classes in COMPONENT_LIBRARY.md"
    echo "   - Document new HTML structures in COMPONENT_LIBRARY.md"
    echo "   - Document new design patterns in DESIGN_SYSTEM.md"
    echo "   - Document new styling in CSS_STANDARDS.md"
    echo "   - Document architectural changes in TECHNICAL_ARCHITECTURE.md"
    echo ""
    echo "3. ✅ AFTER MAKING CHANGES:"
    echo "   - Run: ./scripts/architectural-enforcer.sh"
    echo "   - Verify all violations are fixed"
    echo "   - Update .last-workflow-check file"
    echo "   - Only then proceed with deployment"
    echo ""
    echo "4. 🚨 BLOCKING CONDITIONS:"
    echo "   - Undocumented CSS classes"
    echo "   - Undocumented HTML structures"
    echo "   - Undocumented design patterns"
    echo "   - Architectural drift"
    echo "   - Missing component specifications"
    echo ""
}

# Create mandatory workflow file
create_workflow_file() {
    log "📝 Creating mandatory workflow file..."
    
    cat > "$DEVELOPMENT_DIR/.ai-agent-workflow" << 'EOF'
# MANDATORY AI AGENT WORKFLOW
# ===========================
# This file documents the REQUIRED workflow for AI agents
# Failure to follow this workflow will BLOCK deployment

## 🚨 CRITICAL RULE: NO CHANGES WITHOUT DOCUMENTATION
Every change MUST be documented in architectural blueprints before deployment.

## 📋 STEP 1: PRE-CHANGE VALIDATION
./scripts/architectural-enforcer.sh

## 🔧 STEP 2: MAKE CHANGES + DOCUMENT
- Update code files
- IMMEDIATELY update documentation:
  * COMPONENT_LIBRARY.md - New classes/structures
  * CSS_STANDARDS.md - New styling patterns
  * DESIGN_SYSTEM.md - New design patterns
  * TECHNICAL_ARCHITECTURE.md - Architectural changes

## ✅ STEP 3: POST-CHANGE VALIDATION
./scripts/architectural-enforcer.sh

## 🚀 STEP 4: DEPLOY ONLY IF VALIDATION PASSES
./scripts/deploy.sh

## 🚨 BLOCKING CONDITIONS:
- Any undocumented CSS classes
- Any undocumented HTML structures
- Any undocumented design patterns
- Any architectural drift
- Any missing component specifications

## 💥 CONSEQUENCES OF VIOLATION:
- Deployment will be BLOCKED
- Changes will be REJECTED
- AI agent must fix documentation before proceeding
EOF

    log "✅ Mandatory workflow file created"
}

# Main execution
main() {
    # Create workflow file if it doesn't exist
    if [ ! -f "$DEVELOPMENT_DIR/.ai-agent-workflow" ]; then
        create_workflow_file
    fi
    
    # Check mandatory workflow
    if ! check_mandatory_workflow; then
        echo ""
        error "🚨 AI AGENT WORKFLOW VIOLATIONS DETECTED!"
        echo ""
        enforce_mandatory_workflow
        echo ""
        error "💥 DEPLOYMENT BLOCKED - Follow mandatory workflow first"
        exit 1
    else
        log "✅ AI agent workflow followed correctly"
        exit 0
    fi
}

# Run main function
main "$@"
