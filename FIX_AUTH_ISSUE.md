# Authentication State Persistence Issue - Root Cause Analysis

## Problem Description

**Symptoms:**
- User logs in successfully
- Briefly navigates to home screen
- App reloads and returns to login page
- Authentication state appears to be lost

## Root Cause

The authentication providers are **auto-disposing** due to generated code not being updated.

### Technical Breakdown:

1. **Login Flow Completes**
   - User authenticates successfully
   - `MockAuthService` sets auth state
   - Navigation to `/home` occurs

2. **Router Rebuild Triggered**
   - Router watches `authStateChangesProvider`
   - Provider is marked as `isAutoDispose: true` (line 112 in auth_provider.g.dart)
   - When router rebuilds, Riverpod disposes unused providers

3. **Provider Recreation**
   - New `MockAuthService()` instance created
   - Fresh, empty user list loaded
   - Auth state stream emits `null` (no logged-in user)

4. **Redirect Loop**
   - Router sees `authState.value == null`
   - Redirects to `/login` (line 72-76 in app_router.dart)
   - **User is logged out automatically**

## Evidence

**File:** `lib/presentation/providers/auth_provider.g.dart`

```dart
// Line 25, 66, 112 - All providers still have auto-dispose enabled
isAutoDispose: true,  // ❌ This is the problem
```

**Expected (after running build_runner):**
```dart
isAutoDispose: false,  // ✅ Keeps provider alive
```

## Solution

The `@Riverpod(keepAlive: true)` annotation was added to the source file (`auth_provider.dart`), but the **generated code hasn't been updated**.

### **CRITICAL: Run Build Runner**

Execute one of the following commands:

**Option 1: Using batch file**
```cmd
regenerate_freezed.bat
```

**Option 2: Direct command (if Flutter is in PATH)**
```cmd
flutter pub run build_runner build --delete-conflicting-outputs
```

**Option 3: Via IDE**
- Open terminal in VS Code/Android Studio
- Run: `flutter pub run build_runner build --delete-conflicting-outputs`

### What This Will Fix:

The build_runner will regenerate `auth_provider.g.dart` with:
- `isAutoDispose: false` for `authServiceProvider`
- `isAutoDispose: false` for `authRepositoryProvider`
- `isAutoDispose: false` for `authStateChangesProvider`

This ensures providers **persist** throughout the app lifecycle and don't get recreated on navigation.

## Verification

After running build_runner, verify the fix:

1. Check `lib/presentation/providers/auth_provider.g.dart`
2. Look for lines containing `isAutoDispose:`
3. Confirm they are set to `false` for auth-related providers

## Additional Context

**Files Involved:**
- `lib/presentation/providers/auth_provider.dart` - Source (already fixed)
- `lib/presentation/providers/auth_provider.g.dart` - Generated (needs update)
- `lib/data/services/mock/mock_auth_service.dart` - Service initialization
- `lib/core/router/app_router.dart` - Router redirect logic

**Why This Wasn't Caught Earlier:**
- Build runner commands couldn't execute via Bash tool on Windows
- IDE diagnostics don't show build_runner errors
- Generated code changes require manual rebuild

---

**Status:** Awaiting build_runner execution to complete fix
**Priority:** CRITICAL - Blocks authentication flow
**Estimated Fix Time:** 1-2 minutes (time to run build_runner)
