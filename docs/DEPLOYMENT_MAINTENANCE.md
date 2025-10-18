# Deployment and Maintenance Guide

## Westmark Talent Group Website

### Overview

This document provides comprehensive guidance for deploying, maintaining, and troubleshooting the Westmark Talent Group website. It covers the current deployment process, maintenance procedures, and common issues that may arise.

## Current Deployment Architecture

### Hosting Configuration
- **Domain**: `www.westmarktalentgroup.com`
- **Hosting Type**: Static site hosting
- **SSL Certificate**: HTTPS enforcement
- **CDN**: Content delivery network integration
- **Backup**: Automated backup system

### File Structure
```
Production Environment
├── index.html (Homepage)
├── clients.html (Clients page)
├── contact-us.html (Contact page)
├── logo.html (Brand asset distribution page)
├── assets/ (All static assets)
├── CNAME (Domain configuration)
├── robots.txt (SEO configuration)
└── sitemap.xml (Site structure)
```

## Deployment Process

### Current Deployment Workflow

#### 1. Development Phase
```bash
# Local development using Mobirise
1. Open Mobirise Website Builder v6.0.5
2. Load project from local directory
3. Make content and design changes
4. Preview changes in browser
5. Test responsive design and functionality
```

#### 2. Build and Export
```bash
# Export from Mobirise
1. Click "Publish" in Mobirise
2. Select export directory
3. Choose "Publish to local folder"
4. Wait for export completion
5. Verify exported files
```

#### 3. Quality Assurance
```bash
# Pre-deployment testing
1. Test all pages locally
2. Verify responsive design
3. Check form functionality
4. Validate HTML/CSS
5. Test cross-browser compatibility
6. Verify all links and images
```

#### 4. Deployment
```bash
# Deploy to production
1. Upload files to hosting server
2. Verify file permissions
3. Test live site functionality
4. Check SSL certificate
5. Verify domain configuration
6. Test form submissions
```

### Automated Deployment (Recommended)

#### GitHub Actions Workflow
```yaml
name: Deploy Website
on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    
    - name: Setup Node.js
      uses: actions/setup-node@v2
      with:
        node-version: '16'
    
    - name: Install dependencies
      run: npm install
    
    - name: Build project
      run: npm run build
    
    - name: Deploy to hosting
      uses: peaceiris/actions-gh-pages@v3
      with:
        github_token: ${{ secrets.GITHUB_TOKEN }}
        publish_dir: ./dist
```

#### Alternative: Netlify Deployment
```toml
# netlify.toml
[build]
  publish = "dist"
  command = "npm run build"

[build.environment]
  NODE_VERSION = "16"

[[redirects]]
  from = "/*"
  to = "/index.html"
  status = 200
```

## Maintenance Procedures

### Regular Maintenance Schedule

#### Daily Tasks
- [ ] Monitor website uptime
- [ ] Check form submissions
- [ ] Review error logs
- [ ] Monitor performance metrics

#### Weekly Tasks
- [ ] Review Google Analytics data
- [ ] Check for broken links
- [ ] Verify form functionality
- [ ] Monitor page load times

#### Monthly Tasks
- [ ] Update dependencies
- [ ] Review security status
- [ ] Optimize images and assets
- [ ] Update content as needed
- [ ] Review SEO performance

#### Quarterly Tasks
- [ ] Comprehensive security audit
- [ ] Performance optimization review
- [ ] Content strategy review
- [ ] User experience analysis
- [ ] Backup system verification

### Content Updates

#### HTML Content Updates
```bash
# Process for updating content
1. Make changes in Mobirise builder
2. Export updated files
3. Test changes locally
4. Deploy to staging (if available)
5. Deploy to production
6. Verify changes live
```

#### Asset Updates
```bash
# Process for updating assets
1. Prepare new images/assets
2. Optimize for web (compress, resize)
3. Update HTML references
4. Test locally
5. Deploy to production
6. Verify asset loading
```

#### Form Updates
```bash
# Process for updating forms
1. Modify form in Mobirise
2. Update Formoid configuration
3. Test form submission
4. Verify email delivery
5. Deploy to production
6. Test live form
```

## Performance Monitoring

### Core Web Vitals
```javascript
// Google Analytics 4 Core Web Vitals tracking
gtag('event', 'web_vitals', {
  event_category: 'Web Vitals',
  event_label: 'LCP',
  value: Math.round(lcp)
});

gtag('event', 'web_vitals', {
  event_category: 'Web Vitals',
  event_label: 'FID',
  value: Math.round(fid)
});

gtag('event', 'web_vitals', {
  event_category: 'Web Vitals',
  event_label: 'CLS',
  value: Math.round(cls * 1000)
});
```

