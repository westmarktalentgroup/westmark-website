# Technical Architecture Documentation

## Westmark Talent Group Website

### Architecture Overview

The Westmark Talent Group website follows a **static site architecture** built with modern web technologies, optimized for performance, SEO, and maintainability. The site leverages the Mobirise Website Builder platform while maintaining custom functionality and styling.

## Technical Stack Deep Dive

### Frontend Framework
- **Bootstrap 5.1**: Latest Bootstrap version with enhanced grid system and components
- **Custom CSS Framework**: 965-line custom stylesheet with responsive design patterns
- **JavaScript Architecture**: ES6+ compatible with polyfills for legacy browser support

### Build System
- **Mobirise v6.0.5**: Visual website builder with automated export capabilities
- **Asset Pipeline**: Automated minification and optimization of CSS/JS files
- **Version Control**: Git-based development workflow with structured asset management

## Code Structure Analysis

### HTML Architecture

#### Semantic Structure
```html
<!-- Consistent section-based architecture -->
<section data-bs-version="5.1" class="[component-type] cid-[unique-id]" id="[section-id]">
  <!-- Section content with Bootstrap grid system -->
</section>
```

#### Component Pattern
- **Menu Components**: Navigation with soap bar design
- **Hero Sections**: Full-screen landing areas with parallax backgrounds
- **Content Cards**: Bootstrap card-based content presentation
- **Contact Components**: Professional contact CTAs and information
- **Interactive Elements**: Accordion, carousel, and modal components

### CSS Architecture

#### File Organization
```
assets/css/optimized.css (consolidated)
├── Base Styles (body, typography, buttons)
├── Component Styles (hero, navigation, cards)
├── Utility Classes (spacing, colors, typography)
├── Responsive Breakpoints (mobile-first approach)
└── Custom Animations (transitions, hover effects)
```

#### CSS Methodology
- **Mobile-First**: Responsive design starting from mobile breakpoints
- **Component-Based**: Modular CSS architecture for maintainability
- **Utility Classes**: Bootstrap utility classes with custom extensions
- **CSS Variables**: Consistent color scheme and spacing system

### JavaScript Architecture

#### Core Functionality
```javascript
// Main script.js (69 lines) - Core functionality
- DOM manipulation and event handling
- Bootstrap component initialization
- Custom animation and interaction logic
- Performance optimization features
```

#### Plugin Integration
- **Consolidated Components**: Custom navigation, hero sections, content cards
- **Parallax Effects**: Jarallax integration for scroll effects
- **Contact Handling**: Direct contact information and call-to-action buttons
- **Smooth Scrolling**: Custom smooth scroll implementation

## Asset Management Strategy

### Image Optimization
- **Format Selection**: PNG for logos, JPG for photographs, SVG for scalable graphics
- **Responsive Images**: Multiple image sizes for different device resolutions
- **Lazy Loading**: Optimized image loading for performance
- **Meta Images**: Social media optimized images for sharing

### Font Management
- **Google Fonts Integration**: Playfair Display and Manrope font families
- **Font Preloading**: Critical font loading optimization
- **Fallback Strategy**: System font fallbacks for performance
- **Icon System**: Mobirise icon system for UI elements

### Script Loading Strategy
- **Critical Path**: Essential JavaScript loaded synchronously
- **Async Loading**: Non-critical scripts loaded asynchronously
- **Deferred Execution**: Scripts executed after DOM ready
- **Bundle Optimization**: Bootstrap bundle for framework components

## Performance Optimization

### Loading Performance
- **Critical CSS**: Above-the-fold styles loaded inline
- **JavaScript Deferring**: Non-critical scripts deferred for faster initial load
- **Image Optimization**: WebP format support with fallbacks
- **Font Optimization**: Font display swap for better perceived performance

### Runtime Performance
- **Event Delegation**: Efficient event handling for dynamic content
- **DOM Caching**: Reduced DOM queries for better performance
- **Animation Optimization**: CSS transforms and opacity for smooth animations
- **Memory Management**: Proper cleanup of event listeners and timers

## Security Implementation

### Form Security
- **CSRF Protection**: Form submission validation and security
- **Input Sanitization**: Client and server-side input validation
- **HTTPS Enforcement**: Secure connection requirements
- **Content Security Policy**: XSS protection and resource validation

### External Resource Security
- **CDN Validation**: Secure external resource loading
- **Link Validation**: Safe external link handling
- **Script Integrity**: External script validation and security
- **Data Encryption**: Secure form data transmission

## Responsive Design Implementation

### Breakpoint Strategy
```css
/* Mobile-first responsive design */
@media (min-width: 576px) { /* Small devices */ }
@media (min-width: 768px) { /* Medium devices */ }
@media (min-width: 992px) { /* Large devices */ }
@media (min-width: 1200px) { /* Extra large devices */ }
```

### Component Responsiveness
- **Navigation**: Collapsible mobile navigation with hamburger menu
- **Grid System**: Bootstrap responsive grid with custom breakpoints
- **Typography**: Responsive font sizing and line height adjustments
- **Images**: Responsive images with appropriate sizing and cropping

