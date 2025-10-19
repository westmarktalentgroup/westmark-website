# 🚨 CRITICAL: READ THIS FIRST - AI CODING GUIDE

## IMMEDIATE AI REFERENCE (No Discovery Required)

### WORKFLOW (MANDATORY)
- **ALWAYS work in `development/` directory**
- **NEVER edit production files directly**
- **ALWAYS use `./scripts/deploy.sh` for deployment**

### FILE STRUCTURE
```
development/           # 🧪 WORK HERE
├── index.html        # Main homepage
├── clients.html      # Clients page  
├── contact-us.html   # Contact page
├── assets/
│   ├── css/optimized.css    # ALL styles (72 classes)
│   ├── js/consolidated.js   # ALL functionality (15 functions)
│   └── images/              # All images
└── sw.js             # Service worker
```

### CSS CLASSES (72 total)
**Navigation**: `soap-bar-nav`, `soap-bar`, `soap-bar-link`
**Typography**: `display-1`, `hero-title`, `section-title`, `text-content`
**Components**: `btn-primary`, `card`, `form-group`, `form-control`
**Layout**: `hero-section`, `about-section`, `contact-section`

### JAVASCRIPT FUNCTIONS (15 total)
**Utilities**: `$`, `$$`, `addClass`, `removeClass`, `hasClass`, `toggleClass`
**Core**: `initNavigation()`, `initSoapBarScroll()`, `initAccordion()`, `initForms()`
**Performance**: `initPerformanceMonitoring()`, `initServiceWorker()`, `initLazyLoading()`

### DESIGN TOKENS
```css
--font-family-heading: 'Playfair Display', serif;
--font-family-body: 'Manrope', sans-serif;
--color-primary: #000000;
--color-secondary: #ae301c;
--spacing-1: 0.25rem; /* 4px */
--spacing-4: 1rem;    /* 16px */
```

### COMMON TASKS
1. **Add new section**: `<section class="[name]-section" id="[name]">`
2. **Style component**: Add to `optimized.css` with design tokens
3. **Add functionality**: Add function to `consolidated.js`
4. **Deploy changes**: Run `./scripts/deploy.sh`

### DEPLOYMENT WORKFLOW
```bash
# 1. Edit development files
edit development/index.html
edit development/assets/css/optimized.css

# 2. Test locally
open development/index.html

# 3. Deploy to production
./scripts/deploy.sh
```

## 🎯 THIS FILE IS AUTOMATICALLY READ BY CURSOR AI
