# CSS Architecture Documentation

## Westmark Talent Group Website

### Overview

This document outlines the clean CSS architecture implemented for the Westmark Talent Group website, replacing band-aid fixes with proper CSS specificity and design system principles.

## Architecture Principles

### Core Principles
- **No !important declarations** (except for legitimate accessibility and print styles)
- **CSS Custom Properties** for consistent design tokens
- **Mobile-first responsive design** with progressive enhancement
- **Proper CSS specificity** instead of override hacks
- **Component-based architecture** with clear separation of concerns
- **Performance optimization** with efficient selectors and animations

### Design System Integration
- **Design Tokens**: All colors, spacing, typography, and other design values use CSS custom properties
- **Consistent Naming**: BEM methodology for component classes
- **Responsive Design**: Mobile-first approach with clean breakpoint management
- **Accessibility**: WCAG 2.1 AA compliance built into all components

## File Structure

### CSS Files
```
assets/
├── theme/css/
│   └── style.css                    # Main stylesheet with design tokens and base styles
├── mobirise/css/
│   └── mbr-additional.css          # Component-specific styles (buttons, forms, etc.)
└── css/
    ├── mobile-responsive.css        # Mobile-first responsive styles
    └── mobile-text-fixes.css       # Legacy mobile text fixes
```

### File Responsibilities

#### `style.css` - Main Stylesheet
- **Design Tokens**: CSS custom properties for colors, typography, spacing
- **Base Styles**: Reset, typography, layout foundations
- **Component Base**: Button system, form controls, carousel components
- **Accessibility**: Screen reader styles, focus management, reduced motion
- **Print Styles**: Optimized print layouts

#### `mbr-additional.css` - Component Styles
- **Button Variants**: All button styles with proper specificity
- **Form Components**: Input styling, validation states
- **Display Classes**: Typography display utilities
- **Background Utilities**: Color background classes
- **Legacy Compatibility**: Maintains existing class names

#### `mobile-responsive.css` - Responsive Design
- **Breakpoint Management**: Mobile-first responsive design
- **Touch Optimization**: Touch-friendly sizing and interactions
- **Performance**: Optimized animations and images for mobile
- **Accessibility**: Mobile-specific accessibility enhancements

## Design Token System

### Color System
```css
:root {
  /* Primary Colors */
  --color-primary: #000000;
  --color-secondary: #FFFFFF;
  --color-accent: #007BFF;
  --color-surface: #F8F9FA;
  --color-border: #DEE2E6;
  
  /* Text Colors */
  --color-text-primary: #232323;
  --color-text-secondary: #6C757D;
  --color-text-muted: #ADB5BD;
  --color-text-inverse: #FFFFFF;
  
  /* Brand Colors */
  --color-brand-primary: #edefea;
  --color-brand-secondary: #464845;
}
```

### Typography System
```css
:root {
  /* Font Families */
  --font-family-primary: 'Playfair Display', serif;
  --font-family-secondary: 'Manrope', sans-serif;
  --font-family-fallback: system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
  
  /* Font Sizes */
  --font-size-xs: 0.75rem;
  --font-size-sm: 0.875rem;
  --font-size-base: 1rem;
  --font-size-lg: 1.125rem;
  --font-size-xl: 1.25rem;
  --font-size-2xl: 1.5rem;
  --font-size-3xl: 1.875rem;
  --font-size-4xl: 2.25rem;
  --font-size-5xl: 3rem;
  
  /* Line Heights */
  --line-height-tight: 1.2;
  --line-height-normal: 1.4;
  --line-height-relaxed: 1.6;
  --line-height-loose: 1.8;
}
```

### Spacing System
```css
:root {
  /* Spacing Scale */
  --spacing-1: 0.25rem;    /* 4px */
  --spacing-2: 0.5rem;     /* 8px */
  --spacing-3: 0.75rem;    /* 12px */
  --spacing-4: 1rem;       /* 16px */
  --spacing-5: 1.25rem;    /* 20px */
  --spacing-6: 1.5rem;     /* 24px */
  --spacing-8: 2rem;       /* 32px */
  --spacing-10: 2.5rem;    /* 40px */
  --spacing-12: 3rem;      /* 48px */
  --spacing-16: 4rem;      /* 64px */
  --spacing-20: 5rem;      /* 80px */
}
```