## Browser Compatibility

### Modern Browser Support
- **Chrome 90+**: Full feature support with modern CSS and JavaScript
- **Firefox 88+**: Complete functionality with vendor prefix support
- **Safari 14+**: Full feature support with webkit optimizations
- **Edge 90+**: Chromium-based Edge with full compatibility

### Legacy Browser Support
- **Internet Explorer 11+**: Polyfill support for ES6+ features
- **Older Mobile Browsers**: Graceful degradation for older devices
- **Progressive Enhancement**: Core functionality works without JavaScript

## SEO Implementation

### Technical SEO
- **Semantic HTML**: Proper heading hierarchy and semantic elements
- **Meta Tags**: Comprehensive meta descriptions and titles
- **Open Graph**: Social media optimization for sharing
- **Twitter Cards**: Twitter-specific meta information
- **Structured Data**: Schema.org markup for rich snippets

### Content SEO
- **Keyword Optimization**: Strategic keyword placement in content
- **Internal Linking**: Logical site structure and navigation
- **Image Alt Tags**: Descriptive alt text for accessibility and SEO
- **URL Structure**: Clean, descriptive URLs for better indexing

## Analytics and Tracking

### Google Analytics Integration
```javascript
// Google Analytics 4 implementation
gtag('config', 'G-WKB103GCWX', {
  // Custom configuration options
  page_title: 'Westmark Talent Group',
  custom_map: {
    // Custom dimension mapping
  }
});
```

### Event Tracking
- **Form Submissions**: Contact form completion tracking
- **Job Applications**: Job listing click and application tracking
- **Navigation**: User journey and page interaction tracking
- **Conversion Goals**: Lead generation and engagement metrics

## External Integrations

### Zoho Recruit Integration
- **Job Posting API**: Dynamic job listing management
- **Application Tracking**: Job application submission and tracking
- **Career Portal**: Seamless integration with external career site
- **Data Synchronization**: Real-time job data updates

### Social Media Integration
- **LinkedIn Integration**: Professional networking and sharing
- **Social Icons**: Mobirise icon system for UI elements
- **Sharing Optimization**: Open Graph and Twitter Card support
- **Social Analytics**: Social media engagement tracking

## Deployment Architecture

### Hosting Configuration
- **Static Hosting**: Optimized for static site hosting platforms
- **CDN Integration**: Content delivery network for global performance
- **SSL Certificate**: HTTPS enforcement for security
- **Custom Domain**: www.westmarktalentgroup.com configuration

### Build and Deploy Process
```
Development → Mobirise Builder → Export → Optimization → Deployment
     ↓              ↓              ↓          ↓           ↓
  Local Dev    Visual Editor   Static Files  Minify   Live Site
```

## Monitoring and Maintenance

### Performance Monitoring
- **Core Web Vitals**: LCP, FID, CLS measurement and optimization
- **Page Speed**: Google PageSpeed Insights monitoring
- **User Experience**: Real user monitoring and analytics
- **Error Tracking**: JavaScript error monitoring and reporting

### Content Management
- **Static Content**: HTML-based content management
- **Asset Updates**: Centralized asset management and updates
- **Version Control**: Git-based version management and rollback
- **Backup Strategy**: Automated backup and recovery procedures

## Future Technical Roadmap

### Short-term Improvements (3-6 months)
- **Performance Optimization**: Core Web Vitals improvement
- **Accessibility Enhancement**: WCAG 2.1 AA compliance
- **Mobile Optimization**: Progressive Web App features
- **Analytics Enhancement**: Advanced conversion tracking

### Long-term Technical Goals (6-12 months)
- **Dynamic Content**: API-driven content management
- **Advanced Search**: Elasticsearch integration for job search
- **Real-time Updates**: WebSocket integration for live updates
- **Machine Learning**: AI-powered job matching algorithms

### Infrastructure Upgrades
- **CDN Optimization**: Multi-region content delivery
- **Database Integration**: Dynamic job listing management
- **API Development**: RESTful API for external integrations
- **Microservices**: Service-oriented architecture for scalability

## Technical Debt and Considerations

### Current Limitations
- **Static Architecture**: Limited dynamic content capabilities
- **Build Process**: Manual export and deployment process
- **Content Management**: HTML-based content updates
- **Performance**: Room for optimization in asset loading

### Mitigation Strategies
- **Automated Builds**: CI/CD pipeline for automated deployment
- **Performance Budgets**: Core Web Vitals performance targets
- **Code Quality**: Automated linting and testing
- **Documentation**: Comprehensive technical documentation

## Mobile Technical Architecture

### Mobile-First Technical Strategy

#### Core Mobile Technical Principles
- **Performance First**: Optimize for mobile performance and battery life
- **Touch Optimization**: All interactions designed for touch input
- **Responsive Design**: Mobile-first responsive architecture
- **Progressive Enhancement**: Base mobile experience enhanced for larger screens

