# Design System Documentation

## Westmark Talent Group Website

### Overview

This document defines the complete design system for the Westmark Talent Group website, including design tokens, color palette, typography, spacing, and visual standards. This system ensures consistency across all pages and components while maintaining the professional construction industry aesthetic.

## Design Philosophy

### Mobile-First Approach
- **Touch-First**: All design elements optimized for touch interaction
- **Performance**: Design optimized for mobile performance and battery life
- **Accessibility**: Mobile-specific accessibility considerations
- **Progressive Enhancement**: Base mobile experience enhanced for larger screens

### Core Design Principles
- **Consistency**: Unified visual language across all components
- **Accessibility**: WCAG 2.1 AA compliance for inclusive design
- **Performance**: Optimized for fast loading and smooth interactions
- **Brand Alignment**: Professional construction industry aesthetic

## Color System

### Primary Color Palette
```css
/* Primary Colors */
--color-primary: #000000;             /* Primary brand color */
--color-secondary: #FFFFFF;           /* Secondary brand color */
--color-accent: #007BFF;             /* Accent color for CTAs */
--color-surface: #F8F9FA;            /* Surface/background color */
--color-border: #DEE2E6;             /* Border color */
```

### Text Color System
```css
/* Text Colors */
--color-text-primary: #000000;       /* Primary text color */
--color-text-secondary: #6C757D;     /* Secondary text color */
--color-text-muted: #ADB5BD;         /* Muted text color */
--color-text-inverse: #FFFFFF;       /* Text on dark backgrounds */
```

### Semantic Color System
```css
/* Semantic Colors */
--color-success: #28A745;            /* Success states */
--color-error: #DC3545;              /* Error states */
--color-warning: #FFC107;            /* Warning states */
--color-info: #17A2B8;               /* Information states */
```

### Color Usage Guidelines
- **Primary Colors**: Used for main actions, branding, and key elements
- **Surface Colors**: Used for backgrounds, cards, and content areas
- **Text Colors**: High contrast for readability across all devices
- **Semantic Colors**: Consistent feedback colors for user actions

## Typography System

### Font Families
```css
/* Font Stack */
--font-family-primary: 'Playfair Display', serif;    /* Headings */
--font-family-secondary: 'Manrope', sans-serif;      /* Body text */
--font-family-fallback: system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
```

### Typography Scale (Mobile-First)
```css
/* Base Typography Scale */
--font-size-xs: 0.75rem;            /* 12px - Small labels, captions */
--font-size-sm: 0.875rem;           /* 14px - Small body text */
--font-size-base: 1rem;             /* 16px - Base body text (prevents zoom) */
--font-size-lg: 1.125rem;           /* 18px - Large body text */
--font-size-xl: 1.25rem;            /* 20px - Small headings */
--font-size-2xl: 1.5rem;            /* 24px - Section headings */
--font-size-3xl: 1.875rem;          /* 30px - Page headings */
--font-size-4xl: 2.25rem;           /* 36px - Hero headings */
--font-size-5xl: 3rem;              /* 48px - Large hero text */

/* Responsive Typography Enhancements */
@media (min-width: 768px) {
  --font-size-2xl: 1.75rem;         /* 28px - Enhanced section headings */
  --font-size-3xl: 2.25rem;         /* 36px - Enhanced page headings */
  --font-size-4xl: 2.75rem;         /* 44px - Enhanced hero headings */
  --font-size-5xl: 3.5rem;          /* 56px - Enhanced large hero text */
}

@media (min-width: 992px) {
  --font-size-2xl: 2rem;            /* 32px - Desktop section headings */
  --font-size-3xl: 2.5rem;          /* 40px - Desktop page headings */
  --font-size-4xl: 3rem;            /* 48px - Desktop hero headings */
  --font-size-5xl: 4rem;            /* 64px - Desktop large hero text */
}
```

### Line Heights
```css
/* Line Height Scale */
--line-height-tight: 1.2;           /* Tight spacing for headings */
--line-height-normal: 1.4;           /* Normal spacing for body text */
--line-height-relaxed: 1.6;          /* Relaxed spacing for readability */
--line-height-loose: 1.8;            /* Loose spacing for hero text */
```

### Typography Usage
- **Hero Text**: 3xl-5xl sizes with tight line height
- **Page Headings**: 2xl-3xl sizes with normal line height
- **Section Headings**: xl-2xl sizes with normal line height
- **Body Text**: base-lg sizes with relaxed line height
- **UI Elements**: sm-base sizes with normal line height

## Spacing System

### Base Spacing Scale (Mobile-First)
```css
/* Core Spacing Scale */
--spacing-1: 0.25rem;               /* 4px - Minimal spacing */
--spacing-2: 0.5rem;                /* 8px - Small spacing */
--spacing-3: 0.75rem;               /* 12px - Medium spacing */
--spacing-4: 1rem;                  /* 16px - Base spacing */
--spacing-5: 1.25rem;               /* 20px - Large spacing */
--spacing-6: 1.5rem;                /* 24px - Extra large spacing */
--spacing-8: 2rem;                  /* 32px - Section spacing */
--spacing-10: 2.5rem;               /* 40px - Large section spacing */
--spacing-12: 3rem;                 /* 48px - Extra large section spacing */
--spacing-16: 4rem;                 /* 64px - Hero section spacing */
--spacing-20: 5rem;                 /* 80px - Page section spacing */
```

