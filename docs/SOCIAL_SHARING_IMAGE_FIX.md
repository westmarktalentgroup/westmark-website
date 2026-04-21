# 📱 Social Sharing Image Optimization
**Date**: October 26, 2025  
**Issue**: Logo appears blurry when shared on iMessage/social media  
**Current**: 128x62 pixels (TOO SMALL)  
**Required**: 1200x628 pixels or higher

## 🚨 **PROBLEM**

Your current social sharing image is **128x62 pixels**, which causes:
- ❌ Blurry appearance in iMessage
- ❌ Poor quality on Twitter/LinkedIn
- ❌ Low resolution in previews
- ❌ Unprofessional appearance

## ✅ **SOLUTION**

### **Step 1: Create High-Resolution Social Image**

You need to create a **1200x628 pixel** image for optimal social sharing.

**Recommended Approach:**
1. Open your `Westmark_logo-3.svg` in a graphics editor (Figma, Adobe Illustrator, or similar)
2. Create a new canvas: **1200x628 pixels**
3. Place your logo centered with some breathing room
4. Add a background color or gradient that matches your brand
5. Export as PNG at high quality
6. Save as: `assets/images/og-image.png`

**Alternative Quick Fix (if you have ImageMagick or similar):**
```bash
# If you have imagemagick installed
convert Westmark_logo-3.svg -resize 1200x628 \
  -background "#ffffff" -gravity center -extent 1200x628 \
  -quality 95 assets/images/og-image.png
```

### **Step 2: Update HTML Meta Tags**

Once you have the high-resolution image, update these files:

**File**: `development/index.html` (lines 23, 31)
**Change**: 
```html
<!-- FROM: -->
<meta property="og:image" content="assets/images/westmark-logo-128x62-1.webp">
<meta name="twitter:image" content="assets/images/westmark-logo-128x62-1.webp">

<!-- TO: -->
<meta property="og:image" content="https://westmarktalentgroup.com/assets/images/og-image.png">
<meta property="og:image:width" content="1200">
<meta property="og:image:height" content="628">
<meta property="og:image:type" content="image/png">
<meta name="twitter:image" content="https://westmarktalentgroup.com/assets/images/og-image.png">
<meta name="twitter:image:width" content="1200">
<meta name="twitter:image:height" content="628">
```

**File**: `index.html` (production version)
**Same changes as above**

### **Step 3: Add Absolute URLs**

Social media platforms need **absolute URLs** (not relative):
- ✅ Use: `https://westmarktalentgroup.com/assets/images/og-image.png`
- ❌ Don't use: `assets/images/og-image.png`

## 📐 **REQUIRED SPECIFICATIONS**

### **Image Dimensions**
- **Optimal Size**: 1200x628 pixels (1.91:1 aspect ratio)
- **Minimum Size**: 600x314 pixels
- **Maximum Size**: 1200x628 pixels
- **File Format**: PNG for logos with transparency, JPG if no transparency needed

### **File Size**
- **Maximum**: 5MB (aim for under 1MB)
- **Format**: PNG (better quality for logos)
- **Compression**: High quality (90-95%)

### **Content Specifications**
- **Logo**: Large, centered, high quality
- **Background**: Solid color or subtle gradient
- **Padding**: At least 40-60px around edges
- **Text**: Keep minimal or use large, readable fonts if needed

## 🎨 **DESIGN RECOMMENDATIONS**

### **For iMessage/Apple Messages**
- Use simple, bold logo
- High contrast background
- Avoid small text
- Clean, professional look

### **For Twitter**
- 1200x675 pixels (slightly taller)
- More vertical space for logo
- Bold, recognizable branding

### **For LinkedIn**
- 1200x627 pixels (slightly shorter)
- Professional, clean layout
- Subtle colors work best

## 🔧 **IMMEDIATE ACTION REQUIRED**

**You Need to:**
1. Create a 1200x628 pixel version of your logo
2. Add appropriate background
3. Save as `assets/images/og-image.png`
4. Update the meta tags in HTML files
5. Deploy the changes

**I can update the HTML meta tags once you provide the image file.**

---

**Would you like me to:**
1. ✅ Update the HTML meta tags now (once you add the image)?
2. ✅ Add the proper Open Graph attributes?
3. ✅ Optimize for iMessage specifically?
