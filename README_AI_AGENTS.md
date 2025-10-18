# 🚨 CRITICAL: READ THIS FIRST

## ⚠️ **MANDATORY WORKFLOW FOR AI AGENTS**

**BEFORE MAKING ANY CHANGES TO THIS CODEBASE:**

1. **READ**: `AI_AGENT_WORKFLOW_RULES.md` - Contains mandatory workflow rules
2. **UNDERSTAND**: This project uses development-first workflow
3. **NEVER**: Modify production files without explicit user approval

## 📁 **Directory Structure**

- **`/Code/`** = **PRODUCTION/LIVE** (NEVER MODIFY WITHOUT PERMISSION)
- **`/Code/development/`** = **STAGING/TESTING** (SAFE TO MODIFY)

## 🔒 **Production Protection**

**The main directory contains LIVE PRODUCTION FILES:**
- `index.html` - Live homepage
- `clients.html` - Live clients page  
- `contact-us.html` - Live contact page
- `logo.html` - Live logo page
- `assets/` - Live assets directory

**These files serve real users and must be protected!**

## 🛠 **Correct Workflow**

1. **Develop** → Work in `/development/` directory
2. **Test** → Verify functionality in development
3. **Present** → Show results to user
4. **Approve** → Wait for explicit permission
5. **Deploy** → Only then modify production files

## 📋 **Current Project Status**

### **CSS Architecture Cleanup - Phase 1**
- **Status**: ✅ Implemented in development only
- **Files**: `development/assets/css/typography.css`, `development/assets/css/spacing.css`
- **Next**: Test in development, then get approval for production

### **Documentation Created**
- `AI_AGENT_WORKFLOW_RULES.md` - Mandatory workflow rules
- `DEVELOPMENT_TESTING_GUIDE.md` - How to test safely
- `PHASE_1_MIGRATION_GUIDE.md` - Migration process

## 🚨 **Emergency Contacts**

If you accidentally modify production files:
1. **STOP** - Do not make more changes
2. **NOTIFY** - Tell the user immediately
3. **ROLLBACK** - Restore from development/backup
4. **DOCUMENT** - Record what happened

---

**Remember**: Development first, production only with approval! 🛡️
