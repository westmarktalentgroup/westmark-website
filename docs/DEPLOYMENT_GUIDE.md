# Deployment Guide - Westmark Talent Group

## Overview
This comprehensive deployment guide consolidates all deployment procedures, maintenance guidelines, and GitHub Pages-specific considerations for the Westmark Talent Group website.

## 🚨 Critical GitHub Pages Context

### How GitHub Pages Works
- **Automatic Deployment**: Any commit to `main` branch goes live immediately
- **No Staging**: No intermediate testing environment
- **Public Repository**: Changes are visible to everyone
- **No Rollback**: Once deployed, changes are live

### Why This Matters
- **Higher Risk**: Changes go live immediately
- **No Safety Net**: Can't test on staging first
- **Public Impact**: Broken CSS affects real users immediately
- **Development-First Critical**: Must test thoroughly before any main branch changes

## 📁 File Structure

### GitHub Pages Structure
```
Repository Root (main branch)
├── index.html          # Live homepage
├── clients.html         # Live clients page
├── contact-us.html      # Live contact page
├── logo.html           # Live logo page (private/internal)
├── assets/             # Live assets
├── development/        # Development testing only
├── docs/              # Documentation
└── [other files]      # Configuration, etc.
```

### Development Environment
```
development/
├── index.html          # Development homepage
├── clients.html         # Development clients page
├── contact-us.html      # Development contact page
├── logo.html           # Development logo page
├── assets/             # Development assets
└── protection-system.sh # Development protection system
```

## 🚨 Single Deployment Script Policy

### Why This Matters
- **Confusion**: Multiple deployment scripts create uncertainty about which one to use
- **Maintenance**: Duplicate scripts require duplicate maintenance and updates
- **Inconsistency**: Different scripts may have different behaviors
- **Errors**: Using the wrong script can cause deployment failures

### Automatic Prevention
The protection system automatically detects and prevents duplicate scripts:
- Multiple deployment scripts (`*deploy*.sh`)
- Multiple protection scripts (`*protection*.sh`, `*guard*.sh`, `*enforcer*.sh`)

## 📋 Deployment Workflow

### Standard Deployment Process
```bash
# 1. Make changes in development directory
cd development
# ... make your changes ...

# 2. Run protection system checks (from repo root: ./scripts/protection-system.sh runs in development/)
cd ..
./scripts/protection-system.sh

# 3. Deploy to production (copies development/ to root, commits, creates deploy-* branch, pushes)
./scripts/deploy.sh

# 4. Open PR and merge (main is branch-protected; deploy.sh outputs the PR link)
#    - Required: "Westmark Production Protection" status check (deploy-* branches are allowed)
#    - Required: approval from someone other than the last pusher
#    - Then merge the PR on GitHub to deploy to GitHub Pages
```

### Single Deployment Script: `scripts/deploy.sh`
- **Location**: `scripts/deploy.sh` (run from repository root: `./scripts/deploy.sh`)
- **Purpose**: Comprehensive deployment with all features
- **Features**:
  - Protection system validation
  - Automatic backup creation
  - Performance analysis
  - Security checks
  - Asset cleanup
  - Backup management

## 🧪 Testing Strategy

### Pre-Deployment Testing
```bash
# Test in development directory
cd development/
python3 -m http.server 8001
open http://localhost:8001/index.html

# Test all pages
- development/index.html
- development/clients.html  
- development/contact-us.html
- development/logo.html
```

### Cross-Browser Testing
- **Chrome** - Primary browser
- **Firefox** - Secondary browser
- **Safari** - Mobile testing
- **Mobile devices** - Real device testing

### Performance Testing
- **PageSpeed Insights** - Google's performance tool
- **GTmetrix** - Detailed performance analysis
- **Mobile testing** - Real mobile devices

## 🚀 Safe Deployment Steps

1. **Test in development** - Verify all changes work
2. **Cross-browser test** - Ensure compatibility
3. **Mobile test** - Verify responsive design
4. **Performance test** - Check Core Web Vitals
5. **Get user approval** - Confirm ready for deployment
6. **Deploy** - Run `./scripts/deploy.sh`, then open PR and merge to main (branch protection requires PR)
7. **Monitor live site** - Watch for any issues
8. **Quick rollback** - If issues, revert immediately

