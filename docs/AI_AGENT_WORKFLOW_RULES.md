# 🚨 CRITICAL: DEVELOPMENT-FIRST WORKFLOW FOR AI AGENTS

## 🛑 **IMMEDIATE STOP - READ THIS BEFORE ANY ACTION**
**If you are about to modify ANY files in this project, you MUST read this entire document first.**
**This applies to EVERY request, even if the user doesn't explicitly mention following procedures.**
**Violation of these rules will result in incorrect deployment and potential production issues.**

## ⚠️ **MANDATORY WORKFLOW RULES - NO EXCEPTIONS**

### **🚨 STOP! READ THIS FIRST BEFORE ANY FILE OPERATIONS**
**This file contains CRITICAL rules that MUST be followed for EVERY request, regardless of what the user asks for.**

### **NEVER MODIFY PRODUCTION FILES DIRECTLY**
- **Main directory** (`/Code/`) = **PRODUCTION/LIVE**
- **Development directory** (`/Code/development/`) = **STAGING/TESTING ONLY**

### **🔒 MANDATORY DEPLOYMENT CHECKLIST - EVERY SINGLE REQUEST**
**Before making ANY changes, you MUST:**

1. **🔍 CHECK FOR DEPLOYMENT SCRIPTS FIRST**
   - Look for: `deploy.sh`, `deploy.py`, `deploy.js`, or similar
   - **NEVER** use manual `cp` commands for production files
   - **ALWAYS** use project-specific deployment tools

2. **📖 READ PROJECT WORKFLOW DOCUMENTATION**
   - Check for `AI_AGENT_WORKFLOW_RULES.md`, `DEPLOYMENT.md`, or similar
   - **NEVER** assume manual operations are correct
   - **ALWAYS** follow established procedures

3. **🚫 PROHIBITED ACTIONS - NEVER DO THESE**
   - `cp development/file.html ./` ❌
   - `git add . && git commit` ❌ (without proper deployment)
   - Direct production file editing ❌
   - Manual file copying to production ❌

### **🎯 DEPLOYMENT SCRIPT MANDATE**
**This project has a `deploy.sh` script that MUST be used for all production deployments.**
- **File Location**: `/Code/deploy.sh`
- **Purpose**: Handles backups, systematic copying, and error handling
- **Usage**: `./deploy.sh` (run from project root)
- **NEVER use manual cp commands** - Always use the deployment script

### **🚨 DEPLOYMENT SCRIPT CHECK**
**Before ANY production changes, you MUST:**
1. Check if `deploy.sh` exists in the project root
2. If it exists, USE IT instead of manual commands
3. If it doesn't exist, ask the user about deployment procedures
4. **NEVER assume manual copying is acceptable**

### **🔒 PRODUCTION PROTECTION RULES**

1. **ALWAYS TEST IN DEVELOPMENT FIRST**
   - All changes must be implemented in `/development/` directory
   - Test thoroughly before any production deployment
   - Verify functionality across all pages and devices

2. **NEVER EDIT THESE PRODUCTION FILES DIRECTLY:**
   - `index.html` (main directory)
   - `clients.html` (main directory)  
   - `contact-us.html` (main directory)
   - `logo.html` (main directory)
   - Any files in `/assets/` (main directory)

3. **DEVELOPMENT WORKFLOW:**
   ```
   Development → Testing → Approval → Production Deployment
   ```

## 📁 **DIRECTORY STRUCTURE EXPLANATION**

### **Production (LIVE) - `/Code/`**
- **Purpose**: Live website that users see
- **Hosting**: GitHub Pages (automatic deployment from main branch)
- **Files**: `index.html`, `clients.html`, `contact-us.html`, `logo.html`
- **Rule**: **NEVER MODIFY WITHOUT EXPLICIT USER APPROVAL**

**Note**: `logo.html` is a private/internal page for sharing logo images (email signatures, social media) - not public-facing

### **Development (STAGING) - `/Code/development/`**
- **Purpose**: Testing environment for new features
- **Files**: `development/index.html`, `development/clients.html`, etc.
- **Rule**: **SAFE TO MODIFY** - This is where all testing happens

## 🛠 **CORRECT IMPLEMENTATION WORKFLOW**

