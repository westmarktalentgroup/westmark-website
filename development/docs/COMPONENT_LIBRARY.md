# Component Library Documentation

## Westmark Talent Group Website

### Overview

This document provides detailed specifications for all UI components used in the Westmark Talent Group website. Each component includes design specifications, HTML structure, CSS classes, JavaScript behavior, and usage examples to ensure consistent implementation across all pages.

## Component Design Principles

### Core Component Standards
- **Consistency**: All components follow the same design patterns
- **Accessibility**: WCAG 2.1 AA compliance built into all components
- **Responsiveness**: Mobile-first design with progressive enhancement
- **Performance**: Optimized for fast loading and smooth interactions

### Component Architecture
- **Modular Design**: Each component is self-contained and reusable
- **Design Tokens**: Components use design system variables for consistency
- **BEM Methodology**: Consistent class naming convention across all components
- **Progressive Enhancement**: Base functionality enhanced for modern browsers

## Navigation Components

### Navigation Bar

#### Purpose
Primary navigation component providing site-wide navigation and brand identity.

#### HTML Structure
```html
<nav class="navbar navbar-expand-lg navbar-light bg-white fixed-top" role="navigation" aria-label="Main navigation">
  <div class="container">
    <a class="navbar-brand" href="index.html" aria-label="Westmark Talent Group Home">
      <img src="assets/images/westmark-logo-128x62-1.png" 
           alt="Westmark Talent Group" 
           class="navbar-brand__logo"
           width="128" 
           height="62">
    </a>
    
    <button class="navbar-toggler" 
            type="button" 
            data-bs-toggle="collapse" 
            data-bs-target="#navbarNav" 
            aria-controls="navbarNav" 
            aria-expanded="false" 
            aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ms-auto">
        <li class="nav-item">
          <a class="nav-link" href="index.html">Home</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="clients.html">Clients</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="contact-us.html">Contact</a>
        </li>
      </ul>
    </div>
  </div>
</nav>
```

#### CSS Classes
- `.navbar`: Base navigation container
- `.navbar-brand`: Brand logo and name area
- `.navbar-brand__logo`: Brand logo image
- `.navbar-toggler`: Mobile menu toggle button
- `.navbar-nav`: Navigation menu list
- `.nav-item`: Individual navigation item
- `.nav-link`: Navigation link styling

#### Behavior
- **Fixed Position**: Stays at top during scroll
- **Responsive**: Collapses to hamburger menu on mobile
- **Accessibility**: Proper ARIA labels and keyboard navigation
- **Brand Identity**: Logo always visible for brand recognition

### Dropdown Navigation

#### Purpose
Enhanced navigation with dropdown support for complex menu structures.

#### HTML Structure
```html
<div class="dropdown">
  <button class="btn btn-link dropdown-toggle" 
          type="button" 
          id="servicesDropdown" 
          data-bs-toggle="dropdown" 
          aria-expanded="false">
    Services
  </button>
  <ul class="dropdown-menu" aria-labelledby="servicesDropdown">
    <li><a class="dropdown-item" href="#">Recruitment</a></li>
    <li><a class="dropdown-item" href="#">Talent Acquisition</a></li>
    <li><a class="dropdown-item" href="#">Consulting</a></li>
  </ul>
</div>
```

#### CSS Classes
- `.dropdown`: Dropdown container
- `.dropdown-toggle`: Dropdown trigger button
- `.dropdown-menu`: Dropdown menu list
- `.dropdown-item`: Individual dropdown item

#### Behavior
- **Hover/Focus**: Dropdown opens on hover or focus
- **Keyboard Navigation**: Full keyboard accessibility
- **Mobile Support**: Touch-friendly dropdown interactions
- **Accessibility**: Proper ARIA attributes and screen reader support

## Content Components

### Hero Section

#### Purpose
Full-width landing area with compelling messaging and call-to-action.

#### HTML Structure
```html
<section class="hero" role="banner">
  <div class="hero__background">
    <img src="assets/images/background1.jpg" 
         alt="Construction industry background" 
         class="hero__image"
         loading="eager">
  </div>
  <div class="hero__overlay"></div>
  <div class="container">
    <div class="hero__content">
      <h1 class="hero__title">Building the Future, One Placement at a Time</h1>
      <p class="hero__subtitle">Professional recruitment for construction management professionals and general contractors</p>
      <div class="hero__actions">
        <a href="clients.html" class="btn btn--primary btn--lg">For Employers</a>
        <a href="contact-us.html" class="btn btn--secondary btn--lg">Contact Us</a>
      </div>
    </div>
  </div>
</section>
```

