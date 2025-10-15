import 'dart:async';
import 'dart:math';

/// Mock OTP Service for simulating OTP generation, delivery, and validation
/// This is a frontend-only implementation for prototype purposes
class MockOtpService {
  final Map<String, _OtpData> _otpStorage = {};
  final Random _random = Random();

  static const int otpLength = 6;
  static const int otpValiditySeconds = 60;
  static const int maxResendAttempts = 3;
  static const int maxVerificationAttempts = 3;
  static const double deliverySuccessRate = 0.8; // 80% success rate

  /// Generates and "sends" an OTP to the specified identifier (email or phone)
  /// Returns SendOtpResult with success status and generated OTP (for testing)
  Future<SendOtpResult> sendOtp({
    required String identifier, // email or phone
    required OtpPurpose purpose,
  }) async {
    // Simulate network delay
    await Future.delayed(Duration(milliseconds: 500 + _random.nextInt(1000)));

    // Check if there's an existing OTP that's still valid
    final existing = _otpStorage[identifier];
    if (existing != null && !existing.isExpired) {
      // Check resend attempts
      if (existing.resendCount >= maxResendAttempts) {
        return SendOtpResult(
          success: false,
          errorMessage: 'Maximum resend attempts reached. Please try again later.',
        );
      }
    }

    // Generate 6-digit OTP
    final otp = _generateOtp();

    // Simulate delivery success/failure (80% success)
    final deliverySuccessful = _random.nextDouble() < deliverySuccessRate;

    if (!deliverySuccessful) {
      return SendOtpResult(
        success: false,
        errorMessage: 'Failed to send OTP. Please try again.',
      );
    }

    // Store OTP with metadata
    final resendCount = existing?.resendCount ?? 0;
    _otpStorage[identifier] = _OtpData(
      otp: otp,
      purpose: purpose,
      expiresAt: DateTime.now().add(const Duration(seconds: otpValiditySeconds)),
      createdAt: DateTime.now(),
      resendCount: resendCount + 1,
      verificationAttempts: 0,
    );

    return SendOtpResult(
      success: true,
      otp: otp, // Include OTP in result for testing/debugging
      expiresInSeconds: otpValiditySeconds,
    );
  }

  /// Verifies an OTP for the given identifier
  Future<VerifyOtpResult> verifyOtp({
    required String identifier,
    required String otp,
  }) async {
    // Simulate network delay
    await Future.delayed(Duration(milliseconds: 300 + _random.nextInt(700)));

    final stored = _otpStorage[identifier];

    // No OTP found
    if (stored == null) {
      return VerifyOtpResult(
        success: false,
        errorMessage: 'No OTP found. Please request a new one.',
      );
    }

    // OTP expired
    if (stored.isExpired) {
      _otpStorage.remove(identifier);
      return VerifyOtpResult(
        success: false,
        errorMessage: 'OTP has expired. Please request a new one.',
      );
    }

    // Check verification attempts
    if (stored.verificationAttempts >= maxVerificationAttempts) {
      _otpStorage.remove(identifier);
      return VerifyOtpResult(
        success: false,
        errorMessage: 'Maximum verification attempts reached. Please request a new OTP.',
        attemptsExceeded: true,
      );
    }

    // Increment verification attempts
    stored.verificationAttempts++;

    // Verify OTP
    if (stored.otp == otp) {
      // Success - remove OTP from storage
      _otpStorage.remove(identifier);
      return VerifyOtpResult(
        success: true,
        purpose: stored.purpose,
      );
    } else {
      // Failed verification
      final attemptsLeft = maxVerificationAttempts - stored.verificationAttempts;
      return VerifyOtpResult(
        success: false,
        errorMessage: 'Invalid OTP. $attemptsLeft attempt(s) remaining.',
        attemptsRemaining: attemptsLeft,
      );
    }
  }

  /// Resends OTP to the same identifier
  Future<SendOtpResult> resendOtp({
    required String identifier,
    required OtpPurpose purpose,
  }) async {
    return sendOtp(identifier: identifier, purpose: purpose);
  }

  /// Gets remaining time for OTP validity
  int? getRemainingSeconds(String identifier) {
    final stored = _otpStorage[identifier];
    if (stored == null || stored.isExpired) return null;

    return stored.expiresAt.difference(DateTime.now()).inSeconds;
  }

  /// Checks if identifier has an active OTP
  bool hasActiveOtp(String identifier) {
    final stored = _otpStorage[identifier];
    return stored != null && !stored.isExpired;
  }

  /// Clears OTP for identifier (useful for testing or cancellation)
  void clearOtp(String identifier) {
    _otpStorage.remove(identifier);
  }

  /// Clears all expired OTPs (cleanup)
  void clearExpired() {
    _otpStorage.removeWhere((key, value) => value.isExpired);
  }

  String _generateOtp() {
    return List.generate(
      otpLength,
      (index) => _random.nextInt(10).toString(),
    ).join();
  }
}

/// Internal class to store OTP data
class _OtpData {
  final String otp;
  final OtpPurpose purpose;
  final DateTime expiresAt;
  final DateTime createdAt;
  int resendCount;
  int verificationAttempts;

  _OtpData({
    required this.otp,
    required this.purpose,
    required this.expiresAt,
    required this.createdAt,
    required this.resendCount,
    required this.verificationAttempts,
  });

  bool get isExpired => DateTime.now().isAfter(expiresAt);
}

/// Purpose of OTP
enum OtpPurpose {
  login,
  registration,
  forgotPassword,
  phoneVerification,
  emailVerification,
}

/// Result of sending OTP
class SendOtpResult {
  final bool success;
  final String? otp; // For testing/debugging only
  final int? expiresInSeconds;
  final String? errorMessage;

  SendOtpResult({
    required this.success,
    this.otp,
    this.expiresInSeconds,
    this.errorMessage,
  });
}

/// Result of verifying OTP
class VerifyOtpResult {
  final bool success;
  final OtpPurpose? purpose;
  final String? errorMessage;
  final int? attemptsRemaining;
  final bool attemptsExceeded;

  VerifyOtpResult({
    required this.success,
    this.purpose,
    this.errorMessage,
    this.attemptsRemaining,
    this.attemptsExceeded = false,
  });
}
