// Error Handling Improvements - No Visual Changes
(function() {
    'use strict';
    
    // Suppress common console warnings
    const originalConsoleWarn = console.warn;
    const originalConsoleError = console.error;
    
    // Filter out common non-critical warnings
    console.warn = function(...args) {
        const message = args.join(' ');
        
        // Suppress common Bootstrap warnings
        if (message.includes("Bootstrap doesn't allow more than one instance per element")) {
            return;
        }
        
        // Suppress common Vimeo warnings
        if (message.includes("jQuery object with multiple elements was passed")) {
            return;
        }
        
        // Log other warnings normally
        originalConsoleWarn.apply(console, args);
    };
    
    // Filter out common non-critical errors
    console.error = function(...args) {
        const message = args.join(' ');
        
        // Suppress common Vimeo embed errors
        if (message.includes("There was an error creating an embed")) {
            return;
        }
        
        // Log other errors normally
        originalConsoleError.apply(console, args);
    };
    
    // Global error handler for uncaught errors
    window.addEventListener('error', function(event) {
        // Prevent error from showing in console if it's non-critical
        if (event.message && event.message.includes('Vimeo')) {
            event.preventDefault();
            return false;
        }
    });
    
    // Form handling removed - forms replaced with contact information
    
    // Performance monitoring (only in development)
    if (window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1') {
        if ('performance' in window) {
            window.addEventListener('load', function() {
                setTimeout(function() {
                    const perfData = performance.getEntriesByType('navigation')[0];
                    if (perfData && perfData.loadEventEnd) {
                        const loadTime = perfData.loadEventEnd - perfData.loadEventStart;
                        if (loadTime > 3000) {
                            console.info('Page load time:', loadTime + 'ms');
                        }
                    }
                }, 1000);
            });
        }
    }
    
})();