#### CSS Classes
- `.hero`: Hero section container
- `.hero__background`: Background image container
- `.hero__image`: Hero background image
- `.hero__overlay`: Dark overlay for text readability
- `.hero__content`: Hero content wrapper
- `.hero__title`: Main hero heading
- `.hero__subtitle`: Hero description text
- `.hero__actions`: Call-to-action buttons

#### Behavior
- **Full Width**: Extends to container edges
- **Responsive Images**: Optimized for different screen sizes
- **Text Overlay**: Dark overlay ensures text readability
- **Call-to-Action**: Prominent buttons for user engagement

### Content Cards

#### Purpose
Display content in organized, visually appealing card format.

#### HTML Structure
```html
<div class="card">
  <div class="card__image">
    <img src="assets/images/pexels-1948912-3609139-2136x1430.jpg" 
         alt="Construction workers" 
         class="card__img"
         loading="lazy">
  </div>
  <div class="card__content">
    <h3 class="card__title">Project Manager Position</h3>
    <p class="card__description">Leading construction projects with experienced team members in commercial and residential sectors.</p>
    <div class="card__meta">
      <span class="card__location">Denver, CO</span>
      <span class="card__type">Full-time</span>
    </div>
    <div class="card__actions">
      <a href="#" class="btn btn--primary">Apply Now</a>
      <a href="#" class="btn btn--secondary">Learn More</a>
    </div>
  </div>
</div>
```

#### CSS Classes
- `.card`: Base card container
- `.card__image`: Card image container
- `.card__img`: Card image
- `.card__content`: Card content wrapper
- `.card__title`: Card title heading
- `.card__description`: Card description text
- `.card__meta`: Card metadata information
- `.card__actions`: Card action buttons

#### Behavior
- **Hover Effects**: Subtle animations on hover
- **Responsive Images**: Images scale appropriately
- **Consistent Spacing**: Uses design system spacing values
- **Accessible Content**: Proper heading hierarchy and alt text

### Content Grid

#### Purpose
Organize multiple content items in responsive grid layout.

#### HTML Structure
```html
<div class="content-grid">
  <div class="content-grid__item">
    <div class="card">
      <!-- Card content -->
    </div>
  </div>
  <div class="content-grid__item">
    <div class="card">
      <!-- Card content -->
    </div>
  </div>
  <div class="content-grid__item">
    <div class="card">
      <!-- Card content -->
    </div>
  </div>
</div>
```

#### CSS Classes
- `.content-grid`: Grid container
- `.content-grid__item`: Individual grid item

#### Behavior
- **Responsive Layout**: Adapts to different screen sizes
- **Consistent Spacing**: Uses design system spacing values
- **Flexible Items**: Items grow and shrink appropriately
- **Mobile Optimization**: Single column on mobile devices

## Form Components

### Contact Form

#### Purpose
Capture user inquiries and lead information for business development.

#### HTML Structure
```html
<form class="contact-form" action="#" method="POST" novalidate>
  <div class="form-group">
    <label for="name" class="form-label">Full Name *</label>
    <input type="text" 
           id="name" 
           name="name" 
           class="form-control" 
           required 
           aria-describedby="name-error"
           placeholder="Enter your full name">
    <div id="name-error" class="form-error" role="alert"></div>
  </div>
  
  <div class="form-group">
    <label for="email" class="form-label">Email Address *</label>
    <input type="email" 
           id="email" 
           name="email" 
           class="form-control" 
           required 
           aria-describedby="email-error"
           placeholder="Enter your email address">
    <div id="email-error" class="form-error" role="alert"></div>
  </div>
  
  <div class="form-group">
    <label for="phone" class="form-label">Phone Number</label>
    <input type="tel" 
           id="phone" 
           name="phone" 
           class="form-control" 
           aria-describedby="phone-error"
           placeholder="Enter your phone number">
    <div id="phone-error" class="form-error" role="alert"></div>
  </div>
  
  <div class="form-group">
    <label for="message" class="form-label">Message *</label>
    <textarea id="message" 
              name="message" 
              class="form-control" 
              rows="4" 
              required 
              aria-describedby="message-error"
              placeholder="Tell us about your recruitment needs"></textarea>
    <div id="message-error" class="form-error" role="alert"></div>
  </div>
  
  <div class="form-group">
    <button type="submit" class="btn btn--primary btn--lg">
      Send Message
    </button>
  </div>
</form>
```

