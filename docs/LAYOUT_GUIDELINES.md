# Layout Guidelines Documentation

## Westmark Talent Group Website

### Overview

This document provides comprehensive guidelines for implementing layouts across the Westmark Talent Group website. It covers the grid system, breakpoints, spacing patterns, and layout best practices to ensure consistent and responsive design across all pages.

## Grid System Foundation

### Bootstrap 5.1 Grid System

#### Core Grid Principles
The website uses Bootstrap 5.1's 12-column grid system as the foundation for all layouts.

**Grid Container**:
```html
<div class="container">
  <!-- Content with max-width and horizontal padding -->
</div>

<div class="container-fluid">
  <!-- Full-width content without max-width constraints -->
</div>
```

**Grid Row**:
```html
<div class="row">
  <!-- Grid columns go here -->
</div>
```

**Grid Columns**:
```html
<div class="col-12">        <!-- Full width on all screens -->
<div class="col-md-6">      <!-- Half width on medium+ screens -->
<div class="col-lg-4">      <!-- Third width on large+ screens -->
<div class="col-xl-3">      <!-- Quarter width on extra large+ screens -->
```

#### Container Max-Widths
```css
/* Bootstrap 5.1 Container Sizes */
.container-sm { max-width: 540px; }   /* Small devices */
.container-md { max-width: 720px; }   /* Medium devices */
.container-lg { max-width: 960px; }   /* Large devices */
.container-xl { max-width: 1140px; }  /* Extra large devices */
.container-xxl { max-width: 1320px; } /* Extra extra large devices */
```

### Grid Usage Patterns

#### Single Column Layout
**Use Case**: Hero sections, full-width content, page titles

```html
<div class="container">
  <div class="row">
    <div class="col-12">
      <!-- Full-width content -->
    </div>
  </div>
</div>
```

#### Two Column Layout
**Use Case**: Content with sidebar, form with image, split content

```html
<div class="container">
  <div class="row">
    <div class="col-12 col-md-6">
      <!-- Left column content -->
    </div>
    <div class="col-12 col-md-6">
      <!-- Right column content -->
    </div>
  </div>
</div>
```

#### Three Column Layout
**Use Case**: Feature cards, service offerings, job listings

```html
<div class="container">
  <div class="row">
    <div class="col-12 col-md-6 col-lg-4">
      <!-- First column -->
    </div>
    <div class="col-12 col-md-6 col-lg-4">
      <!-- Second column -->
    </div>
    <div class="col-12 col-md-6 col-lg-4">
      <!-- Third column -->
    </div>
  </div>
</div>
```

#### Four Column Layout
**Use Case**: Feature grids, statistics, team members

```html
<div class="container">
  <div class="row">
    <div class="col-6 col-md-3">
      <!-- First column -->
    </div>
    <div class="col-6 col-md-3">
      <!-- Second column -->
    </div>
    <div class="col-6 col-md-3">
      <!-- Third column -->
    </div>
    <div class="col-6 col-md-3">
      <!-- Fourth column -->
    </div>
  </div>
</div>
```

## Responsive Breakpoints

### Mobile-First Breakpoint Strategy

#### Breakpoint System
```css
/* Mobile-First Breakpoints */
--breakpoint-sm: 576px;             /* Small devices */
--breakpoint-md: 768px;             /* Medium devices */
--breakpoint-lg: 992px;             /* Large devices */
--breakpoint-xl: 1200px;            /* Extra large devices */
--breakpoint-xxl: 1400px;           /* Extra extra large devices */
```

#### Breakpoint Usage
- **Mobile**: Base styles (default)
- **Small**: `@media (min-width: 576px)`
- **Medium**: `@media (min-width: 768px)`
- **Large**: `@media (min-width: 992px)`
- **Extra Large**: `@media (min-width: 1200px)`
- **Extra Extra Large**: `@media (min-width: 1400px)`

### Responsive Behavior Patterns

