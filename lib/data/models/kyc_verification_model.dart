import 'package:freezed_annotation/freezed_annotation.dart';

part 'kyc_verification_model.freezed.dart';
part 'kyc_verification_model.g.dart';

/// Government-issued ID types valid in the Philippines
enum GovernmentIdType {
  @JsonValue('drivers_license')
  driversLicense,
  @JsonValue('passport')
  passport,
  @JsonValue('national_id')
  nationalId, // PhilSys National ID
  @JsonValue('umid')
  umid, // Unified Multi-Purpose ID
  @JsonValue('sss')
  sss, // Social Security System ID
  @JsonValue('gsis')
  gsis, // Government Service Insurance System ID
  @JsonValue('philhealth')
  philhealth,
  @JsonValue('voters_id')
  votersId,
  @JsonValue('prc_id')
  prcId, // Professional Regulation Commission ID
}

/// KYC verification status
enum KycVerificationStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('verified')
  verified,
  @JsonValue('rejected')
  rejected,
}

/// KYC verification model for identity confirmation under RA 8792
/// Ensures buyer and seller identities are verified before digital agreement
@freezed
abstract class KycVerification with _$KycVerification {
  const factory KycVerification({
    required String id,
    required String userId,
    required String userName,

    // ===== GOVERNMENT ID VERIFICATION =====
    /// Type of government-issued ID submitted
    required GovernmentIdType governmentIdType,

    /// ID number (encrypted in production, plain for mock)
    required String governmentIdNumber,

    /// URL to uploaded government ID photo (front and back)
    required String governmentIdPhotoUrl,

    /// URL to selfie photo holding ID
    required String selfiePhotoUrl,

    // ===== RA 8792 LEGAL COMPLIANCE =====
    /// User consent that this verification is legally binding under RA 8792
    /// "I agree that this verification and identity confirmation are legally
    /// binding under the Electronic Commerce Act of 2000 (RA 8792)."
    @Default(false) bool ra8792ConsentGiven,

    // ===== VERIFICATION METADATA =====
    /// Timestamp when verification was completed (null if pending)
    DateTime? verifiedAt,

    /// Current verification status
    @Default(KycVerificationStatus.pending) KycVerificationStatus status,

    /// Rejection reason if status is rejected
    String? rejectionReason,

    /// Timestamp when verification was submitted
    required DateTime submittedAt,
  }) = _KycVerification;

  factory KycVerification.fromJson(Map<String, dynamic> json) =>
      _$KycVerificationFromJson(json);
}
