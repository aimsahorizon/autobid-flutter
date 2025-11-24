import 'dart:async';
import 'package:autobid/data/models/subscription_tier.dart';
import 'package:uuid/uuid.dart';
import '../../models/user_model.dart';
import 'mock_otp_service.dart';

class MockAuthService {
  final _authStateController = StreamController<UserModel?>.broadcast();
  final _otpService = MockOtpService();
  UserModel? _currentUser;
  final _uuid = const Uuid();

  // In-memory user storage (simulates database)
  final List<UserModel> _users = [];

  // Pending OTP verifications (stores identifier -> user data)
  final Map<String, Map<String, dynamic>> _pendingVerifications = {};

  static const int maxOtpAttempts = 3;
  static const int lockDurationMinutes = 30;

  // Constructor - loads test users for development
  MockAuthService() {
    _loadTestUsers();
    // Emit initial null state to ensure stream is active and has a value
    _authStateController.add(null);
  }

  Stream<UserModel?> get authStateChanges => _authStateController.stream;

  UserModel? getCurrentUser() => _currentUser;

  MockOtpService get otpService => _otpService;

  /// Loads pre-configured test users for development/testing
  void _loadTestUsers() {
    final now = DateTime.now();

    _users.addAll([
      // Test User 1: Verified user (full access)
      UserModel(
        id: 'test-user-1',
        email: 'test@autobid.com',
        phoneNumber: '+639171234567',
        fullName: 'Test User (Verified)',
        password: 'Test123',
        accountType: 'individual',
        createdAt: now.subtract(const Duration(days: 30)),
        verifiedBadge: true,
        accountStatus: AccountStatus.verified,
        kycStatus: 'approved',
      ),

      // Test User 2: Pending KYC review
      UserModel(
        id: 'test-user-2',
        email: 'pending@autobid.com',
        phoneNumber: '+639171234568',
        fullName: 'Pending User',
        password: 'Test123',
        accountType: 'individual',
        createdAt: now.subtract(const Duration(days: 5)),
        verifiedBadge: false,
        accountStatus: AccountStatus.pending,
        kycStatus: 'pending',
      ),

      // Test User 3: Rejected KYC
      UserModel(
        id: 'test-user-3',
        email: 'rejected@autobid.com',
        phoneNumber: '+639171234569',
        fullName: 'Rejected User',
        password: 'Test123',
        accountType: 'individual',
        createdAt: now.subtract(const Duration(days: 10)),
        verifiedBadge: false,
        accountStatus: AccountStatus.rejected,
        kycStatus: 'rejected',
        rejectionReason: 'ID document not clear. Please re-upload.',
      ),

      // Test User 4: For testing password flows
      UserModel(
        id: 'test-user-4',
        email: 'demo@autobid.com',
        phoneNumber: '+639171234570',
        fullName: 'Demo User',
        password: 'Demo123',
        accountType: 'individual',
        createdAt: now.subtract(const Duration(days: 15)),
        verifiedBadge: true,
        accountStatus: AccountStatus.verified,
        kycStatus: 'approved',
      ),
    ]);
  }

  Future<AuthResult> signInWithEmail(String email, String password) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      // LOGIN NEVER FAILS - Always succeed regardless of credentials
      UserModel user;

      // Find user by email or phone
      final existingUser = _findUserByIdentifier(email);

      if (existingUser != null) {
        // Use existing demo account with their respective status
        user = existingUser;

        // Auto-unlock if account was locked (for demo purposes)
        if (user.accountStatus == AccountStatus.locked) {
          user = user.copyWith(
            accountStatus: AccountStatus.pending,
            otpFailureCount: 0,
          );
          final userIndex = _users.indexWhere((u) => u.id == user.id);
          if (userIndex != -1) {
            _users[userIndex] = user;
          }
        }
      } else {
        // Create a new demo user if not found (login never fails)
        user = UserModel(
          id: _uuid.v4(),
          email: email.isEmpty ? 'demo_${_uuid.v4().substring(0, 8)}@autobid.com' : email,
          phoneNumber: '+63917${DateTime.now().millisecondsSinceEpoch % 10000000}',
          fullName: 'Demo User',
          password: password,
          accountType: 'individual',
          createdAt: DateTime.now(),
          verifiedBadge: true,
          accountStatus: AccountStatus.verified,
          kycStatus: 'approved',
        );
        _users.add(user);
      }

