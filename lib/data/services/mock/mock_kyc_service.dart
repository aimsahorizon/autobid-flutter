import 'dart:async';
import 'dart:typed_data';
import 'package:uuid/uuid.dart';
import '../../models/kyc_model.dart';

class MockKycService {
  final _uuid = const Uuid();
  final Map<String, KycModel> _kycDatabase = {};
  final Map<String, Timer> _autoApproveTimers = {};

  Future<KycModel> submitKYC({
    required String userId,
    required IdType idType,
    required String idNumber,
    required Uint8List primaryIdImage,
    Uint8List? secondaryIdImage,
    required Uint8List selfieImage,
  }) async {
    // Simulate upload delay
    await Future.delayed(const Duration(seconds: 2));

    // Generate fake URLs for uploaded images
    final primaryIdUrl = 'https://storage.autobid.com/kyc/${_uuid.v4()}_primary.jpg';
    final secondaryIdUrl = secondaryIdImage != null
        ? 'https://storage.autobid.com/kyc/${_uuid.v4()}_secondary.jpg'
        : null;
    final selfieUrl = 'https://storage.autobid.com/kyc/${_uuid.v4()}_selfie.jpg';

    final kycModel = KycModel(
      id: _uuid.v4(),
      userId: userId,
      idType: idType,
      idNumber: idNumber,
      idImageUrl: primaryIdUrl,
      secondaryIdImageUrl: secondaryIdUrl,
      selfieUrl: selfieUrl,
      verificationStatus: KycVerificationStatus.pending,
      submittedAt: DateTime.now(),
    );

    _kycDatabase[userId] = kycModel;

    // Auto-approve after 3 seconds for demo
    _autoApproveTimers[userId]?.cancel();
    _autoApproveTimers[userId] = Timer(const Duration(seconds: 3), () {
      _autoApproveKyc(userId);
    });

    return kycModel;
  }

  void _autoApproveKyc(String userId) {
    final kyc = _kycDatabase[userId];
    if (kyc != null && kyc.verificationStatus == KycVerificationStatus.pending) {
      _kycDatabase[userId] = kyc.copyWith(
        verificationStatus: KycVerificationStatus.verified,
        verifiedAt: DateTime.now(),
      );
    }
  }

  Future<KycModel?> getKYCStatus(String userId) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return _kycDatabase[userId];
  }

  Future<bool> hasVerifiedKYC(String userId) async {
    final kyc = await getKYCStatus(userId);
    return kyc?.verificationStatus == KycVerificationStatus.verified;
  }

  // For testing purposes - manually reject KYC
  Future<void> rejectKYC(String userId, String reason) async {
    final kyc = _kycDatabase[userId];
    if (kyc != null) {
      _autoApproveTimers[userId]?.cancel();
      _kycDatabase[userId] = kyc.copyWith(
        verificationStatus: KycVerificationStatus.rejected,
        rejectionReason: reason,
      );
    }
  }

  // Submit full registration with all user data
  Future<Map<String, dynamic>> submitRegistration({
    required String email,
    required String password,
    required String phoneNumber,
    required String firstName,
    required String middleName,
    required String lastName,
    required DateTime dateOfBirth,
    required String gender,
    required String street,
    required String barangay,
    required String city,
    required String province,
    required String zipCode,
    required String nationality,
    required String nationalIdNumber,
    required Uint8List primaryIdFront,
    required Uint8List primaryIdBack,
    required String secondaryIdType,
    required String secondaryIdNumber,
    required Uint8List secondaryIdImage,
    required Uint8List selfieImage,
    required bool termsAccepted,
    required bool privacyAccepted,
  }) async {
    // Validate required fields
    if (email.isEmpty || password.isEmpty || phoneNumber.isEmpty) {
      throw Exception('Email, password, and phone number are required');
    }

    if (firstName.isEmpty || lastName.isEmpty) {
      throw Exception('First name and last name are required');
    }

    if (!termsAccepted || !privacyAccepted) {
      throw Exception('Terms and Privacy Policy must be accepted');
    }

    // Simulate API delay
    await Future.delayed(const Duration(seconds: 2));

    // Generate user ID
    final userId = _uuid.v4();

    // Generate fake URLs for uploaded images
    final primaryIdFrontUrl = 'https://storage.autobid.com/kyc/${_uuid.v4()}_primary_front.jpg';
    // Primary ID back is stored for future use
    // ignore: unused_local_variable
    final primaryIdBackUrl = 'https://storage.autobid.com/kyc/${_uuid.v4()}_primary_back.jpg';
    final secondaryIdUrl = 'https://storage.autobid.com/kyc/${_uuid.v4()}_secondary.jpg';
    final selfieUrl = 'https://storage.autobid.com/kyc/${_uuid.v4()}_selfie.jpg';

    // Create KYC model
    final kycModel = KycModel(
      id: _uuid.v4(),
      userId: userId,
      idType: IdType.nationalId,
      idNumber: nationalIdNumber,
      idImageUrl: primaryIdFrontUrl,
      secondaryIdImageUrl: secondaryIdUrl,
      selfieUrl: selfieUrl,
      verificationStatus: KycVerificationStatus.pending,
      submittedAt: DateTime.now(),
    );

    _kycDatabase[userId] = kycModel;

    // Auto-approve after 5 seconds for demo
    _autoApproveTimers[userId]?.cancel();
    _autoApproveTimers[userId] = Timer(const Duration(seconds: 5), () {
      _autoApproveKyc(userId);
    });

    return {
      'userId': userId,
      'email': email,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'kycStatus': 'pending',
      'message': 'Registration submitted successfully',
    };
  }

  void dispose() {
    for (var timer in _autoApproveTimers.values) {
      timer.cancel();
    }
    _autoApproveTimers.clear();
  }
}
