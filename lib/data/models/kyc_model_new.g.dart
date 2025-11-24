// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kyc_model_new.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PhilippineAddress _$PhilippineAddressFromJson(Map<String, dynamic> json) =>
    _PhilippineAddress(
      street: json['street'] as String,
      barangay: json['barangay'] as String,
      city: json['city'] as String,
      province: json['province'] as String,
      zipCode: json['zipCode'] as String,
    );

Map<String, dynamic> _$PhilippineAddressToJson(_PhilippineAddress instance) =>
    <String, dynamic>{
      'street': instance.street,
      'barangay': instance.barangay,
      'city': instance.city,
      'province': instance.province,
      'zipCode': instance.zipCode,
    };

_KycModelNew _$KycModelNewFromJson(Map<String, dynamic> json) => _KycModelNew(
  id: json['id'] as String,
  userId: json['userId'] as String,
  primaryIdType: json['primaryIdType'] as String? ?? 'Philippine National ID',
  primaryIdNumber: json['primaryIdNumber'] as String,
  primaryIdFrontImage: json['primaryIdFrontImage'] as String,
  primaryIdBackImage: json['primaryIdBackImage'] as String,
  secondaryIdType: $enumDecode(
    _$SecondaryIdTypeEnumMap,
    json['secondaryIdType'],
  ),
  secondaryIdNumber: json['secondaryIdNumber'] as String,
  secondaryIdImage: json['secondaryIdImage'] as String,
  selfieImage: json['selfieImage'] as String,
  dateOfBirth: DateTime.parse(json['dateOfBirth'] as String),
  address: PhilippineAddress.fromJson(json['address'] as Map<String, dynamic>),
  verificationStatus: $enumDecode(
    _$KycVerificationStatusEnumMap,
    json['verificationStatus'],
  ),
  submittedAt: DateTime.parse(json['submittedAt'] as String),
  verifiedAt: json['verifiedAt'] == null
      ? null
      : DateTime.parse(json['verifiedAt'] as String),
  rejectionReason: json['rejectionReason'] as String?,
);

Map<String, dynamic> _$KycModelNewToJson(_KycModelNew instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'primaryIdType': instance.primaryIdType,
      'primaryIdNumber': instance.primaryIdNumber,
      'primaryIdFrontImage': instance.primaryIdFrontImage,
      'primaryIdBackImage': instance.primaryIdBackImage,
      'secondaryIdType': _$SecondaryIdTypeEnumMap[instance.secondaryIdType]!,
      'secondaryIdNumber': instance.secondaryIdNumber,
      'secondaryIdImage': instance.secondaryIdImage,
      'selfieImage': instance.selfieImage,
      'dateOfBirth': instance.dateOfBirth.toIso8601String(),
      'address': instance.address,
      'verificationStatus':
          _$KycVerificationStatusEnumMap[instance.verificationStatus]!,
      'submittedAt': instance.submittedAt.toIso8601String(),
      'verifiedAt': instance.verifiedAt?.toIso8601String(),
      'rejectionReason': instance.rejectionReason,
    };

const _$SecondaryIdTypeEnumMap = {
  SecondaryIdType.driversLicense: 'drivers_license',
  SecondaryIdType.passport: 'passport',
  SecondaryIdType.sss: 'sss',
  SecondaryIdType.umid: 'umid',
  SecondaryIdType.prc: 'prc',
  SecondaryIdType.votersId: 'voters_id',
  SecondaryIdType.postalId: 'postal_id',
};

const _$KycVerificationStatusEnumMap = {
  KycVerificationStatus.pending: 'pending',
  KycVerificationStatus.verified: 'verified',
  KycVerificationStatus.rejected: 'rejected',
};
