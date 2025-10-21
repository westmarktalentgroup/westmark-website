# Component Library Documentation

## Westmark Talent Group Website

### Overview

This document defines all components, CSS classes, and HTML structures used in the Westmark Talent Group website. It serves as the comprehensive reference for all architectural elements and ensures consistency across the entire codebase.

## CSS Class Documentation

### Layout Classes
- **`.container`**: Main container with max-width and centering
- **`.container-fluid`**: Full-width container
- **`.row`**: Flexbox row container
- **`.col-12`**: Full-width column (100%)
- **`.col-md-4`**: Medium screen 4-column width (33.33%)
- **`.col-md-6`**: Medium screen 6-column width (50%)
- **`.col-md-8`**: Medium screen 8-column width (66.67%)
- **`.col-md-12`**: Medium screen full-width (100%)
- **`.col-lg-4`**: Large screen 4-column width (33.33%)
- **`.col-lg-8`**: Large screen 8-column width (66.67%)
- **`.col-lg-10`**: Large screen 10-column width (83.33%)

### Utility Classes
- **`.justify-content-center`**: Center content horizontally
- **`.align-items-center`**: Center content vertically
- **`.text-center`**: Center text alignment
- **`.text-left`**: Left text alignment
- **`.text-right`**: Right text alignment
- **`.d-none`**: Hide element (display: none)
- **`.d-block`**: Show as block element
- **`.d-flex`**: Display as flex container
- **`.flex-column`**: Flex direction column

### Navigation Classes
- **`.navbar-brand`**: Navigation brand/logo container
- **`.navbar-toggler`**: Mobile navigation toggle button
- **`.navbar-collapse`**: Navigation collapse container
- **`.collapse`**: Collapsible content container
- **`.collapse.show`**: Show collapsed content
- **`.nav-item`**: Navigation item container
- **`.nav-link`**: Navigation link styling
- **`.navbar-nav`**: Navigation list container
- **`.hamburger`**: Mobile hamburger menu icon

### Soap Bar Navigation Classes
- **`.soap-bar-nav`**: Fixed navigation bar container
- **`.soap-bar`**: Main navigation bar styling
- **`.soap-bar-nav-items`**: Navigation items container
- **`.soap-bar-link`**: Navigation link styling with hover effects

### Typography Classes
- **`.display-1`**: Largest display text (hero titles)
- **`.display-2`**: Large display text (section headers)
- **`.display-4`**: Medium display text
- **`.display-5`**: Small display text (card titles)
- **`.display-7`**: Smallest display text (body text)
- **`.text-white`**: White text color
- **`.text-semibold`**: Semi-bold font weight
- **`.text-content`**: Standard content text styling
- **`.section-title`**: Section header styling
- **`.hero-title`**: Hero section main title
- **`.hero-subtitle`**: Hero section subtitle

### Button Classes
- **`.btn`**: Base button styling
- **`.btn-primary`**: Primary button (filled)
- **`.btn-secondary`**: Secondary button (filled)
- **`.btn-outline-primary`**: Primary outline button
- **`.btn-outline-secondary`**: Secondary outline button
- **`.btn-sm`**: Small button size
- **`.btn-lg`**: Large button size
- **`.btn-cta-primary`**: Call-to-action primary button

### Card Classes
- **`.card`**: Base card container
- **`.card-header`**: Card header section
- **`.card-title`**: Card title styling
- **`.card-content-text`**: Card content text container
- **`.card-box`**: Card box container with spacing

### FAQ Classes
- **`.faq-accordion`**: FAQ accordion container
- **`.faq-item`**: Individual FAQ item
- **`.faq-header`**: FAQ item header
- **`.faq-toggle`**: FAQ toggle button
- **`.faq-question`**: FAQ question text
- **`.faq-icon`**: FAQ expand/collapse icon (chevron ▼/▲)
- **`.faq-collapse`**: FAQ collapsible content (hidden by default)
- **`.faq-collapse.show`**: FAQ expanded state
- **`.faq-answer`**: FAQ answer container

### Section Classes
- **`.hero-section`**: Hero banner section
- **`.about-section`**: About content section
- **`.faq-section`**: FAQ section
- **`.opportunities-section`**: Job opportunities section
- **`.process-section`**: Process steps section
- **`.services-section`**: Services section
- **`.contact-section`**: Contact form section
- **`.info-section`**: Information section
- **`.cta-section`**: Call-to-action section
- **`.footer-section`**: Footer section

### Hero Section Classes
- **`.hero-overlay`**: Hero background overlay
- **`.content-wrap`**: Hero content wrapper

### Item Classes
- **`.item`**: Generic item container
- **`.item-content`**: Item content container
- **`.item-footer`**: Item footer section
- **`.item-title`**: Item title styling
- **`.item-img`**: Item image container
- **`.item-wrapper`**: Item wrapper container

### Form Classes
- **`.form-group`**: Form input group
- **`.form-label`**: Form label styling
- **`.form-control`**: Form input styling
- **`.contact-form`**: Contact form container

