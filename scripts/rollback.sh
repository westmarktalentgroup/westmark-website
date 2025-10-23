#!/bin/bash

# Deployment Rollback Script
# Westmark Talent Group Website
# 
# This script provides emergency rollback capability for deployments

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}🔄 DEPLOYMENT ROLLBACK SYSTEM${NC}"
echo "=============================="
echo ""

# Function to list available backups
list_backups() {
    echo -e "${BLUE}📋 Available Backups:${NC}"
    echo "====================="
    
    if [[ ! -d "backups" ]] || [[ -z "$(ls -A backups 2>/dev/null)" ]]; then
        echo -e "${RED}❌ No backups found${NC}"
        echo -e "${YELLOW}💡 Run a deployment first to create backups${NC}"
        return 1
    fi
    
    local backup_count=0
    for backup in backups/backup-*; do
        if [[ -d "$backup" ]]; then
            ((backup_count++))
            local backup_name=$(basename "$backup")
            local backup_date=$(echo "$backup_name" | sed 's/backup-//' | sed 's/-/ /')
            echo "  $backup_count. $backup_name ($backup_date)"
        fi
    done
    
    echo ""
    echo -e "${GREEN}Total backups: $backup_count${NC}"
    return 0
}

# Function to perform rollback
perform_rollback() {
    local backup_dir="$1"
    
    if [[ ! -d "$backup_dir" ]]; then
        echo -e "${RED}❌ Backup directory not found: $backup_dir${NC}"
        return 1
    fi
    
    echo -e "${YELLOW}⚠️  WARNING: This will overwrite current production files${NC}"
    echo -e "${YELLOW}⚠️  Make sure you want to rollback to: $(basename "$backup_dir")${NC}"
    echo ""
    read -p "Are you sure you want to proceed? (yes/no): " confirm
    
    if [[ "$confirm" != "yes" ]]; then
        echo -e "${BLUE}ℹ️  Rollback cancelled${NC}"
        return 0
    fi
    
    echo -e "${BLUE}🔄 Starting rollback process...${NC}"
    
    # Create emergency backup of current state
    local emergency_backup="backups/emergency-backup-$(date +%Y%m%d-%H%M%S)"
    mkdir -p "$emergency_backup"
    
    echo "📦 Creating emergency backup of current state..."
    cp *.html *.json *.txt *.xml *.js "$emergency_backup/" 2>/dev/null || true
    cp -r assets "$emergency_backup/" 2>/dev/null || true
    cp *.png *.svg *.jpg *.jpeg "$emergency_backup/" 2>/dev/null || true
    echo "✅ Emergency backup created: $emergency_backup"
    
    # Restore from selected backup
    echo "🔄 Restoring files from backup..."
    cp "$backup_dir"/*.html ./ 2>/dev/null || true
    cp "$backup_dir"/*.json ./ 2>/dev/null || true
    cp "$backup_dir"/*.txt ./ 2>/dev/null || true
    cp "$backup_dir"/*.xml ./ 2>/dev/null || true
    cp "$backup_dir"/*.js ./ 2>/dev/null || true
    cp "$backup_dir"/*.png ./ 2>/dev/null || true
    cp "$backup_dir"/*.svg ./ 2>/dev/null || true
    cp "$backup_dir"/*.jpg ./ 2>/dev/null || true
    cp "$backup_dir"/*.jpeg ./ 2>/dev/null || true
    
    if [[ -d "$backup_dir/assets" ]]; then
        rm -rf assets
        cp -r "$backup_dir/assets" ./
    fi
    
    echo "✅ Files restored from backup"
    
    # Commit rollback
    echo "📝 Committing rollback..."
    git add .
    git commit -m "ROLLBACK: Restored from $(basename "$backup_dir")

- Emergency backup: $emergency_backup
- Rollback reason: Manual rollback requested
- Timestamp: $(date)"

    echo ""
    echo -e "${GREEN}✅ Rollback completed successfully${NC}"
    echo -e "${GREEN}📦 Emergency backup: $emergency_backup${NC}"
    echo -e "${YELLOW}💡 Push changes to deploy rollback: git push origin main${NC}"
    
    return 0
}

# Main rollback interface
main() {
    echo -e "${BLUE}🔄 Deployment Rollback System${NC}"
    echo "=============================="
    echo ""
    
    # List available backups
    if ! list_backups; then
        exit 1
    fi
    
    echo ""
    echo -e "${BLUE}Select rollback option:${NC}"
    echo "1. Rollback to specific backup"
    echo "2. Rollback to latest backup"
    echo "3. Exit"
    echo ""
    read -p "Enter your choice (1-3): " choice
    
    case $choice in
        1)
            echo ""
            read -p "Enter backup directory name (e.g., backup-20251021-123456): " backup_name
            if [[ -d "backups/$backup_name" ]]; then
                perform_rollback "backups/$backup_name"
            else
                echo -e "${RED}❌ Backup not found: $backup_name${NC}"
                exit 1
            fi
            ;;
        2)
            # Find latest backup
            local latest_backup=$(ls -1t backups/backup-* 2>/dev/null | head -1)
            if [[ -n "$latest_backup" ]]; then
                echo -e "${BLUE}🔄 Rolling back to latest backup: $(basename "$latest_backup")${NC}"
                perform_rollback "$latest_backup"
            else
                echo -e "${RED}❌ No backups found${NC}"
                exit 1
            fi
            ;;
        3)
            echo -e "${BLUE}ℹ️  Rollback cancelled${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}❌ Invalid choice${NC}"
            exit 1
            ;;
    esac
}

# Run main function
main "$@"