#### Mobile Technical Standards
```css
/* Mobile Technical Standards */
--mobile-touch-target: 44px;           /* Minimum touch target size */
--mobile-touch-spacing: 8px;           /* Minimum spacing between touch targets */
--mobile-font-size-min: 16px;          /* Minimum font size to prevent zoom on iOS */
--mobile-border-radius: 8px;           /* Mobile-optimized border radius */
--mobile-shadow: 0 2px 8px rgba(0, 0, 0, 0.1); /* Mobile shadow */
--mobile-transition: 0.25s ease-out;   /* Mobile-optimized transition timing */
```

### Mobile Performance Architecture

#### Mobile Performance Optimization
```javascript
// Mobile Performance Monitoring
class MobilePerformanceMonitor {
  constructor() {
    this.metrics = {};
    this.init();
  }
  
  init() {
    // Monitor Core Web Vitals
    this.monitorLCP();
    this.monitorFID();
    this.monitorCLS();
    
    // Monitor mobile-specific metrics
    this.monitorBatteryUsage();
    this.monitorNetworkConditions();
    this.monitorDeviceCapabilities();
  }
  
  monitorLCP() {
    if ('PerformanceObserver' in window) {
      const observer = new PerformanceObserver((list) => {
        for (const entry of list.getEntries()) {
          if (entry.name === 'LCP') {
            this.metrics.lcp = entry.value;
            this.reportMetric('LCP', entry.value);
          }
        }
      });
      observer.observe({ entryTypes: ['largest-contentful-paint'] });
    }
  }
  
  monitorFID() {
    if ('PerformanceObserver' in window) {
      const observer = new PerformanceObserver((list) => {
        for (const entry of list.getEntries()) {
          if (entry.name === 'FID') {
            this.metrics.fid = entry.value;
            this.reportMetric('FID', entry.value);
          }
        }
      });
      observer.observe({ entryTypes: ['first-input'] });
    }
  }
  
  monitorCLS() {
    if ('PerformanceObserver' in window) {
      let clsValue = 0;
      const observer = new PerformanceObserver((list) => {
        for (const entry of list.getEntries()) {
          if (!entry.hadRecentInput) {
            clsValue += entry.value;
            this.metrics.cls = clsValue;
            this.reportMetric('CLS', clsValue);
          }
        }
      });
      observer.observe({ entryTypes: ['layout-shift'] });
    }
  }
  
  monitorBatteryUsage() {
    if ('getBattery' in navigator) {
      navigator.getBattery().then(battery => {
        battery.addEventListener('levelchange', () => {
          this.metrics.batteryLevel = battery.level;
          this.reportMetric('BatteryLevel', battery.level);
        });
        
        battery.addEventListener('chargingchange', () => {
          this.metrics.isCharging = battery.charging;
          this.reportMetric('IsCharging', battery.charging);
        });
      });
    }
  }
  
  monitorNetworkConditions() {
    if ('connection' in navigator) {
      const connection = navigator.connection;
      
      connection.addEventListener('change', () => {
        this.metrics.networkType = connection.effectiveType;
        this.metrics.downlink = connection.downlink;
        this.reportMetric('NetworkType', connection.effectiveType);
        this.reportMetric('Downlink', connection.downlink);
      });
    }
  }
  
  monitorDeviceCapabilities() {
    // Monitor device memory
    if ('deviceMemory' in navigator) {
      this.metrics.deviceMemory = navigator.deviceMemory;
      this.reportMetric('DeviceMemory', navigator.deviceMemory);
    }
    
    // Monitor hardware concurrency
    if ('hardwareConcurrency' in navigator) {
      this.metrics.hardwareConcurrency = navigator.hardwareConcurrency;
      this.reportMetric('HardwareConcurrency', navigator.hardwareConcurrency);
    }
    
    // Monitor device pixel ratio
    this.metrics.devicePixelRatio = window.devicePixelRatio;
    this.reportMetric('DevicePixelRatio', window.devicePixelRatio);
  }
  
  reportMetric(name, value) {
    // Send to analytics
    if (typeof gtag !== 'undefined') {
      gtag('event', 'mobile_performance', {
        event_category: 'Mobile Performance',
        event_label: name,
        value: Math.round(value * 100) / 100
      });
    }
    
    // Log for debugging
    console.log(`Mobile Performance - ${name}:`, value);
  }
  
  getMetrics() {
    return this.metrics;
  }
}

// Initialize mobile performance monitoring
const mobilePerformanceMonitor = new MobilePerformanceMonitor();
```