### Performance Budgets
| Metric | Target | Warning | Critical |
|--------|--------|---------|----------|
| First Contentful Paint | < 1.8s | < 3.0s | > 3.0s |
| Largest Contentful Paint | < 2.5s | < 4.0s | > 4.0s |
| Cumulative Layout Shift | < 0.1 | < 0.25 | > 0.25 |
| First Input Delay | < 100ms | < 300ms | > 300ms |

### Monitoring Tools
- **Google PageSpeed Insights**: Performance scoring
- **Google Search Console**: Core Web Vitals monitoring
- **GTmetrix**: Detailed performance analysis
- **WebPageTest**: Advanced performance testing

## Security Maintenance

### Security Checklist
- [ ] SSL certificate valid and up to date
- [ ] HTTPS enforcement active
- [ ] Content Security Policy implemented
- [ ] External resources validated
- [ ] Form security measures active
- [ ] Dependencies up to date
- [ ] Security headers configured
- [ ] Regular security scans performed

### Security Headers
```http
# Recommended security headers
Strict-Transport-Security: max-age=31536000; includeSubDomains
Content-Security-Policy: default-src 'self'; script-src 'self' 'unsafe-inline' https://www.googletagmanager.com; style-src 'self' 'unsafe-inline' https://fonts.googleapis.com; font-src 'self' https://fonts.gstatic.com; img-src 'self' data: https:; connect-src 'self' https://www.google-analytics.com;
X-Content-Type-Options: nosniff
X-Frame-Options: DENY
X-XSS-Protection: 1; mode=block
Referrer-Policy: strict-origin-when-cross-origin
```

### Vulnerability Scanning
```bash
# Automated security scanning
1. Run OWASP ZAP security scan
2. Check for known vulnerabilities
3. Review dependency security status
4. Monitor security advisories
5. Update vulnerable dependencies
```

## Troubleshooting Guide

### Common Issues and Solutions

#### 1. Website Not Loading
```bash
# Troubleshooting steps
1. Check DNS configuration
2. Verify hosting service status
3. Check SSL certificate
4. Review server error logs
5. Test from different locations
6. Check browser console for errors
```

#### 2. Forms Not Working
```bash
# Troubleshooting steps
1. Verify Formoid configuration
2. Check form action URLs
3. Test form validation
4. Review server error logs
5. Check email delivery settings
6. Test with different browsers
```

#### 3. Images Not Displaying
```bash
# Troubleshooting steps
1. Check file paths and permissions
2. Verify image file integrity
3. Check browser console for 404 errors
4. Test image URLs directly
5. Verify image optimization
6. Check CDN configuration
```

#### 4. Performance Issues
```bash
# Troubleshooting steps
1. Run performance audit
2. Check Core Web Vitals
3. Analyze asset loading
4. Review JavaScript execution
5. Check server response times
6. Optimize critical rendering path
```

#### 5. SEO Issues
```bash
# Troubleshooting steps
1. Check meta tags
2. Verify sitemap accessibility
3. Test robots.txt configuration
4. Review page structure
5. Check for duplicate content
6. Verify schema markup
```

### Error Log Analysis

#### Common Error Codes
```http
# HTTP Status Codes
200 - OK (Success)
301 - Moved Permanently
302 - Found (Temporary Redirect)
404 - Not Found
500 - Internal Server Error
503 - Service Unavailable
```

#### JavaScript Error Handling
```javascript
// Global error handler
window.addEventListener('error', function(e) {
  console.error('JavaScript Error:', e.error);
  
  // Send to analytics
  gtag('event', 'exception', {
    description: e.error.message,
    fatal: false
  });
});

// Unhandled promise rejection
window.addEventListener('unhandledrejection', function(e) {
  console.error('Unhandled Promise Rejection:', e.reason);
  
  // Send to analytics
  gtag('event', 'exception', {
    description: 'Unhandled Promise Rejection: ' + e.reason,
    fatal: false
  });
});
```

## Backup and Recovery

### Backup Strategy
```bash
# Automated backup process
1. Daily: File system backup
2. Weekly: Full system backup
3. Monthly: Configuration backup
4. Quarterly: Complete site backup
5. Before updates: Pre-update backup
```

### Recovery Procedures
```bash
# Site recovery process
1. Identify issue and scope
2. Restore from appropriate backup
3. Verify site functionality
4. Test critical features
5. Monitor for issues
6. Document incident and resolution
```

