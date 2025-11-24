import 'package:freezed_annotation/freezed_annotation.dart';

part 'kyc_model.freezed.dart';
part 'kyc_model.g.dart';

enum IdType {
  @JsonValue('national_id')
  nationalId,
  @JsonValue('drivers_license')
  driversLicense,
  @JsonValue('passport')
  passport,
  @JsonValue('voters_id')
  votersId,
}

enum KycVerificationStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('verified')
  verified,
  @JsonValue('rejected')
  rejected,
}

@freezed
abstract class KycModel with _$KycModel {
  const factory KycModel({
    required String id,
    required String userId,
    required IdType idType,
    required String idNumber,
    required String idImageUrl,
    String? secondaryIdImageUrl,
    required String selfieUrl,
    required KycVerificationStatus verificationStatus,
    required DateTime submittedAt,
    DateTime? verifiedAt,
    String? rejectionReason,
  }) = _KycModel;

  factory KycModel.fromJson(Map<String, dynamic> json) =>
      _$KycModelFromJson(json);

  get secondaryIdType => null;
}