#### Content Stacking
```css
/* Mobile-first content stacking */
.content-item {
  margin-bottom: var(--spacing-4);
}

/* Tablet: side-by-side layout */
@media (min-width: 768px) {
  .content-item {
    margin-bottom: var(--spacing-6);
  }
}

/* Desktop: grid layout */
@media (min-width: 992px) {
  .content-item {
    margin-bottom: var(--spacing-8);
  }
}
```

#### Navigation Adaptation
```css
/* Mobile: stacked navigation */
.nav-item {
  display: block;
  margin-bottom: var(--spacing-2);
}

/* Desktop: horizontal navigation */
@media (min-width: 992px) {
  .nav-item {
    display: inline-block;
    margin-bottom: 0;
    margin-right: var(--spacing-4);
  }
}
```

## Layout Patterns

### Hero Section Layout

#### Full-Width Hero
```html
<section class="hero hero--full-width">
  <div class="hero__background">
    <img src="assets/images/background1.jpg" 
         alt="Construction industry background" 
         class="hero__image">
  </div>
  <div class="hero__overlay"></div>
  <div class="container">
    <div class="row justify-content-center">
      <div class="col-12 col-lg-8 text-center">
        <h1 class="hero__title">Building the Future, One Placement at a Time</h1>
        <p class="hero__subtitle">Professional recruitment for construction management</p>
        <div class="hero__actions">
          <a href="clients.html" class="btn btn--primary btn--lg">For Employers</a>
          <a href="contact-us.html" class="btn btn--secondary btn--lg">Contact Us</a>
        </div>
      </div>
    </div>
  </div>
</section>
```

#### Hero Layout Specifications
- **Full Width**: Extends to viewport edges
- **Centered Content**: Content centered both horizontally and vertically
- **Responsive Text**: Text scales appropriately for different screen sizes
- **Action Buttons**: Prominent call-to-action buttons below text

### Content Section Layout

#### Standard Content Section
```html
<section class="content-section">
  <div class="container">
    <div class="row">
      <div class="col-12">
        <h2 class="content-section__title">Our Services</h2>
        <p class="content-section__description">Comprehensive recruitment solutions for the construction industry.</p>
      </div>
    </div>
    <div class="row">
      <div class="col-12 col-md-6 col-lg-4">
        <!-- Service card 1 -->
      </div>
      <div class="col-12 col-md-6 col-lg-4">
        <!-- Service card 2 -->
      </div>
      <div class="col-12 col-md-6 col-lg-4">
        <!-- Service card 3 -->
      </div>
    </div>
  </div>
</section>
```

#### Content Section Specifications
- **Container**: Uses Bootstrap container for content width
- **Title Area**: Full-width title and description
- **Content Grid**: Responsive grid for content items
- **Consistent Spacing**: Uses design system spacing values

### Card Grid Layout

#### Responsive Card Grid
```html
<div class="card-grid">
  <div class="row">
    <div class="col-12 col-sm-6 col-lg-4">
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
    <!-- Additional cards -->
  </div>
</div>
```

#### Card Grid Specifications
- **Mobile**: Single column layout
- **Tablet**: Two columns on medium screens
- **Desktop**: Three columns on large screens
- **Consistent Spacing**: Equal spacing between cards

### Form Layout

#### Contact Form Layout
```html
<div class="form-container">
  <div class="row justify-content-center">
    <div class="col-12 col-lg-8">
      <form class="contact-form">
        <div class="row">
          <div class="col-12 col-md-6">
            <div class="form-group">
              <label for="name" class="form-label">Full Name *</label>
              <input type="text" id="name" name="name" class="form-control" required>
            </div>
          </div>
          <div class="col-12 col-md-6">
            <div class="form-group">
              <label for="email" class="form-label">Email Address *</label>
              <input type="email" id="email" name="email" class="form-control" required>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-12">
            <div class="form-group">
              <label for="message" class="form-label">Message *</label>
              <textarea id="message" name="message" class="form-control" rows="4" required></textarea>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-12 text-center">
            <button type="submit" class="btn btn--primary btn--lg">Send Message</button>
          </div>
        </div>
      </form>
    </div>
  </div>
</div>
```

