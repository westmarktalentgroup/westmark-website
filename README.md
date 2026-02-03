# Westmark Talent Group Website

## 🚨 **CRITICAL: AI AGENTS READ THIS FIRST**

### **MANDATORY WORKFLOW**
- **ALWAYS work in `development/` directory first**
- **NEVER edit production files directly** (main directory)
- **ALWAYS use `./scripts/deploy.sh` for deployment**

### **QUICK REFERENCE**
- **CSS Classes**: `soap-bar-nav`, `hero-section`, `btn-primary`, `card`, `form-group`
- **JS Functions**: `initNavigation()`, `initSoapBarScroll()`, `initAccordion()`, `initForms()`
- **Design Tokens**: `--font-family-heading`, `--color-primary`, `--spacing-*`
- **Patterns**: `<section class="[name]-section" id="[name]">`

### **FULL AI GUIDE**
📖 **See `AI_GUIDE.md` for complete reference**

---

## 🏗️ Development Workflow

This repository uses a **staging-to-production** workflow optimized for GitHub Pages deployment.

### 📁 Directory Structure

```
/
├── development/          # 🧪 STAGING ENVIRONMENT
│   ├── index.html       # Test changes here first
│   ├── clients.html
│   ├── contact-us.html
│   ├── logo.html
│   ├── assets/          # All CSS, JS, images
│   └── docs/            # Documentation
├── scripts/             # 🛠️ DEVELOPMENT TOOLS
│   ├── deploy.sh        # Deployment script
│   ├── protection-system.sh
│   └── *.sh            # All development scripts
├── docs/                # 📚 PROJECT DOCUMENTATION
├── backups/             # 💾 AUTOMATIC BACKUPS
├── index.html           # 🚀 PRODUCTION (GitHub Pages)
├── clients.html
├── contact-us.html
├── logo.html
├── assets/              # Production assets
└── .gitignore           # Excludes development/
```

### 🔄 Workflow Process

1. **Develop & Test** in `development/` directory
2. **Test locally** to ensure everything works
3. **Deploy to production** using `./scripts/deploy.sh`
4. **Commit & Push** to main branch
5. **GitHub Pages** automatically deploys

### 🚀 Quick Deployment

```bash
# Deploy development changes to production
./scripts/deploy.sh

# Commit and push to GitHub Pages
git add .
git commit -m "Deploy: [describe your changes]"
git push origin main
```

### 🎯 Why This Setup?

- **GitHub Pages Limitation**: Must serve from root directory or `/docs`
- **Testing Safety**: Test in `development/` before affecting live site
- **Easy Rollback**: Backup created before each deployment
- **Clean Git History**: Only production files tracked in git

### 📋 Development Guidelines

1. **Always work in `development/`** directory
2. **Test thoroughly** before deploying
3. **Use descriptive commit messages** for deployments
4. **Keep `development/` in sync** with latest changes

### 🚨 CRITICAL WORKFLOW RULES

**⚠️ NEVER MODIFY PRODUCTION FILES DIRECTLY**

- ✅ **DO**: Work only in `development/` directory
- ✅ **DO**: Use `./scripts/deploy.sh` to copy to production
- ❌ **DON'T**: Edit files in root directory (production)
- ❌ **DON'T**: Manually copy files to production
- ❌ **DON'T**: Skip the deployment script

**🔄 Correct Workflow:**
1. Make changes in `development/`
2. Test in `development/`
3. Run `./scripts/deploy.sh` to deploy
4. Commit and push to GitHub

### 🔧 Recent Optimizations

- ✅ **WebP Image Format**: Quality 95 (near-lossless)
- ✅ **Progressive Enhancement**: `<picture>` elements with fallbacks
- ✅ **Service Worker**: Caching for better performance
- ✅ **SEO Optimized**: Comprehensive meta tags and structured data

### 📞 Support

For questions about the development workflow, contact the development team.
