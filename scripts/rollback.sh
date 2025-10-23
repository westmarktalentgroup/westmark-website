#!/bin/bash

# ==========================================================================
# WESTMARK TALENT GROUP - EMERGENCY ROLLBACK SCRIPT
# Quick rollback to previous working version
# ==========================================================================

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${RED}🚨 Westmark Talent Group - Emergency Rollback${NC}"
echo "=============================================="

# Check if we're in the right directory
if [ ! -d "backups" ]; then
    echo -e "${RED}❌ Error: No backups directory found${NC}"
    exit 1
fi

# List available backups
echo -e "${BLUE}📋 Available backups:${NC}"
ls -la backups/ | grep backup- | tail -5

# Get latest backup
LATEST_BACKUP=$(ls -t backups/backup-* | head -1)
if [ -z "$LATEST_BACKUP" ]; then
    echo -e "${RED}❌ Error: No backups found${NC}"
    exit 1
fi

echo -e "${YELLOW}⚠️  Latest backup: $LATEST_BACKUP${NC}"
echo -e "${YELLOW}⚠️  This will restore the website to the previous working state${NC}"

# Confirm rollback
read -p "Are you sure you want to rollback? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${BLUE}ℹ️  Rollback cancelled${NC}"
    exit 0
fi

# Create current state backup before rollback
echo -e "${BLUE}💾 Creating emergency backup of current state...${NC}"
EMERGENCY_BACKUP="backups/emergency-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$EMERGENCY_BACKUP"
cp -r . "$EMERGENCY_BACKUP/" 2>/dev/null || true
echo -e "${GREEN}✅ Emergency backup created: $EMERGENCY_BACKUP${NC}"

# Perform rollback
echo -e "${BLUE}🔄 Rolling back to: $LATEST_BACKUP${NC}"
cp -r "$LATEST_BACKUP"/* ./
echo -e "${GREEN}✅ Files restored successfully${NC}"

# Commit rollback
echo -e "${BLUE}📝 Committing rollback...${NC}"
git add .
git commit -m "ROLLBACK: Emergency rollback to $(basename $LATEST_BACKUP)" || echo "No changes to commit"

# Create rollback branch
ROLLBACK_BRANCH="rollback-$(date +%Y%m%d-%H%M%S)"
echo -e "${BLUE}🌿 Creating rollback branch: $ROLLBACK_BRANCH${NC}"
git checkout -b "$ROLLBACK_BRANCH"

# Push rollback
echo -e "${BLUE}📤 Pushing rollback to GitHub...${NC}"
git push origin "$ROLLBACK_BRANCH"

echo -e "${GREEN}🎉 Rollback successful!${NC}"
echo "=============================================="
echo -e "${GREEN}✅ Emergency backup: $EMERGENCY_BACKUP${NC}"
echo -e "${GREEN}✅ Rollback branch: $ROLLBACK_BRANCH${NC}"
echo -e "${GREEN}✅ Pushed to GitHub${NC}"
echo ""
echo -e "${BLUE}📋 Next steps:${NC}"
echo "1. GitHub Actions will automatically deploy the rollback"
echo "2. Monitor the deployment status"
echo "3. Investigate the issue that caused the rollback"
echo ""
echo -e "${BLUE}🔗 Monitor deployment:${NC}"
echo "   https://github.com/westmarktalentgroup/westmark-website/actions"
echo ""
echo -e "${RED}🚨 Emergency rollback complete!${NC}"

# Switch back to main
git checkout main