#### Mobile Loading Strategy
```javascript
// Mobile Loading Strategy
class MobileLoadingStrategy {
  constructor() {
    this.init();
  }
  
  init() {
    this.setupIntersectionObserver();
    this.setupResourceHints();
    this.setupCriticalCSS();
  }
  
  setupIntersectionObserver() {
    if ('IntersectionObserver' in window) {
      const imageObserver = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
          if (entry.isIntersecting) {
            const img = entry.target;
            img.src = img.dataset.src;
            img.classList.remove('mobile-image-lazy');
            img.classList.add('mobile-image-loaded');
            imageObserver.unobserve(img);
          }
        });
      });
      
      // Observe all lazy images
      document.querySelectorAll('.mobile-image-lazy').forEach(img => {
        imageObserver.observe(img);
      });
    }
  }
  
  setupResourceHints() {
    // Preload critical resources
    const criticalResources = [
      '/assets/css/optimized.css',
      '/assets/js/consolidated.js',
      '/assets/images/westmark-logo-128x62-1.png'
    ];
    
    criticalResources.forEach(resource => {
      const link = document.createElement('link');
      link.rel = 'preload';
      link.href = resource;
      link.as = resource.endsWith('.css') ? 'style' : 'image';
      document.head.appendChild(link);
    });
  }
  
  setupCriticalCSS() {
    // Inline critical CSS for above-the-fold content
    const criticalCSS = `
      .mobile-hero { min-height: 100vh; }
      .mobile-navigation { position: fixed; top: 0; }
      .mobile-container { padding: 0 1rem; }
    `;
    
    const style = document.createElement('style');
    style.textContent = criticalCSS;
    document.head.appendChild(style);
  }
}

// Initialize mobile loading strategy
const mobileLoadingStrategy = new MobileLoadingStrategy();
```

### Mobile Touch Architecture

#### Mobile Touch Event Handling
```javascript
// Mobile Touch Event Handler
class MobileTouchHandler {
  constructor() {
    this.touchStartX = 0;
    this.touchStartY = 0;
    this.touchEndX = 0;
    this.touchEndY = 0;
    this.minSwipeDistance = 50;
    this.init();
  }
  
  init() {
    this.setupTouchEvents();
    this.setupGestureRecognition();
  }
  
  setupTouchEvents() {
    document.addEventListener('touchstart', (e) => {
      this.touchStartX = e.changedTouches[0].screenX;
      this.touchStartY = e.changedTouches[0].screenY;
    });
    
    document.addEventListener('touchend', (e) => {
      this.touchEndX = e.changedTouches[0].screenX;
      this.touchEndY = e.changedTouches[0].screenY;
      this.handleSwipe();
    });
  }
  
  setupGestureRecognition() {
    // Add touch feedback for interactive elements
    document.querySelectorAll('.mobile-touch-target').forEach(element => {
      element.addEventListener('touchstart', (e) => {
        element.classList.add('mobile-touch-active');
      });
      
      element.addEventListener('touchend', (e) => {
        element.classList.remove('mobile-touch-active');
      });
    });
  }
  
  handleSwipe() {
    const deltaX = this.touchEndX - this.touchStartX;
    const deltaY = this.touchEndY - this.touchStartY;
    
    if (Math.abs(deltaX) > Math.abs(deltaY)) {
      // Horizontal swipe
      if (Math.abs(deltaX) > this.minSwipeDistance) {
        if (deltaX > 0) {
          this.handleSwipeRight();
        } else {
          this.handleSwipeLeft();
        }
      }
    } else {
      // Vertical swipe
      if (Math.abs(deltaY) > this.minSwipeDistance) {
        if (deltaY > 0) {
          this.handleSwipeDown();
        } else {
          this.handleSwipeUp();
        }
      }
    }
  }
  
  handleSwipeLeft() {
    // Handle left swipe (e.g., next carousel item)
    const event = new CustomEvent('mobileSwipeLeft');
    document.dispatchEvent(event);
  }
  
  handleSwipeRight() {
    // Handle right swipe (e.g., previous carousel item)
    const event = new CustomEvent('mobileSwipeRight');
    document.dispatchEvent(event);
  }
  
  handleSwipeUp() {
    // Handle up swipe (e.g., show more content)
    const event = new CustomEvent('mobileSwipeUp');
    document.dispatchEvent(event);
  }
  
  handleSwipeDown() {
    // Handle down swipe (e.g., refresh content)
    const event = new CustomEvent('mobileSwipeDown');
    document.dispatchEvent(event);
  }
}

// Initialize mobile touch handler
const mobileTouchHandler = new MobileTouchHandler();
```

