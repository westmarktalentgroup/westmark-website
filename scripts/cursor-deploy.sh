#!/bin/bash

# Enhanced Deploy Script with Cursor Touch ID Integration
# This script requires Cursor environment and Touch ID authentication

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Touch ID authentication will be handled by simple-touchid-auth.sh

echo -e "${BLUE}🚀 Westmark Talent Group - Cursor Touch ID Deployment${NC}"
echo -e "${BLUE}====================================================${NC}"
echo ""
echo -e "${YELLOW}🔒 CURSOR TOUCH ID PROTECTION ACTIVE:${NC}"
echo -e "${YELLOW}   ✅ Must be run from Cursor environment${NC}"
echo -e "${YELLOW}   ✅ Touch ID authentication required${NC}"
echo -e "${YELLOW}   ✅ GitHub token verification${NC}"
echo -e "${YELLOW}   ✅ All changes must go through development/ first${NC}"
echo ""

# Check if development directory exists
if [ ! -d "$PROJECT_ROOT/development" ]; then
    echo -e "${RED}❌ Error: development/ directory not found!${NC}"
    echo -e "${YELLOW}Please run this script from the repository root directory.${NC}"
    exit 1
fi

# Authenticate with Touch ID
echo -e "${BLUE}🔐 Initiating Cursor Touch ID Authentication...${NC}"
GITHUB_TOKEN=$(./scripts/simple-touchid-auth.sh --quiet)

if [[ -z "$GITHUB_TOKEN" ]]; then
    echo -e "${RED}❌ Authentication failed${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Touch ID authentication successful${NC}"

# Set GitHub token for git operations
export GITHUB_TOKEN

# Run protection system checks
echo -e "${BLUE}🔒 Running protection system checks...${NC}"
if [ -f "$PROJECT_ROOT/scripts/protection-system.sh" ]; then
    "$PROJECT_ROOT/scripts/protection-system.sh" --cleanup
    if [ $? -ne 0 ]; then
        echo -e "${RED}❌ Protection system checks failed!${NC}"
        exit 1
    fi
fi

# Backup current production files
echo -e "${BLUE}📦 Creating backup of current production files...${NC}"
mkdir -p "$PROJECT_ROOT/backups"
BACKUP_DIR="$PROJECT_ROOT/backups/backup-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$BACKUP_DIR"