#### CSS Classes
- `.contact-form`: Form container
- `.form-group`: Form field group
- `.form-label`: Form field label
- `.form-control`: Form input/textarea
- `.form-error`: Form error message
- `.btn`: Button styling

#### Behavior
- **Form Validation**: Client-side and server-side validation
- **Error Handling**: Clear error messages with ARIA attributes
- **Accessibility**: Proper labels and error descriptions
- **Responsive Design**: Mobile-optimized form layout

### Form Validation

#### Purpose
Provide real-time feedback and validation for form inputs.

#### JavaScript Implementation
```javascript
class FormValidator {
  constructor(form) {
    this.form = form;
    this.fields = form.querySelectorAll('.form-control');
    this.init();
  }
  
  init() {
    this.setupEventListeners();
    this.setupFormSubmission();
  }
  
  setupEventListeners() {
    this.fields.forEach(field => {
      field.addEventListener('blur', () => this.validateField(field));
      field.addEventListener('input', () => this.clearError(field));
    });
  }
  
  validateField(field) {
    const errorElement = document.getElementById(field.id + '-error');
    let isValid = true;
    let errorMessage = '';
    
    // Required field validation
    if (field.hasAttribute('required') && !field.value.trim()) {
      isValid = false;
      errorMessage = 'This field is required';
    }
    
    // Email validation
    if (field.type === 'email' && field.value && !this.isValidEmail(field.value)) {
      isValid = false;
      errorMessage = 'Please enter a valid email address';
    }
    
    // Phone validation
    if (field.type === 'tel' && field.value && !this.isValidPhone(field.value)) {
      isValid = false;
      errorMessage = 'Please enter a valid phone number';
    }
    
    if (!isValid) {
      this.showError(field, errorElement, errorMessage);
    } else {
      this.clearError(field);
    }
    
    return isValid;
  }
  
  showError(field, errorElement, message) {
    field.classList.add('form-control--error');
    errorElement.textContent = message;
    errorElement.style.display = 'block';
  }
  
  clearError(field) {
    const errorElement = document.getElementById(field.id + '-error');
    field.classList.remove('form-control--error');
    errorElement.style.display = 'none';
  }
  
  isValidEmail(email) {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
  }
  
  isValidPhone(phone) {
    const phoneRegex = /^[\+]?[1-9][\d]{0,15}$/;
    return phoneRegex.test(phone.replace(/[\s\-\(\)]/g, ''));
  }
  
  validateForm() {
    let isValid = true;
    this.fields.forEach(field => {
      if (!this.validateField(field)) {
        isValid = false;
      }
    });
    return isValid;
  }
  
  setupFormSubmission() {
    this.form.addEventListener('submit', (e) => {
      if (!this.validateForm()) {
        e.preventDefault();
        // Focus first error field
        const firstError = this.form.querySelector('.form-control--error');
        if (firstError) {
          firstError.focus();
        }
      }
    });
  }
}

// Initialize form validation
document.addEventListener('DOMContentLoaded', () => {
  const forms = document.querySelectorAll('.contact-form');
  forms.forEach(form => new FormValidator(form));
});
```

## Interactive Components

### Accordion

#### Purpose
Organize content in collapsible sections for better information hierarchy.

#### HTML Structure
```html
<div class="accordion" role="region" aria-label="Frequently asked questions">
  <div class="accordion__item">
    <button class="accordion__header" 
            aria-expanded="false" 
            aria-controls="faq-1">
      <span class="accordion__title">What services do you offer?</span>
      <span class="accordion__icon" aria-hidden="true"></span>
    </button>
    <div id="faq-1" class="accordion__content" aria-hidden="true">
      <div class="accordion__body">
        <p>We specialize in recruitment for construction management professionals, including project managers, superintendents, estimators, and other key positions in the construction industry.</p>
      </div>
    </div>
  </div>
  
  <div class="accordion__item">
    <button class="accordion__header" 
            aria-expanded="false" 
            aria-controls="faq-2">
      <span class="accordion__title">How do you find qualified candidates?</span>
      <span class="accordion__icon" aria-hidden="true"></span>
    </button>
    <div id="faq-2" class="accordion__content" aria-hidden="true">
      <div class="accordion__body">
        <p>We use a combination of industry networks, professional databases, targeted outreach, and referrals to identify and attract top talent in the construction field.</p>
      </div>
    </div>
  </div>
</div>
```