      // Success - Always login regardless of credentials
      _currentUser = user;
      _authStateController.add(user);

      return AuthResult(success: true, user: user);
    } catch (e) {
      // Even on exception, create and login a guest user
      final guestUser = UserModel(
        id: _uuid.v4(),
        email: 'guest_${DateTime.now().millisecondsSinceEpoch}@autobid.com',
        fullName: 'Guest User',
        accountType: 'individual',
        createdAt: DateTime.now(),
        verifiedBadge: true,
        accountStatus: AccountStatus.verified,
        kycStatus: 'approved',
      );

      _users.add(guestUser);
      _currentUser = guestUser;
      _authStateController.add(guestUser);

      return AuthResult(success: true, user: guestUser);
    }
  }

  Future<AuthResult> signUpWithEmail({
    required String email,
    required String password,
    required String fullName,
    String? phoneNumber,
  }) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      // Validation
      if (email.isEmpty || password.isEmpty || fullName.isEmpty) {
        return AuthResult(
          success: false,
          errorMessage: 'All fields are required',
        );
      }

      if (!_isValidEmail(email)) {
        return AuthResult(
          success: false,
          errorMessage: 'Invalid email format',
        );
      }

      if (password.length < 6) {
        return AuthResult(
          success: false,
          errorMessage: 'Password must be at least 6 characters',
        );
      }

      if (phoneNumber != null && phoneNumber.isNotEmpty) {
        if (!_isValidPhone(phoneNumber)) {
          return AuthResult(
            success: false,
            errorMessage: 'Invalid phone number format',
          );
        }
      }

      // Create new user
      final user = UserModel(
        id: _uuid.v4(),
        email: email,
        fullName: fullName,
        phoneNumber: phoneNumber,
        kycStatus: 'pending',
        accountType: 'individual',
        createdAt: DateTime.now(),
        verifiedBadge: false,
      );

      _currentUser = user;
      _authStateController.add(user);

      return AuthResult(success: true, user: user);
    } catch (e) {
      return AuthResult(
        success: false,
        errorMessage: 'An error occurred during sign up',
      );
    }
  }

  Future<AuthResult> signInWithGoogle() async {
    try {
      // Optimized: Simulate network delay (reduced from 2s)
      await Future.delayed(const Duration(milliseconds: 600));

      // Create mock Google user
      final user = UserModel(
        id: _uuid.v4(),
        email: 'googleuser@example.com',
        fullName: 'Google User',
        phoneNumber: null,
        kycStatus: 'pending',
        accountType: 'individual',
        createdAt: DateTime.now(),
        verifiedBadge: true,
      );

      _currentUser = user;
      _authStateController.add(user);

      return AuthResult(success: true, user: user);
    } catch (e) {
      return AuthResult(
        success: false,
        errorMessage: 'Google sign-in failed',
      );
    }
  }

  Future<void> signOut() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _currentUser = null;
    _authStateController.add(null);
  }

  Future<AuthResult> updateProfile({
    String? fullName,
    String? phoneNumber,
    DateTime? dateOfBirth,
    String? gender,
  }) async {
    try {
      await Future.delayed(const Duration(milliseconds: 800));

      if (_currentUser == null) {
        return AuthResult(
          success: false,
          errorMessage: 'No user is currently signed in',
        );
      }

      // Validate phone if provided
      if (phoneNumber != null && phoneNumber.isNotEmpty) {
        if (!_isValidPhone(phoneNumber)) {
          return AuthResult(
            success: false,
            errorMessage: 'Invalid phone number format',
          );
        }
      }

      // Update user with new data
      final updatedUser = _currentUser!.copyWith(
        fullName: fullName ?? _currentUser!.fullName,
        phoneNumber: phoneNumber,
        dateOfBirth: dateOfBirth,
        gender: gender,
      );

      _currentUser = updatedUser;
      _authStateController.add(updatedUser);

      return AuthResult(success: true, user: updatedUser);
    } catch (e) {
      return AuthResult(
        success: false,
        errorMessage: 'Failed to update profile',
      );
    }
  }

  Future<AuthResult> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      await Future.delayed(const Duration(milliseconds: 800));

      if (_currentUser == null) {
        return AuthResult(
          success: false,
          errorMessage: 'No user is currently signed in',
        );
      }

      // Validate both passwords are provided
      if (currentPassword.isEmpty || newPassword.isEmpty) {
        return AuthResult(
          success: false,
          errorMessage: 'Both passwords are required',
        );
      }

      // Validate current password matches stored password
      if (_currentUser!.password != currentPassword) {
        return AuthResult(
          success: false,
          errorMessage: 'Current password is incorrect',
        );
      }

      // Validate new password length
      if (newPassword.length < 6) {
        return AuthResult(
          success: false,
          errorMessage: 'New password must be at least 6 characters',
        );
      }

      // Ensure new password is different from current
      if (currentPassword == newPassword) {
        return AuthResult(
          success: false,
          errorMessage: 'New password must be different from current password',
        );
      }

      // Update password in current user and user list
      final updatedUser = _currentUser!.copyWith(password: newPassword);
      _currentUser = updatedUser;

      // Update in user list as well
      final userIndex = _users.indexWhere((u) => u.id == _currentUser!.id);
      if (userIndex != -1) {
        _users[userIndex] = updatedUser;
      }

      _authStateController.add(updatedUser);

      return AuthResult(success: true, user: updatedUser);
    } catch (e) {
      return AuthResult(
        success: false,
        errorMessage: 'Failed to change password',
      );
    }
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  bool _isValidPhone(String phone) {
    final phoneRegex = RegExp(r'^\+?[1-9]\d{1,14}$');
    return phoneRegex.hasMatch(phone.replaceAll(RegExp(r'[\s-]'), ''));
  }

  // ========== OTP-BASED LOGIN FLOW ==========

  /// Step 1: Request OTP for login (email or phone)
  Future<AuthResult> requestLoginOtp(String identifier) async {
    try {
      await Future.delayed(const Duration(milliseconds: 800));

      // Validate identifier
      if (identifier.isEmpty) {
        return AuthResult(
          success: false,
          errorMessage: 'Email or phone number is required',
        );
      }

      // Find existing user
      final user = _findUserByIdentifier(identifier);
      if (user == null) {
        return AuthResult(
          success: false,
          errorMessage: 'No account found with this email or phone number',
        );
      }

      // Check if account is locked
      final lockCheck = _checkAccountLock(user);
      if (!lockCheck.success) {
        return lockCheck;
      }

      // Send OTP
      final otpResult = await _otpService.sendOtp(
        identifier: identifier,
        purpose: OtpPurpose.login,
      );

      if (!otpResult.success) {
        return AuthResult(
          success: false,
          errorMessage: otpResult.errorMessage ?? 'Failed to send OTP',
        );
      }

      // Store user data for verification
      _pendingVerifications[identifier] = {
        'userId': user.id,
        'purpose': 'login',
        'timestamp': DateTime.now(),
      };

      return AuthResult(
        success: true,
        message: 'OTP sent successfully',
        otpSent: true,
        debugOtp: otpResult.otp, // For testing
      );
    } catch (e) {
      return AuthResult(
        success: false,
        errorMessage: 'An error occurred while sending OTP',
      );
    }
  }

  /// Step 2: Verify OTP and complete login
  Future<AuthResult> verifyLoginOtp(String identifier, String otp) async {
    try {
      await Future.delayed(const Duration(milliseconds: 600));

      // Check if there's a pending verification
      if (!_pendingVerifications.containsKey(identifier)) {
        return AuthResult(
          success: false,
          errorMessage: 'No pending verification found. Please request OTP again.',
        );
      }

      // Find user
      final userId = _pendingVerifications[identifier]!['userId'] as String;
      final userIndex = _users.indexWhere((u) => u.id == userId);
      if (userIndex == -1) {
        return AuthResult(
          success: false,
          errorMessage: 'User not found',
        );
      }

      final user = _users[userIndex];

      // Check account lock
      final lockCheck = _checkAccountLock(user);
      if (!lockCheck.success) {
        return lockCheck;
      }

      // Verify OTP
      final verifyResult = await _otpService.verifyOtp(
        identifier: identifier,
        otp: otp,
      );

      if (!verifyResult.success) {
        // Handle failed attempt
        final updatedUser = await _handleFailedOtpAttempt(user);
        return AuthResult(
          success: false,
          errorMessage: verifyResult.errorMessage,
          attemptsRemaining: verifyResult.attemptsRemaining,
          accountLocked: updatedUser.accountStatus == AccountStatus.locked,
        );
      }

      // Success - reset failure count and set as current user
      final updatedUser = user.copyWith(
        otpFailureCount: 0,
        lastOtpAttempt: DateTime.now(),
        accountStatus: user.accountStatus == AccountStatus.guest
            ? AccountStatus.pending
            : user.accountStatus,
      );

      _users[userIndex] = updatedUser;
      _currentUser = updatedUser;
      _authStateController.add(updatedUser);
      _pendingVerifications.remove(identifier);

      return AuthResult(success: true, user: updatedUser);
    } catch (e) {
      return AuthResult(
        success: false,
        errorMessage: 'An error occurred during verification',
      );
    }
  }

  /// Request OTP for security changes (email/phone change)
  /// Does NOT validate if identifier exists in system
  /// Used for verifying new emails/phones during security settings changes
  Future<AuthResult> requestSecurityOtp(String identifier) async {
    try {
      await Future.delayed(const Duration(milliseconds: 800));

      // Validate identifier format only
      if (identifier.isEmpty) {
        return AuthResult(
          success: false,
          errorMessage: 'Email or phone number is required',
        );
      }

      // Send OTP directly without user validation
      final otpResult = await _otpService.sendOtp(
        identifier: identifier,
        purpose: OtpPurpose.emailVerification, // Generic purpose
      );

      if (!otpResult.success) {
        return AuthResult(
          success: false,
          errorMessage: otpResult.errorMessage ?? 'Failed to send OTP',
        );
      }

      return AuthResult(
        success: true,
        message: 'OTP sent successfully',
        otpSent: true,
        debugOtp: otpResult.otp, // For testing
      );
    } catch (e) {
      return AuthResult(
        success: false,
        errorMessage: 'An error occurred while sending OTP',
      );
    }
  }

  // ========== OTP-BASED REGISTRATION FLOW ==========

  /// Step 1: Check if user exists and send registration OTP
  Future<AuthResult> requestRegistrationOtp({
    required String email,
    required String phoneNumber,
  }) async {
    try {
      await Future.delayed(const Duration(milliseconds: 800));

      // Check if user already exists
      final existing = _findUserByIdentifier(email) ??
          _findUserByIdentifier(phoneNumber);
      if (existing != null) {
        return AuthResult(
          success: false,
          errorMessage: 'An account with this email or phone already exists',
        );
      }

      // Send OTP to email
      final emailOtpResult = await _otpService.sendOtp(
        identifier: email,
        purpose: OtpPurpose.emailVerification,
      );

      if (!emailOtpResult.success) {
        return AuthResult(
          success: false,
          errorMessage: 'Failed to send OTP to email',
        );
      }

      // Send OTP to phone
      final phoneOtpResult = await _otpService.sendOtp(
        identifier: phoneNumber,
        purpose: OtpPurpose.phoneVerification,
      );

      if (!phoneOtpResult.success) {
        return AuthResult(
          success: false,
          errorMessage: 'Failed to send OTP to phone',
        );
      }

      return AuthResult(
        success: true,
        message: 'OTPs sent to email and phone',
        otpSent: true,
        debugOtp: '${emailOtpResult.otp}/${phoneOtpResult.otp}',
      );
    } catch (e) {
      return AuthResult(
        success: false,
        errorMessage: 'Failed to send registration OTPs',
      );
    }
  }

  /// Step 2: Verify both email and phone OTPs, then create user
  Future<AuthResult> verifyRegistrationOtp({
    required String email,
    required String phoneNumber,
    required String emailOtp,
    required String phoneOtp,
    required String fullName,
    String? password,
  }) async {
    try {
      await Future.delayed(const Duration(milliseconds: 800));

      // Verify email OTP
      final emailVerify = await _otpService.verifyOtp(
        identifier: email,
        otp: emailOtp,
      );

      if (!emailVerify.success) {
        return AuthResult(
          success: false,
          errorMessage: 'Invalid email OTP: ${emailVerify.errorMessage}',
        );
      }

      // Verify phone OTP
      final phoneVerify = await _otpService.verifyOtp(
        identifier: phoneNumber,
        otp: phoneOtp,
      );

      if (!phoneVerify.success) {
        return AuthResult(
          success: false,
          errorMessage: 'Invalid phone OTP: ${phoneVerify.errorMessage}',
        );
      }

      // Create new user with pending status
      final newUser = UserModel(
        id: _uuid.v4(),
        email: email,
        phoneNumber: phoneNumber,
        fullName: fullName,
        password: password,
        accountType: 'individual',
        createdAt: DateTime.now(),
        verifiedBadge: false,
        accountStatus: AccountStatus.pending,
        kycStatus: 'pending',
      );

      _users.add(newUser);
      _currentUser = newUser;
      _authStateController.add(newUser);

      return AuthResult(success: true, user: newUser);
    } catch (e) {
      return AuthResult(
        success: false,
        errorMessage: 'Failed to complete registration',
      );
    }
  }

  // ========== FORGOT PASSWORD FLOW ==========

  /// Step 1: Request password reset OTP
  Future<AuthResult> requestPasswordResetOtp(String identifier) async {
    try {
      await Future.delayed(const Duration(milliseconds: 800));

      // Find user
      final user = _findUserByIdentifier(identifier);
      if (user == null) {
        return AuthResult(
          success: false,
          errorMessage: 'No account found with this email or phone',
        );
      }

      // Send OTP
      final otpResult = await _otpService.sendOtp(
        identifier: identifier,
        purpose: OtpPurpose.forgotPassword,
      );

      if (!otpResult.success) {
        return AuthResult(
          success: false,
          errorMessage: otpResult.errorMessage ?? 'Failed to send OTP',
        );
      }

      // Store pending reset
      _pendingVerifications[identifier] = {
        'userId': user.id,
        'purpose': 'password_reset',
        'timestamp': DateTime.now(),
      };

      return AuthResult(
        success: true,
        message: 'OTP sent successfully',
        otpSent: true,
        debugOtp: otpResult.otp,
      );
    } catch (e) {
      return AuthResult(
        success: false,
        errorMessage: 'Failed to send password reset OTP',
      );
    }
  }

  /// Step 2: Verify password reset OTP
  Future<AuthResult> verifyPasswordResetOtp(
    String identifier,
    String otp,
  ) async {
    try {
      await Future.delayed(const Duration(milliseconds: 600));

      // Verify OTP
      final verifyResult = await _otpService.verifyOtp(
        identifier: identifier,
        otp: otp,
      );

      if (!verifyResult.success) {
        return AuthResult(
          success: false,
          errorMessage: verifyResult.errorMessage,
        );
      }

      return AuthResult(
        success: true,
        message: 'OTP verified. You can now reset your password.',
      );
    } catch (e) {
      return AuthResult(
        success: false,
        errorMessage: 'OTP verification failed',
      );
    }
  }

  /// Step 3: Reset password after OTP verification
  Future<AuthResult> resetPassword(
    String identifier,
    String newPassword,
  ) async {
    try {
      await Future.delayed(const Duration(milliseconds: 800));

      if (!_pendingVerifications.containsKey(identifier)) {
        return AuthResult(
          success: false,
          errorMessage: 'Please verify OTP first',
        );
      }

      final userId = _pendingVerifications[identifier]!['userId'] as String;
      final userIndex = _users.indexWhere((u) => u.id == userId);
      if (userIndex == -1) {
        return AuthResult(
          success: false,
          errorMessage: 'User not found',
        );
      }

      // Update password
      final updatedUser = _users[userIndex].copyWith(password: newPassword);
      _users[userIndex] = updatedUser;
      _pendingVerifications.remove(identifier);

      return AuthResult(
        success: true,
        message: 'Password reset successfully',
      );
    } catch (e) {
      return AuthResult(
        success: false,
        errorMessage: 'Failed to reset password',
      );
    }
  }

  // ========== ACCOUNT MANAGEMENT ==========

  /// Update user account status (for admin reviews)
  Future<AuthResult> updateAccountStatus({
    required String userId,
    required AccountStatus status,
    String? rejectionReason,
  }) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));

      final userIndex = _users.indexWhere((u) => u.id == userId);
      if (userIndex == -1) {
        return AuthResult(
          success: false,
          errorMessage: 'User not found',
        );
      }

      final updatedUser = _users[userIndex].copyWith(
        accountStatus: status,
        rejectionReason: rejectionReason,
        verifiedBadge: status == AccountStatus.verified,
      );

      _users[userIndex] = updatedUser;

      // Update current user if it's the same
      if (_currentUser?.id == userId) {
        _currentUser = updatedUser;
        _authStateController.add(updatedUser);
      }

      return AuthResult(success: true, user: updatedUser);
    } catch (e) {
      return AuthResult(
        success: false,
        errorMessage: 'Failed to update account status',
      );
    }
  }

  /// Unlock account (admin or automatic after lock period)
  Future<AuthResult> unlockAccount(String userId) async {
    return updateAccountStatus(
      userId: userId,
      status: AccountStatus.pending,
    );
  }

  // ========== HELPER METHODS ==========

  /// Check if account is locked
  AuthResult _checkAccountLock(UserModel user) {
    if (user.accountStatus == AccountStatus.locked) {
      // Check if lock duration has passed
      if (user.lastOtpAttempt != null) {
        final lockDuration = DateTime.now().difference(user.lastOtpAttempt!);
        if (lockDuration.inMinutes < lockDurationMinutes) {
          final remainingMinutes =
              lockDurationMinutes - lockDuration.inMinutes;
          return AuthResult(
            success: false,
            errorMessage:
                'Account is locked. Please try again in $remainingMinutes minutes or contact support.',
            accountLocked: true,
          );
        } else {
          // Auto-unlock after duration
          final userIndex = _users.indexWhere((u) => u.id == user.id);
          if (userIndex != -1) {
            _users[userIndex] = user.copyWith(
              accountStatus: AccountStatus.pending,
              otpFailureCount: 0,
            );
          }
        }
      } else {
        return AuthResult(
          success: false,
          errorMessage: 'Account is locked. Please contact support.',
          accountLocked: true,
        );
      }
    }
    return AuthResult(success: true);
  }

  /// Handle failed OTP attempt
  Future<UserModel> _handleFailedOtpAttempt(UserModel user) async {
    final newFailureCount = user.otpFailureCount + 1;
    final shouldLock = newFailureCount >= maxOtpAttempts;

    final updatedUser = user.copyWith(
      otpFailureCount: newFailureCount,
      lastOtpAttempt: DateTime.now(),
      accountStatus:
          shouldLock ? AccountStatus.locked : user.accountStatus,
    );

    final userIndex = _users.indexWhere((u) => u.id == user.id);
    if (userIndex != -1) {
      _users[userIndex] = updatedUser;
    }

    return updatedUser;
  }

  /// Find user by email or phone
  UserModel? _findUserByIdentifier(String identifier) {
    try {
      return _users.firstWhere(
        (user) =>
            user.email == identifier ||
            user.phoneNumber == identifier,
      );
    } catch (e) {
      return null;
    }
  }

  /// Get all users (for admin panel)
  List<UserModel> getAllUsers() => List.unmodifiable(_users);

  /// Create guest user (browse without registration)
  UserModel createGuestUser() {
    final guest = UserModel(
      id: 'guest_${_uuid.v4()}',
      email: '',
      fullName: 'Guest User',
      accountType: 'guest',
      createdAt: DateTime.now(),
      verifiedBadge: false,
      accountStatus: AccountStatus.guest,
      kycStatus: 'none',
    );
    return guest;
  }

  // ========== SUBSCRIPTION & TOKEN BALANCE UPDATES ==========

  /// Update user's subscription tier
  /// Called by MockSubscriptionService when subscription changes
  Future<void> updateUserSubscriptionTier({
    required String userId,
    required SubscriptionTierType tierType,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final userIndex = _users.indexWhere((u) => u.id == userId);
    if (userIndex == -1) return;

    // Reset listing quota when subscription changes
    final now = DateTime.now();
    final resetDate = now.add(const Duration(days: 30));

    final updatedUser = _users[userIndex].copyWith(
      subscriptionTier: tierType,
      listingsUsedThisMonth: 0, // Reset quota on subscription change
      listingQuotaResetDate: resetDate,
    );

    _users[userIndex] = updatedUser;

    // Update current user if it's the same
    if (_currentUser?.id == userId) {
      _currentUser = updatedUser;
      _authStateController.add(updatedUser);
    }
  }

  /// Update user's token balance
  /// Called by MockTokenService when tokens are purchased or allocated
  Future<void> updateUserTokenBalance({
    required String userId,
    required int tokenBalance,
  }) async {
    await Future.delayed(const Duration(milliseconds: 200));

    final userIndex = _users.indexWhere((u) => u.id == userId);
    if (userIndex == -1) return;

    final updatedUser = _users[userIndex].copyWith(
      tokenBalance: tokenBalance,
      tokenBalanceLastUpdated: DateTime.now(),
    );

    _users[userIndex] = updatedUser;

    // Update current user if it's the same
    if (_currentUser?.id == userId) {
      _currentUser = updatedUser;
      _authStateController.add(updatedUser);
    }
  }

  /// Increment user's listing usage
  /// Called when a listing is successfully created
  Future<void> incrementListingUsage({
    required String userId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 200));

    final userIndex = _users.indexWhere((u) => u.id == userId);
    if (userIndex == -1) return;

    final user = _users[userIndex];

    // Check if quota needs reset (past reset date)
    final now = DateTime.now();
    final needsReset = user.listingQuotaResetDate == null ||
                      now.isAfter(user.listingQuotaResetDate!);

    final updatedUser = user.copyWith(
      listingsUsedThisMonth: needsReset ? 1 : user.listingsUsedThisMonth + 1,
      listingQuotaResetDate: needsReset
          ? now.add(const Duration(days: 30))
          : user.listingQuotaResetDate,
    );

    _users[userIndex] = updatedUser;

    // Update current user if it's the same
    if (_currentUser?.id == userId) {
      _currentUser = updatedUser;
      _authStateController.add(updatedUser);
    }
  }

  /// Reset user's listing quota
  /// Called when quota reset date has passed or on subscription renewal
  Future<void> resetListingQuota({
    required String userId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 200));

    final userIndex = _users.indexWhere((u) => u.id == userId);
    if (userIndex == -1) return;

    final now = DateTime.now();
    final updatedUser = _users[userIndex].copyWith(
      listingsUsedThisMonth: 0,
      listingQuotaResetDate: now.add(const Duration(days: 30)),
    );

    _users[userIndex] = updatedUser;

    // Update current user if it's the same
    if (_currentUser?.id == userId) {
      _currentUser = updatedUser;
      _authStateController.add(updatedUser);
    }
  }

  void dispose() {
    _authStateController.close();
  }
}

class AuthResult {
  final bool success;
  final UserModel? user;
  final String? errorMessage;
  final String? message;
  final bool otpSent;
  final String? debugOtp; // For testing/debugging
  final bool accountLocked;
  final int? attemptsRemaining;

  AuthResult({
    required this.success,
    this.user,
    this.errorMessage,
    this.message,
    this.otpSent = false,
    this.debugOtp,
    this.accountLocked = false,
    this.attemptsRemaining,
  });
}