### Disaster Recovery Plan
```bash
# Disaster recovery steps
1. Assess damage and impact
2. Activate backup systems
3. Restore from off-site backup
4. Verify data integrity
5. Test all functionality
6. Communicate with stakeholders
7. Document lessons learned
```

## Monitoring and Alerting

### Uptime Monitoring
```javascript
// Uptime monitoring setup
const checkUptime = () => {
  fetch('/health-check')
    .then(response => {
      if (!response.ok) {
        // Send alert
        sendAlert('Website down', response.status);
      }
    })
    .catch(error => {
      // Send alert
      sendAlert('Website unreachable', error.message);
    });
};

// Check every 5 minutes
setInterval(checkUptime, 5 * 60 * 1000);
```

### Performance Alerts
```javascript
// Performance monitoring
const monitorPerformance = () => {
  // Monitor Core Web Vitals
  if ('PerformanceObserver' in window) {
    const observer = new PerformanceObserver((list) => {
      for (const entry of list.getEntries()) {
        if (entry.name === 'LCP' && entry.value > 4000) {
          sendAlert('LCP performance issue', entry.value);
        }
      }
    });
    observer.observe({ entryTypes: ['largest-contentful-paint'] });
  }
};
```

## Future Improvements

### Deployment Automation
- **CI/CD Pipeline**: Automated testing and deployment
- **Blue-Green Deployment**: Zero-downtime deployments
- **Rollback Automation**: Automatic rollback on failures
- **Environment Management**: Staging and production environments

### Monitoring Enhancements
- **Real-time Monitoring**: Live performance monitoring
- **Predictive Analytics**: AI-powered issue prediction
- **Automated Alerts**: Smart alerting system
- **Performance Dashboards**: Real-time performance metrics

### Security Improvements
- **Automated Security Scanning**: Continuous security monitoring
- **Threat Detection**: AI-powered threat detection
- **Compliance Monitoring**: Automated compliance checking
- **Security Training**: Regular security awareness training

## Development Environment Architecture

### Complete Asset Dependency Analysis

#### **Core HTML Structure**
The website is built using **Mobirise Website Builder v6.0.5** with a modular architecture that separates content, styling, and functionality into distinct layers:

**HTML Foundation (`index.html`)**:
- **Semantic Structure**: Uses HTML5 semantic elements (`<section>`, `<nav>`, `<article>`) for accessibility and SEO
- **Bootstrap Integration**: Built on Bootstrap 5.1 framework for responsive grid system
- **Mobirise Classes**: Custom CSS classes (`cid-uMOnIuaQSz`, `cid-uMOnIua8FF`) that control specific section styling
- **Data Attributes**: Bootstrap 5.1 data attributes (`data-bs-version="5.1"`) for component functionality

#### **CSS Architecture & Dependencies**

**1. Bootstrap Core (`assets/bootstrap/`)**:
- **`bootstrap.min.css`**: Core Bootstrap framework providing grid system, components, and utilities
- **`bootstrap-grid.min.css`**: Responsive grid system for layout management
- **`bootstrap-reboot.min.css`**: CSS reset and base styling normalization

**2. Mobirise Icon System (`assets/web/assets/mobirise-icons2/`)**:
- **`mobirise2.css`**: Icon font definitions and styling
- **`mobirise2.woff/.ttf/.eot/.svg`**: Icon font files for cross-browser compatibility
- **Purpose**: Provides scalable vector icons for navigation, buttons, and UI elements

**3. Parallax Effects (`assets/parallax/`)**:
- **`jarallax.css`**: CSS for parallax scrolling effects
- **Purpose**: Enables smooth background parallax scrolling in hero sections

**4. Navigation System (`assets/dropdown/`)**:
- **`style.css`**: Custom styling for responsive navigation dropdowns
- **Purpose**: Controls mobile hamburger menu, dropdown behavior, and navigation animations

**5. Icon System (`assets/web/assets/mobirise-icons2/`)**:
- **`mobirise2.css`**: Icon system styling and positioning
- **Purpose**: Provides consistent icon display and hover effects

**6. Theme Customization (`assets/theme/`)**:
- **`style.css`**: Custom website-specific styling and overrides
- **Purpose**: Contains brand colors, typography, and custom component styling

**7. Mobirise Core (`assets/mobirise/`)**:
- **`mbr-additional.css`**: Critical Mobirise-specific styling and layout rules
- **Purpose**: Contains section-specific CSS rules (e.g., `.cid-uMOnIuaQSz` for hero section background)

#### **JavaScript Functionality & Dependencies**

