# Layout Guidelines Documentation

## Westmark Talent Group Website

### Overview

This document defines the layout guidelines and responsive behavior for all components in the Westmark Talent Group website. It ensures consistent spacing, alignment, and responsive behavior across all pages and components.

## Layout System

### Container System
- **`.container`**: Main container with max-width and centering
- **`.container-fluid`**: Full-width container for hero sections
- **Responsive breakpoints**: 576px, 768px, 992px, 1200px

### Grid System
- **`.row`**: Flexbox row container
- **`.col-*`**: Column classes for responsive layouts
- **Gutters**: Consistent spacing between columns
- **Alignment**: Center, start, end alignment utilities

### Spacing System
- **Consistent spacing scale**: 4px, 8px, 12px, 16px, 20px, 24px, 32px, 40px, 48px, 64px, 80px
- **Vertical rhythm**: Consistent spacing between sections
- **Component spacing**: Internal spacing within components

## Component Layout Patterns

### Hero Section Layout
- **Full-width container**: Uses `.container-fluid`
- **Content positioning**: Bottom-aligned content
- **Overlay positioning**: Absolute positioned overlay
- **Responsive behavior**: Scales with viewport

### Card Layout
- **Card container**: Consistent padding and spacing
- **Content hierarchy**: Title, content, footer structure
- **Responsive behavior**: Stacks on mobile, side-by-side on desktop

### Navigation Layout
- **Fixed positioning**: Top of viewport
- **Soap bar design**: Rounded navigation bar
- **Mobile behavior**: Hamburger menu
- **Desktop behavior**: Horizontal navigation

### Form Layout
- **Form groups**: Consistent spacing between form elements
- **Label positioning**: Above form controls
- **Button alignment**: Right-aligned action buttons
- **Validation states**: Error and success styling

## Responsive Design Guidelines

### Mobile-First Approach
- **Base styles**: Mobile-first design
- **Progressive enhancement**: Enhanced for larger screens
- **Touch optimization**: 44px minimum touch targets
- **Performance**: Optimized for mobile performance

### Breakpoint Strategy
- **Small (576px+)**: Enhanced mobile layout
- **Medium (768px+)**: Tablet layout adjustments
- **Large (992px+)**: Desktop layout
- **Extra Large (1200px+)**: Large desktop optimizations

### Typography Scaling
- **Responsive typography**: Uses `clamp()` for fluid scaling
- **Line height**: Consistent line height ratios
- **Font weights**: Appropriate weights for each screen size
- **Readability**: Optimized for each device type

## Alignment Guidelines

### Content Alignment
- **Center alignment**: Used for section headers and CTAs
- **Left alignment**: Used for body content and forms
- **Right alignment**: Used for action buttons and metadata

### Vertical Alignment
- **Flexbox alignment**: Uses `align-items` for vertical centering
- **Baseline alignment**: Text baseline alignment
- **Visual alignment**: Optical alignment for different font sizes

## Spacing Guidelines

### Section Spacing
- **Large sections**: 4rem (64px) spacing between major sections
- **Medium sections**: 2rem (32px) spacing between subsections
- **Small sections**: 1rem (16px) spacing between related elements

### Component Spacing
- **Card padding**: 1.5rem (24px) internal padding
- **Button spacing**: 0.75rem (12px) between buttons
- **Form spacing**: 1rem (16px) between form groups

### Text Spacing
- **Line height**: 1.6 for body text, 1.4 for headings
- **Paragraph spacing**: 1rem (16px) between paragraphs
- **List spacing**: 0.5rem (8px) between list items

## Performance Guidelines

### Layout Performance
- **Efficient selectors**: Optimized CSS selectors
- **Minimal reflows**: Avoid layout thrashing
- **Hardware acceleration**: Use `transform` for animations
- **Lazy loading**: Defer non-critical layout elements

### Responsive Performance
- **Efficient media queries**: Group related styles
- **Conditional loading**: Load assets based on screen size
- **Touch optimization**: Optimize for touch interactions
- **Battery optimization**: Efficient animations and transitions