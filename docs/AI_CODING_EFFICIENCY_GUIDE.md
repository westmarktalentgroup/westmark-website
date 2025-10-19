# AI Coding Efficiency Guide - Westmark Talent Group

## 🎯 **OPTIMIZED FOR CURSOR AI ASSISTANCE**

This guide consolidates all essential information for efficient AI-assisted coding through Cursor.

## 📁 **SIMPLIFIED FILE STRUCTURE**

### Core Files (AI Focus)
```
development/
├── index.html          # Main homepage
├── clients.html         # Clients page  
├── contact-us.html     # Contact page
├── logo.html           # Logo distribution
├── assets/
│   ├── css/optimized.css    # ALL styles (72 classes)
│   ├── js/consolidated.js   # ALL functionality (15 functions)
│   └── images/              # All images
└── sw.js               # Service worker
```

### Essential Documentation (AI Reference)
```
docs/
├── AI_AGENT_WORKFLOW_RULES.md    # CRITICAL: Workflow rules
├── TECHNICAL_ARCHITECTURE.md     # System overview
├── DESIGN_SYSTEM.md              # Design tokens & patterns
├── CSS_STANDARDS.md              # CSS conventions
└── DEPLOYMENT_GUIDE.md           # Deployment procedures
```

## 🎨 **DESIGN SYSTEM (AI Reference)**

### CSS Classes (72 total)
```css
/* Navigation */
.soap-bar-nav, .soap-bar, .soap-bar-nav-items, .soap-bar-link

/* Typography */
.display-1, .display-2, .display-4, .display-5, .display-7
.hero-title, .hero-subtitle, .section-title, .text-content

/* Components */
.btn, .btn-primary, .btn-secondary, .btn-outline-primary
.card, .card-title, .card-wrapper
.form-group, .form-control, .form-label

/* Layout */
.hero-section, .hero-overlay, .about-section, .contact-section
```

### JavaScript Functions (15 total)
```javascript
// Utilities
$, $$, addClass, removeClass, hasClass, toggleClass

// Core Features
initNavigation(), initSoapBarScroll(), initAccordion()
initForms(), initPerformanceMonitoring(), initServiceWorker()
initLazyLoading(), showNotification()
```

## 🚀 **AI CODING PATTERNS**

### 1. **Consistent Naming**
- **Components**: `soap-bar-nav`, `hero-section`, `contact-section`
- **Utilities**: `btn-primary`, `text-content`, `form-group`
- **States**: `hover`, `focus`, `active`, `disabled`

### 2. **Semantic HTML Structure**
```html
<section class="soap-bar-nav" id="navigation">
<nav class="soap-bar">
<section class="hero-section" id="hero">
<main id="main-content">
<section class="about-section" id="about">
```

### 3. **CSS Organization**
```css
/* Design Tokens */
:root { --font-family-heading, --color-primary, --spacing-1 }

/* Typography */
.display-1, .hero-title, .section-title

/* Components */
.btn, .card, .form-group

/* Layout */
.hero-section, .soap-bar-nav
```

## 🔧 **AI ASSISTANCE WORKFLOW**

### 1. **Always Work in Development**
```bash
# Edit development files
edit development/index.html
edit development/assets/css/optimized.css
edit development/assets/js/consolidated.js
```

### 2. **Deploy Changes**
```bash
# Use deploy script
./scripts/deploy.sh
```

### 3. **Follow Patterns**
- Use existing class names
- Follow semantic HTML structure
- Maintain design token consistency
- Test in development first

## 📋 **QUICK REFERENCE**

### Common Tasks
- **Add new section**: Use `section` + semantic class name
- **Style component**: Add to `optimized.css` with design tokens
- **Add functionality**: Add function to `consolidated.js`
- **Deploy changes**: Use `./scripts/deploy.sh`

### File Locations
- **Styles**: `development/assets/css/optimized.css`
- **Scripts**: `development/assets/js/consolidated.js`
- **Images**: `development/assets/images/`
- **Deploy**: `./scripts/deploy.sh`

## 🎯 **AI EFFICIENCY TIPS**

1. **Reference existing patterns** before creating new ones
2. **Use semantic class names** that describe purpose
3. **Leverage design tokens** for consistency
4. **Follow the established workflow** (dev → test → deploy)
5. **Check documentation** for established patterns

This consolidated guide provides everything needed for efficient AI-assisted coding through Cursor.
