/**
 * Westmark Talent Group - Performance Monitoring
 * Core Web Vitals tracking and performance optimization
 */

class PerformanceMonitor {
    constructor() {
        this.metrics = {};
        this.init();
    }

    init() {
        // Wait for page load
        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', () => this.startMonitoring());
        } else {
            this.startMonitoring();
        }
    }

    startMonitoring() {
        // Monitor Core Web Vitals
        this.monitorLCP();
        this.monitorFID();
        this.monitorCLS();
        this.monitorFCP();
        this.monitorTTFB();
        
        // Monitor resource loading
        this.monitorResources();
        
        // Monitor user interactions
        this.monitorInteractions();
    }

    monitorLCP() {
        // Largest Contentful Paint
        const observer = new PerformanceObserver((entryList) => {
            const entries = entryList.getEntries();
            const lastEntry = entries[entries.length - 1];
            
            this.metrics.lcp = {
                value: lastEntry.startTime,
                element: lastEntry.element?.tagName || 'unknown',
                url: lastEntry.url || 'unknown'
            };

            this.reportMetric('lcp', this.metrics.lcp);
        });

        observer.observe({ entryTypes: ['largest-contentful-paint'] });
    }

    monitorFID() {
        // First Input Delay
        const observer = new PerformanceObserver((entryList) => {
            const entries = entryList.getEntries();
            
            entries.forEach(entry => {
                this.metrics.fid = {
                    value: entry.processingStart - entry.startTime,
                    eventType: entry.name,
                    target: entry.target?.tagName || 'unknown'
                };

                this.reportMetric('fid', this.metrics.fid);
            });
        });

        observer.observe({ entryTypes: ['first-input'] });
    }

    monitorCLS() {
        // Cumulative Layout Shift
        let clsValue = 0;
        let clsEntries = [];

        const observer = new PerformanceObserver((entryList) => {
            const entries = entryList.getEntries();
            
            entries.forEach(entry => {
                if (!entry.hadRecentInput) {
                    clsValue += entry.value;
                    clsEntries.push(entry);
                }
            });

            this.metrics.cls = {
                value: clsValue,
                entries: clsEntries.length
            };

            this.reportMetric('cls', this.metrics.cls);
        });

        observer.observe({ entryTypes: ['layout-shift'] });
    }

    monitorFCP() {
        // First Contentful Paint
        const observer = new PerformanceObserver((entryList) => {
            const entries = entryList.getEntries();
            
            entries.forEach(entry => {
                this.metrics.fcp = {
                    value: entry.startTime,
                    size: entry.size || 0
                };

                this.reportMetric('fcp', this.metrics.fcp);
            });
        });

        observer.observe({ entryTypes: ['paint'] });
    }

    monitorTTFB() {
        // Time to First Byte
        window.addEventListener('load', () => {
            const navigation = performance.getEntriesByType('navigation')[0];
            
            if (navigation) {
                this.metrics.ttfb = {
                    value: navigation.responseStart - navigation.requestStart,
                    dns: navigation.domainLookupEnd - navigation.domainLookupStart,
                    connect: navigation.connectEnd - navigation.connectStart
                };

                this.reportMetric('ttfb', this.metrics.ttfb);
            }
        });
    }

    monitorResources() {
        // Monitor resource loading performance
        const observer = new PerformanceObserver((entryList) => {
            const entries = entryList.getEntries();
            
            entries.forEach(entry => {
                if (entry.duration > 1000) { // Resources taking longer than 1 second
                    this.reportSlowResource(entry);
                }
            });
        });

        observer.observe({ entryTypes: ['resource'] });
    }

    monitorInteractions() {
        // Monitor user interactions for engagement metrics
        let interactionCount = 0;
        let scrollDepth = 0;

        // Track clicks
        document.addEventListener('click', (e) => {
            interactionCount++;
            this.reportInteraction('click', {
                target: e.target.tagName,
                text: e.target.textContent?.substring(0, 50) || '',
                url: window.location.pathname
            });
        });

        // Track scroll depth
        window.addEventListener('scroll', () => {
            const scrollPercent = Math.round(
                (window.scrollY / (document.body.scrollHeight - window.innerHeight)) * 100
            );
            
            if (scrollPercent > scrollDepth) {
                scrollDepth = scrollPercent;
                
                if (scrollDepth % 25 === 0) { // Report at 25%, 50%, 75%, 100%
                    this.reportInteraction('scroll', {
                        depth: scrollDepth,
                        url: window.location.pathname
                    });
                }
            }
        });
    }

    reportMetric(metricName, data) {
        // Send to Google Analytics if available
        if (typeof gtag !== 'undefined') {
            gtag('event', metricName, {
                custom_parameter_1: metricName,
                custom_parameter_2: JSON.stringify(data),
                value: Math.round(data.value)
            });
        }

        // Log to console in development
        if (window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1') {
            console.log(`📊 ${metricName.toUpperCase()}:`, data);
        }

        // Store locally for debugging
        this.metrics[metricName] = data;
    }

    reportSlowResource(entry) {
        const resourceData = {
            name: entry.name,
            duration: Math.round(entry.duration),
            size: entry.transferSize || 0,
            type: entry.initiatorType
        };

        if (typeof gtag !== 'undefined') {
            gtag('event', 'slow_resource', {
                custom_parameter_1: 'performance',
                custom_parameter_2: JSON.stringify(resourceData)
            });
        }

        if (window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1') {
            console.warn('🐌 Slow Resource:', resourceData);
        }
    }

    reportInteraction(type, data) {
        if (typeof gtag !== 'undefined') {
            gtag('event', type, {
                custom_parameter_1: 'engagement',
                custom_parameter_2: JSON.stringify(data)
            });
        }
    }

    getMetrics() {
        return this.metrics;
    }

    generateReport() {
        const report = {
            timestamp: new Date().toISOString(),
            url: window.location.href,
            metrics: this.metrics,
            userAgent: navigator.userAgent,
            connection: navigator.connection ? {
                effectiveType: navigator.connection.effectiveType,
                downlink: navigator.connection.downlink
            } : null
        };

        return report;
    }
}

// Initialize performance monitoring
const performanceMonitor = new PerformanceMonitor();

// Export for debugging
window.westmarkPerformance = performanceMonitor;