### Process Classes
- **`.process-number`**: Process step number container
- **`.number`**: Individual number styling with black color and bold weight
  - `color: var(--color-primary)` - Black for consistency
  - `font-weight: var(--font-weight-bold)` - Bold for prominence
  - `display: inline-block` - Proper spacing and alignment

### Footer Classes
- **`.footer-content`**: Footer content container
- **`.footer-text`**: Footer text styling
- **`.footer-links`**: Footer links container
- **`.footer-link`**: Individual footer link

### CTA Classes
- **`.cta-buttons`**: Call-to-action buttons container

### Utility Classes
- **`.logo`**: Logo styling
- **`.features-without-image`**: Features without image layout
- **`.collapsed`**: Collapsed state styling
- **`.panel-text`**: Panel text styling
- **`.video-wrapper`**: Video wrapper container
- **`.align-left`**: Left alignment utility

### Spacing Classes
- **`.mb-4`**: Bottom margin spacing
- **`.mt-3`**: Top margin spacing
- **`.mb-3`**: Bottom margin spacing

## HTML Structure Documentation

### Page Structure Patterns

#### Index Page Structure
- **`.hero-section`**: Main hero banner with background image and overlay
- **`.about-section`**: About content section with mission statement
- **`.opportunities-section`**: Current job opportunities display
- **`.cta-section`**: Connecting Construction Management Professionals call-to-action
- **`.faq-section`**: Frequently Asked Questions accordion
- **`.footer-section`**: Site footer with links and copyright

#### Clients Page Structure
- **`.process-section`**: Three-step process explanation
- **`.services-section`**: Service offerings display
- **`.cta-section`**: Call-to-action for client engagement
- **`.footer-section`**: Site footer with links and copyright

#### Contact Page Structure
- **`.contact-section`**: Contact form and information
- **`.info-section`**: Additional contact information
- **`.footer-section`**: Site footer with links and copyright

### Section Structure Patterns

#### Standard Section Pattern
```html
<section class="[section-name]-section" id="[section-id]">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-12 col-lg-10">
                <div class="section-head">
                    <h4 class="section-title text-center display-2">
                        <strong>Section Title</strong>
                    </h4>
                </div>
                <!-- Section content -->
            </div>
        </div>
    </div>
</section>
```

#### Hero Section Pattern
```html
<section class="hero-section" id="hero">
    <div class="hero-overlay"></div>
    <div class="container-fluid">
        <div class="row">
            <div class="content-wrap col-12">
                <h1 class="hero-title display-1">
                    <strong>Hero Title</strong>
                </h1>
                <p class="hero-subtitle display-7">Hero subtitle text</p>
            </div>
        </div>
    </div>
</section>
```

#### Card Content Pattern
```html
<div class="card">
    <div class="card-wrapper">
        <div class="card-content-text">
            <h4 class="card-title display-5">
                <strong>Card Title</strong>
            </h4>
            <p class="text-content display-7">Card content text</p>
        </div>
    </div>
</div>
```

#### FAQ Accordion Pattern
```html
<div class="faq-accordion">
    <div class="faq-item">
        <div class="faq-header">
            <button class="faq-toggle collapsed">
                <h6 class="faq-question display-7">
                    <strong>FAQ Question</strong>
                </h6>
                <span class="faq-icon">+</span>
            </button>
        </div>
        <div class="faq-collapse collapse">
            <div class="faq-answer">
                <p class="panel-text display-7">FAQ answer text</p>
            </div>
        </div>
    </div>
</div>
```

## Process Number Component

### Purpose
Display process step numbers in a consistent, prominent style for the clients page process section.

### CSS Classes
- `.process-number`: Container for process numbers with centered alignment
- `.number`: Individual number styling with black color and bold weight

### HTML Structure
```html
<div class="process-number">
    <span class="number display-1">1.</span>
</div>
```

### CSS Implementation
```css
.process-number {
  text-align: center;
  margin-bottom: var(--spacing-4);
}

.number {
  display: inline-block;
  color: var(--color-primary); /* Black for consistency */
  font-weight: var(--font-weight-bold);
}
```

### Usage Guidelines
- **Color**: Uses `var(--color-primary)` (black) for consistency with design system
- **Font Weight**: Bold for prominence and readability
- **Alignment**: Centered within process cards
- **Spacing**: Proper margin-bottom for visual separation

### CSS Class Documentation
- **`.number`**: Individual number styling with black color and bold weight
  - `color: var(--color-primary)` - Black for consistency
  - `font-weight: var(--font-weight-bold)` - Bold for prominence
  - `display: inline-block` - Proper spacing and alignment

#### FAQ Dropdown Clean Design
- **FAQ dropdown clean pattern**: Clean dropdown design with chevron icons and proper accordion behavior
  - Implementation: Transparent background with border-bottom separators
  - Usage: FAQ accordion sections with clean, minimal appearance
  - Features: Smooth transitions, hover effects, chevron rotation (▼/▲)
  - Behavior: All panels start collapsed, only one can be open at a time
  - Icons: Downward chevron (▼) for collapsed, upward chevron (▲) for expanded