## Component Architecture

### Button System
```css
/* Base Button */
.btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  padding: var(--spacing-3) var(--spacing-6);
  font-family: var(--font-family-secondary);
  font-size: var(--font-size-base);
  font-weight: 600;
  line-height: var(--line-height-normal);
  border: 2px solid transparent;
  border-radius: var(--border-radius-base);
  cursor: pointer;
  transition: all var(--transition-base);
  min-height: 44px; /* Touch-friendly */
}

/* Button Variants - Using proper specificity */
.btn-primary {
  background-color: var(--color-secondary);
  border-color: var(--color-secondary);
  color: var(--color-text-secondary);
}

.btn-primary:hover,
.btn-primary:focus {
  background-color: var(--color-surface);
  border-color: var(--color-surface);
  color: var(--color-text-primary);
}
```

### Form Components
```css
.form-control {
  display: block;
  width: 100%;
  padding: var(--spacing-3) var(--spacing-4);
  font-family: var(--font-family-secondary);
  font-size: var(--font-size-base);
  line-height: var(--line-height-normal);
  color: var(--color-text-primary);
  background-color: var(--color-secondary);
  border: 1px solid var(--color-border);
  border-radius: var(--border-radius-base);
  transition: border-color var(--transition-base), box-shadow var(--transition-base);
  min-height: 48px; /* Touch-friendly */
}

.form-control:focus {
  border-color: var(--color-accent);
  outline: 0;
  box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.1);
}
```

## Responsive Design

### Mobile-First Approach
```css
/* Base styles (mobile) */
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

### Breakpoint System
```css
/* Mobile-First Breakpoints */
--breakpoint-sm: 576px;    /* Small devices */
--breakpoint-md: 768px;    /* Medium devices */
--breakpoint-lg: 992px;   /* Large devices */
--breakpoint-xl: 1200px;  /* Extra large devices */
--breakpoint-xxl: 1400px; /* Extra extra large devices */
```

## Accessibility Implementation

### Focus Management
```css
.btn:focus,
.form-control:focus,
.nav-link:focus {
  outline: 2px solid var(--color-accent);
  outline-offset: 2px;
}
```

### Screen Reader Support
```css
.sr-only {
  position: absolute;
  width: 1px;
  height: 1px;
  padding: 0;
  margin: -1px;
  overflow: hidden;
  clip: rect(0, 0, 0, 0);
  white-space: nowrap;
  border: 0;
}
```

### Reduced Motion Support
```css
@media (prefers-reduced-motion: reduce) {
  *,
  *::before,
  *::after {
    animation-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
    transition-duration: 0.01ms !important;
  }
}
```

## Performance Optimizations

### Efficient Selectors
- **Avoid deep nesting**: Maximum 3 levels of nesting
- **Use specific selectors**: Target elements directly when possible
- **Minimize universal selectors**: Use specific element selectors
- **Optimize animations**: Use `transform` and `opacity` for smooth animations

### Animation Performance
```css
/* Optimize animations for performance */
.embla__button,
.carousel-control,
.carousel .close,
.modalWindow .close,
.carousel-indicators li {
  will-change: opacity;
}

.btn,
.form-control {
  will-change: transform;
}
```

## Migration from Legacy Styles

### Removed Band-aid Fixes

#### Phone Link Visibility Crisis (FIXED)
**Before (Band-aid):**
```css
.phone-link {
  display: inline-block !important;
  visibility: visible !important;
  opacity: 1 !important;
  /* ... 50+ more !important declarations */
}
```

**After (Clean):**
```css
.phone-link {
  color: inherit;
  text-decoration: none;
  display: inline-block;
  transition: color var(--transition-fast);
}

