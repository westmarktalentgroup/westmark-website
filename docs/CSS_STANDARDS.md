# CSS Standards - Westmark Talent Group

## Overview
This document consolidates CSS architecture, quality standards, and implementation guidelines for the Westmark Talent Group website. It replaces the previous separate CSS documentation files with a comprehensive, unified standard.

## 🎯 Core Principles

### Architecture Principles
- **No !important declarations** (except for legitimate accessibility and print styles)
- **CSS Custom Properties** for consistent design tokens
- **Mobile-first responsive design** with progressive enhancement
- **Proper CSS specificity** instead of override hacks
- **Component-based architecture** with clear separation of concerns
- **Performance optimization** with efficient selectors and animations

### Quality Standards
- **Custom CSS files**: 0 `!important` declarations allowed
- **Framework override file** (`override.css`): ≤8 `!important` declarations allowed
- **Total project limit**: ≤10 `!important` declarations maximum
- **Design token usage** throughout all components
- **WCAG 2.1 AA compliance** built into all components

## 📁 File Structure

### CSS Files
```
assets/
├── css/
│   └── optimized.css                  # Consolidated stylesheet with all design tokens and components
└── css/
    ├── typography.css               # Typography system and font management
    ├── spacing.css                  # Spacing utilities and layout helpers
    ├── mobile-responsive.css        # Mobile-first responsive styles
    └── mobile-text-fixes.css        # Legacy mobile text fixes
```

### File Responsibilities

#### `style.css` - Main Stylesheet
- **Design Tokens**: CSS custom properties for colors, typography, spacing
- **Base Styles**: Reset, typography, layout foundations
- **Component Base**: Button system, form controls, carousel components
- **Accessibility**: Screen reader styles, focus management, reduced motion
- **Print Styles**: Optimized print layouts

#### `override.css` - Component Styles
- **Button Variants**: All button styles with proper specificity
- **Form Components**: Input styling, validation states
- **Display Classes**: Typography display utilities
- **Background Utilities**: Color background classes
- **Legacy Compatibility**: Maintains existing class names
- **Framework Overrides**: Only justified `!important` declarations

#### `typography.css` - Typography System
- **Font Families**: CSS custom properties for consistent typography
- **Font Sizes**: Responsive typography with `clamp()` functions
- **Line Heights**: Consistent spacing and readability
- **Font Weights**: Proper weight hierarchy
- **Responsive Typography**: Mobile-first font scaling

#### `spacing.css` - Spacing System
- **Spacing Scale**: Consistent spacing values using CSS custom properties
- **Layout Utilities**: Margin and padding utilities
- **Grid System**: CSS Grid and Flexbox utilities
- **Responsive Spacing**: Mobile-first spacing adjustments

## 🎨 Design Token System

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
  
  /* Process Number Colors */
  --process-number-color: var(--color-primary); /* Black for consistency */
  
  /* Border Radius Patterns */
  --border-radius-cta: 50px; /* 50px border-radius pattern for CTA buttons */
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
  --font-family-heading: 'Playfair Display', serif;
  --font-family-body: 'Manrope', sans-serif;
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

## 🚨 !important Prevention Policy

### Zero Tolerance for Band-aid Solutions
We maintain **ZERO** unnecessary `!important` declarations in our custom CSS files to prevent technical debt and maintain clean, maintainable code.

### Maximum !important Usage Limits
- **Custom CSS files**: `0 !important` declarations allowed
- **Framework override file** (`override.css`): `≤8 !important` declarations allowed
- **Total project limit**: `≤10 !important` declarations maximum

### Allowed !important Usage (Framework Overrides Only)
Only these specific cases are justified in `override.css`:

```css
/* ✅ JUSTIFIED: Framework positioning overrides */
.hero-section .container-fluid {
  align-items: flex-end !important;     /* Override framework centering */
  justify-content: flex-start !important; /* Override framework centering */
  padding: 2rem !important;             /* Override framework spacing */
}

/* ✅ JUSTIFIED: Text control overrides */
.hero-section .section-title {
  white-space: nowrap !important;       /* Prevent title line breaks */
  overflow: visible !important;         /* Override default overflow */
  text-overflow: unset !important;      /* Override default ellipsis */
}

/* ✅ JUSTIFIED: Typography overrides */
.hero-section .display-1 {
  font-size: 3.5rem !important;         /* Override framework default */
  line-height: 1.1 !important;          /* Override framework default */
}
```

### Prohibited !important Usage
Never use `!important` for basic styling, layout properties, or responsive typography. Use specific selectors, CSS cascade order, and CSS custom properties instead.

## 🧩 Component Architecture

