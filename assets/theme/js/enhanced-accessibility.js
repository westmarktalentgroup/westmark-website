/**
 * Enhanced Accessibility and Form Handling
 * Provides better user experience, form validation, and accessibility features
 */

(function() {
  'use strict';

  // Focus management
  class FocusManager {
    constructor() {
      this.focusableElements = 'button, [href], input, select, textarea, [tabindex]:not([tabindex="-1"])';
      this.modalStack = [];
      this.init();
    }

    init() {
      // Add focus-visible polyfill
      document.body.classList.add('js-focus-visible');
      
      // Handle focus trapping
      this.setupFocusTrapping();
      
      // Handle skip navigation
      this.setupSkipNavigation();
    }

    setupFocusTrapping() {
      // Trap focus within modals and expanded mobile menu
      document.addEventListener('keydown', (e) => {
        if (e.key === 'Tab') {
          this.handleTabKey(e);
        }
      });
    }

    handleTabKey(e) {
      const mobileMenu = document.querySelector('.mobile-hamburger.expanded');
      if (mobileMenu) {
        const focusableElements = mobileMenu.querySelectorAll(this.focusableElements);
        const firstElement = focusableElements[0];
        const lastElement = focusableElements[focusableElements.length - 1];

        if (e.shiftKey) {
          if (document.activeElement === firstElement) {
            e.preventDefault();
            lastElement.focus();
          }
        } else {
          if (document.activeElement === lastElement) {
            e.preventDefault();
            firstElement.focus();
          }
        }
      }
    }

    setupSkipNavigation() {
      const skipLink = document.querySelector('.skip-navigation');
      if (skipLink) {
        skipLink.addEventListener('click', (e) => {
          e.preventDefault();
          const target = document.querySelector(skipLink.getAttribute('href'));
          if (target) {
            target.focus();
            target.scrollIntoView({ behavior: 'smooth' });
          }
        });
      }
    }
  }

  // Form validation and handling
  class FormHandler {
    constructor() {
      this.forms = document.querySelectorAll('form[data-form-title]');
      this.init();
    }

    init() {
      this.forms.forEach(form => {
        this.setupForm(form);
      });
    }

    setupForm(form) {
      const inputs = form.querySelectorAll('input, textarea');
      const submitButton = form.querySelector('button[type="submit"]');
      
      // Add real-time validation
      inputs.forEach(input => {
        input.addEventListener('blur', () => this.validateField(input));
        input.addEventListener('input', () => this.clearFieldError(input));
      });

      // Handle form submission
      form.addEventListener('submit', (e) => this.handleSubmit(e, form));
      
      // Handle submit button state
      if (submitButton) {
        inputs.forEach(input => {
          input.addEventListener('input', () => this.updateSubmitButton(form, submitButton));
        });
      }
    }

    validateField(field) {
      const value = field.value.trim();
      const errorElement = document.getElementById(field.getAttribute('aria-describedby'));
      
      if (!errorElement) return;

      let isValid = true;
      let errorMessage = '';

      // Required field validation
      if (field.hasAttribute('required') && !value) {
        isValid = false;
        errorMessage = 'This field is required.';
      }

      // Email validation
      if (field.type === 'email' && value) {
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(value)) {
          isValid = false;
          errorMessage = 'Please enter a valid email address.';
        }
      }

      // Length validation
      if (field.hasAttribute('minlength') && value.length < parseInt(field.getAttribute('minlength'))) {
        isValid = false;
        errorMessage = `Minimum length is ${field.getAttribute('minlength')} characters.`;
      }

      if (field.hasAttribute('maxlength') && value.length > parseInt(field.getAttribute('maxlength'))) {
        isValid = false;
        errorMessage = `Maximum length is ${field.getAttribute('maxlength')} characters.`;
      }

      // Update field state
      if (isValid) {
        field.classList.remove('is-invalid');
        field.classList.add('is-valid');
        errorElement.textContent = '';
        errorElement.style.display = 'none';
      } else {
        field.classList.remove('is-valid');
        field.classList.add('is-invalid');
        errorElement.textContent = errorMessage;
        errorElement.style.display = 'block';
      }

      return isValid;
    }

    clearFieldError(field) {
      const errorElement = document.getElementById(field.getAttribute('aria-describedby'));
      if (errorElement) {
        field.classList.remove('is-invalid', 'is-valid');
        errorElement.textContent = '';
        errorElement.style.display = 'none';
      }
    }

    updateSubmitButton(form, submitButton) {
      const inputs = form.querySelectorAll('input[required], textarea[required]');
      const isValid = Array.from(inputs).every(input => input.value.trim() !== '');
      
      submitButton.disabled = !isValid;
      submitButton.setAttribute('aria-disabled', !isValid);
    }

    async handleSubmit(e, form) {
      e.preventDefault();
      
      const submitButton = form.querySelector('button[type="submit"]');
      const statusElement = document.getElementById('submit-status');
      
      // Validate all fields
      const inputs = form.querySelectorAll('input, textarea');
      const isValid = Array.from(inputs).every(input => this.validateField(input));
      
      if (!isValid) {
        // Focus first invalid field
        const firstInvalid = form.querySelector('.is-invalid');
        if (firstInvalid) {
          firstInvalid.focus();
        }
        return;
      }

      // Update button state
      if (submitButton) {
        submitButton.disabled = true;
        submitButton.setAttribute('aria-disabled', 'true');
        submitButton.innerHTML = '<span class="spinner-border spinner-border-sm me-2" role="status" aria-hidden="true"></span>Sending...';
      }

      // Update status
      if (statusElement) {
        statusElement.textContent = 'Sending your message...';
        statusElement.classList.remove('sr-only');
      }

      try {
        // Simulate form submission (replace with actual API call)
        await this.submitForm(form);
        
        // Success
        if (statusElement) {
          statusElement.textContent = 'Message sent successfully!';
          statusElement.classList.add('text-success');
        }
        
        // Reset form
        form.reset();
        inputs.forEach(input => {
          input.classList.remove('is-valid', 'is-invalid');
        });
        
      } catch (error) {
        // Error
        if (statusElement) {
          statusElement.textContent = 'Error sending message. Please try again.';
          statusElement.classList.add('text-danger');
        }
        
        console.error('Form submission error:', error);
      } finally {
        // Reset button state
        if (submitButton) {
          submitButton.disabled = false;
          submitButton.setAttribute('aria-disabled', 'false');
          submitButton.innerHTML = 'Submit';
        }
        
        // Hide status after delay
        if (statusElement) {
          setTimeout(() => {
            statusElement.classList.add('sr-only');
            statusElement.classList.remove('text-success', 'text-danger');
          }, 5000);
        }
      }
    }

    async submitForm(form) {
      // Simulate API call
      return new Promise((resolve, reject) => {
        setTimeout(() => {
          // Simulate 90% success rate
          if (Math.random() > 0.1) {
            resolve();
          } else {
            reject(new Error('Network error'));
          }
        }, 1000);
      });
    }
  }

  // Mobile menu enhancements
  class MobileMenuHandler {
    constructor() {
      this.mobileHamburger = document.querySelector('.mobile-hamburger');
      this.init();
    }

    init() {
      if (this.mobileHamburger) {
        this.setupMobileMenu();
      }
    }

    setupMobileMenu() {
      this.mobileHamburger.addEventListener('click', (e) => {
        e.preventDefault();
        this.toggleMenu();
      });

      // Close menu when clicking outside
      document.addEventListener('click', (e) => {
        if (!this.mobileHamburger.contains(e.target)) {
          this.closeMenu();
        }
      });

      // Handle escape key
      document.addEventListener('keydown', (e) => {
        if (e.key === 'Escape') {
          this.closeMenu();
        }
      });

      // Handle focus management
      this.setupFocusManagement();
    }

    toggleMenu() {
      const isExpanded = this.mobileHamburger.classList.contains('expanded');
      
      if (isExpanded) {
        this.closeMenu();
      } else {
        this.openMenu();
      }
    }

    openMenu() {
      this.mobileHamburger.classList.add('expanded');
      this.mobileHamburger.setAttribute('aria-expanded', 'true');
      
      // Focus first menu item
      const firstMenuItem = this.mobileHamburger.querySelector('[role="menuitem"]');
      if (firstMenuItem) {
        setTimeout(() => firstMenuItem.focus(), 100);
      }
    }

    closeMenu() {
      this.mobileHamburger.classList.remove('expanded');
      this.mobileHamburger.setAttribute('aria-expanded', 'false');
      
      // Return focus to hamburger button
      this.mobileHamburger.focus();
    }

    setupFocusManagement() {
      const menuItems = this.mobileHamburger.querySelectorAll('[role="menuitem"]');
      
      menuItems.forEach((item, index) => {
        item.addEventListener('keydown', (e) => {
          switch (e.key) {
            case 'ArrowDown':
            case 'ArrowRight':
              e.preventDefault();
              const nextIndex = (index + 1) % menuItems.length;
              menuItems[nextIndex].focus();
              break;
              
            case 'ArrowUp':
            case 'ArrowLeft':
              e.preventDefault();
              const prevIndex = (index - 1 + menuItems.length) % menuItems.length;
              menuItems[prevIndex].focus();
              break;
              
            case 'Home':
              e.preventDefault();
              menuItems[0].focus();
              break;
              
            case 'End':
              e.preventDefault();
              menuItems[menuItems.length - 1].focus();
              break;
          }
        });
      });
    }
  }

  // Initialize when DOM is ready
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }

  function init() {
    new FocusManager();
    new FormHandler();
    new MobileMenuHandler();
    
    // Announce page changes for screen readers
    announcePageLoad();
  }

  function announcePageLoad() {
    const pageTitle = document.title;
    const announcement = document.createElement('div');
    announcement.setAttribute('aria-live', 'polite');
    announcement.setAttribute('aria-atomic', 'true');
    announcement.className = 'sr-only';
    announcement.textContent = `Page loaded: ${pageTitle}`;
    
    document.body.appendChild(announcement);
    
    // Remove after announcement
    setTimeout(() => {
      if (announcement.parentNode) {
        announcement.parentNode.removeChild(announcement);
      }
    }, 1000);
  }

})();
