// Enhanced Responsive JavaScript for Westmark Website

document.addEventListener('DOMContentLoaded', function() {
    
    // Responsive Navigation Enhancement
    const navbar = document.querySelector('.navbar');
    const navbarToggler = document.querySelector('.navbar-toggler');
    const navbarCollapse = document.querySelector('.navbar-collapse');
    
    if (navbar && navbarToggler && navbarCollapse) {
        // Close mobile menu when clicking outside
        document.addEventListener('click', function(e) {
            if (!navbar.contains(e.target)) {
                if (navbarCollapse.classList.contains('show')) {
                    navbarToggler.click();
                }
            }
        });
        
        // Close mobile menu when clicking on a link
        const navLinks = navbarCollapse.querySelectorAll('.nav-link');
        navLinks.forEach(link => {
            link.addEventListener('click', () => {
                if (window.innerWidth < 992) {
                    navbarToggler.click();
                }
            });
        });
        
        // Add scroll effect to navbar
        let lastScrollTop = 0;
        window.addEventListener('scroll', function() {
            const scrollTop = window.pageYOffset || document.documentElement.scrollTop;
            
            if (scrollTop > 100) {
                navbar.classList.add('navbar-scrolled');
            } else {
                navbar.classList.remove('navbar-scrolled');
            }
            
            // Hide/show navbar on scroll (mobile only)
            if (window.innerWidth < 768) {
                if (scrollTop > lastScrollTop && scrollTop > 200) {
                    navbar.style.transform = 'translateY(-100%)';
                } else {
                    navbar.style.transform = 'translateY(0)';
                }
            }
            
            lastScrollTop = scrollTop;
        });
    }
    
    // Responsive Image Loading - Optimized
    const images = document.querySelectorAll('img:not([loading])');
    images.forEach(img => {
        img.setAttribute('loading', 'lazy');
        img.classList.add('responsive-img');
        
        // Handle image errors
        img.addEventListener('error', function() {
            this.style.display = 'none';
        });
    });
    
    // Responsive Form Enhancement
    const forms = document.querySelectorAll('form');
    forms.forEach(form => {
        // Add responsive classes
        form.classList.add('contact-form');
        
        // Enhance form inputs
        const inputs = form.querySelectorAll('input, textarea, select');
        inputs.forEach(input => {
            input.classList.add('form-control');
            
            // Add focus effects
            input.addEventListener('focus', function() {
                this.parentElement.classList.add('focused');
            });
            
            input.addEventListener('blur', function() {
                if (!this.value) {
                    this.parentElement.classList.remove('focused');
                }
            });
        });
    });
    
    // Responsive Table Enhancement
    const tables = document.querySelectorAll('table');
    tables.forEach(table => {
        if (!table.parentElement.classList.contains('table-responsive')) {
            const wrapper = document.createElement('div');
            wrapper.className = 'table-responsive';
            table.parentNode.insertBefore(wrapper, table);
            wrapper.appendChild(table);
        }
    });
    
    // Responsive Card Enhancement
    const cards = document.querySelectorAll('.card');
    cards.forEach(card => {
        // Add hover effects for desktop only
        if (window.innerWidth > 768) {
            card.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-5px)';
                this.style.boxShadow = '0 8px 25px rgba(0,0,0,0.15)';
            });
            
            card.addEventListener('mouseleave', function() {
                this.style.transform = 'translateY(0)';
                this.style.boxShadow = '0 2px 10px rgba(0,0,0,0.1)';
            });
        }
    });
    
    // Responsive Button Enhancement
    const buttons = document.querySelectorAll('.btn');
    buttons.forEach(btn => {
        // Add touch feedback for mobile
        btn.addEventListener('touchstart', function() {
            this.style.transform = 'scale(0.95)';
        });
        
        btn.addEventListener('touchend', function() {
            this.style.transform = 'scale(1)';
        });
    });
    
    // Dynamic Font Size Adjustment
    function adjustFontSizes() {
        const vw = window.innerWidth;
        const root = document.documentElement;
        
        // Adjust base font size based on viewport width
        if (vw < 576) {
            root.style.fontSize = '14px';
        } else if (vw < 768) {
            root.style.fontSize = '15px';
        } else if (vw < 992) {
            root.style.fontSize = '16px';
        } else {
            root.style.fontSize = '16px';
        }
    }
    
    // Call on load and resize
    adjustFontSizes();
    window.addEventListener('resize', adjustFontSizes);
    
    // Responsive Spacing Adjustment
    function adjustSpacing() {
        const vw = window.innerWidth;
        const sections = document.querySelectorAll('section');
        
        sections.forEach(section => {
            if (vw < 576) {
                section.style.padding = '2rem 0';
            } else if (vw < 768) {
                section.style.padding = '3rem 0';
            } else if (vw < 992) {
                section.style.padding = '4rem 0';
            } else {
                section.style.padding = '5rem 0';
            }
        });
    }
    
    // Call on load and resize
    adjustSpacing();
    window.addEventListener('resize', adjustSpacing);
    
    // Touch Device Detection
    function isTouchDevice() {
        return 'ontouchstart' in window || navigator.maxTouchPoints > 0;
    }
    
    if (isTouchDevice()) {
        document.body.classList.add('touch-device');
        
        // Optimize for touch devices
        const touchElements = document.querySelectorAll('.btn, .nav-link, .card');
        touchElements.forEach(element => {
            element.style.minHeight = '44px';
        });
    }
    
    // Responsive Grid Adjustment
    function adjustGrid() {
        const vw = window.innerWidth;
        const gridItems = document.querySelectorAll('[class*="col-"]');
        
        gridItems.forEach(item => {
            if (vw < 576) {
                item.style.marginBottom = '1rem';
            } else {
                item.style.marginBottom = '';
            }
        });
    }
    
    // Call on load and resize
    adjustGrid();
    window.addEventListener('resize', adjustGrid);
    
    // Performance Optimization
    let resizeTimer;
    window.addEventListener('resize', function() {
        clearTimeout(resizeTimer);
        resizeTimer = setTimeout(function() {
            adjustFontSizes();
            adjustSpacing();
            adjustGrid();
        }, 250);
    });
    
    // Intersection Observer for Lazy Loading
    if ('IntersectionObserver' in window) {
        const imageObserver = new IntersectionObserver((entries, observer) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    const img = entry.target;
                    if (img.dataset.src) {
                        img.src = img.dataset.src;
                        img.removeAttribute('data-src');
                        imageObserver.unobserve(img);
                    }
                }
            });
        });
        
        // Observe images with data-src attribute
        const lazyImages = document.querySelectorAll('img[data-src]');
        lazyImages.forEach(img => imageObserver.observe(img));
    }
    
    // Add CSS classes for responsive utilities
    function addResponsiveClasses() {
        const body = document.body;
        
        // Add viewport size classes
        if (window.innerWidth < 576) {
            body.classList.add('viewport-xs');
        } else if (window.innerWidth < 768) {
            body.classList.add('viewport-sm');
        } else if (window.innerWidth < 992) {
            body.classList.add('viewport-md');
        } else if (window.innerWidth < 1200) {
            body.classList.add('viewport-lg');
        } else {
            body.classList.add('viewport-xl');
        }
        
        // Add orientation classes
        if (window.innerHeight > window.innerWidth) {
            body.classList.add('orientation-portrait');
            body.classList.remove('orientation-landscape');
        } else {
            body.classList.add('orientation-landscape');
            body.classList.remove('orientation-portrait');
        }
    }
    
    // Call on load and resize
    addResponsiveClasses();
    window.addEventListener('resize', addResponsiveClasses);
    window.addEventListener('orientationchange', addResponsiveClasses);
    
    // Console log for debugging
    console.log('Responsive JavaScript loaded successfully');
    console.log('Viewport width:', window.innerWidth);
    console.log('Touch device:', isTouchDevice());
});

// Export for module systems (if needed)
if (typeof module !== 'undefined' && module.exports) {
    module.exports = {};
}