### Current Opportunities Component (Updated Implementation)

#### Purpose
Display job listings in a single row with flexbox layout and square images. This component shows 4 job opportunities in a horizontal layout that maintains single-row display across all screen sizes.

#### HTML Structure
```html
<!-- Current Opportunities Section -->
<section class="opportunities-section" id="opportunities">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-12">
                <div class="section-head">
                    <h4 class="section-title text-center display-2">
                        <strong>Current Opportunities</strong>
                    </h4>
                </div>
                <div style="display: flex; gap: 1.5rem; flex-wrap: nowrap; padding: 0 1.5rem;">
                    <div style="flex: 1; min-width: 0;">
                        <div class="card">
                            <div class="item-wrapper">
                                <div class="item-img" style="position: relative; width: 100%; height: 0; padding-bottom: 100%; overflow: hidden;">
                                    <img src="assets/images/job-image.webp" alt="Job Position" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; object-fit: cover; object-position: center;">
                                </div>
                                <div class="item-content">
                                    <h5 class="item-title display-5"><strong>Sr. PM</strong><br><strong>Luxury Residential</strong></h5>
                                    <p class="text-content display-7">Santa Monica - California</p>
                                    <p class="text-content display-7">Luxury builder in Santa Monica $30M+ builds.</p>
                                    <div class="item-footer">
                                        <a href="job-url" class="btn btn-outline-primary display-7" target="_blank" rel="noopener noreferrer">Apply</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Repeat for 3 more job cards -->
                </div>
            </div>
        </div>
    </div>
</section>
```

#### CSS Implementation
```css
/* Flexbox Layout for Single Row */
.opportunities-container {
    display: flex;
    gap: 1.5rem;
    flex-wrap: nowrap;
    padding: 0 1.5rem;
}

.opportunity-card {
    flex: 1;
    min-width: 0;
}

/* Square Image Implementation */
.item-img {
    position: relative;
    width: 100%;
    height: 0;
    padding-bottom: 100%;
    overflow: hidden;
}

.item-img img {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    object-fit: cover;
    object-position: center;
}

/* Text Content Sizing */
.text-content {
    font-family: var(--font-family-body);
    font-size: 1.575rem;
    line-height: 1.6;
    margin-bottom: var(--spacing-1);
}
```

## Section Header Component

### Purpose
Standardized section headers with consistent typography and spacing across all page sections.

### Header Class Hierarchy
- **`.section-title`**: Main section headers (centered, full-width sections)
- **`.card-title`**: Content headers within cards (left-aligned)
- **`.cta-title`**: Call-to-action headers Sherman (left-aligned, CTA sections)

### CSS Classes
- `.section-title`: Main section headers with center alignment
- `.card-title`: Card content headers with left alignment
- `.cta-title`: CTA section headers with left alignment
- `.text-center`: Center alignment utility
- `.display-2`: Typography class for consistent sizing
- `.mb-4`: Bottom margin utility

### HTML Structure
```html
<!-- Main Section Header Pattern -->
<section class="opportunities-section">
  <div class="container">
    <div class="section-head">
      <h4 class="section-title text-center display-2">
        <strong>Section Title</strong>
      </h4>
    </div>
  </div>
</section>

<!-- Card Header Pattern -->
<div class="card">
  <div class="card-content-text">
    <h3 class="card-title display-2">
      <strong>Card Title</strong>
    </h3>
  </div>
</div>

<!-- CTA Header Pattern -->
<section class="cta-section">
  <div class="container">
    <h1 class="section-title display-2 mb-4">
      <strong>CTA Title</strong>
    </h1>
  </div>
</section>
```

### CSS Implementation
```css
/* Section Header System */
.section-title {
  font-family: var(--font-family-body);
  font-size: clamp(2.8rem, 4.8vw, 4.8rem);
  font-weight: var(--font-weight-bold);
  color: var(--color-primary);
  text-align: center;
  margin-bottom: var(--spacing-4);
}

.card-title {
  font-family: var(--font-family-body);
  font-size: clamp(2.8rem, 4.8vw, 4.8rem);
  font-weight: var(--font-weight-bold);
  color: var(--color-primary);
  margin-bottom: var(--spacing-4);
}

.cta-title {
  font-family: var(--font-family-body);
  font-size: clamp(2.8rem, 4.8vw, 4.8rem);
  font-weight: var(--font-weight-bold);
  color: var(--color-primary);
  margin-bottom: var(--spacing-4);
}
```

### Usage Guidelines
- **Main sections**: Use `.section-title` with `.text-center` for full-width sections
- **Card content**: Use `.card-title` for headers within cards
- **CTA sections**: Use `.section-title` with `.mb-4` for call-to-action sections
- **Consistency**: Always pair with `.display-2` for typography consistency
- **Semantic HTML**: Use appropriate heading tags (h1, h3, h4) based on content hierarchy