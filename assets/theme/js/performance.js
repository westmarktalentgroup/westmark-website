// Performance Optimization Script for Westmark Website

document.addEventListener('DOMContentLoaded', function() {
    
    // Lazy load images with Intersection Observer
    if ('IntersectionObserver' in window) {
        const imageObserver = new IntersectionObserver((entries, observer) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    const img = entry.target;
                    if (img.dataset.src) {
                        img.src = img.dataset.src;
                        img.classList.remove('lazy');
                        imageObserver.unobserve(img);
                    }
                }
            });
        });

        document.querySelectorAll('img[data-src]').forEach(img => {
            imageObserver.observe(img);
        });
    }

    // Optimize scroll events with throttling
    let ticking = false;
    function updateOnScroll() {
        ticking = false;
        // Update navbar scroll effects
        const navbar = document.querySelector('.navbar-dropdown');
        if (navbar) {
            const scrollTop = window.pageYOffset || document.documentElement.scrollTop;
            if (scrollTop > 100) {
                navbar.classList.add('navbar-scrolled');
            } else {
                navbar.classList.remove('navbar-scrolled');
            }
        }
    }

    function requestTick() {
        if (!ticking) {
            requestAnimationFrame(updateOnScroll);
            ticking = true;
        }
    }

    window.addEventListener('scroll', requestTick, { passive: true });

    // Optimize resize events
    let resizeTimeout;
    function handleResize() {
        clearTimeout(resizeTimeout);
        resizeTimeout = setTimeout(() => {
            // Handle responsive adjustments
            const isMobile = window.innerWidth < 768;
            document.body.classList.toggle('is-mobile', isMobile);
        }, 250);
    }

    window.addEventListener('resize', handleResize, { passive: true });

    // Preload critical resources
    function preloadResource(href, as) {
        const link = document.createElement('link');
        link.rel = 'preload';
        link.href = href;
        link.as = as;
        document.head.appendChild(link);
    }

    // Preload critical images
    const criticalImages = [
        'assets/images/westmark-logo-128x62-1.png',
        'assets/images/background1.jpg'
    ];

    criticalImages.forEach(src => {
        preloadResource(src, 'image');
    });

    // Optimize form interactions
    const forms = document.querySelectorAll('form');
    forms.forEach(form => {
        const inputs = form.querySelectorAll('input, textarea, select');
        
        inputs.forEach(input => {
            // Add focus optimization
            input.addEventListener('focus', function() {
                this.parentElement.classList.add('focused');
            }, { passive: true });
            
            input.addEventListener('blur', function() {
                if (!this.value) {
                    this.parentElement.classList.remove('focused');
                }
            }, { passive: true });
        });
    });

    // Optimize navigation interactions
    const navLinks = document.querySelectorAll('.nav-link');
    navLinks.forEach(link => {
        link.addEventListener('click', function() {
            // Add loading state for navigation
            document.body.classList.add('navigating');
            setTimeout(() => {
                document.body.classList.remove('navigating');
            }, 100);
        }, { passive: true });
    });

    // Optimize mobile navigation
    const mobileHamburger = document.querySelector('.mobile-hamburger');
    if (mobileHamburger) {
        let touchStartY = 0;
        let touchEndY = 0;
        
        mobileHamburger.addEventListener('touchstart', function(e) {
            touchStartY = e.touches[0].clientY;
        }, { passive: true });
        
        mobileHamburger.addEventListener('touchend', function(e) {
            touchEndY = e.changedTouches[0].clientY;
            const diff = touchStartY - touchEndY;
            
            // Swipe up to expand, swipe down to collapse
            if (Math.abs(diff) > 50) {
                if (diff > 0 && !this.classList.contains('expanded')) {
                    this.classList.add('expanded');
                } else if (diff < 0 && this.classList.contains('expanded')) {
                    this.classList.remove('expanded');
                }
            }
        }, { passive: true });
    }

    // Performance monitoring
    if ('performance' in window) {
        window.addEventListener('load', function() {
            setTimeout(() => {
                const perfData = performance.getEntriesByType('navigation')[0];
                if (perfData) {
                    console.log('Page Load Time:', perfData.loadEventEnd - perfData.loadEventStart, 'ms');
                }
            }, 0);
        });
    }
});
