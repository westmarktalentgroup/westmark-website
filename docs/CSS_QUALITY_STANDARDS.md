# CSS Quality Standards - Westmark Talent Group

## 🚨 **!important Prevention Policy**

### **Zero Tolerance for Band-aid Solutions**

We maintain **ZERO** unnecessary `!important` declarations in our custom CSS files to prevent technical debt and maintain clean, maintainable code.

## 📊 **Quality Standards**

### **Maximum !important Usage Limits**
- **Custom CSS files**: `0 !important` declarations allowed
- **Framework override file** (`mbr-additional.css`): `≤8 !important` declarations allowed
- **Total project limit**: `≤10 !important` declarations maximum

### **Allowed !important Usage (Framework Overrides Only)**
Only these specific cases are justified in `mbr-additional.css`:

```css
/* ✅ JUSTIFIED: Framework positioning overrides */
.header18.cid-uMOnIuaQSz .container-fluid {
  align-items: flex-end !important;     /* Override Mobirise centering */
  justify-content: flex-start !important; /* Override Mobirise centering */
  padding: 2rem !important;             /* Override Mobirise spacing */
}

/* ✅ JUSTIFIED: Text control overrides */
.header18.cid-uMOnIuaQSz .mbr-section-title {
  white-space: nowrap !important;       /* Prevent title line breaks */
  overflow: visible !important;         /* Override default overflow */
  text-overflow: unset !important;      /* Override default ellipsis */
}

/* ✅ JUSTIFIED: Typography overrides */
.header18.cid-uMOnIuaQSz .display-1 {
  font-size: 3.5rem !important;         /* Override Mobirise default */
  line-height: 1.1 !important;          /* Override Mobirise default */
}
```

## ❌ **Prohibited !important Usage**

### **Never Use !important For:**
```css
/* ❌ PROHIBITED: Basic styling */
.navbar-nav .nav-link {
  color: #000 !important;              /* Use specific selectors */
  font-weight: 500 !important;         /* Use CSS cascade */
  padding: 0.5rem !important;          /* Use proper specificity */
}

/* ❌ PROHIBITED: Layout properties */
.item-title {
  font-size: 1.2rem !important;        /* Use responsive units */
  margin-bottom: 0.5rem !important;    /* Use CSS cascade */
}

/* ❌ PROHIBITED: Responsive typography */
.display-1 {
  font-size: clamp(2.5rem, 5vw, 5rem) !important; /* Remove !important */
}
```

## ✅ **Proper Solutions Instead of !important**

### **1. Use Specific Selectors**
```css
/* ✅ GOOD: Specific selector overrides Bootstrap */
.navbar-nav .nav-link {
  color: #000;
  font-weight: 500;
}

/* ❌ BAD: Using !important as band-aid */
.nav-link {
  color: #000 !important;
}
```

### **2. Leverage CSS Cascade Order**
Our CSS files load in this order (ensuring proper cascade):
1. Bootstrap CSS (framework)
2. Mobirise CSS (framework)
3. **Our custom CSS** (highest priority)

### **3. Use CSS Custom Properties**
```css
/* ✅ GOOD: CSS variables for consistent theming */
:root {
  --primary-color: #007BFF;
  --font-size-base: clamp(1rem, 1.5vw, 1.125rem);
}

.btn {
  background-color: var(--primary-color);
  font-size: var(--font-size-base);
}
```

### **4. Use Responsive Units**
```css
/* ✅ GOOD: Responsive typography without !important */
.display-1 {
  font-size: clamp(2.5rem, 5vw, 5rem);
  line-height: 1.1;
}

.item-title {
  font-size: clamp(1.125rem, 2vw, 1.5rem);
  font-weight: 600;
}
```

## 🔒 **Automated Prevention**

### **Pre-commit Validation**
The protection system automatically:
- ✅ Counts total `!important` declarations
- ✅ Blocks commits with excessive usage (>10 total)
- ✅ Detects anti-patterns in custom CSS files
- ✅ Validates CSS quality standards

### **Quality Gates**
- **Development**: Protection system validates on every commit
- **Production**: Deployment blocked if standards violated
- **Monitoring**: Continuous validation of CSS quality

## 🎯 **Benefits of Clean CSS**

### **Maintainability**
- ✅ Easier to debug and modify
- ✅ Predictable cascade behavior
- ✅ Better code readability

### **Performance**
- ✅ Fewer specificity conflicts
- ✅ Better browser optimization
- ✅ Faster CSS parsing

### **Team Collaboration**
- ✅ Consistent coding standards
- ✅ Easier code reviews
- ✅ Reduced technical debt

## 📋 **Developer Checklist**

Before adding any CSS:

- [ ] **Can I use a more specific selector?**
- [ ] **Is this a framework override that justifies !important?**
- [ ] **Have I tried using CSS cascade order?**
- [ ] **Can I use CSS custom properties instead?**
- [ ] **Is this responsive typography that should use clamp()?**
- [ ] **Will this create technical debt?**

## 🚨 **Emergency Override Process**

If you absolutely must add `!important`:

1. **Document the justification** in the CSS comment
2. **Explain why cascade order doesn't work**
3. **Add to mbr-additional.css only**
4. **Update this document with the new case**
5. **Ensure total count stays ≤10**

## 📊 **Current Status**

- **Custom CSS files**: 0 `!important` declarations ✅
- **Framework overrides**: 8 `!important` declarations ✅
- **Total project**: 8 `!important` declarations ✅
- **Quality standard**: COMPLIANT ✅

---

*This document is automatically enforced by the protection system. Violations will block commits and deployments.*
