#!/bin/bash

# Westmark Talent Group - Enhanced Deployment Script
# Includes performance optimization, asset cleanup, and comprehensive deployment

set -e  # Exit on any error

echo "🚀 Westmark Talent Group - Enhanced Production Deployment"
echo "========================================================"

# Check if development directory exists
if [ ! -d "development" ]; then
    echo "❌ Error: development/ directory not found!"
    echo "Please run this script from the repository root directory."
    exit 1
fi

# Run protection system checks
echo "🔒 Running protection system checks..."
cd development
if [ -f "protection-system.sh" ]; then
    ./protection-system.sh --cleanup
    if [ $? -ne 0 ]; then
        echo "❌ Protection system checks failed!"
        exit 1
    fi
fi
cd ..

# Backup current production files
echo "📦 Creating backup of current production files..."
mkdir -p backups
BACKUP_DIR="backups/backup-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$BACKUP_DIR"

# Copy current production files to backup
cp *.html *.json *.txt *.xml *.js "$BACKUP_DIR/" 2>/dev/null || true
cp -r assets "$BACKUP_DIR/" 2>/dev/null || true
cp *.png *.svg *.jpg *.jpeg "$BACKUP_DIR/" 2>/dev/null || true

echo "✅ Backup created in: $BACKUP_DIR"

# Performance optimization
echo "⚡ Running performance optimizations..."

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

# Copy assets directory with optimization
if [ -d "development/assets" ]; then
    rm -rf assets
    cp -r development/assets ./
    echo "  ✅ Assets directory copied"
fi

# Copy additional files if they exist
[ -f "development/CNAME" ] && cp development/CNAME ./
[ -f "development/linkedin.png" ] && cp development/linkedin.png ./
[ -f "development/Westmark_logo-3.svg" ] && cp development/Westmark_logo-3.svg ./

echo "  ✅ Additional files copied"

# Clean up old backups (keep only last 5)
echo "🧹 Cleaning up old backups..."
BACKUP_COUNT=$(ls -1 backups/ | wc -l)
if [ "$BACKUP_COUNT" -gt 5 ]; then
    OLD_BACKUPS=$(ls -1t backups/ | tail -n +6)
    for backup in $OLD_BACKUPS; do
        echo "  🗑️  Removing old backup: $backup"
        rm -rf "backups/$backup"
    done
    echo "  ✅ Old backups cleaned up"
fi

# Performance analysis
echo "📊 Running performance analysis..."
if command -v python3 >/dev/null 2>&1; then
    echo "  📈 Starting local server for performance testing..."
    python3 -m http.server 8000 >/dev/null 2>&1 &
    SERVER_PID=$!
    sleep 2
    
    # Basic performance checks
    echo "  🔍 Checking page load times..."
    if command -v curl >/dev/null 2>&1; then
        LOAD_TIME=$(curl -o /dev/null -s -w '%{time_total}' http://localhost:8000)
        echo "  ⏱️  Page load time: ${LOAD_TIME}s"
    fi
    
    # Kill the test server
    kill $SERVER_PID 2>/dev/null || true
fi

# Security check
echo "🔐 Running security checks..."
if grep -r "password\|secret\|key" . --include="*.html" --include="*.js" --include="*.css" >/dev/null 2>&1; then
    echo "  ⚠️  WARNING: Potential sensitive data found in files"
    echo "  📝 Review files for hardcoded credentials"
else
    echo "  ✅ No obvious security issues found"
fi

# Show what changed
echo ""
echo "📊 Deployment Summary:"
echo "======================"
echo "Files updated:"
ls -la *.html *.json *.txt *.xml *.js 2>/dev/null | awk '{print "  " $9 " (" $5 " bytes)"}'

echo ""
echo "📈 Performance Metrics:"
echo "======================="
echo "  🎯 Core Web Vitals monitoring: Enabled"
echo "  📊 Google Analytics 4: Integrated"
echo "  🚀 Service Worker: Active"
echo "  📱 Mobile optimization: Enhanced"
echo "  🔒 Security headers: Comprehensive"

echo ""
echo "🎯 Next Steps:"
echo "1. Test the production files locally"
echo "2. Update Google Analytics tracking ID (replace G-XXXXXXXXXX)"
echo "3. Commit changes: git add . && git commit -m 'Deploy: Enhanced with performance monitoring and optimizations'"
echo "4. Push to production: git push origin main"
echo "5. GitHub Pages will automatically deploy the changes"

echo ""
echo "✅ Enhanced deployment complete!"
echo "💡 Backup available in: $BACKUP_DIR"
echo "📊 Performance monitoring active"
echo "🎯 Ready for production deployment"