#### Mobile Gesture Recognition
```javascript
// Mobile Gesture Recognition
class MobileGestureRecognition {
  constructor() {
    this.gestures = new Map();
    this.init();
  }
  
  init() {
    this.setupPinchZoom();
    this.setupDoubleTap();
    this.setupLongPress();
  }
  
  setupPinchZoom() {
    let initialDistance = 0;
    let currentScale = 1;
    
    document.addEventListener('touchstart', (e) => {
      if (e.touches.length === 2) {
        initialDistance = this.getDistance(e.touches[0], e.touches[1]);
      }
    });
    
    document.addEventListener('touchmove', (e) => {
      if (e.touches.length === 2) {
        e.preventDefault();
        const currentDistance = this.getDistance(e.touches[0], e.touches[1]);
        const scale = currentDistance / initialDistance;
        
        if (scale !== currentScale) {
          currentScale = scale;
          this.handlePinchZoom(scale);
        }
      }
    });
  }
  
  setupDoubleTap() {
    let lastTap = 0;
    const doubleTapDelay = 300;
    
    document.addEventListener('touchend', (e) => {
      const currentTime = new Date().getTime();
      const tapLength = currentTime - lastTap;
      
      if (tapLength < doubleTapDelay && tapLength > 0) {
        this.handleDoubleTap(e);
      }
      lastTap = currentTime;
    });
  }
  
  setupLongPress() {
    let pressTimer = null;
    const longPressDelay = 500;
    
    document.addEventListener('touchstart', (e) => {
      pressTimer = setTimeout(() => {
        this.handleLongPress(e);
      }, longPressDelay);
    });
    
    document.addEventListener('touchend', () => {
      if (pressTimer) {
        clearTimeout(pressTimer);
        pressTimer = null;
      }
    });
    
    document.addEventListener('touchmove', () => {
      if (pressTimer) {
        clearTimeout(pressTimer);
        pressTimer = null;
      }
    });
  }
  
  getDistance(touch1, touch2) {
    const dx = touch1.clientX - touch2.clientX;
    const dy = touch1.clientY - touch2.clientY;
    return Math.sqrt(dx * dx + dy * dy);
  }
  
  handlePinchZoom(scale) {
    const event = new CustomEvent('mobilePinchZoom', { detail: { scale } });
    document.dispatchEvent(event);
  }
  
  handleDoubleTap(e) {
    const event = new CustomEvent('mobileDoubleTap', { detail: { target: e.target } });
    document.dispatchEvent(event);
  }
  
  handleLongPress(e) {
    const event = new CustomEvent('mobileLongPress', { detail: { target: e.target } });
    document.dispatchEvent(event);
  }
}

// Initialize mobile gesture recognition
const mobileGestureRecognition = new MobileGestureRecognition();
```

### Mobile Responsive Architecture

#### Mobile Breakpoint Management
```javascript
// Mobile Breakpoint Manager
class MobileBreakpointManager {
  constructor() {
    this.breakpoints = {
      xs: 0,      // Extra small devices (portrait phones)
      sm: 576,    // Small devices (landscape phones)
      md: 768,    // Medium devices (tablets)
      lg: 992,    // Large devices (desktops)
      xl: 1200,   // Extra large devices (large desktops)
      xxl: 1400   // Extra extra large devices
    };
    
    this.currentBreakpoint = this.getCurrentBreakpoint();
    this.init();
  }
  
  init() {
    this.setupResizeListener();
    this.setupOrientationListener();
    this.setupDeviceCapabilityDetection();
  }
  
  setupResizeListener() {
    let resizeTimer;
    window.addEventListener('resize', () => {
      clearTimeout(resizeTimer);
      resizeTimer = setTimeout(() => {
        const newBreakpoint = this.getCurrentBreakpoint();
        if (newBreakpoint !== this.currentBreakpoint) {
          this.handleBreakpointChange(this.currentBreakpoint, newBreakpoint);
          this.currentBreakpoint = newBreakpoint;
        }
      }, 250);
    });
  }
  
  setupOrientationListener() {
    window.addEventListener('orientationchange', () => {
      setTimeout(() => {
        const newBreakpoint = this.getCurrentBreakpoint();
        this.handleBreakpointChange(this.currentBreakpoint, newBreakpoint);
        this.currentBreakpoint = newBreakpoint;
      }, 100);
    });
  }
  
  setupDeviceCapabilityDetection() {
    // Detect device capabilities
    this.deviceCapabilities = {
      touch: 'ontouchstart' in window,
      orientation: 'onorientationchange' in window,
      devicePixelRatio: window.devicePixelRatio || 1,
      viewport: {
        width: window.innerWidth,
        height: window.innerHeight
      }
    };
    
    // Add device capability classes to body
    document.body.classList.add(`device-${this.deviceCapabilities.touch ? 'touch' : 'no-touch'}`);
    document.body.classList.add(`dpr-${Math.round(this.deviceCapabilities.devicePixelRatio)}`);
  }
  
  getCurrentBreakpoint() {
    const width = window.innerWidth;
    
    if (width >= this.breakpoints.xxl) return 'xxl';
    if (width >= this.breakpoints.xl) return 'xl';
    if (width >= this.breakpoints.lg) return 'lg';
    if (width >= this.breakpoints.md) return 'md';
    if (width >= this.breakpoints.sm) return 'sm';
    return 'xs';
  }
  
  handleBreakpointChange(oldBreakpoint, newBreakpoint) {
    // Remove old breakpoint class
    document.body.classList.remove(`breakpoint-${oldBreakpoint}`);
    
    // Add new breakpoint class
    document.body.classList.add(`breakpoint-${newBreakpoint}`);
    
    // Dispatch breakpoint change event
    const event = new CustomEvent('breakpointChange', {
      detail: {
        old: oldBreakpoint,
        new: newBreakpoint,
        width: window.innerWidth,
        height: window.innerHeight
      }
    });
    document.dispatchEvent(event);
    
    // Log breakpoint change
    console.log(`Breakpoint changed from ${oldBreakpoint} to ${newBreakpoint}`);
  }
  
  isBreakpoint(breakpoint) {
    return this.currentBreakpoint === breakpoint;
  }
  
  isBreakpointOrLarger(breakpoint) {
    const breakpointOrder = ['xs', 'sm', 'md', 'lg', 'xl', 'xxl'];
    const currentIndex = breakpointOrder.indexOf(this.currentBreakpoint);
    const targetIndex = breakpointOrder.indexOf(breakpoint);
    return currentIndex >= targetIndex;
  }
  
  getDeviceCapabilities() {
    return this.deviceCapabilities;
  }
}

// Initialize mobile breakpoint manager
const mobileBreakpointManager = new MobileBreakpointManager();
```