### Section Header System
```css
/* Section Header Hierarchy - Standard Patterns */

/* 1. Main Section Headers */
.section-title {
  font-family: var(--font-family-body); /* Manrope */
  font-size: clamp(2.8rem, 4.8vw, 4.8rem); /* 80% of hero text */
  font-weight: var(--font-weight-bold);
  color: var(--color-primary);
  text-align: center;
  margin-bottom: var(--spacing-4);
}

/* 2. Card/Content Headers */
.card-title {
  font-family: var(--font-family-body); /* Manrope */
  font-size: clamp(2.8rem, 4.8vw, 4.8rem); /* Same as section-title */
  font-weight: var(--font-weight-bold);
  color: var(--color-primary);
  margin-bottom: var(--spacing-4);
}

/* 3. Call-to-Action Headers */
.cta-title {
  font-family: var(--font-family-body); /* Manrope */
  font-size: clamp(2.8rem, 4.8vw, 4.8rem); /* Same as section-title */
  font-weight: var(--font-weight-bold);
  color: var(--color-primary);
  margin-bottom: var(--spacing-4);
}
```

### Section Header Usage Patterns
```html
<!-- 1. Main Section Headers (centered, full-width sections) -->
<section class="opportunities-section">
  <div class="container">
    <div class="section-head">
      <h4 class="section-title text-center display-2">
        <strong>Current Opportunities</strong>
      </h4>
    </div>
  </div>
</section>

<!-- 2. Card/Content Headers (within cards, left-aligned) -->
<div class="card">
  <div class="card-content-text">
    <h3 class="card-title display-2">
      <strong>Our Mission</strong>
    </h3>
  </div>
</div>

<!-- 3. Call-to-Action Headers (CTA sections, left-aligned) -->
<section class="cta-section">
  <div class="container">
    <h1 class="section-title display-2 mb-4">
      <strong>Connecting Construction Management Professionals</strong>
    </h1>
  </div>
</section>
```

### Button System
```css
/* Base Button */
.btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  padding: var(--spacing-3) var(--spacing-6);
  font-family: var(--font-family-body);
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
  font-family: var(--font-family-body);
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

### Typography Hierarchy
```css
/* Typography Hierarchy - Using CSS Custom Properties */
.display-1 {
  font-size: clamp(2.5rem, 5vw, 5rem);
  line-height: 1.1;
  margin-bottom: 1rem;
  font-family: var(--font-family-heading); /* Playfair Display */
  font-weight: var(--font-weight-bold);
}

.display-2 {
  font-size: clamp(2rem, 4vw, 4rem);
  line-height: 1.2;
  margin-bottom: 1rem;
  font-family: var(--font-family-body); /* Manrope */
  font-weight: var(--font-weight-bold);
}

.display-5 {
  font-size: clamp(1.25rem, 2.5vw, 2rem);
  line-height: 1.3;
  margin-bottom: 0.75rem;
  font-family: var(--font-family-body); /* Manrope */
  font-weight: var(--font-weight-semibold);
}

.display-7 {
  font-size: clamp(1rem, 1.5vw, 1.4rem);
  line-height: 1.5;
  margin-bottom: 1rem;
  font-family: var(--font-family-body); /* Manrope */
  font-weight: var(--font-weight-normal);
}
```

## 📱 Responsive Design

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

## ♿ Accessibility Implementation

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

## 🎨 Design System Standards

### Latest Opportunities Images
- **Aspect Ratio**: 1:1 (square) - as specified in design documentation
- **Minimum Resolution**: 400px × 400px
- **CSS Implementation**: Uses `padding-bottom: 100%` technique
- **Responsive**: Scales with container width while maintaining square shape

```css
/* Latest Opportunities - Square Image Sizing */
.item-img img {
  width: 100%;
  height: 0;
  padding-bottom: 100%; /* Creates 1:1 aspect ratio (square) */
  object-fit: cover;
  object-position: center;
  border-radius: 0.5rem;
}
```

## ⚡ Performance Optimizations

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

## 📋 Best Practices

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

## 🔒 Automated Prevention

### Pre-commit Validation
The protection system automatically:
- ✅ Counts total `!important` declarations
- ✅ Blocks commits with excessive usage (>10 total)
- ✅ Detects anti-patterns in custom CSS files
- ✅ Validates CSS quality standards

### Quality Gates
- **Development**: Protection system validates on every commit
- **Production**: Deployment blocked if standards violated
- **Monitoring**: Continuous validation of CSS quality

## 📊 Current Status

- **Custom CSS files**: 0 `!important` declarations ✅
- **Framework overrides**: 8 `!important` declarations ✅
- **Total project**: 8 `!important` declarations ✅
- **Quality standard**: COMPLIANT ✅

## 📱 Mobile Navigation Standards

### Responsive Navigation Behavior
- **Mobile (< 992px)**: Navigation hidden by default, hamburger menu visible
- **Desktop (≥ 992px)**: Navigation always visible, hamburger hidden
- **Toggle Mechanism**: JavaScript controls `.navbar-collapse.show` class
- **Display States**: 
  - Mobile: `display: none` (default), `display: flex` (when `.show` active)
  - Desktop: `display: flex` (always visible)

### Hamburger Menu Implementation
- **Custom JavaScript**: Uses custom toggle mechanism (not Bootstrap)
- **HTML Structure**: Should use `class="navbar-collapse"` only
- **Bootstrap Conflict**: Avoid `class="collapse navbar-collapse"` as it conflicts with Bootstrap CSS
- **Toggle Class**: JavaScript adds/removes `.show` class for visibility control
- **Animation**: Smooth slide-down animation with opacity transition
- **Hamburger Transform**: 4-line hamburger transforms to X with rotation animations
- **Z-Index Management**: Proper layering (navbar-toggler: 1001, navbar-collapse: 1000)

### Mobile Menu Layout
- **Vertical Stack**: Navigation items stack vertically on mobile
- **Full Width**: Links take full width of container
- **Proper Spacing**: Consistent padding and gaps
- **Touch Friendly**: Minimum 44px touch targets
- **Positioning**: Absolute positioning below soap bar with backdrop blur
- **Accessibility**: Proper ARIA attributes and keyboard navigation support

## 📱 Mobile Hero Section Standards

### Responsive Behavior
- **Desktop**: Full viewport height (100vh) with text positioned at bottom
- **Mobile**: Reduced height (80vh) with text positioned at bottom

### Mobile Positioning
- Uses `align-items: flex-end` to position hero text at bottom of image
- Maintains proper spacing with `padding: var(--spacing-4)`
- Ensures text is readable over hero background with overlay

### CSS Implementation
```css
@media (max-width: 768px) {
  .hero-section {
    min-height: 80vh;
  }
  
  .hero-section .container-fluid {
    height: 80vh;
    padding: var(--spacing-4);
    align-items: flex-end;
  }
}
```

## 🎨 Logo Page Standards

### High-Quality Logo Display
- **Vector Format**: Uses SVG for scalable, high-quality logo display
- **Professional Styling**: Clean background with subtle shadow and padding
- **Responsive Design**: Logo scales appropriately on all devices
- **Download Options**: Multiple format downloads (SVG, PNG, WebP)

### Logo Page Styling
- **Background**: Light gray (`#f8f9fa`) for professional appearance
- **Logo Container**: White background with shadow and rounded corners
- **Typography**: Uses Manrope font family for consistency
- **Download Buttons**: Black background with red hover state

