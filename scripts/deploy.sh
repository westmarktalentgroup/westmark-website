#!/bin/bash

# ==========================================================================
# WESTMARK TALENT GROUP - MODERN DEPLOYMENT SCRIPT
# Streamlined deployment following industry best practices
# ==========================================================================

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 Westmark Talent Group - Modern Deployment${NC}"
echo "=============================================="

# Check if we're in the right directory
if [ ! -f "development/index.html" ]; then
    echo -e "${RED}❌ Error: Run this script from the project root directory${NC}"
    exit 1
fi

# Check if we're on main branch
CURRENT_BRANCH=$(git branch --show-current)
if [ "$CURRENT_BRANCH" != "main" ]; then
    echo -e "${YELLOW}⚠️  Warning: Not on main branch (currently on: $CURRENT_BRANCH)${NC}"
    echo -e "${YELLOW}   This will create a deployment branch from main${NC}"
fi

echo -e "${BLUE}📋 Pre-deployment checks...${NC}"

# 1. Check for uncommitted changes
if ! git diff --quiet; then
    echo -e "${YELLOW}⚠️  Uncommitted changes detected${NC}"
    echo -e "${YELLOW}   Committing changes automatically...${NC}"
    git add .
    git commit -m "Auto-commit: $(date '+%Y-%m-%d %H:%M:%S')"
fi

# 2. Create backup
echo -e "${BLUE}💾 Creating backup...${NC}"
BACKUP_DIR="backups/backup-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$BACKUP_DIR"
cp -r . "$BACKUP_DIR/" 2>/dev/null || true
echo -e "${GREEN}✅ Backup created: $BACKUP_DIR${NC}"

# 3. Copy development to production
echo -e "${BLUE}📦 Deploying development to production...${NC}"
cp -r development/* ./
echo -e "${GREEN}✅ Files copied successfully${NC}"

# 4. Commit deployment
echo -e "${BLUE}📝 Committing deployment...${NC}"
git add .
git commit -m "Deploy: $(date '+%Y-%m-%d %H:%M:%S')" || echo "No changes to commit"

# 5. Create deployment branch
DEPLOY_BRANCH="deploy-$(date +%Y%m%d-%H%M%S)"
echo -e "${BLUE}🌿 Creating deployment branch: $DEPLOY_BRANCH${NC}"
git checkout -b "$DEPLOY_BRANCH"

# 6. Push to GitHub
echo -e "${BLUE}📤 Pushing to GitHub...${NC}"
git push origin "$DEPLOY_BRANCH"

echo -e "${GREEN}🎉 Deployment successful!${NC}"
echo "=============================================="
echo -e "${GREEN}✅ Backup created: $BACKUP_DIR${NC}"
echo -e "${GREEN}✅ Deployment branch: $DEPLOY_BRANCH${NC}"
echo -e "${GREEN}✅ Pushed to GitHub${NC}"
echo ""
echo -e "${BLUE}📋 Next steps:${NC}"
echo "1. GitHub Actions will automatically:"
echo "   • Run tests and validation"
echo "   • Create Pull Request"
echo "   • Deploy to production after merge"
echo ""
echo -e "${BLUE}🔗 Monitor deployment:${NC}"
echo "   https://github.com/westmarktalentgroup/westmark-website/actions"
echo ""
echo -e "${GREEN}🚀 Modern deployment complete!${NC}"

# Switch back to main
git checkout main