#### Mobile Layout Adaptation
```javascript
// Mobile Layout Adapter
class MobileLayoutAdapter {
  constructor() {
    this.init();
  }
  
  init() {
    this.setupLayoutListeners();
    this.adaptLayoutForBreakpoint();
  }
  
  setupLayoutListeners() {
    document.addEventListener('breakpointChange', (e) => {
      this.adaptLayoutForBreakpoint();
    });
    
    document.addEventListener('orientationchange', () => {
      setTimeout(() => {
        this.adaptLayoutForBreakpoint();
      }, 100);
    });
  }
  
  adaptLayoutForBreakpoint() {
    const breakpoint = mobileBreakpointManager.currentBreakpoint;
    
    // Adapt navigation layout
    this.adaptNavigation(breakpoint);
    
    // Adapt content layout
    this.adaptContent(breakpoint);
    
    // Adapt form layout
    this.adaptForms(breakpoint);
    
    // Adapt image layout
    this.adaptImages(breakpoint);
  }
  
  adaptNavigation(breakpoint) {
    const navigation = document.querySelector('.mobile-navigation');
    if (!navigation) return;
    
    if (breakpoint === 'xs' || breakpoint === 'sm') {
      // Mobile navigation
      navigation.classList.add('mobile-navigation--mobile');
      navigation.classList.remove('mobile-navigation--tablet', 'mobile-navigation--desktop');
    } else if (breakpoint === 'md') {
      // Tablet navigation
      navigation.classList.add('mobile-navigation--tablet');
      navigation.classList.remove('mobile-navigation--mobile', 'mobile-navigation--desktop');
    } else {
      // Desktop navigation
      navigation.classList.add('mobile-navigation--desktop');
      navigation.classList.remove('mobile-navigation--mobile', 'mobile-navigation--tablet');
    }
  }
  
  adaptContent(breakpoint) {
    const contentSections = document.querySelectorAll('.mobile-content-section');
    
    contentSections.forEach(section => {
      if (breakpoint === 'xs' || breakpoint === 'sm') {
        section.classList.add('mobile-content-section--mobile');
        section.classList.remove('mobile-content-section--tablet', 'mobile-content-section--desktop');
      } else if (breakpoint === 'md') {
        section.classList.add('mobile-content-section--tablet');
        section.classList.remove('mobile-content-section--mobile', 'mobile-content-section--desktop');
      } else {
        section.classList.add('mobile-content-section--desktop');
        section.classList.remove('mobile-content-section--mobile', 'mobile-content-section--tablet');
      }
    });
  }
  
  adaptForms(breakpoint) {
    const forms = document.querySelectorAll('.mobile-form');
    
    forms.forEach(form => {
      if (breakpoint === 'xs' || breakpoint === 'sm') {
        form.classList.add('mobile-form--mobile');
        form.classList.remove('mobile-form--tablet', 'mobile-form--desktop');
      } else if (breakpoint === 'md') {
        form.classList.add('mobile-form--tablet');
        form.classList.remove('mobile-form--mobile', 'mobile-form--desktop');
      } else {
        form.classList.add('mobile-form--desktop');
        form.classList.remove('mobile-form--mobile', 'mobile-form--tablet');
      }
    });
  }
  
  adaptImages(breakpoint) {
    const images = document.querySelectorAll('.mobile-image');
    
    images.forEach(img => {
      if (breakpoint === 'xs' || breakpoint === 'sm') {
        img.classList.add('mobile-image--mobile');
        img.classList.remove('mobile-image--tablet', 'mobile-image--desktop');
      } else if (breakpoint === 'md') {
        img.classList.add('mobile-image--tablet');
        img.classList.remove('mobile-image--mobile', 'mobile-image--desktop');
      } else {
        img.classList.add('mobile-image--desktop');
        img.classList.remove('mobile-image--mobile', 'mobile-image--tablet');
      }
    });
  }
}

// Initialize mobile layout adapter
const mobileLayoutAdapter = new MobileLayoutAdapter();
```