#### Form Layout Specifications
- **Centered**: Form centered on larger screens
- **Responsive Grid**: Fields stack on mobile, side-by-side on larger screens
- **Full-Width**: Message field spans full width
- **Centered Button**: Submit button centered below form

## Spacing and Layout

### Section Spacing

#### Consistent Section Spacing
```css
/* Section spacing using design system tokens */
.content-section {
  padding: var(--spacing-16) 0; /* 64px top/bottom on mobile */
}

@media (min-width: 768px) {
  .content-section {
    padding: var(--spacing-20) 0; /* 80px top/bottom on tablet */
  }
}

@media (min-width: 992px) {
  .content-section {
    padding: var(--spacing-24) 0; /* 96px top/bottom on desktop */
  }
}
```

#### Section Spacing Guidelines
- **Hero Sections**: Use spacing-16 to spacing-20
- **Content Sections**: Use spacing-12 to spacing-16
- **Card Sections**: Use spacing-8 to spacing-12
- **Footer Sections**: Use spacing-8 to spacing-12

### Component Spacing

#### Internal Component Spacing
```css
/* Component spacing using design system tokens */
.card {
  padding: var(--spacing-6); /* 24px internal spacing */
  margin-bottom: var(--spacing-4); /* 16px bottom margin */
}

@media (min-width: 768px) {
  .card {
    padding: var(--spacing-8); /* 32px internal spacing on tablet */
    margin-bottom: var(--spacing-6); /* 24px bottom margin on tablet */
  }
}
```

#### Component Spacing Guidelines
- **Cards**: Use spacing-4 to spacing-6 for internal padding
- **Buttons**: Use spacing-3 to spacing-4 for button padding
- **Forms**: Use spacing-4 to spacing-6 for form field spacing
- **Navigation**: Use spacing-2 to spacing-4 for navigation spacing

## Layout Best Practices

### Content Hierarchy

#### Visual Hierarchy Implementation
```css
/* Content hierarchy using spacing and typography */
.content-section__title {
  margin-bottom: var(--spacing-6);
  font-size: var(--font-size-3xl);
  font-weight: 700;
}

.content-section__description {
  margin-bottom: var(--spacing-8);
  font-size: var(--font-size-lg);
  color: var(--color-text-secondary);
}

.content-section__content {
  margin-bottom: var(--spacing-12);
}
```

#### Hierarchy Guidelines
- **Titles**: Use larger font sizes and bottom margins
- **Descriptions**: Use medium font sizes and moderate margins
- **Content**: Use standard font sizes and consistent spacing
- **Actions**: Use appropriate spacing above action elements

### Responsive Images

#### Image Layout Implementation
```html
<!-- Responsive image with proper aspect ratio -->
<div class="image-container">
  <img src="assets/images/pexels-1948912-3609139-2136x1430.jpg" 
       alt="Construction workers" 
       class="responsive-image"
       loading="lazy">
</div>
```

```css
/* Responsive image styling */
.image-container {
  width: 100%;
  overflow: hidden;
  border-radius: var(--border-radius-base);
}

.responsive-image {
  width: 100%;
  height: auto;
  display: block;
  object-fit: cover;
}
```

#### Image Layout Guidelines
- **Aspect Ratios**: Maintain consistent aspect ratios across breakpoints
- **Responsive Scaling**: Images scale proportionally with containers
- **Loading Optimization**: Use lazy loading for images below the fold
- **Accessibility**: Provide descriptive alt text for all images

### Layout Containment

#### Layout Containment Implementation
```css
/* Layout containment for performance */
.layout-container {
  contain: layout style;
  isolation: isolate;
}

.content-section {
  contain: layout;
  margin-bottom: var(--spacing-16);
}

.card-grid {
  contain: layout style;
  display: grid;
  gap: var(--spacing-6);
}
```

#### Containment Guidelines
- **Layout Containment**: Use `contain: layout` for independent sections
- **Style Containment**: Use `contain: style` for isolated components
- **Paint Containment**: Use `contain: paint` for overflow elements
- **Performance**: Implement containment for better rendering performance

