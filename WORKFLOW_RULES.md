# Workflow Rules - Westmark Talent Group

## Development Workflow Standards

### Core Principle: Development-First Workflow

**Production Protection:**
- Production files are read-only
- All changes must originate in development directory
- Deployment script is the only method for production updates

**Development Requirements:**
- Work exclusively in `development/` directory
- Use deployment script for production updates
- Test changes before deployment
- Follow staging-to-production workflow

---

## 📁 **DIRECTORY STRUCTURE RULES**

### 🧪 **DEVELOPMENT DIRECTORY** (`development/`)
- **Purpose**: Staging environment for testing changes
- **Action**: ✅ **EDIT HERE** - Make all changes in this directory
- **Files**: All HTML, CSS, JS, images, and assets
- **Testing**: Test all functionality here before deployment

### 🚀 **PRODUCTION DIRECTORY** (root `/`)
- **Purpose**: Live website files served by GitHub Pages
- **Action**: ❌ **NEVER EDIT** - Files are managed by deployment script
- **Files**: Auto-generated from development directory
- **Deployment**: Only modified via `./deploy.sh` script

---

## Correct Workflow Process

### Development Phase
```bash
# Work in development directory
cd development/
# Make your changes here
# Test your changes locally
```

### Deployment Phase
```bash
# Deploy from development to production
./deploy.sh
```

### Version Control Phase
```bash
# Commit and push to GitHub
git add .
git commit -m "Deploy: [describe your changes]"
git push origin main
```

---

## 🛡️ **PROTECTION MECHANISMS**

### **Automated Checks**
- ✅ **Protection System**: Validates changes before deployment
- ✅ **Backup Creation**: Automatic backup before each deployment
- ✅ **File Integrity**: Checks for duplicate files and conflicts
- ✅ **Security Validation**: Scans for sensitive data and vulnerabilities

### **Manual Verification**
- ✅ **Test in Development**: Always test changes locally first
- ✅ **Review Changes**: Check what files will be deployed
- ✅ **Validate Functionality**: Ensure everything works as expected

---

## 📋 **CHECKLIST BEFORE DEPLOYMENT**

- [ ] All changes made in `development/` directory only
- [ ] Changes tested locally in development environment
- [ ] No direct edits to production files
- [ ] Ready to run `./deploy.sh` script
- [ ] Prepared descriptive commit message

---

## 🚨 **EMERGENCY PROCEDURES**

### **If Production Files Are Accidentally Modified:**
1. **DON'T PANIC** - Backup system is in place
2. **Restore from backup** using the latest backup in `backups/` directory
3. **Re-deploy from development** using `./deploy.sh`
4. **Verify functionality** and test thoroughly

### **If Deployment Fails:**
1. **Check protection system warnings** in deployment output
2. **Fix issues in development** directory
3. **Re-run deployment** script
4. **Contact development team** if issues persist

---

## 💡 **BEST PRACTICES**

### **Development**
- Keep development directory in sync with latest changes
- Use descriptive file names and comments
- Test on multiple devices and browsers
- Validate HTML, CSS, and JavaScript

### **Deployment**
- Always use the deployment script
- Review deployment summary before committing
- Use clear, descriptive commit messages
- Monitor deployment logs for warnings

### **Version Control**
- Commit frequently with meaningful messages
- Keep commit history clean and organized
- Use conventional commit format when possible
- Tag major releases and deployments

---

## 📞 **SUPPORT**

If you have questions about the workflow or encounter issues:
1. **Check this document** for common solutions
2. **Review deployment logs** for specific error messages
3. **Contact development team** for assistance
4. **Document any issues** for future reference

---

**Remember: The development workflow exists to protect the production website and ensure smooth, reliable deployments. Always follow these rules! 🛡️**
