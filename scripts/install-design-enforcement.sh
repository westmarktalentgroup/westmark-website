#!/bin/bash

# INSTALL DESIGN INTENT ENFORCEMENT SYSTEM
# Sets up automated enforcement for any AI agent

echo "🛡️  Installing Design Intent Enforcement System"
echo "================================================"

# Check if running from correct directory
if [ ! -d "development" ]; then
    echo "❌ Error: Must run from repository root directory"
    exit 1
fi

# Copy enforcement scripts to development directory
echo "📋 Copying enforcement scripts..."

cp scripts/design-intent-enforcer.sh development/
cp scripts/ai-agent-validator.sh development/
chmod +x development/design-intent-enforcer.sh
chmod +x development/ai-agent-validator.sh

echo "✅ Enforcement scripts installed"

# Install pre-commit hook
echo "🔗 Installing pre-commit hook..."

if [ -d ".git/hooks" ]; then
    cp development/pre-commit-hook .git/hooks/pre-commit
    chmod +x .git/hooks/pre-commit
    echo "✅ Pre-commit hook installed"
else
    echo "⚠️  WARNING: Git hooks directory not found"
    echo "💡 Run: git init to create hooks directory"
fi

# Test enforcement system
echo "🧪 Testing enforcement system..."

cd development
if [ -f "design-intent-enforcer.sh" ]; then
    echo "✅ Design intent enforcer ready"
else
    echo "❌ Design intent enforcer installation failed"
    exit 1
fi

if [ -f "ai-agent-validator.sh" ]; then
    echo "✅ AI agent validator ready"
else
    echo "❌ AI agent validator installation failed"
    exit 1
fi

cd ..

echo ""
echo "🎯 DESIGN INTENT ENFORCEMENT SYSTEM INSTALLED"
echo "=============================================="
echo ""
echo "✅ Automatic enforcement active for:"
echo "  🔒 Pre-commit validation"
echo "  🎯 Design intent compliance"
echo "  📋 Documentation alignment"
echo "  🤖 AI agent validation"
echo ""
echo "🚀 Any AI agent will now be forced to follow documentation!"
echo ""
echo "💡 To test: ./development/ai-agent-validator.sh"
echo "💡 To validate: ./development/design-intent-enforcer.sh"
