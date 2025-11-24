# Fix Instructions

## Problem
The Freezed generated files are out of sync with the UserModel definition. The UserModel was updated with new fields (password, rejectionReason, accountStatus, otpFailureCount, lastOtpAttempt) but the generated files haven't been regenerated.

## Solution

**IMPORTANT: Run these commands from your IDE's terminal (VS Code/Android Studio) or from a terminal where Flutter is in your PATH.**

### Option 1: Run from VS Code Terminal (Recommended)
1. Open VS Code
2. Open the project folder: `C:\Users\nekol\Desktop\Flutter\AutoBID\autobid`
3. Open a new terminal (Terminal > New Terminal)
4. Run these commands:

```bash
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

### Option 2: Run from Android Studio Terminal
1. Open Android Studio
2. Open the project
3. Click on "Terminal" tab at the bottom
4. Run the same commands as above

### Option 3: Run from Command Prompt (if Flutter is in PATH)
```cmd
cd C:\Users\nekol\Desktop\Flutter\AutoBID\autobid
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

### Step 3: Verify the fix
After regeneration completes, run:

```bash
flutter analyze
```

This should show no errors related to UserModel fields.

### Step 4: Test the app
Run the app to ensure everything works:

```bash
flutter run
```

## What was changed

### Files modified:
1. `lib/data/models/user_model.dart` - Added new fields for authentication flow
2. `lib/data/services/local/local_storage_service.dart` - Uses new accountStatus field
3. `lib/presentation/screens/guest/tabs/account_tab.dart` - Uses password and accountStatus
4. `lib/presentation/screens/guest/widgets/account_status_card.dart` - Uses accountStatus and rejectionReason
5. `lib/presentation/screens/auth/signup/signup_step8_review.dart` - Creates user with accountStatus.pending
6. All signup navigation paths fixed for 9-step flow

### New fields in UserModel:
- `String? password` - User password for login
- `String? rejectionReason` - Reason if application rejected
- `AccountStatus accountStatus` - Current account status (guest/pending/rejected/verified/locked)
- `int otpFailureCount` - Track OTP verification failures
- `DateTime? lastOtpAttempt` - Track last OTP attempt time

## If you still see errors

If after regeneration you still see errors, please share the specific error messages.
