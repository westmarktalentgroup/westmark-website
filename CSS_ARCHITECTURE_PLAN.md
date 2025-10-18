# CSS Architecture Cleanup Plan

## Current State Analysis
- **Total !important declarations**: 473 across 8 files
- **Main culprits**: 
  - `mobile-text-fixes.css`: 60 declarations (our band-aid fixes)
  - `style.css`: 91 declarations (framework overrides)
  - `mbr-additional.css`: 6 declarations (theme overrides)

## Categorization of !important Issues

### 🔴 **HIGH PRIORITY - Typography & Layout**
**File**: `mobile-text-fixes.css` (60 declarations)
**Problem**: Fighting framework defaults with !important
**Impact**: Makes future styling changes difficult

**Categories**:
1. **Font Sizing** (25 declarations)
   - `.display-1`, `.display-2`, `.display-5`, `.display-7`
   - `.process-text`, `.item-title`, `.item-content p`
   - Mobile responsive overrides

2. **Navigation** (8 declarations)
   - `.navbar-nav .nav-link` sizing and colors
   - Mobile navigation adjustments

3. **Buttons** (6 declarations)
   - `.btn` sizing and padding
   - Mobile button adjustments

4. **Spacing** (8 declarations)
   - `.mb-2`, `.mb-3`, `.mb-4`, `.mt-3`
   - Margin utilities

5. **Text Alignment** (4 declarations)
   - `.text-center`, `.text-left`
   - Mobile alignment overrides

6. **Color & Weight** (9 declarations)
   - `.mbr-text`, `.mbr-white`
   - Font weight overrides

### 🟡 **MEDIUM PRIORITY - Component Overrides**
**File**: `style.css` (91 declarations)
**Problem**: Overriding third-party framework styles

**Categories**:
1. **Carousel Components** (15 declarations)
   - `.carousel-control`, `.carousel-indicators`
   - Button styling overrides

2. **Phone Link Visibility** (35 declarations)
   - `.phone-link` visibility fixes
   - Multiple state overrides (hover, focus, active)

3. **Form Controls** (8 declarations)
   - `.form-control` styling
   - Input field overrides

4. **Layout Utilities** (6 declarations)
   - `.mt-4`, `.mb-4` spacing
   - Media sizing overrides

5. **Accessibility** (8 declarations)
   - Focus states, reduced motion
   - Print styles

6. **Framework Overrides** (19 declarations)
   - Bootstrap component overrides
   - Mobirise framework fixes

### 🟢 **LOW PRIORITY - Theme Colors**
**File**: `mbr-additional.css` (6 declarations)
**Problem**: Theme color overrides
**Impact**: Minimal - just color definitions

## Fix Strategy - Chunked Approach

### **Phase 1: Typography Foundation** (Week 1)
**Goal**: Replace font-size !important with proper CSS custom properties
**Files**: `mobile-text-fixes.css` → `typography.css`

**Approach**:
1. Create CSS custom properties for font scales
2. Use `clamp()` for responsive typography
3. Implement proper CSS cascade instead of !important

**Risk**: Low - Typography changes are isolated

### **Phase 2: Component Architecture** (Week 2)
**Goal**: Replace component !important with BEM methodology
**Files**: `style.css` → `components.css`

**Approach**:
1. Implement BEM naming convention
2. Use higher specificity instead of !important
3. Create component-specific stylesheets

**Risk**: Medium - Components are interconnected

### **Phase 3: Layout System** (Week 3)
**Goal**: Replace spacing !important with CSS Grid/Flexbox
**Files**: `mobile-text-fixes.css` → `layout.css`

**Approach**:
1. Implement CSS Grid for layout
2. Use CSS custom properties for spacing
3. Create utility classes without !important

**Risk**: Medium - Layout changes affect multiple pages

### **Phase 4: Framework Integration** (Week 4)
**Goal**: Clean integration with Bootstrap/Mobirise
**Files**: All files → `framework-overrides.css`

**Approach**:
1. Create proper override hierarchy
2. Use CSS layers for specificity
3. Minimize framework conflicts

**Risk**: High - Framework integration is complex

## Implementation Plan

### **Chunk 1: Typography System** (Start Here)
```css
/* Replace this !important mess: */
.display-1 { font-size: 2.5rem !important; }

/* With proper CSS custom properties: */
:root {
  --font-size-display-1: clamp(2rem, 5vw, 5rem);
  --font-size-display-2: clamp(1.75rem, 4vw, 4rem);
  --font-size-display-5: clamp(1.125rem, 2.5vw, 2rem);
  --font-size-display-7: clamp(0.95rem, 1.5vw, 1.4rem);
}

.display-1 { font-size: var(--font-size-display-1); }
```

### **Chunk 2: Component Classes**
```css
/* Replace this !important mess: */
.navbar-nav .nav-link { font-size: 1.2rem !important; }

/* With BEM methodology: */
.navbar__link { font-size: 1.2rem; }
.navbar__link--mobile { font-size: 1.1rem; }
```

### **Chunk 3: Layout Utilities**
```css
/* Replace this !important mess: */
.mb-2 { margin-bottom: 0.5rem !important; }

/* With CSS custom properties: */
:root {
  --spacing-xs: 0.5rem;
  --spacing-sm: 0.75rem;
  --spacing-md: 1rem;
}

.spacing-mb-xs { margin-bottom: var(--spacing-xs); }
```

## Success Metrics
- **Reduce !important by 80%** (from 473 to ~95)
- **Improve maintainability** - New styles don't need !important
- **Better performance** - Less CSS specificity conflicts
- **Easier debugging** - Clear CSS cascade

## Next Steps
1. **Start with Chunk 1** - Typography system
2. **Test thoroughly** - Each chunk should be fully functional
3. **Document changes** - Keep track of what's been fixed
4. **Gradual rollout** - Deploy to development first

## Files to Create
- `assets/css/typography.css` - Font system
- `assets/css/components.css` - Component styles
- `assets/css/layout.css` - Layout utilities
- `assets/css/framework-overrides.css` - Framework fixes
- `assets/css/design-system.css` - Main design system file