#### CSS Classes
- `.accordion`: Accordion container
- `.accordion__item`: Individual accordion item
- `.accordion__header`: Accordion header button
- `.accordion__title`: Accordion item title
- `.accordion__icon`: Expand/collapse icon
- `.accordion__content`: Accordion content area
- `.accordion__body`: Accordion content wrapper

#### Behavior
- **Smooth Animations**: CSS transitions for content expansion
- **Accessibility**: Proper ARIA attributes and keyboard navigation
- **Single/Multiple**: Configurable for single or multiple open items
- **Touch Friendly**: Optimized for mobile interactions

### Carousel

#### Purpose
Display multiple content items in a scrollable, interactive format.

#### HTML Structure
```html
<div class="carousel" role="region" aria-label="Job listings">
  <div class="carousel__container">
    <div class="carousel__slide" aria-hidden="false">
      <div class="carousel__content">
        <div class="card">
          <div class="card__image">
            <img src="assets/images/pexels-1948912-3609139-2136x1430.jpg" 
                 alt="Construction workers" 
                 class="card__img">
          </div>
          <div class="card__content">
            <h3 class="card__title">Project Manager</h3>
            <p class="card__description">Leading construction projects with experienced team</p>
            <div class="card__actions">
              <a href="#" class="btn btn--primary">Apply Now</a>
            </div>
          </div>
        </div>
      </div>
    </div>
    
    <div class="carousel__slide" aria-hidden="true">
      <!-- Additional slides -->
    </div>
  </div>
  
  <div class="carousel__controls">
    <button class="carousel__prev" 
            aria-label="Previous slide" 
            aria-controls="carousel">
      <span class="carousel__icon" aria-hidden="true">‹</span>
    </button>
    <button class="carousel__next" 
            aria-label="Next slide" 
            aria-controls="carousel">
      <span class="carousel__icon" aria-hidden="true">›</span>
    </button>
  </div>
  
  <div class="carousel__indicators">
    <button class="carousel__indicator" 
            aria-label="Go to slide 1" 
            aria-current="true"></button>
    <button class="carousel__indicator" 
            aria-label="Go to slide 2" 
            aria-current="false"></button>
  </div>
</div>
```

#### CSS Classes
- `.carousel`: Carousel container
- `.carousel__container`: Carousel slides container
- `.carousel__slide`: Individual carousel slide
- `.carousel__content`: Slide content wrapper
- `.carousel__controls`: Navigation controls
- `.carousel__prev/next`: Previous/next buttons
- `.carousel__indicators`: Slide indicators
- `.carousel__indicator`: Individual indicator

#### Behavior
- **Touch Gestures**: Support for swipe navigation
- **Keyboard Navigation**: Full keyboard accessibility
- **Auto-play**: Configurable auto-advance functionality
- **Responsive**: Adapts to different screen sizes

## Utility Components

### Loading States

#### Purpose
Provide visual feedback during content loading and processing.

#### HTML Structure
```html
<!-- Skeleton Loading -->
<div class="skeleton">
  <div class="skeleton__header">
    <div class="skeleton__title"></div>
    <div class="skeleton__subtitle"></div>
  </div>
  <div class="skeleton__content">
    <div class="skeleton__line"></div>
    <div class="skeleton__line"></div>
    <div class="skeleton__line"></div>
  </div>
</div>

<!-- Loading Spinner -->
<div class="spinner" role="status" aria-label="Loading">
  <div class="spinner__circle"></div>
  <span class="spinner__text">Loading...</span>
</div>
```

#### CSS Classes
- `.skeleton`: Skeleton loading container
- `.skeleton__header`: Skeleton header area
- `.skeleton__title`: Skeleton title placeholder
- `.skeleton__subtitle`: Skeleton subtitle placeholder
- `.skeleton__content`: Skeleton content area
- `.skeleton__line`: Skeleton line placeholder
- `.spinner`: Loading spinner container
- `.spinner__circle`: Spinner animation element
- `.spinner__text`: Loading text