**1. Bootstrap JavaScript (`assets/bootstrap/js/`)**:
- **`bootstrap.bundle.min.js`**: Complete Bootstrap JavaScript including Popper.js
- **Purpose**: Powers interactive components like navigation toggles, modals, and tooltips

**2. Parallax Engine (`assets/parallax/`)**:
- **`jarallax.js`**: JavaScript library for smooth parallax scrolling
- **Purpose**: Controls background image movement during scroll for immersive hero sections

**3. Smooth Scrolling (`assets/smoothscroll/`)**:
- **`smooth-scroll.js`**: Custom smooth scrolling implementation
- **Purpose**: Provides smooth anchor link navigation and scroll animations
- **Status**: ❌ Removed - Unused functionality

**4. Video Player Integration (`assets/ytplayer/`)**:
- **`index.js`**: YouTube video player integration
- **Purpose**: Enables embedded video content with custom controls
- **Status**: ❌ Removed - Unused functionality

**5. Navigation Enhancement (`assets/dropdown/`)**:
- **`navbar-dropdown.js`**: Custom navigation behavior and animations
- **Purpose**: Controls mobile menu behavior, dropdown animations, and responsive navigation

**6. Interactive Elements (`assets/mbr-switch-arrow/`)**:
- **`mbr-switch-arrow.js`**: Toggle and accordion functionality
- **Purpose**: Powers FAQ accordion sections and interactive content toggles
- **Status**: ❌ Removed - Unused functionality

**7. Form Handling (`assets/formoid/`)**:
- **`formoid.min.js`**: Form validation and submission handling
- **Purpose**: Manages contact form validation, submission, and success/error messaging
- **Status**: ❌ Removed - Forms replaced with contact CTAs

**8. Theme Functionality (`assets/theme/js/`)**:
- **`script.js`**: Custom website-specific JavaScript functionality
- **Purpose**: Contains site-specific interactions, animations, and custom behaviors

#### **Image Assets & Media**

**1. Hero Section Images**:
- **`pexels-apasaric-1437493-2000x1333.jpg`**: Main hero background (construction site)
- **Purpose**: Provides the primary visual impact for the landing section

**2. Job Listing Images**:
- **`pexels-pixabay-259588-742x494.jpg`**: Project Manager position (luxury residential)
- **`photo-1567954970774-58d6aa6c50dc-1.jpeg`**: Superintendent position (K-12 schools)
- **`pexels-sevenstormphotography-439416-742x557.jpg`**: Assistant PM position (commercial)
- **`pexels-expect-best-79873-323780-742x478.jpg`**: Senior PM position (luxury residential)
- **Purpose**: Visual representation of job opportunities with relevant construction imagery

**3. Brand Assets**:
- **`westmark-logo-128x62-1.png`**: Favicon and small logo usage
- **`westmark_logo-850x412.png`**: Full-size logo for hero sections
- **`westmarktalentgrouponeliner.svg`**: Vector logo for scalable usage
- **Purpose**: Brand identity and visual recognition across all pages

**4. Meta Images**:
- **`index-meta.png`**: Social media preview for homepage
- **`clients-meta.png`**: Social media preview for clients page
- **`contact-us-meta.png`**: Social media preview for contact page
- **Purpose**: Optimized images for social media sharing and SEO

#### **Font Dependencies**

**1. Google Fonts Integration**:
- **Playfair Display**: Serif font for headings and display text
- **Manrope**: Sans-serif font for body text and UI elements
- **Purpose**: Provides professional typography hierarchy and brand consistency

### Development Environment Setup

#### **Critical Setup Requirements**

**1. Asset Path Resolution**:
The development environment must maintain the exact asset path structure:
```
development/
├── assets/
│   ├── bootstrap/css/          # Bootstrap framework
│   ├── web/assets/mobirise-icons2/  # Icon system
│   ├── parallax/               # Parallax effects
│   ├── dropdown/               # Navigation system
│   ├── web/assets/mobirise-icons2/  # Icon system
│   ├── theme/                  # Custom styling
│   ├── mobirise/               # Core Mobirise styling
│   ├── images/                 # All media assets
│   └── [other asset folders]   # Additional dependencies
```

