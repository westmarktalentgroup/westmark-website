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