### Responsive Spacing Enhancements
```css
/* Tablet Spacing Enhancements */
@media (min-width: 768px) {
  --spacing-8: 2.5rem;              /* 40px - Enhanced section spacing */
  --spacing-10: 3rem;               /* 48px - Enhanced large spacing */
  --spacing-12: 3.5rem;             /* 56px - Enhanced extra large spacing */
  --spacing-16: 5rem;               /* 80px - Enhanced hero spacing */
  --spacing-20: 6rem;               /* 96px - Enhanced page spacing */
}

/* Desktop Spacing Enhancements */
@media (min-width: 992px) {
  --spacing-8: 3rem;                /* 48px - Desktop section spacing */
  --spacing-10: 4rem;               /* 64px - Desktop large spacing */
  --spacing-12: 4.5rem;             /* 72px - Desktop extra large spacing */
  --spacing-16: 6rem;               /* 96px - Desktop hero spacing */
  --spacing-20: 8rem;               /* 128px - Desktop page spacing */
}
```

### Spacing Usage Guidelines
- **Component Spacing**: Use spacing-2 to spacing-6 for component internal spacing
- **Section Spacing**: Use spacing-8 to spacing-12 for section separation
- **Page Spacing**: Use spacing-16 to spacing-20 for major page sections
- **Responsive Adjustments**: Scale spacing proportionally across breakpoints

## Component System

### Navigation System - Soap Bar Design

#### Soap Bar Navigation Specifications
```css
/* Soap Bar Navigation */
.soap-bar-nav {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  z-index: 1000;
  padding: var(--spacing-3) 0;
}

.soap-bar {
  background-color: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(10px);
  border-radius: 25px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
  margin: 0 auto;
  max-width: 600px;
  width: fit-content;
  padding: var(--spacing-3) var(--spacing-6);
}
```

#### Navigation Design Principles
- **Floating Design**: Semi-transparent white bar with backdrop blur
- **Centered Layout**: Navigation items centered horizontally
- **Compact Size**: Maximum 600px width, fits content
- **Fixed Position**: Stays at top while scrolling (no parallax)
- **Responsive**: Adapts to mobile with hamburger menu
- **Accessibility**: 44px minimum touch targets

#### Navigation States
- **Default**: Semi-transparent white with subtle shadow
- **Hover**: Enhanced shadow and slight lift effect
- **Scrolled**: Increased opacity and stronger shadow
- **Mobile**: Stacked navigation with full-width links


### is-builder Component

#### is-builder Specifications


#### is-builder Design Principles
- **Purpose**: [Auto-detected from CSS properties]
- **Usage**: [To be documented]
- **Responsive**: [Auto-detected from media queries]
- **Accessibility**: [Auto-detected from touch targets]

#### is-builder States
- **Default**: [Auto-detected from base styles]
- **Hover**: [Auto-detected from :hover states]
- **Focus**: [Auto-detected from :focus states]
- **Active**: [Auto-detected from :active states]


### nav-dropdown Component

#### nav-dropdown Specifications


#### nav-dropdown Design Principles
- **Purpose**: [Auto-detected from CSS properties]
- **Usage**: [To be documented]
- **Responsive**: [Auto-detected from media queries]
- **Accessibility**: [Auto-detected from touch targets]

#### nav-dropdown States
- **Default**: [Auto-detected from base styles]
- **Hover**: [Auto-detected from :hover states]
- **Focus**: [Auto-detected from :focus states]
- **Active**: [Auto-detected from :active states]

### Button Specifications
```css
/* Button Base */
--button-height: 44px;               /* Touch-friendly minimum height */
--button-padding-x: 1.5rem;         /* Horizontal padding */
--button-border-radius: 8px;        /* Rounded corners */
--button-font-size: 1rem;           /* Button text size */
--button-font-weight: 600;          /* Button text weight */

/* Button Variants */
--button-primary-bg: var(--color-primary);
--button-primary-text: var(--color-text-inverse);
--button-secondary-bg: var(--color-surface);
--button-secondary-text: var(--color-text-primary);
--button-secondary-border: var(--color-border);
```

### Form Element Specifications
```css
/* Form Input Base */
--input-height: 48px;                /* Touch-friendly input height */
--input-padding-x: 1rem;            /* Horizontal padding */
--input-border-radius: 8px;         /* Rounded corners */
--input-border: 1px solid var(--color-border);
--input-focus-border: 2px solid var(--color-accent);
--input-focus-shadow: 0 0 0 3px rgba(0, 123, 255, 0.1);
```

### Card Specifications
```css
/* Card Base */
--card-padding: 1.5rem;             /* Internal spacing */
--card-border-radius: 12px;         /* Rounded corners */
--card-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
--card-border: 1px solid var(--color-border);
--card-background: var(--color-surface);
```

## Icon System