### CSS Implementation
```css
.logo {
  display: block;
  margin: 0 auto;
  max-width: 100%;
  height: auto;
  box-shadow: 0 4px 20px rgba(0,0,0,0.1);
  border-radius: 8px;
  background: white;
  padding: 20px;
}

.download-links a {
  padding: 10px 20px;
  background: #000;
  color: white;
  text-decoration: none;
  border-radius: 5px;
  font-weight: 500;
  transition: background 0.3s;
}

.download-links a:hover {
  background: #ae301c;
}
```

## 🎨 Form Control Standards

### Select Dropdown Styling
- **Custom Arrows**: Black SVG arrows using data URI
- **Browser Compatibility**: Remove default arrows with `appearance: none`
- **Arrow Color**: `#000000` (black) for consistency
- **Positioning**: Right-aligned with proper padding

```css
/* Custom select dropdown styling */
select.form-control {
  background-image: url("data:image/svg+xml;charset=utf8,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 4 5'%3E%3Cpath fill='%23000000' d='M2 0L0 2h4zm0 5L0 3h4z'/%3E%3C/svg%3E");
  background-repeat: no-repeat;
  background-position: right 0.75rem center;
  background-size: 8px 10px;
  padding-right: 2.5rem;
  -webkit-appearance: none;
  -moz-appearance: none;
  appearance: none;
}
```

## 🚫 Horizontal Scroll Prevention

### Global Overflow Control
- **Body Level**: `overflow-x: hidden` prevents horizontal scrolling
- **Container Constraints**: All containers respect viewport boundaries
- **Flex Wrapping**: `flex-wrap: wrap` instead of `nowrap` on mobile
- **Text Wrapping**: Removed `white-space: nowrap` from hero elements

### Mobile Responsiveness
- **Typography**: Responsive font sizes with `clamp()` functions
- **Layout**: Proper column stacking on mobile devices
- **Spacing**: Consistent padding and margins across screen sizes

## 🔐 Touch ID Security Standards

### Authentication Script Standards
- **Quiet Mode**: Support for `--quiet` flag for automated deployments
- **Error Handling**: Proper exit codes and error messages
- **Token Validation**: Real-time GitHub API verification
- **Environment Detection**: Cursor-specific environment validation
- **Keychain Integration**: Secure credential storage with Touch ID

### Deployment Security
- **Biometric Requirement**: Touch ID authentication for all deployments
- **Token Management**: Secure storage in macOS Keychain
- **API Verification**: GitHub token validation before deployment
- **Audit Logging**: Complete deployment history tracking

## 🛠️ Maintenance Guidelines

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

## 📋 Developer Checklist

Before adding any CSS:

- [ ] **Can I use a more specific selector?**
- [ ] **Is this a framework override that justifies !important?**
- [ ] **Have I tried using CSS cascade order?**
- [ ] **Can I use CSS custom properties instead?**
- [ ] **Is this responsive typography that should use clamp()?**
- [ ] **Will this create technical debt?**

---

*This CSS standards document serves as the comprehensive guide for maintaining clean, performant, and accessible styles for the Westmark Talent Group website. All future CSS development should follow these principles and patterns.*
