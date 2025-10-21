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