### **Step 1: Development Implementation**
```bash
# ✅ CORRECT: Modify development files
edit development/index.html
edit development/assets/css/new-feature.css
```

### **Step 2: Testing**
```bash
# ✅ CORRECT: Test in development
open development/index.html
test all functionality
verify no regressions
```

### **Step 3: User Approval**
- Present changes to user
- Get explicit approval for production deployment
- Document what will be deployed

### **Step 4: Production Deployment**
```bash
# ✅ CORRECT: Only after approval - USE DEPLOYMENT SCRIPT
./deploy.sh

# ❌ NEVER DO THIS:
cp development/index.html index.html
cp development/assets/css/new-feature.css assets/css/new-feature.css
```

## 🚨 **WHAT NOT TO DO**

### **❌ NEVER DO THIS:**
```bash
# WRONG: Direct production modification
edit index.html
edit clients.html
edit assets/css/style.css
```

### **❌ NEVER ASSUME:**
- "It's just a small change"
- "It won't break anything"
- "The user will be okay with it"

## 📋 **MANDATORY CHECKLIST FOR AI AGENTS**

Before making ANY changes:

- [ ] **🚨 STOP! READ THIS FILE FIRST** - No exceptions
- [ ] **🔍 CHECK FOR DEPLOYMENT SCRIPTS** - Look for deploy.sh, deploy.py, etc.
- [ ] **📖 READ PROJECT WORKFLOW DOCS** - Check for workflow rules
- [ ] **Identify target environment**: Development or Production?
- [ ] **If Production**: STOP - Ask user for explicit permission
- [ ] **If Development**: Proceed with implementation
- [ ] **Test thoroughly** in development environment
- [ ] **Document changes** made
- [ ] **Present results** to user for approval
- [ ] **Wait for approval** before production deployment
- [ ] **USE DEPLOYMENT SCRIPT** - Never use manual cp commands
- [ ] **FOLLOW ESTABLISHED PROCEDURES** - Don't improvise workflows

## 🔄 **CURRENT PROJECT STATUS**

### **CSS Architecture Cleanup Project**
- **Phase 1**: Typography & Spacing System
- **Status**: ✅ Implemented in development only
- **Files Created**: 
  - `development/assets/css/typography.css`
  - `development/assets/css/spacing.css`
- **Next Step**: Test in development, then get approval for production

### **Files Modified (Development Only)**
- ✅ `development/index.html` - Added new CSS files
- ✅ `development/assets/css/` - New CSS files created
- ❌ **NO PRODUCTION FILES MODIFIED**

## 📞 **EMERGENCY ROLLBACK PROCEDURE**

If production files are accidentally modified:

1. **Immediately notify user**
2. **Identify what was changed**
3. **Restore from development or backup**
4. **Document the incident**
5. **Update workflow to prevent recurrence**

## 🎯 **SUCCESS CRITERIA**

### **For AI Agents:**
- ✅ Always ask before production changes
- ✅ Test thoroughly in development first
- ✅ Document all changes made
- ✅ Wait for user approval before deployment

### **For Users:**
- ✅ Clear visibility into what's being changed
- ✅ Control over when changes go live
- ✅ Confidence that production is protected

---

## 🔒 **FAIL-SAFE MECHANISM**

### **AUTOMATIC DEPLOYMENT SCRIPT DETECTION**
**If you see ANY of these commands in your planned actions:**
- `cp development/` → **STOP! Use ./deploy.sh instead**
- `git add .` → **STOP! Check if deployment script was used first**
- Direct file modification in root directory → **STOP! Use development/ first**

### **EMERGENCY PROCEDURE IF YOU VIOLATE THESE RULES**
1. **Immediately acknowledge the violation**
2. **Explain what went wrong**
3. **Use the proper deployment script to fix it**
4. **Document the incident for future prevention**

---

## 📝 **DOCUMENTATION FOR FUTURE AI AGENTS**

**This file must be read and understood before making ANY changes to this codebase.**

**Key Rule**: Development first, production only with explicit approval.

**When in doubt**: Ask the user before modifying production files.

**Remember**: It's better to ask permission than to break a live website.

**CRITICAL**: Always check for deployment scripts before manual file operations.
