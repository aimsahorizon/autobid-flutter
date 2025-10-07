import 'package:freezed_annotation/freezed_annotation.dart';
import 'kyc_model.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

enum VerificationLevel {
  @JsonValue('unverified')
  unverified,
  @JsonValue('level1')
  level1,
  @JsonValue('level2')
  level2,
  @JsonValue('level3')
  level3,
  @JsonValue('dealer')
  dealer,
}

enum ProofOfAddressType {
  @JsonValue('utility_bill')
  utilityBill,
  @JsonValue('bank_statement')
  bankStatement,
  @JsonValue('government_letter')
  governmentLetter,
  @JsonValue('rental_contract')
  rentalContract,
  @JsonValue('barangay_certificate')
  barangayCertificate,
}

enum BackgroundCheckStatus {
  @JsonValue('none')
  none,
  @JsonValue('pending')
  pending,
  @JsonValue('cleared')
  cleared,
  @JsonValue('rejected')
  rejected,
}

@freezed
abstract class ProofOfAddress with _$ProofOfAddress {
  const factory ProofOfAddress({
    required ProofOfAddressType type,
    required String imageUrl,
    required DateTime uploadedAt,
    @Default(false) bool verified,
  }) = _ProofOfAddress;

  factory ProofOfAddress.fromJson(Map<String, dynamic> json) =>
      _$ProofOfAddressFromJson(json);
}

@freezed
abstract class NbiClearance with _$NbiClearance {
  const factory NbiClearance({
    required String imageUrl,
    required DateTime issueDate,
    required DateTime expiryDate,
  }) = _NbiClearance;

  factory NbiClearance.fromJson(Map<String, dynamic> json) =>
      _$NbiClearanceFromJson(json);
}

@freezed
abstract class VerificationLimits with _$VerificationLimits {
  const factory VerificationLimits({
    required int buyLimit,
    required int sellLimit,
  }) = _VerificationLimits;

  factory VerificationLimits.fromJson(Map<String, dynamic> json) =>
      _$VerificationLimitsFromJson(json);
}

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String email,
    required String fullName,
    String? firstName,
    String? middleName,
    String? lastName,
    DateTime? dateOfBirth,
    String? gender,
    String? phoneNumber,
    String? street,
    String? barangay,
    String? city,
    String? province,
    String? zipCode,
    String? nationality,
    @Default(false) bool termsAccepted,
    @Default(false) bool privacyAccepted,
    @Default('pending') String kycStatus,
    @Default('individual') String accountType,
    required DateTime createdAt,
    @Default(false) bool verifiedBadge,
    KycModel? kycData,
    @Default(VerificationLevel.unverified) VerificationLevel verificationLevel,
    VerificationLimits? verificationLimits,
    ProofOfAddress? proofOfAddress,
    String? tin,
    NbiClearance? nbiClearance,
    @Default(BackgroundCheckStatus.none) BackgroundCheckStatus backgroundCheckStatus,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
