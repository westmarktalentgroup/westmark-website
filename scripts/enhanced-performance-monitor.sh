#!/bin/bash

# Enhanced Performance Monitoring System
# Westmark Talent Group Website
# 
# This script provides comprehensive performance monitoring and analysis

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
PERFORMANCE_LOG=".performance-monitor.log"
PERFORMANCE_THRESHOLD=2.0  # seconds

# Function to log performance data
log_performance() {
    local metric="$1"
    local value="$2"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] $metric: $value" >> "$PERFORMANCE_LOG"
}

# Function to run comprehensive performance analysis
run_performance_analysis() {
    echo -e "${BLUE}📊 COMPREHENSIVE PERFORMANCE ANALYSIS${NC}"
    echo "====================================="
    
    # Start local server
    echo "🚀 Starting performance test server..."
    python3 -m http.server 8000 > /dev/null 2>&1 &
    SERVER_PID=$!
    sleep 3
    
    # Test multiple pages
    local pages=("index.html" "clients.html" "contact-us.html" "logo.html")
    local total_time=0
    local page_count=0
    
    echo ""
    echo -e "${BLUE}📈 Page Load Performance:${NC}"
    echo "========================="
    
    for page in "${pages[@]}"; do
        if [[ -f "$page" ]]; then
            echo -n "Testing $page... "
            
            # Measure load time
            local load_time=$(curl -o /dev/null -s -w '%{time_total}' "http://localhost:8000/$page" 2>/dev/null || echo "0")
            
            # Format output
            if (( $(echo "$load_time < $PERFORMANCE_THRESHOLD" | bc -l) )); then
                echo -e "${GREEN}${load_time}s ✅${NC}"
            else
                echo -e "${YELLOW}${load_time}s ⚠️${NC}"
            fi
            
            # Log performance data
            log_performance "PAGE_LOAD_TIME" "$page:$load_time"
            
            total_time=$(echo "$total_time + $load_time" | bc -l)
            ((page_count++))
        fi
    done
    
    # Calculate average
    if [[ $page_count -gt 0 ]]; then
        local avg_time=$(echo "scale=3; $total_time / $page_count" | bc -l)
        echo ""
        echo -e "${BLUE}📊 Performance Summary:${NC}"
        echo "====================="
        echo "Average load time: ${avg_time}s"
        echo "Total pages tested: $page_count"
        echo "Performance threshold: ${PERFORMANCE_THRESHOLD}s"
        
        # Performance assessment
        if (( $(echo "$avg_time < $PERFORMANCE_THRESHOLD" | bc -l) )); then
            echo -e "${GREEN}✅ Performance: EXCELLENT${NC}"
        elif (( $(echo "$avg_time < $((PERFORMANCE_THRESHOLD * 1.5))" | bc -l) )); then
            echo -e "${YELLOW}⚠️  Performance: ACCEPTABLE${NC}"
        else
            echo -e "${RED}❌ Performance: NEEDS IMPROVEMENT${NC}"
        fi
        
        # Log summary
        log_performance "AVERAGE_LOAD_TIME" "$avg_time"
        log_performance "PAGES_TESTED" "$page_count"
        log_performance "PERFORMANCE_THRESHOLD" "$PERFORMANCE_THRESHOLD"
    fi
    
    # Test asset loading
    echo ""
    echo -e "${BLUE}🖼️  Asset Loading Performance:${NC}"
    echo "============================="
    
    local assets=("assets/css/optimized.css" "assets/js/consolidated.js")
    for asset in "${assets[@]}"; do
        if [[ -f "$asset" ]]; then
            echo -n "Testing $asset... "
            local asset_time=$(curl -o /dev/null -s -w '%{time_total}' "http://localhost:8000/$asset" 2>/dev/null || echo "0")
            echo -e "${GREEN}${asset_time}s${NC}"
            log_performance "ASSET_LOAD_TIME" "$asset:$asset_time"
        fi
    done
    
    # Memory usage analysis
    echo ""
    echo -e "${BLUE}💾 Memory Usage Analysis:${NC}"
    echo "========================"
    
    local css_size=$(du -h "assets/css/optimized.css" 2>/dev/null | cut -f1 || echo "N/A")
    local js_size=$(du -h "assets/js/consolidated.js" 2>/dev/null | cut -f1 || echo "N/A")
    local total_size=$(du -sh . 2>/dev/null | cut -f1 || echo "N/A")
    
    echo "CSS file size: $css_size"
    echo "JavaScript file size: $js_size"
    echo "Total site size: $total_size"
    
    log_performance "CSS_SIZE" "$css_size"
    log_performance "JS_SIZE" "$js_size"
    log_performance "TOTAL_SIZE" "$total_size"
    
    # Kill test server
    kill $SERVER_PID 2>/dev/null || true
    
    echo ""
    echo -e "${GREEN}✅ Performance analysis completed${NC}"
    echo -e "${BLUE}📝 Results logged to: $PERFORMANCE_LOG${NC}"
}

# Function to show performance history
show_performance_history() {
    echo -e "${BLUE}📋 PERFORMANCE HISTORY${NC}"
    echo "===================="
    
    if [[ -f "$PERFORMANCE_LOG" ]]; then
        echo "Recent performance data:"
        echo ""
        tail -20 "$PERFORMANCE_LOG"
    else
        echo -e "${YELLOW}No performance data available${NC}"
    fi
}

# Function to generate performance report
generate_performance_report() {
    echo -e "${BLUE}📊 PERFORMANCE REPORT${NC}"
    echo "===================="
    
    if [[ ! -f "$PERFORMANCE_LOG" ]]; then
        echo -e "${YELLOW}No performance data available${NC}"
        return 1
    fi
    
    echo "Generating performance report..."
    echo ""
    
    # Extract average load times
    echo "📈 Average Load Times:"
    grep "AVERAGE_LOAD_TIME" "$PERFORMANCE_LOG" | tail -10
    
    echo ""
    echo "🖼️  Asset Performance:"
    grep "ASSET_LOAD_TIME" "$PERFORMANCE_LOG" | tail -10
    
    echo ""
    echo "💾 File Sizes:"
    grep -E "(CSS_SIZE|JS_SIZE|TOTAL_SIZE)" "$PERFORMANCE_LOG" | tail -10
    
    echo ""
    echo -e "${GREEN}✅ Performance report generated${NC}"
}

# Function to clear performance data
clear_performance_data() {
    echo -e "${YELLOW}⚠️  This will clear all performance monitoring data${NC}"
    read -p "Are you sure? (yes/no): " confirm
    
    if [[ "$confirm" == "yes" ]]; then
        rm -f "$PERFORMANCE_LOG"
        echo -e "${GREEN}✅ Performance data cleared${NC}"
    else
        echo -e "${BLUE}ℹ️  Operation cancelled${NC}"
    fi
}

# Main performance monitoring interface
main() {
    case "${1:-analyze}" in
        "analyze")
            run_performance_analysis
            ;;
        "history")
            show_performance_history
            ;;
        "report")
            generate_performance_report
            ;;
        "clear")
            clear_performance_data
            ;;
        *)
            echo -e "${BLUE}📊 Enhanced Performance Monitoring System${NC}"
            echo "========================================"
            echo ""
            echo "Usage: $0 [command]"
            echo ""
            echo "Commands:"
            echo "  analyze  - Run comprehensive performance analysis"
            echo "  history  - Show performance history"
            echo "  report   - Generate performance report"
            echo "  clear    - Clear performance data"
            ;;
    esac
}

# Run main function
main "$@"