#### Behavior
- **Skeleton Screens**: Show content structure while loading
- **Loading Indicators**: Clear feedback for user actions
- **Accessibility**: Screen reader support for loading states
- **Performance**: Lightweight animations for smooth experience

### Toast Notifications

#### Purpose
Display temporary feedback messages to users.

#### HTML Structure
```html
<div class="toast" role="alert" aria-live="polite" aria-atomic="true">
  <div class="toast__header">
    <span class="toast__title">Success</span>
    <button class="toast__close" 
            aria-label="Close notification" 
            type="button">
      <span class="toast__icon" aria-hidden="true">×</span>
    </button>
  </div>
  <div class="toast__body">
    Your message has been sent successfully.
  </div>
</div>
```

#### CSS Classes
- `.toast`: Toast notification container
- `.toast__header`: Toast header area
- `.toast__title`: Toast title text
- `.toast__close`: Close button
- `.toast__icon`: Close icon
- `.toast__body`: Toast message content

#### Behavior
- **Auto-dismiss**: Configurable auto-hide functionality
- **Manual Close**: User can manually close notifications
- **Accessibility**: Screen reader support and ARIA attributes
- **Positioning**: Configurable positioning on screen

## Component Implementation Guidelines

### CSS Implementation

#### Design Token Usage
```css
/* Use design system tokens for consistency */
.component {
  color: var(--color-text-primary);
  background: var(--color-surface);
  padding: var(--spacing-4);
  border-radius: var(--border-radius-base);
  box-shadow: var(--shadow-base);
  font-size: var(--font-size-base);
  line-height: var(--line-height-normal);
}

/* Component variants */
.component--primary {
  background: var(--color-primary);
  color: var(--color-text-inverse);
}

.component--large {
  padding: var(--spacing-6);
  font-size: var(--font-size-lg);
}
```

#### Responsive Implementation
```css
/* Mobile-first approach */
.component {
  padding: var(--spacing-4);
  font-size: var(--font-size-base);
}

/* Tablet enhancements */
@media (min-width: 768px) {
  .component {
    padding: var(--spacing-6);
    font-size: var(--font-size-lg);
  }
}

/* Desktop enhancements */
@media (min-width: 992px) {
  .component {
    padding: var(--spacing-8);
    font-size: var(--font-size-xl);
  }
}
```

### JavaScript Implementation

#### Component Class Structure
```javascript
class Component {
  constructor(element, options = {}) {
    this.element = element;
    this.options = { ...this.defaultOptions, ...options };
    this.init();
  }
  
  get defaultOptions() {
    return {
      // Default component options
    };
  }
  
  init() {
    this.setupEventListeners();
    this.setupAccessibility();
  }
  
  setupEventListeners() {
    // Component-specific event handling
  }
  
  setupAccessibility() {
    // Accessibility enhancements
  }
  
  destroy() {
    // Cleanup when component is removed
  }
}

// Component initialization
document.addEventListener('DOMContentLoaded', () => {
  const components = document.querySelectorAll('.component');
  components.forEach(element => new Component(element));
});
```

### Accessibility Implementation

#### ARIA Attributes
```html
<!-- Proper ARIA implementation -->
<button class="component" 
        aria-expanded="false" 
        aria-controls="content" 
        aria-label="Toggle content">
  Toggle
</button>
<div id="content" 
     class="component__content" 
     aria-hidden="true">
  Content here
</div>
```

#### Keyboard Navigation
```javascript
// Keyboard navigation support
setupKeyboardNavigation() {
  this.element.addEventListener('keydown', (e) => {
    switch (e.key) {
      case 'Enter':
      case ' ':
        e.preventDefault();
        this.toggle();
        break;
      case 'Escape':
        this.close();
        break;
    }
  });
}
```

## Component Testing

### Visual Testing
- **Cross-browser**: Test in all supported browsers
- **Responsive**: Verify behavior across all breakpoints
- **Accessibility**: Test with screen readers and keyboard navigation
- **Performance**: Measure component rendering performance

### Functional Testing
- **User Interactions**: Test all user interactions and states
- **Error Handling**: Verify error states and edge cases
- **Integration**: Test component integration with other components
- **Accessibility**: Validate ARIA attributes and keyboard support

---

*This component library provides comprehensive specifications for all UI components used in the Westmark Talent Group website. All components should follow these specifications to ensure consistency and maintainability across the project.*
