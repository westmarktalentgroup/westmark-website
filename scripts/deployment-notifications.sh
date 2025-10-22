#!/bin/bash

# Deployment Notification System
# Westmark Talent Group Website
# 
# This script provides deployment notifications and status tracking

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
NOTIFICATION_LOG=".deployment-notifications.log"
DEPLOYMENT_STATUS_FILE=".deployment-status"

# Function to log notification
log_notification() {
    local level="$1"
    local message="$2"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] [$level] $message" >> "$NOTIFICATION_LOG"
}

# Function to send deployment start notification
notify_deployment_start() {
    local backup_dir="$1"
    
    log_notification "INFO" "🚀 DEPLOYMENT STARTED"
    log_notification "INFO" "Backup: $backup_dir"
    log_notification "INFO" "User: $(whoami)"
    log_notification "INFO" "Host: $(hostname)"
    
    # Update deployment status
    cat > "$DEPLOYMENT_STATUS_FILE" << EOF
STATUS=IN_PROGRESS
START_TIME=$(date '+%Y-%m-%d %H:%M:%S')
BACKUP_DIR=$backup_dir
USER=$(whoami)
HOST=$(hostname)
EOF
    
    echo -e "${BLUE}📢 Deployment notification sent${NC}"
}

# Function to send deployment success notification
notify_deployment_success() {
    local backup_dir="$1"
    local performance_time="$2"
    
    log_notification "SUCCESS" "✅ DEPLOYMENT COMPLETED SUCCESSFULLY"
    log_notification "SUCCESS" "Backup: $backup_dir"
    log_notification "SUCCESS" "Performance: ${performance_time}s"
    log_notification "SUCCESS" "Files updated: $(git status --porcelain | wc -l)"
    
    # Update deployment status
    cat > "$DEPLOYMENT_STATUS_FILE" << EOF
STATUS=SUCCESS
START_TIME=$(grep START_TIME "$DEPLOYMENT_STATUS_FILE" 2>/dev/null | cut -d'=' -f2)
END_TIME=$(date '+%Y-%m-%d %H:%M:%S')
BACKUP_DIR=$backup_dir
PERFORMANCE_TIME=$performance_time
USER=$(whoami)
HOST=$(hostname)
EOF
    
    echo -e "${GREEN}📢 Success notification sent${NC}"
}

# Function to send deployment failure notification
notify_deployment_failure() {
    local error_message="$1"
    
    log_notification "ERROR" "❌ DEPLOYMENT FAILED"
    log_notification "ERROR" "Error: $error_message"
    log_notification "ERROR" "Time: $(date '+%Y-%m-%d %H:%M:%S')"
    
    # Update deployment status
    cat > "$DEPLOYMENT_STATUS_FILE" << EOF
STATUS=FAILED
START_TIME=$(grep START_TIME "$DEPLOYMENT_STATUS_FILE" 2>/dev/null | cut -d'=' -f2)
END_TIME=$(date '+%Y-%m-%d %H:%M:%S')
ERROR_MESSAGE=$error_message
USER=$(whoami)
HOST=$(hostname)
EOF
    
    echo -e "${RED}📢 Failure notification sent${NC}"
}

# Function to show deployment status
show_deployment_status() {
    echo -e "${BLUE}📊 DEPLOYMENT STATUS${NC}"
    echo "=================="
    
    if [[ -f "$DEPLOYMENT_STATUS_FILE" ]]; then
        source "$DEPLOYMENT_STATUS_FILE"
        
        echo "Status: $STATUS"
        echo "Start Time: $START_TIME"
        echo "End Time: $END_TIME"
        echo "User: $USER"
        echo "Host: $HOST"
        
        if [[ "$STATUS" == "SUCCESS" ]]; then
            echo "Performance: ${PERFORMANCE_TIME}s"
            echo "Backup: $BACKUP_DIR"
        elif [[ "$STATUS" == "FAILED" ]]; then
            echo "Error: $ERROR_MESSAGE"
        fi
    else
        echo -e "${YELLOW}No deployment status available${NC}"
    fi
    
    echo ""
    echo -e "${BLUE}Recent Notifications:${NC}"
    echo "======================"
    tail -10 "$NOTIFICATION_LOG" 2>/dev/null || echo "No notifications found"
}

# Function to show deployment history
show_deployment_history() {
    echo -e "${BLUE}📋 DEPLOYMENT HISTORY${NC}"
    echo "===================="
    
    if [[ -f "$NOTIFICATION_LOG" ]]; then
        grep -E "(DEPLOYMENT STARTED|DEPLOYMENT COMPLETED|DEPLOYMENT FAILED)" "$NOTIFICATION_LOG" | tail -20
    else
        echo -e "${YELLOW}No deployment history available${NC}"
    fi
}

# Function to clear notifications
clear_notifications() {
    echo -e "${YELLOW}⚠️  This will clear all deployment notifications${NC}"
    read -p "Are you sure? (yes/no): " confirm
    
    if [[ "$confirm" == "yes" ]]; then
        rm -f "$NOTIFICATION_LOG" "$DEPLOYMENT_STATUS_FILE"
        echo -e "${GREEN}✅ Notifications cleared${NC}"
    else
        echo -e "${BLUE}ℹ️  Operation cancelled${NC}"
    fi
}

# Main notification interface
main() {
    case "${1:-status}" in
        "start")
            notify_deployment_start "$2"
            ;;
        "success")
            notify_deployment_success "$2" "$3"
            ;;
        "failure")
            notify_deployment_failure "$2"
            ;;
        "status")
            show_deployment_status
            ;;
        "history")
            show_deployment_history
            ;;
        "clear")
            clear_notifications
            ;;
        *)
            echo -e "${BLUE}📢 Deployment Notification System${NC}"
            echo "================================"
            echo ""
            echo "Usage: $0 [command] [options]"
            echo ""
            echo "Commands:"
            echo "  start <backup_dir>     - Send deployment start notification"
            echo "  success <backup_dir> <performance_time> - Send success notification"
            echo "  failure <error_msg>    - Send failure notification"
            echo "  status                 - Show current deployment status"
            echo "  history                - Show deployment history"
            echo "  clear                  - Clear all notifications"
            ;;
    esac
}

# Run main function
main "$@"