### Deployment Commands
**Do not copy manually.** Always use the deployment script and PR workflow:
```bash
./scripts/deploy.sh   # Copies development/ → root, creates deploy-* branch, pushes
# Then open the PR link it prints and merge on GitHub (branch protection requires PR).
```
Manual `cp` and `git push origin main` are blocked; use `./scripts/deploy.sh` and merge via PR.

## ⚠️ GitHub Pages Risks & Mitigation

### High-Risk Scenarios
- **Broken CSS** - Site looks broken immediately
- **Performance issues** - Slow loading affects users
- **Mobile problems** - Poor mobile experience
- **Cross-browser issues** - Incompatibility with browsers

### Mitigation Strategies
- **Thorough testing** - Test everything before deployment
- **Gradual rollout** - Deploy one page at a time if needed
- **Quick rollback** - Immediate revert if issues
- **Monitoring** - Watch for user reports

## 🔄 Rollback Strategy

### Quick Rollback Process
**Branch protection blocks direct push to main.** Use one of:

1. **Rollback script (local restore + new deploy):**  
   `./scripts/rollback.sh` — restores from a backup under `backups/`. Then run `./scripts/deploy.sh` to create a deploy branch with the rolled-back state and open a PR to merge.

2. **Revert via PR:** Create a branch from `main`, revert the bad commit (`git revert <commit>`), run `./scripts/deploy.sh` from that state (or push the revert branch and open a PR), then merge the PR.

## 📊 Monitoring and Maintenance

### Performance Monitoring
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

## 🔒 Security Maintenance

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

## 🛠️ Troubleshooting Guide

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

## 🔧 Maintenance Guidelines

### When Adding New Features
1. **Enhance existing script** - Don't create new ones
2. **Update documentation** - Keep guidelines current
3. **Test thoroughly** - Ensure new features work
4. **Run protection system** - Verify no duplicates

### Script Enhancement Process
```bash
# 1. Backup current script
cp scripts/deploy.sh scripts/deploy.sh.backup

# 2. Enhance the script
# ... add new features to scripts/deploy.sh ...

# 3. Test the enhanced script (from repo root)
./scripts/deploy.sh

# 4. Run protection system to verify (from repo root)
./scripts/protection-system.sh
```

## 📈 Best Practices

### Do's
- ✅ **Enhance existing scripts** instead of creating new ones
- ✅ **Run protection system** before deploying
- ✅ **Test thoroughly** after making changes
- ✅ **Document changes** in commit messages
- ✅ **Keep backups** of working scripts before major changes

### Don'ts
- ❌ **Create duplicate scripts** - Use existing ones
- ❌ **Skip protection system** - Always run validation
- ❌ **Deploy without testing** - Test locally first
- ❌ **Ignore error messages** - Fix issues before proceeding
- ❌ **Forget to commit** - Always commit working changes

## 🎯 Success Metrics

### Project Health Indicators
- ✅ **Single deployment script** - No duplicates
- ✅ **Single protection script** - No duplicates
- ✅ **Clean file structure** - Organized and logical
- ✅ **Consistent workflow** - Same process every time
- ✅ **Automated validation** - Protection system prevents issues

### GitHub Pages Best Practices

#### Before Every Deployment
- [ ] Test thoroughly in development
- [ ] Cross-browser compatibility check
- [ ] Mobile responsiveness test
- [ ] Performance impact assessment
- [ ] User approval obtained
- [ ] Rollback plan ready

#### After Every Deployment
- [ ] Monitor live site immediately
- [ ] Check Core Web Vitals
- [ ] Verify all pages load correctly
- [ ] Test critical functionality
- [ ] Watch for user feedback
- [ ] Document any issues

## 🔍 Monitoring and Validation

### Automatic Checks
The protection system automatically validates:
- Single deployment script policy
- Single protection script policy
- File structure integrity
- Asset organization
- Security compliance

### Manual Validation
```bash
# Check for duplicate scripts manually
find . -name "*deploy*.sh" -exec echo "Deploy script: {}" \;
find development -name "*protection*.sh" -exec echo "Protection script: {}" \;

# Should show only:
# Deploy script: ./scripts/deploy.sh
# Protection script: ./scripts/protection-system.sh (run from repo root)
```

---

**Remember**: GitHub Pages means changes go live immediately. Always test thoroughly in development before any main branch changes! 🚨

*This deployment guide ensures the Westmark Talent Group website maintains a clean, efficient, and maintainable deployment process.*
