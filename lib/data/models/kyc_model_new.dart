import 'package:freezed_annotation/freezed_annotation.dart';

part 'kyc_model_new.freezed.dart';
part 'kyc_model_new.g.dart';

enum SecondaryIdType {
  @JsonValue('drivers_license')
  driversLicense,
  @JsonValue('passport')
  passport,
  @JsonValue('sss')
  sss,
  @JsonValue('umid')
  umid,
  @JsonValue('prc')
  prc,
  @JsonValue('voters_id')
  votersId,
  @JsonValue('postal_id')
  postalId,
}

enum KycVerificationStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('verified')
  verified,
  @JsonValue('rejected')
  rejected,
}

enum Gender {
  @JsonValue('male')
  male,
  @JsonValue('female')
  female,
}

@freezed
abstract class PhilippineAddress with _$PhilippineAddress {
  const factory PhilippineAddress({
    required String street,
    required String barangay,
    required String city,
    required String province,
    required String zipCode,
  }) = _PhilippineAddress;

  factory PhilippineAddress.fromJson(Map<String, dynamic> json) =>
      _$PhilippineAddressFromJson(json);
}

@freezed
abstract class KycModelNew with _$KycModelNew {
  const factory KycModelNew({
    required String id,
    required String userId,
    // Primary ID (Philippine National ID - Fixed)
    @Default('Philippine National ID') String primaryIdType,
    required String primaryIdNumber,
    required String primaryIdFrontImage,
    required String primaryIdBackImage,
    // Secondary ID
    required SecondaryIdType secondaryIdType,
    required String secondaryIdNumber,
    required String secondaryIdImage,
    // Selfie
    required String selfieImage,
    // Personal Information
    required DateTime dateOfBirth,
    required PhilippineAddress address,
    // Verification
    required KycVerificationStatus verificationStatus,
    required DateTime submittedAt,
    DateTime? verifiedAt,
    String? rejectionReason,
  }) = _KycModelNew;

  factory KycModelNew.fromJson(Map<String, dynamic> json) =>
      _$KycModelNewFromJson(json);
}