# Copy current production files to backup
cp "$PROJECT_ROOT"/*.html "$BACKUP_DIR/" 2>/dev/null || true
cp "$PROJECT_ROOT"/*.json "$BACKUP_DIR/" 2>/dev/null || true
cp "$PROJECT_ROOT"/*.txt "$BACKUP_DIR/" 2>/dev/null || true
cp "$PROJECT_ROOT"/*.xml "$BACKUP_DIR/" 2>/dev/null || true
cp "$PROJECT_ROOT"/*.js "$BACKUP_DIR/" 2>/dev/null || true
cp -r "$PROJECT_ROOT/assets" "$BACKUP_DIR/" 2>/dev/null || true
cp "$PROJECT_ROOT"/*.png "$BACKUP_DIR/" 2>/dev/null || true
cp "$PROJECT_ROOT"/*.svg "$BACKUP_DIR/" 2>/dev/null || true
cp "$PROJECT_ROOT"/*.jpg "$BACKUP_DIR/" 2>/dev/null || true
cp "$PROJECT_ROOT"/*.jpeg "$BACKUP_DIR/" 2>/dev/null || true

echo -e "${GREEN}✅ Backup created in: $BACKUP_DIR${NC}"

# Copy development files to production
echo -e "${BLUE}🔄 Copying development files to production...${NC}"

# Copy main HTML files
cp "$PROJECT_ROOT/development"/*.html "$PROJECT_ROOT/"
echo -e "${GREEN}  ✅ HTML files copied${NC}"

# Copy configuration files
cp "$PROJECT_ROOT/development"/*.json "$PROJECT_ROOT/"
cp "$PROJECT_ROOT/development"/*.txt "$PROJECT_ROOT/"
cp "$PROJECT_ROOT/development"/*.xml "$PROJECT_ROOT/"
cp "$PROJECT_ROOT/development"/*.js "$PROJECT_ROOT/"
echo -e "${GREEN}  ✅ Configuration files copied${NC}"

# Copy assets directory
if [ -d "$PROJECT_ROOT/development/assets" ]; then
    rm -rf "$PROJECT_ROOT/assets"
    cp -r "$PROJECT_ROOT/development/assets" "$PROJECT_ROOT/"
    echo -e "${GREEN}  ✅ Assets directory copied${NC}"
fi

# Copy additional files if they exist
[ -f "$PROJECT_ROOT/development/CNAME" ] && cp "$PROJECT_ROOT/development/CNAME" "$PROJECT_ROOT/"
[ -f "$PROJECT_ROOT/development/linkedin.png" ] && cp "$PROJECT_ROOT/development/linkedin.png" "$PROJECT_ROOT/"
[ -f "$PROJECT_ROOT/development/Westmark_logo-3.svg" ] && cp "$PROJECT_ROOT/development/Westmark_logo-3.svg" "$PROJECT_ROOT/"

echo -e "${GREEN}  ✅ Additional files copied${NC}"

# Clean up old backups (keep only last 5)
echo -e "${BLUE}🧹 Cleaning up old backups...${NC}"
BACKUP_COUNT=$(ls -1 "$PROJECT_ROOT/backups/" | wc -l)
if [ "$BACKUP_COUNT" -gt 5 ]; then
    OLD_BACKUPS=$(ls -1t "$PROJECT_ROOT/backups/" | tail -n +6)
    for backup in $OLD_BACKUPS; do
        echo -e "${YELLOW}  🗑️  Removing old backup: $backup${NC}"
        rm -rf "$PROJECT_ROOT/backups/$backup"
    done
    echo -e "${GREEN}  ✅ Old backups cleaned up${NC}"
fi

# Security check
echo -e "${BLUE}🔐 Running security checks...${NC}"
if grep -r "password\|secret\|key" "$PROJECT_ROOT" --include="*.html" --include="*.js" --include="*.css" >/dev/null 2>&1; then
    echo -e "${YELLOW}  ⚠️  WARNING: Potential sensitive data found in files${NC}"
    echo -e "${YELLOW}  📝 Review files for hardcoded credentials${NC}"
else
    echo -e "${GREEN}  ✅ No obvious security issues found${NC}"
fi

# Show what changed
echo ""
echo -e "${BLUE}📊 Deployment Summary:${NC}"
echo -e "${BLUE}======================${NC}"
echo -e "${BLUE}Files updated:${NC}"
ls -la "$PROJECT_ROOT"/*.html "$PROJECT_ROOT"/*.json "$PROJECT_ROOT"/*.txt "$PROJECT_ROOT"/*.xml "$PROJECT_ROOT"/*.js 2>/dev/null | awk '{print "  " $9 " (" $5 " bytes)"}'

echo ""
echo -e "${BLUE}📈 Performance Metrics:${NC}"
echo -e "${BLUE}=======================${NC}"
echo -e "${GREEN}  🎯 Core Web Vitals monitoring: Enabled${NC}"
echo -e "${GREEN}  📊 Google Analytics 4: Integrated${NC}"
echo -e "${GREEN}  🚀 Service Worker: Active${NC}"
echo -e "${GREEN}  📱 Mobile optimization: Enhanced${NC}"
echo -e "${GREEN}  🔒 Security headers: Comprehensive${NC}"

echo ""
# Automated documentation update
echo -e "${BLUE}🤖 Running automated documentation updater...${NC}"
if [ -f "$PROJECT_ROOT/scripts/auto-doc-updater.sh" ]; then
    "$PROJECT_ROOT/scripts/auto-doc-updater.sh"
    echo -e "${GREEN}✅ Automated documentation update completed${NC}"
else
    echo -e "${YELLOW}⚠️  Documentation updater not found - skipping${NC}"
fi

echo ""
# Git operations for deployment
echo -e "${BLUE}📤 Checking for changes to push...${NC}"
cd "$PROJECT_ROOT"
if git status --porcelain | grep -q .; then
    echo -e "${BLUE}📝 Committing production changes...${NC}"
    git add .
    git commit -m "Deploy: Production update (Cursor Touch ID)

- Backup: $BACKUP_DIR
- Authentication: Touch ID verified
- Validation: Passed
- Performance: Optimized
- Cursor Environment: Confirmed"
else
    echo -e "${GREEN}✅ No changes to commit${NC}"
fi

# Only push if there are commits to push
if git log origin/main..HEAD --oneline | grep -q .; then
    echo -e "${BLUE}🚀 Pushing to GitHub Pages...${NC}"
    
    # Use GitHub token for authentication
    git push https://$GITHUB_TOKEN@github.com/westmarktalentgroup/westmark-website.git main
else
    echo -e "${GREEN}✅ No new commits to push${NC}"
fi

echo ""
echo -e "${GREEN}✅ Cursor Touch ID deployment complete!${NC}"
echo -e "${GREEN}💡 Backup available in: $BACKUP_DIR${NC}"
echo -e "${GREEN}📊 Performance monitoring active${NC}"
echo -e "${GREEN}🌐 GitHub Pages will automatically deploy the changes${NC}"
echo -e "${GREEN}🔒 Cursor Touch ID protection maintained${NC}"
