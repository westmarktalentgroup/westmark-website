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

## Visual Design Patterns

### Background Patterns
- **Black Background**: Used for CTA sections to create visual contrast
  - Implementation: `background-color: var(--color-primary)`
  - Usage: Call-to-action sections, footer sections
  - Text Color: White for contrast
  - **black background pattern**: Creates visual separation and emphasis for important sections

### Border Radius Patterns
- **50px Border Radius**: Used for CTA buttons to match navigation styling
  - Implementation: `border-radius: 50px`
  - Usage: Call-to-action buttons, primary action buttons
  - Purpose: Creates rounded, modern button appearance

### Dropdown Patterns
- **Clean Dropdown Design**: Used for FAQ sections with no background color
  - Implementation: Transparent background with border-bottom separators
  - Usage: FAQ accordion sections
  - Features: Smooth transitions, hover effects, icon rotation

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
--font-size-4xl: 2.25rem;           /* 36px - Large page headings */
--font-size-5xl: 3rem;              /* 48px - Hero headings */
--font-size-6xl: 3.75rem;           /* 60px - Large hero headings */
```

### Font Weights
```css
/* Font Weight Scale */
--font-weight-normal: 400;          /* Normal text */
--font-weight-medium: 500;          /* Medium emphasis */
--font-weight-semibold: 600;        /* Semi-bold headings */
--font-weight-bold: 700;            /* Bold headings */
```

## Spacing System

### Spacing Scale
```css
/* Spacing Scale */
--spacing-0: 0;                     /* 0px - No spacing */
--spacing-1: 0.25rem;               /* 4px - Tight spacing */
--spacing-2: 0.5rem;                /* 8px - Small spacing */
--spacing-3: 0.75rem;               /* 12px - Medium spacing */
--spacing-4: 1rem;                  /* 16px - Base spacing */
--spacing-5: 1.25rem;               /* 20px - Large spacing */
--spacing-6: 1.5rem;                /* 24px - Extra large spacing */
--spacing-8: 2rem;                  /* 32px - Section spacing */
--spacing-10: 2.5rem;               /* 40px - Large section spacing */
--spacing-12: 3rem;                 /* 48px - Extra large section spacing */
--spacing-16: 4rem;                 /* 64px - Page spacing */
--spacing-20: 5rem;                 /* 80px - Large page spacing */
```

## Component Design Standards

### Button System
- **Primary Buttons**: Black background with white text
- **Secondary Buttons**: White background with black text and border
- **CTA Buttons**: 50px border-radius for modern appearance
- **Touch Targets**: Minimum 44px height for accessibility

### Card System
- **Background**: White with subtle shadows
- **Border Radius**: 8px for modern appearance
- **Spacing**: Consistent padding using spacing scale
- **Hover Effects**: Subtle elevation changes

### Navigation System
- **Soap Bar Design**: Rounded navigation bar
- **Mobile First**: Hamburger menu for mobile, horizontal for desktop
- **Hover Effects**: Light grey background on hover
- **Touch Friendly**: 44px minimum touch targets

## Responsive Design Standards

### Breakpoints
```css
/* Responsive Breakpoints */
--breakpoint-sm: 576px;             /* Small devices */
--breakpoint-md: 768px;             /* Medium devices */
--breakpoint-lg: 992px;             /* Large devices */
--breakpoint-xl: 1200px;            /* Extra large devices */
```

### Mobile-First Approach
- **Base Styles**: Mobile-first design
- **Progressive Enhancement**: Enhanced for larger screens
- **Touch Optimization**: All interactions optimized for touch
- **Performance**: Optimized for mobile performance

## Accessibility Standards

### WCAG 2.1 AA Compliance
- **Color Contrast**: Minimum 4.5:1 ratio for normal text
- **Touch Targets**: Minimum 44px for touch interactions
- **Focus States**: Visible focus indicators
- **Screen Readers**: Semantic HTML and ARIA labels

### Keyboard Navigation
- **Tab Order**: Logical tab sequence
- **Focus Management**: Clear focus indicators
- **Skip Links**: Skip to main content
- **Escape Keys**: Close modals and dropdowns

## Performance Standards

### Loading Performance
- **Critical CSS**: Above-the-fold styles inline
- **Font Loading**: Preload critical fonts
- **Image Optimization**: WebP format with fallbacks
- **JavaScript**: Defer non-critical scripts

### Runtime Performance
- **Smooth Animations**: 60fps animations
- **Efficient Selectors**: Optimized CSS selectors
- **Memory Management**: Proper cleanup of event listeners
- **Battery Optimization**: Efficient animations and transitions