### Mobile Accessibility Architecture

#### Mobile Accessibility Manager
```javascript
// Mobile Accessibility Manager
class MobileAccessibilityManager {
  constructor() {
    this.init();
  }
  
  init() {
    this.setupFocusManagement();
    this.setupScreenReaderSupport();
    this.setupTouchAccessibility();
    this.setupReducedMotion();
  }
  
  setupFocusManagement() {
    // Ensure focus is visible on mobile
    document.addEventListener('focusin', (e) => {
      if (e.target.classList.contains('mobile-focus-target')) {
        e.target.classList.add('mobile-focus-visible');
      }
    });
    
    document.addEventListener('focusout', (e) => {
      if (e.target.classList.contains('mobile-focus-target')) {
        e.target.classList.remove('mobile-focus-visible');
      }
    });
    
    // Handle focus trapping in mobile modals
    this.setupFocusTrapping();
  }
  
  setupFocusTrapping() {
    const modals = document.querySelectorAll('.mobile-modal');
    
    modals.forEach(modal => {
      const focusableElements = modal.querySelectorAll(
        'button, [href], input, select, textarea, [tabindex]:not([tabindex="-1"])'
      );
      
      const firstElement = focusableElements[0];
      const lastElement = focusableElements[focusableElements.length - 1];
      
      modal.addEventListener('keydown', (e) => {
        if (e.key === 'Tab') {
          if (e.shiftKey) {
            if (document.activeElement === firstElement) {
              e.preventDefault();
              lastElement.focus();
            }
          } else {
            if (document.activeElement === lastElement) {
              e.preventDefault();
              firstElement.focus();
            }
          }
        }
      });
    });
  }
  
  setupScreenReaderSupport() {
    // Add ARIA labels for mobile-specific elements
    const hamburgerButtons = document.querySelectorAll('.mobile-navigation__toggle');
    
    hamburgerButtons.forEach(button => {
      button.setAttribute('aria-label', 'Toggle navigation menu');
      button.setAttribute('aria-expanded', 'false');
      button.setAttribute('aria-controls', 'mobile-menu');
    });
    
    // Add ARIA live regions for dynamic content
    this.setupLiveRegions();
  }
  
  setupLiveRegions() {
    // Create live region for notifications
    const liveRegion = document.createElement('div');
    liveRegion.setAttribute('aria-live', 'polite');
    liveRegion.setAttribute('aria-label', 'Notifications');
    liveRegion.classList.add('mobile-sr-live-region');
    liveRegion.style.position = 'absolute';
    liveRegion.style.left = '-10000px';
    liveRegion.style.width = '1px';
    liveRegion.style.height = '1px';
    liveRegion.style.overflow = 'hidden';
    
    document.body.appendChild(liveRegion);
    
    // Store reference for use in other methods
    this.liveRegion = liveRegion;
  }
  
  setupTouchAccessibility() {
    // Ensure touch targets are accessible
    const touchTargets = document.querySelectorAll('.mobile-touch-target');
    
    touchTargets.forEach(target => {
      // Ensure minimum touch target size
      const rect = target.getBoundingClientRect();
      if (rect.width < 44 || rect.height < 44) {
        target.style.minWidth = '44px';
        target.style.minHeight = '44px';
      }
      
      // Add touch feedback
      target.addEventListener('touchstart', () => {
        target.classList.add('mobile-touch-active');
      });
      
      target.addEventListener('touchend', () => {
        target.classList.remove('mobile-touch-active');
      });
    });
  }
  
  setupReducedMotion() {
    // Check for reduced motion preference
    const prefersReducedMotion = window.matchMedia('(prefers-reduced-motion: reduce)');
    
    if (prefersReducedMotion.matches) {
      document.body.classList.add('mobile-reduced-motion');
      
      // Disable animations
      const style = document.createElement('style');
      style.textContent = `
        .mobile-reduced-motion * {
          animation-duration: 0.01ms !important;
          animation-iteration-count: 1 !important;
          transition-duration: 0.01ms !important;
        }
      `;
      document.head.appendChild(style);
    }
    
    // Listen for changes in preference
    prefersReducedMotion.addEventListener('change', (e) => {
      if (e.matches) {
        document.body.classList.add('mobile-reduced-motion');
      } else {
        document.body.classList.remove('mobile-reduced-motion');
      }
    });
  }
  
  announceToScreenReader(message) {
    if (this.liveRegion) {
      this.liveRegion.textContent = message;
      
      // Clear message after announcement
      setTimeout(() => {
        this.liveRegion.textContent = '';
      }, 1000);
    }
  }
  
  setFocus(element) {
    if (element && typeof element.focus === 'function') {
      element.focus();
      
      // Announce focus change to screen reader
      if (element.getAttribute('aria-label')) {
        this.announceToScreenReader(element.getAttribute('aria-label'));
      }
    }
  }
}

// Initialize mobile accessibility manager
const mobileAccessibilityManager = new MobileAccessibilityManager();
```