## Mobile-First Implementation

### Mobile Layout Patterns

#### Mobile Hero Layout
```css
/* Mobile-first hero layout */
.hero {
  min-height: 100vh;
  display: flex;
  align-items: center;
  padding: var(--spacing-8) 0;
}

.hero__content {
  text-align: center;
  padding: 0 var(--spacing-4);
}

.hero__title {
  font-size: var(--font-size-3xl);
  margin-bottom: var(--spacing-4);
}

.hero__subtitle {
  font-size: var(--font-size-lg);
  margin-bottom: var(--spacing-6);
}

.hero__actions {
  display: flex;
  flex-direction: column;
  gap: var(--spacing-3);
}
```

#### Mobile Layout Guidelines
- **Full Height**: Hero sections use full viewport height
- **Centered Content**: All content centered on mobile
- **Stacked Actions**: Action buttons stack vertically on mobile
- **Touch-Friendly**: Ensure 44px minimum touch targets

### Tablet Enhancements

#### Tablet Layout Adaptations
```css
/* Tablet layout enhancements */
@media (min-width: 768px) {
  .hero__content {
    padding: 0 var(--spacing-8);
  }
  
  .hero__title {
    font-size: var(--font-size-4xl);
    margin-bottom: var(--spacing-6);
  }
  
  .hero__subtitle {
    font-size: var(--font-size-xl);
    margin-bottom: var(--spacing-8);
  }
  
  .hero__actions {
    flex-direction: row;
    justify-content: center;
    gap: var(--spacing-4);
  }
}
```

#### Tablet Guidelines
- **Enhanced Typography**: Increase font sizes for better readability
- **Horizontal Actions**: Action buttons can be horizontal on tablet
- **Increased Spacing**: Use larger spacing values for tablet layouts
- **Content Width**: Optimize content width for tablet screens

### Desktop Enhancements

#### Desktop Layout Optimizations
```css
/* Desktop layout optimizations */
@media (min-width: 992px) {
  .hero__content {
    padding: 0 var(--spacing-12);
  }
  
  .hero__title {
    font-size: var(--font-size-5xl);
    margin-bottom: var(--spacing-8);
  }
  
  .hero__subtitle {
    font-size: var(--font-size-2xl);
    margin-bottom: var(--spacing-10);
  }
  
  .hero__actions {
    gap: var(--spacing-6);
  }
}
```

#### Desktop Guidelines
- **Maximum Typography**: Use largest font sizes for desktop
- **Optimal Spacing**: Use maximum spacing values for desktop
- **Content Width**: Optimize for desktop screen sizes
- **Performance**: Ensure smooth performance on desktop devices

## Layout Testing

### Responsive Testing

#### Breakpoint Testing
- **Mobile**: Test at 375px width (iPhone SE)
- **Small**: Test at 576px width
- **Medium**: Test at 768px width (iPad)
- **Large**: Test at 992px width
- **Extra Large**: Test at 1200px width
- **Extra Extra Large**: Test at 1400px width

#### Layout Validation
- **Content Flow**: Verify content flows logically across breakpoints
- **Spacing Consistency**: Ensure consistent spacing at all breakpoints
- **Typography Scaling**: Verify text scales appropriately
- **Image Behavior**: Test image scaling and positioning

### Performance Testing

#### Layout Performance
- **Layout Shifts**: Minimize cumulative layout shift (CLS)
- **Paint Performance**: Optimize paint operations
- **Memory Usage**: Monitor memory usage across different layouts
- **Rendering Speed**: Ensure fast rendering on all devices

#### Optimization Guidelines
- **CSS Containment**: Use layout containment for better performance
- **Minimal Repaints**: Avoid unnecessary repaints and reflows
- **Efficient Selectors**: Use efficient CSS selectors
- **Responsive Images**: Optimize images for different screen sizes

---

*These layout guidelines ensure consistent, responsive, and performant layouts across the Westmark Talent Group website. All layouts should follow these patterns to maintain design system integrity and user experience quality.*
