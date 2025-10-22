# Cursor Touch ID Deployment Setup

## Overview
This setup provides enterprise-grade security for Westmark website deployments using Cursor's environment and macOS Touch ID authentication.

## Features
- ✅ **Cursor Environment Detection**: Only works within Cursor
- ✅ **Touch ID Authentication**: Biometric security for deployments
- ✅ **GitHub Token Management**: Secure token storage in macOS Keychain
- ✅ **Automatic Verification**: GitHub API validation
- ✅ **Audit Trail**: Complete deployment logging

## Setup Instructions

### 1. Create GitHub Personal Access Token
1. Go to GitHub → Settings → Developer settings → Personal access tokens
2. Click "Generate new token (classic)"
3. Select scopes: `repo` (full control)
4. Set expiration: 90 days (recommended)
5. Copy the token (starts with `ghp_`)

### 2. Store Token in macOS Keychain
```bash
# Run this command in Cursor's terminal:
security add-generic-password \
  -a "westmark-cursor-deployment" \
  -s "github-token" \
  -w "your_github_token_here" \
  -T "/Applications/Cursor.app"
```

### 3. Test Touch ID Authentication
```bash
# Test the authentication system:
./scripts/cursor-touchid-auth.sh
```

### 4. Deploy with Touch ID
```bash
# Deploy to production with Touch ID:
./scripts/cursor-deploy.sh
```

## Security Features

### Cursor Environment Detection
- Verifies the script is running within Cursor
- Checks for Cursor-specific environment variables
- Validates parent process is Cursor

### Touch ID Integration
- Uses macOS Keychain with Touch ID
- Requires biometric authentication for each deployment
- Stores credentials securely with app-specific access

### GitHub Token Verification
- Validates token with GitHub API before deployment
- Shows authenticated username
- Prevents deployment with invalid tokens

## Usage

### First Time Setup
1. Run the authentication script to store your GitHub token
2. Touch ID will prompt for authentication
3. Token is stored securely in macOS Keychain

### Regular Deployments
1. Run `./scripts/cursor-deploy.sh` from Cursor
2. Touch ID authentication prompt appears
3. Place finger on Touch ID sensor
4. Deployment proceeds automatically

### Troubleshooting

#### "This script must be run from within Cursor"
- Make sure you're running from Cursor's integrated terminal
- Check that Cursor is the active application

#### "Touch ID authentication failed"
- Ensure Touch ID is enabled in System Preferences
- Try storing the token again with the setup command
- Check that the token is valid

#### "Invalid GitHub token"
- Verify your token has `repo` scope
- Check token hasn't expired
- Regenerate token if necessary

## Security Benefits

1. **Biometric Security**: Only authorized users can deploy
2. **Environment Lock**: Only works within Cursor
3. **Hardware Security**: Touch ID is hardware-backed
4. **Audit Trail**: All authentication attempts logged
5. **Token Management**: Secure storage in macOS Keychain
6. **API Verification**: Real-time GitHub authentication

## File Structure
```
scripts/
├── cursor-touchid-auth.sh    # Touch ID authentication
├── cursor-deploy.sh          # Main deployment script
└── deploy.sh                 # Original deployment script (backup)
```

This system provides the highest level of security while maintaining ease of use through Touch ID integration.