### Icon Sizes
```css
/* Icon Size Scale */
--icon-size-xs: 16px;               /* Small icons */
--icon-size-sm: 20px;               /* Small-medium icons */
--icon-size-base: 24px;             /* Base icon size */
--icon-size-lg: 32px;               /* Large icons */
--icon-size-xl: 48px;               /* Extra large icons */
```

### Icon Usage Guidelines
- **Navigation Icons**: Use icon-size-base (24px) for navigation elements
- **Button Icons**: Use icon-size-sm (20px) for button icons
- **Decorative Icons**: Use icon-size-lg (32px) for decorative elements
- **Hero Icons**: Use icon-size-xl (48px) for hero section icons

## Shadow System

### Shadow Scale
```css
/* Shadow Scale */
--shadow-sm: 0 1px 2px rgba(0, 0, 0, 0.05);
--shadow-base: 0 1px 3px rgba(0, 0, 0, 0.1);
--shadow-md: 0 4px 6px rgba(0, 0, 0, 0.1);
--shadow-lg: 0 10px 15px rgba(0, 0, 0, 0.1);
--shadow-xl: 0 20px 25px rgba(0, 0, 0, 0.15);
```

### Shadow Usage Guidelines
- **Cards**: Use shadow-base to shadow-md for content cards
- **Modals**: Use shadow-lg to shadow-xl for overlays
- **Buttons**: Use shadow-sm for subtle button depth
- **Navigation**: Use shadow-base for navigation elevation

## Animation System

### Transition Timing
```css
/* Transition Scale */
--transition-fast: 150ms;            /* Fast transitions */
--transition-base: 250ms;            /* Base transitions */
--transition-slow: 350ms;            /* Slow transitions */
--transition-slower: 500ms;          /* Slower transitions */
```

### Easing Functions
```css
/* Easing Functions */
--ease-in: cubic-bezier(0.4, 0, 1, 1);
--ease-out: cubic-bezier(0, 0, 0.2, 1);
--ease-in-out: cubic-bezier(0.4, 0, 0.2, 1);
--ease-bounce: cubic-bezier(0.68, -0.55, 0.265, 1.55);
```

### Animation Usage Guidelines
- **Hover Effects**: Use transition-fast with ease-out
- **Page Transitions**: Use transition-base with ease-in-out
- **Loading States**: Use transition-slow with ease-out
- **Micro-interactions**: Use transition-fast with ease-bounce

## Accessibility Standards

### Color Contrast
```css
/* Color Contrast Requirements */
--contrast-ratio-normal: 4.5:1;     /* Normal text contrast */
--contrast-ratio-large: 3:1;        /* Large text contrast */
--contrast-ratio-ui: 3:1;           /* UI element contrast */
```

### Focus Indicators
```css
/* Focus Styles */
--focus-outline: 2px solid var(--color-accent);
--focus-outline-offset: 2px;
--focus-shadow: 0 0 0 3px rgba(0, 123, 255, 0.1);
```

### Touch Targets
```css
/* Touch Target Requirements */
--touch-target-min: 44px;           /* Minimum touch target size */
--touch-target-spacing: 8px;        /* Minimum spacing between targets */
```

## Responsive Breakpoints

### Breakpoint System
```css
/* Mobile-First Breakpoints */
--breakpoint-sm: 576px;             /* Small devices */
--breakpoint-md: 768px;             /* Medium devices */
--breakpoint-lg: 992px;             /* Large devices */
--breakpoint-xl: 1200px;            /* Extra large devices */
--breakpoint-xxl: 1400px;           /* Extra extra large devices */
```

### Breakpoint Usage
- **Mobile**: Base styles (default)
- **Small**: `@media (min-width: 576px)`
- **Medium**: `@media (min-width: 768px)`
- **Large**: `@media (min-width: 992px)`
- **Extra Large**: `@media (min-width: 1200px)`
- **Extra Extra Large**: `@media (min-width: 1400px)`

## Implementation Guidelines

### CSS Variables
```css
/* Design Token Implementation */
:root {
  /* Import all design tokens */
  --color-primary: #000000;
  --color-secondary: #FFFFFF;
  /* ... other tokens */
}

/* Component Implementation */
.button {
  height: var(--button-height);
  padding: 0 var(--button-padding-x);
  border-radius: var(--button-border-radius);
  font-size: var(--button-font-size);
  font-weight: var(--button-font-weight);
}
```

### Class Naming Convention
```css
/* BEM Methodology */
.component { /* Base component */ }
.component--variant { /* Component variant */ }
.component__element { /* Component element */ }
.component__element--modifier { /* Element modifier */ }
```

### Mobile-First Implementation
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

## Design Token Export

### CSS Custom Properties
All design tokens are available as CSS custom properties for easy implementation across the project.

### Design System Integration
The design system integrates with:
- **Bootstrap 5.1**: Framework components enhanced with design tokens
- **Custom Components**: All custom components use design system tokens
- **Responsive Design**: Mobile-first approach with progressive enhancement
- **Accessibility**: WCAG 2.1 AA compliance built into all tokens

---

*This design system serves as the single source of truth for all visual design decisions on the Westmark Talent Group website. All components, layouts, and visual elements should reference these design tokens for consistency.*