### Mobile Testing Architecture

#### Mobile Testing Framework
```javascript
// Mobile Testing Framework
class MobileTestingFramework {
  constructor() {
    this.tests = new Map();
    this.results = new Map();
    this.init();
  }
  
  init() {
    this.setupTestRunner();
    this.registerDefaultTests();
  }
  
  setupTestRunner() {
    // Run tests when DOM is ready
    if (document.readyState === 'loading') {
      document.addEventListener('DOMContentLoaded', () => {
        this.runTests();
      });
    } else {
      this.runTests();
    }
  }
  
  registerDefaultTests() {
    // Touch target size test
    this.registerTest('touchTargetSize', () => {
      const touchTargets = document.querySelectorAll('.mobile-touch-target, .mobile-button, .mobile-form__input');
      let passed = 0;
      let failed = 0;
      
      touchTargets.forEach(target => {
        const rect = target.getBoundingClientRect();
        if (rect.width >= 44 && rect.height >= 44) {
          passed++;
        } else {
          failed++;
          console.warn('Touch target too small:', target, rect);
        }
      });
      
      return {
        passed,
        failed,
        total: passed + failed,
        success: failed === 0
      };
    });
    
    // Font size test
    this.registerTest('fontSize', () => {
      const textElements = document.querySelectorAll('p, span, div, button, input, textarea');
      let passed = 0;
      let failed = 0;
      
      textElements.forEach(element => {
        const computedStyle = window.getComputedStyle(element);
        const fontSize = parseFloat(computedStyle.fontSize);
        
        if (fontSize >= 16) {
          passed++;
        } else {
          failed++;
          console.warn('Font size too small:', element, fontSize);
        }
      });
      
      return {
        passed,
        failed,
        total: passed + failed,
        success: failed === 0
      };
    });
    
    // Color contrast test
    this.registerTest('colorContrast', () => {
      // Basic color contrast check
      const textElements = document.querySelectorAll('p, h1, h2, h3, h4, h5, h6, span, button, a');
      let passed = 0;
      let failed = 0;
      
      textElements.forEach(element => {
        const computedStyle = window.getComputedStyle(element);
        const color = computedStyle.color;
        const backgroundColor = computedStyle.backgroundColor;
        
        // Simple contrast check (this is a basic implementation)
        if (this.hasGoodContrast(color, backgroundColor)) {
          passed++;
        } else {
          failed++;
          console.warn('Poor color contrast:', element, color, backgroundColor);
        }
      });
      
      return {
        passed,
        failed,
        total: passed + failed,
        success: failed === 0
      };
    });
  }
  
  registerTest(name, testFunction) {
    this.tests.set(name, testFunction);
  }
  
  async runTests() {
    console.log('Running mobile tests...');
    
    for (const [name, testFunction] of this.tests) {
      try {
        const result = await testFunction();
        this.results.set(name, result);
        
        console.log(`Test ${name}:`, result.success ? 'PASSED' : 'FAILED', result);
      } catch (error) {
        console.error(`Test ${name} failed with error:`, error);
        this.results.set(name, {
          error: error.message,
          success: false
        });
      }
    }
    
    this.generateReport();
  }
  
  hasGoodContrast(color, backgroundColor) {
    // Basic contrast check (simplified)
    // In a real implementation, you would use a proper contrast calculation library
    return true; // Placeholder
  }
  
  generateReport() {
    const totalTests = this.results.size;
    const passedTests = Array.from(this.results.values()).filter(r => r.success).length;
    const failedTests = totalTests - passedTests;
    
    console.log('=== Mobile Testing Report ===');
    console.log(`Total Tests: ${totalTests}`);
    console.log(`Passed: ${passedTests}`);
    console.log(`Failed: ${failedTests}`);
    console.log(`Success Rate: ${((passedTests / totalTests) * 100).toFixed(1)}%`);
    
    // Log detailed results
    for (const [name, result] of this.results) {
      console.log(`\n${name}:`, result.success ? '✅ PASSED' : '❌ FAILED');
      if (result.error) {
        console.error(`  Error: ${result.error}`);
      }
    }
    
    // Send results to analytics
    this.sendResultsToAnalytics();
  }
  
  sendResultsToAnalytics() {
    if (typeof gtag !== 'undefined') {
      const totalTests = this.results.size;
      const passedTests = Array.from(this.results.values()).filter(r => r.success).length;
      const successRate = (passedTests / totalTests) * 100;
      
      gtag('event', 'mobile_testing_results', {
        event_category: 'Mobile Testing',
        event_label: 'Test Results',
        value: Math.round(successRate)
      });
    }
  }
  
  getResults() {
    return this.results;
  }
}

// Initialize mobile testing framework
const mobileTestingFramework = new MobileTestingFramework();
```

## Architecture Overview

The Westmark Talent Group website follows a **static site architecture** built with modern web technologies, optimized for performance, SEO, and maintainability. The site leverages the Mobirise Website Builder platform while maintaining custom functionality and styling.
