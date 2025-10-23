/* ==========================================================================
   WESTMARK TALENT GROUP - CONSOLIDATED JAVASCRIPT
   All essential functionality consolidated for performance and maintainability
   Custom interactions with responsive behavior
   ========================================================================== */

(function() {
  'use strict';

  // ==========================================================================
  // UTILITY FUNCTIONS
  // ==========================================================================
  
  function $(selector) {
    return document.querySelector(selector);
  }

  function $$(selector) {
    return document.querySelectorAll(selector);
  }

  function addClass(element, className) {
    if (element && element.classList) {
      element.classList.add(className);
    }
  }

  function removeClass(element, className) {
    if (element && element.classList) {
      element.classList.remove(className);
    }
  }

  function hasClass(element, className) {
    return element && element.classList && element.classList.contains(className);
  }

  function toggleClass(element, className) {
    if (element && element.classList) {
      element.classList.toggle(className);
    }
  }

  // ==========================================================================
  // NAVIGATION SYSTEM
  // ==========================================================================
  
  function initNavigation() {
    const navbarToggler = $('.navbar-toggler');
    const navbarCollapse = $('.navbar-collapse');
    const navLinks = $$('.soap-bar-link');

    // Mobile menu toggle
    if (navbarToggler && navbarCollapse) {
      navbarToggler.addEventListener('click', function(e) {
        e.preventDefault();
        e.stopPropagation();
        
        const isOpen = hasClass(navbarCollapse, 'show');
        
        if (isOpen) {
          removeClass(navbarCollapse, 'show');
          removeClass(navbarToggler, 'active');
        } else {
          addClass(navbarCollapse, 'show');
          addClass(navbarToggler, 'active');
        }
      });
    }

    // Smooth scrolling for navigation links
    navLinks.forEach(function(link) {
      link.addEventListener('click', function(e) {
        const href = this.getAttribute('href');
        
        // Only handle internal links
        if (href && href.startsWith('#')) {
          e.preventDefault();
          const target = $(href);
          
          if (target) {
            target.scrollIntoView({
              behavior: 'smooth',
              block: 'start'
            });
            
            // Close mobile menu if open
            if (navbarCollapse && hasClass(navbarCollapse, 'show')) {
              removeClass(navbarCollapse, 'show');
              removeClass(navbarToggler, 'active');
            }
          }
        }
      });
    });

    // Close mobile menu when clicking outside or on nav links
    document.addEventListener('click', function(e) {
      if (navbarCollapse && hasClass(navbarCollapse, 'show')) {
        const soapBar = $('.soap-bar');
        if (!soapBar.contains(e.target)) {
          removeClass(navbarCollapse, 'show');
          removeClass(navbarToggler, 'active');
        }
      }
    });

    // Close mobile menu when clicking on nav links
    navLinks.forEach(function(link) {
      link.addEventListener('click', function() {
        if (navbarCollapse && hasClass(navbarCollapse, 'show')) {
          removeClass(navbarCollapse, 'show');
          removeClass(navbarToggler, 'active');
        }
      });
    });
  }

  // ==========================================================================
  // SOAP BAR SCROLL EFFECT
  // ==========================================================================
  
  function initSoapBarScroll() {
    const soapBar = $('.soap-bar');
    let lastScrollY = window.scrollY;
    let ticking = false;

    function updateSoapBar() {
      const scrollY = window.scrollY;
      
      if (scrollY > 100) {
        addClass(soapBar, 'scrolled');
      } else {
        removeClass(soapBar, 'scrolled');
      }
      
      lastScrollY = scrollY;
      ticking = false;
    }

    function requestTick() {
      if (!ticking) {
        requestAnimationFrame(updateSoapBar);
        ticking = true;
      }
    }

    window.addEventListener('scroll', requestTick, { passive: true });
  }

  // ==========================================================================
  // ACCORDION FUNCTIONALITY
  // ==========================================================================
  
  function initAccordion() {
    const accordionHeaders = $$('[data-bs-toggle="collapse"]');
    
    accordionHeaders.forEach(function(header) {
      header.addEventListener('click', function(e) {
        e.preventDefault();
        
        const targetId = this.getAttribute('data-bs-target');
        const target = $(targetId);
        
        if (target) {
          // Close other open accordion items
          const allPanels = $$('.faq-collapse');
          allPanels.forEach(function(panel) {
            if (panel !== target && hasClass(panel, 'show')) {
              removeClass(panel, 'show');
              const panelHeader = $('[data-bs-target="#' + panel.id + '"]');
              if (panelHeader) {
                addClass(panelHeader, 'collapsed');
                panelHeader.setAttribute('aria-expanded', 'false');
              }
            }
          });
          
          // Toggle current panel
          toggleClass(target, 'show');
          toggleClass(this, 'collapsed');
          this.setAttribute('aria-expanded', hasClass(target, 'show'));
        }
      });
    });
  }

  // ==========================================================================
  // FORM HANDLING
  // ==========================================================================
  
  function initForms() {
    const forms = $$('form');
    
    forms.forEach(function(form) {
      form.addEventListener('submit', function(e) {
        e.preventDefault();
        
        // Basic form validation
        const requiredFields = form.querySelectorAll('[required]');
        let isValid = true;
        
        requiredFields.forEach(function(field) {
          if (!field.value.trim()) {
            isValid = false;
            addClass(field, 'error');
          } else {
            removeClass(field, 'error');
          }
        });
        
        if (isValid) {
          // Here you would typically send the form data to a server
          console.log('Form submitted successfully');
          showNotification('Thank you for your message! We\'ll get back to you soon.');
          form.reset();
        } else {
          showNotification('Please fill in all required fields.');
        }
      });
    });
  }

  // ==========================================================================
  // NOTIFICATION SYSTEM
  // ==========================================================================
  
  function showNotification(message, type = 'success') {
    const notification = document.createElement('div');
    notification.className = `notification notification-${type}`;
    notification.textContent = message;
    
    // Add styles
    notification.style.cssText = `
      position: fixed;
      top: 20px;
      right: 20px;
      background: ${type === 'success' ? '#27d081' : '#d32535'};
      color: white;
      padding: 1rem 1.5rem;
      border-radius: 0.5rem;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
      z-index: 10000;
      transform: translateX(100%);
      transition: transform 0.3s ease;
    `;
    
    document.body.appendChild(notification);
    
    // Animate in
    setTimeout(() => {
      notification.style.transform = 'translateX(0)';
    }, 100);
    
    // Remove after 5 seconds
    setTimeout(() => {
      notification.style.transform = 'translateX(100%)';
      setTimeout(() => {
        if (notification.parentNode) {
          notification.parentNode.removeChild(notification);
        }
      }, 300);
    }, 5000);
  }

  // ==========================================================================
  // PERFORMANCE MONITORING
  // ==========================================================================
  
  function initPerformanceMonitoring() {
    // Monitor page load performance
    window.addEventListener('load', function() {
      if ('performance' in window) {
        const perfData = performance.getEntriesByType('navigation')[0];
        const loadTime = perfData.loadEventEnd - perfData.loadEventStart;
        
        console.log('Page load time:', loadTime + 'ms');
        
        // Send to analytics if needed
        if (typeof gtag !== 'undefined') {
          gtag('event', 'page_load_time', {
            'value': Math.round(loadTime),
            'event_category': 'Performance'
          });
        }
      }
    });
  }

  // ==========================================================================
  // SERVICE WORKER REGISTRATION
  // ==========================================================================
  
  function initServiceWorker() {
    if ('serviceWorker' in navigator) {
      window.addEventListener('load', function() {
        navigator.serviceWorker.register('/sw.js')
          .then(function(registration) {
            console.log('ServiceWorker registration successful');
          })
          .catch(function(err) {
            console.log('ServiceWorker registration failed');
          });
      });
    }
  }

  // ==========================================================================
  // LAZY LOADING FOR IMAGES
  // ==========================================================================
  
  function initLazyLoading() {
    const images = $$('img[data-src]');
    
    if ('IntersectionObserver' in window) {
      const imageObserver = new IntersectionObserver(function(entries, observer) {
        entries.forEach(function(entry) {
          if (entry.isIntersecting) {
            const img = entry.target;
            img.src = img.dataset.src;
            img.classList.remove('lazy');
            imageObserver.unobserve(img);
          }
        });
      });
      
      images.forEach(function(img) {
        imageObserver.observe(img);
      });
    } else {
      // Fallback for older browsers
      images.forEach(function(img) {
        img.src = img.dataset.src;
        img.classList.remove('lazy');
      });
    }
  }

  // ==========================================================================
  // INITIALIZATION
  // ==========================================================================
  
  function init() {
    // Wait for DOM to be ready
    if (document.readyState === 'loading') {
      document.addEventListener('DOMContentLoaded', init);
      return;
    }
    
    // Initialize all components
    initNavigation();
    initSoapBarScroll();
    initAccordion();
    initForms();
    initPerformanceMonitoring();
    initServiceWorker();
    initLazyLoading();
    
    console.log('Westmark Talent Group - Consolidated JavaScript initialized');
  }

  // Start initialization
  init();

})();
