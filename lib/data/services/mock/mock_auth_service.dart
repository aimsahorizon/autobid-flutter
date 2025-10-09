import 'dart:async';
import 'package:uuid/uuid.dart';
import '../../models/user_model.dart';

class MockAuthService {
  final _authStateController = StreamController<UserModel?>.broadcast();
  UserModel? _currentUser;
  final _uuid = const Uuid();

  Stream<UserModel?> get authStateChanges => _authStateController.stream;

  UserModel? getCurrentUser() => _currentUser;

  Future<AuthResult> signInWithEmail(String email, String password) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      // Basic validation
      if (email.isEmpty || password.isEmpty) {
        return AuthResult(
          success: false,
          errorMessage: 'Email and password are required',
        );
      }

      if (password.length < 6) {
        return AuthResult(
          success: false,
          errorMessage: 'Invalid credentials',
        );
      }

      // Create mock user
      final user = UserModel(
        id: _uuid.v4(),
        email: email,
        fullName: 'Test User',
        phoneNumber: '+1234567890',
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
        errorMessage: 'An error occurred during sign in',
      );
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
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));

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

      // Mock validation - in production, verify currentPassword
      if (currentPassword.isEmpty || newPassword.isEmpty) {
        return AuthResult(
          success: false,
          errorMessage: 'Both passwords are required',
        );
      }

      if (newPassword.length < 6) {
        return AuthResult(
          success: false,
          errorMessage: 'New password must be at least 6 characters',
        );
      }

      return AuthResult(success: true, user: _currentUser);
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

  void dispose() {
    _authStateController.close();
  }
}

class AuthResult {
  final bool success;
  final UserModel? user;
  final String? errorMessage;

  AuthResult({
    required this.success,
    this.user,
    this.errorMessage,
  });
}
