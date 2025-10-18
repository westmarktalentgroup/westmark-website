#!/bin/bash

# Westmark Talent Group - Development to Production Deployment Script
# This script copies tested changes from development/ to root directory for GitHub Pages deployment

set -e  # Exit on any error

echo "🚀 Westmark Talent Group - Development to Production Deployment"
echo "=============================================================="

# Check if development directory exists
if [ ! -d "development" ]; then
    echo "❌ Error: development/ directory not found!"
    echo "Please run this script from the repository root directory."
    exit 1
fi

# Backup current production files
echo "📦 Creating backup of current production files..."
BACKUP_DIR="backup-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$BACKUP_DIR"

# Copy current production files to backup
cp *.html *.json *.txt *.xml *.js "$BACKUP_DIR/" 2>/dev/null || true
cp -r assets "$BACKUP_DIR/" 2>/dev/null || true

echo "✅ Backup created in: $BACKUP_DIR"

# Copy development files to production
echo "🔄 Copying development files to production..."

# Copy main HTML files
cp development/*.html ./
echo "  ✅ HTML files copied"

# Copy configuration files
cp development/*.json ./
cp development/*.txt ./
cp development/*.xml ./
cp development/*.js ./
echo "  ✅ Configuration files copied"

# Copy assets directory
if [ -d "development/assets" ]; then
    rm -rf assets
    cp -r development/assets ./
    echo "  ✅ Assets directory copied"
fi

# Copy additional files if they exist
[ -f "development/CNAME" ] && cp development/CNAME ./
[ -f "development/linkedin.png" ] && cp development/linkedin.png ./
[ -f "development/Westmark-logo.png" ] && cp development/Westmark-logo.png ./
[ -f "development/Westmark_logo-3.svg" ] && cp development/Westmark_logo-3.svg ./
[ -f "development/Westmark_logo.png" ] && cp development/Westmark_logo.png ./

echo "  ✅ Additional files copied"

# Show what changed
echo ""
echo "📊 Deployment Summary:"
echo "======================"
echo "Files updated:"
ls -la *.html *.json *.txt *.xml *.js 2>/dev/null | awk '{print "  " $9 " (" $5 " bytes)"}'

echo ""
echo "🎯 Next Steps:"
echo "1. Test the production files locally"
echo "2. Commit changes: git add . && git commit -m 'Deploy: [describe changes]'"
echo "3. Push to production: git push origin main"
echo "4. GitHub Pages will automatically deploy the changes"

echo ""
echo "✅ Development to production deployment complete!"
echo "💡 Backup available in: $BACKUP_DIR"