.phone-link:hover,
.phone-link:focus {
  color: var(--color-accent);
  text-decoration: none;
}
```

#### Button Styling Overrides (FIXED)
**Before (Band-aid):**
```css
.btn-primary {
  background-color: #ffffff !important;
  border-color: #ffffff !important;
  color: #808080 !important;
}
```

**After (Clean):**
```css
.btn-primary {
  background-color: var(--color-secondary);
  border-color: var(--color-secondary);
  color: var(--color-text-secondary);
}

.btn-primary:hover,
.btn-primary:focus {
  background-color: var(--color-surface);
  border-color: var(--color-surface);
  color: var(--color-text-primary);
}
```

#### Responsive Layout Issues (FIXED)
**Before (Band-aid):**
```css
@media (max-width: 991px) {
  .media-size-item {
    width: auto !important;
  }
  .mbr-figure {
    width: 100% !important;
  }
}
```

**After (Clean):**
```css
@media (max-width: 991px) {
  .media-size-item {
    width: auto;
  }
  
  .mbr-figure {
    width: 100%;
  }
}
```

## Best Practices

### CSS Writing Guidelines
1. **Use CSS Custom Properties**: All design values should use design tokens
2. **Mobile-First**: Write base styles for mobile, enhance for larger screens
3. **Proper Specificity**: Use appropriate selectors instead of `!important`
4. **Component-Based**: Organize styles by component, not by page
5. **Performance**: Optimize selectors and animations for performance

### Class Naming Convention
```css
/* BEM Methodology */
.component { /* Base component */ }
.component--variant { /* Component variant */ }
.component__element { /* Component element */ }
.component__element--modifier { /* Element modifier */ }
```

### Code Organization
```css
/* 1. Design Tokens */
:root { /* CSS Custom Properties */ }

/* 2. Base Styles */
*, *::before, *::after { /* Reset */ }
body { /* Base typography */ }

/* 3. Layout Components */
.container { /* Layout utilities */ }

/* 4. UI Components */
.btn { /* Button system */ }
.form-control { /* Form components */ }

/* 5. Responsive Design */
@media (min-width: 768px) { /* Tablet styles */ }

/* 6. Accessibility */
.sr-only { /* Screen reader styles */ }

/* 7. Print Styles */
@media print { /* Print optimizations */ }
```

## Testing and Validation

### CSS Validation
- **No !important declarations** (except accessibility and print)
- **Proper CSS specificity** hierarchy
- **Design token usage** throughout
- **Mobile-first responsive** design
- **Accessibility compliance** (WCAG 2.1 AA)

### Browser Testing
- **Modern Browsers**: Chrome 90+, Firefox 88+, Safari 14+, Edge 90+
- **Mobile Devices**: iOS Safari, Chrome Mobile, Samsung Internet
- **Accessibility**: Screen readers, keyboard navigation, high contrast mode

### Performance Testing
- **Core Web Vitals**: LCP, FID, CLS optimization
- **CSS Performance**: Efficient selectors and animations
- **Mobile Performance**: Touch optimization and battery efficiency

## Maintenance Guidelines

### Adding New Components
1. **Use Design Tokens**: Reference CSS custom properties
2. **Follow BEM**: Use consistent naming convention
3. **Mobile-First**: Start with mobile styles, enhance for larger screens
4. **Test Accessibility**: Ensure WCAG 2.1 AA compliance
5. **Document Usage**: Add component documentation

### Updating Design Tokens
1. **Update CSS Custom Properties**: Modify values in `:root`
2. **Test All Components**: Ensure changes propagate correctly
3. **Update Documentation**: Reflect changes in design system docs
4. **Validate Accessibility**: Check contrast ratios and usability

### Performance Monitoring
1. **Regular Audits**: Check for CSS performance issues
2. **Bundle Analysis**: Monitor CSS file sizes
3. **Core Web Vitals**: Track performance metrics
4. **User Testing**: Validate mobile and accessibility experience

---

*This CSS architecture documentation serves as the guide for maintaining clean, performant, and accessible styles for the Westmark Talent Group website. All future CSS development should follow these principles and patterns.*