**2. CSS Loading Order**:
Critical CSS files must load in this specific order:
```html
<!-- 1. Bootstrap Core (Foundation) -->
<link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">

<!-- 2. Mobirise Icon System (Visual elements) -->
<link rel="stylesheet" href="assets/web/assets/mobirise-icons2/mobirise2.css">

<!-- 3. Parallax Effects (Background animations) -->
<link rel="stylesheet" href="assets/parallax/jarallax.css">

<!-- 4. Navigation System (Menu behavior) -->
<link rel="stylesheet" href="assets/dropdown/css/style.css">

<!-- 5. Social Icons (UI elements) -->
<link rel="stylesheet" href="assets/web/assets/mobirise-icons2/mobirise2.css">

<!-- 6. Theme Customization (Brand styling) -->
<link rel="stylesheet" href="assets/theme/css/style.css">

<!-- 7. Mobirise Core (Layout and section styling) -->
<link rel="stylesheet" href="assets/mobirise/css/mbr-additional.css">
```

**3. JavaScript Loading Order**:
JavaScript files must load in this sequence:
```html
<!-- 1. Bootstrap Framework (Component functionality) -->
<script src="assets/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- 2. Parallax Engine (Background effects) -->
<script src="assets/parallax/jarallax.js"></script>

<!-- 3. Navigation System (Menu behavior) -->
<script src="assets/dropdown/js/navbar-dropdown.js"></script>

<!-- 4. Interactive Elements (Accordions, toggles) -->
<script src="assets/mbr-switch-arrow/mbr-switch-arrow.js"></script>

<!-- 5. Form Handling (Contact forms) -->
<script src="assets/formoid/formoid.min.js"></script>

<!-- 6. Theme Functionality (Custom behaviors) -->
<script src="assets/theme/js/script.js"></script>
```

#### **Common Development Issues & Solutions**

**1. Missing Hero Background Image**:
- **Symptom**: Hero section appears as dark grey block
- **Cause**: Missing `mbr-additional.css` or incorrect asset paths
- **Solution**: Ensure `assets/mobirise/css/mbr-additional.css` loads correctly

**2. Navigation Not Responsive**:
- **Symptom**: Mobile menu doesn't work, navigation appears vertical
- **Cause**: Missing `navbar-dropdown.js` or `dropdown/css/style.css`
- **Solution**: Verify all navigation assets are loaded in correct order

**3. Job Cards Not Styled**:
- **Symptom**: Job listings appear as plain boxes without styling
- **Cause**: Missing `mbr-additional.css` or incorrect CSS class references
- **Solution**: Check CSS loading order and verify all Mobirise classes are defined

**4. Forms Not Functional**:
- **Symptom**: Contact form doesn't submit or validate
- **Cause**: Missing `formoid.min.js` or incorrect form configuration
- **Solution**: Ensure Formoid JavaScript is loaded and form has correct data attributes

**5. Images Not Displaying**:
- **Symptom**: Image placeholders or broken image icons
- **Cause**: Incorrect asset paths or missing image files
- **Solution**: Verify image paths relative to HTML file location

### Asset Build Process & Dependencies

#### **How Assets Are Constructed**

**1. CSS Build Process**:
- **Base Layer**: Bootstrap provides foundation grid and components
- **Icon Layer**: Mobirise icon system adds visual elements
- **Effect Layer**: Parallax and animation CSS adds interactivity
- **Navigation Layer**: Custom navigation styling controls menu behavior
- **Theme Layer**: Brand-specific styling and customizations
- **Mobirise Layer**: Section-specific styling and layout rules

**2. JavaScript Build Process**:
- **Framework Layer**: Bootstrap handles component interactions
- **Effect Layer**: Parallax and smooth scrolling add visual appeal
- **Navigation Layer**: Custom navigation behavior and mobile support
- **Interaction Layer**: Accordions, toggles, and form handling
- **Custom Layer**: Site-specific functionality and behaviors

**3. Image Optimization Process**:
- **Source Images**: High-resolution photos from stock photo services
- **Optimization**: Compressed for web delivery while maintaining quality
- **Responsive Versions**: Multiple sizes for different screen densities
- **Format Selection**: JPEG for photos, PNG for graphics, SVG for logos

#### **Dependency Relationships**

**Critical Dependencies** (Site won't function without):
- Bootstrap CSS/JS (layout and components)
- Mobirise core CSS (section styling)
- Navigation assets (menu functionality)

**Functional Dependencies** (Features won't work without):
- Parallax CSS/JS (hero effects)
- Formoid JS (contact forms)
- Icon system (visual elements)

**Enhancement Dependencies** (Improves experience):
- Smooth scrolling (navigation feel)
- Custom theme JS (additional interactions)
- Video player (multimedia content)

---

*This deployment and maintenance guide provides comprehensive information for managing the Westmark Talent Group website. Regular updates to this guide should be performed as processes and procedures evolve. For specific technical questions or issues, please contact the development team.*
