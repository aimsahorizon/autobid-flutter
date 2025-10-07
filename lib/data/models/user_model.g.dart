// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProofOfAddress _$ProofOfAddressFromJson(Map<String, dynamic> json) =>
    _ProofOfAddress(
      type: $enumDecode(_$ProofOfAddressTypeEnumMap, json['type']),
      imageUrl: json['imageUrl'] as String,
      uploadedAt: DateTime.parse(json['uploadedAt'] as String),
      verified: json['verified'] as bool? ?? false,
    );

Map<String, dynamic> _$ProofOfAddressToJson(_ProofOfAddress instance) =>
    <String, dynamic>{
      'type': _$ProofOfAddressTypeEnumMap[instance.type]!,
      'imageUrl': instance.imageUrl,
      'uploadedAt': instance.uploadedAt.toIso8601String(),
      'verified': instance.verified,
    };

const _$ProofOfAddressTypeEnumMap = {
  ProofOfAddressType.utilityBill: 'utility_bill',
  ProofOfAddressType.bankStatement: 'bank_statement',
  ProofOfAddressType.governmentLetter: 'government_letter',
  ProofOfAddressType.rentalContract: 'rental_contract',
  ProofOfAddressType.barangayCertificate: 'barangay_certificate',
};

_NbiClearance _$NbiClearanceFromJson(Map<String, dynamic> json) =>
    _NbiClearance(
      imageUrl: json['imageUrl'] as String,
      issueDate: DateTime.parse(json['issueDate'] as String),
      expiryDate: DateTime.parse(json['expiryDate'] as String),
    );

Map<String, dynamic> _$NbiClearanceToJson(_NbiClearance instance) =>
    <String, dynamic>{
      'imageUrl': instance.imageUrl,
      'issueDate': instance.issueDate.toIso8601String(),
      'expiryDate': instance.expiryDate.toIso8601String(),
    };

_VerificationLimits _$VerificationLimitsFromJson(Map<String, dynamic> json) =>
    _VerificationLimits(
      buyLimit: (json['buyLimit'] as num).toInt(),
      sellLimit: (json['sellLimit'] as num).toInt(),
    );

Map<String, dynamic> _$VerificationLimitsToJson(_VerificationLimits instance) =>
    <String, dynamic>{
      'buyLimit': instance.buyLimit,
      'sellLimit': instance.sellLimit,
    };

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
  id: json['id'] as String,
  email: json['email'] as String,
  fullName: json['fullName'] as String,
  firstName: json['firstName'] as String?,
  middleName: json['middleName'] as String?,
  lastName: json['lastName'] as String?,
  dateOfBirth: json['dateOfBirth'] == null
      ? null
      : DateTime.parse(json['dateOfBirth'] as String),
  gender: json['gender'] as String?,
  phoneNumber: json['phoneNumber'] as String?,
  street: json['street'] as String?,
  barangay: json['barangay'] as String?,
  city: json['city'] as String?,
  province: json['province'] as String?,
  zipCode: json['zipCode'] as String?,
  nationality: json['nationality'] as String?,
  termsAccepted: json['termsAccepted'] as bool? ?? false,
  privacyAccepted: json['privacyAccepted'] as bool? ?? false,
  kycStatus: json['kycStatus'] as String? ?? 'pending',
  accountType: json['accountType'] as String? ?? 'individual',
  createdAt: DateTime.parse(json['createdAt'] as String),
  verifiedBadge: json['verifiedBadge'] as bool? ?? false,
  kycData: json['kycData'] == null
      ? null
      : KycModel.fromJson(json['kycData'] as Map<String, dynamic>),
  verificationLevel:
      $enumDecodeNullable(
        _$VerificationLevelEnumMap,
        json['verificationLevel'],
      ) ??
      VerificationLevel.unverified,
  verificationLimits: json['verificationLimits'] == null
      ? null
      : VerificationLimits.fromJson(
          json['verificationLimits'] as Map<String, dynamic>,
        ),
  proofOfAddress: json['proofOfAddress'] == null
      ? null
      : ProofOfAddress.fromJson(json['proofOfAddress'] as Map<String, dynamic>),
  tin: json['tin'] as String?,
  nbiClearance: json['nbiClearance'] == null
      ? null
      : NbiClearance.fromJson(json['nbiClearance'] as Map<String, dynamic>),
  backgroundCheckStatus:
      $enumDecodeNullable(
        _$BackgroundCheckStatusEnumMap,
        json['backgroundCheckStatus'],
      ) ??
      BackgroundCheckStatus.none,
);

Map<String, dynamic> _$UserModelToJson(
  _UserModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'fullName': instance.fullName,
  'firstName': instance.firstName,
  'middleName': instance.middleName,
  'lastName': instance.lastName,
  'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
  'gender': instance.gender,
  'phoneNumber': instance.phoneNumber,
  'street': instance.street,
  'barangay': instance.barangay,
  'city': instance.city,
  'province': instance.province,
  'zipCode': instance.zipCode,
  'nationality': instance.nationality,
  'termsAccepted': instance.termsAccepted,
  'privacyAccepted': instance.privacyAccepted,
  'kycStatus': instance.kycStatus,
  'accountType': instance.accountType,
  'createdAt': instance.createdAt.toIso8601String(),
  'verifiedBadge': instance.verifiedBadge,
  'kycData': instance.kycData,
  'verificationLevel': _$VerificationLevelEnumMap[instance.verificationLevel]!,
  'verificationLimits': instance.verificationLimits,
  'proofOfAddress': instance.proofOfAddress,
  'tin': instance.tin,
  'nbiClearance': instance.nbiClearance,
  'backgroundCheckStatus':
      _$BackgroundCheckStatusEnumMap[instance.backgroundCheckStatus]!,
};

const _$VerificationLevelEnumMap = {
  VerificationLevel.unverified: 'unverified',
  VerificationLevel.level1: 'level1',
  VerificationLevel.level2: 'level2',
  VerificationLevel.level3: 'level3',
  VerificationLevel.dealer: 'dealer',
};

const _$BackgroundCheckStatusEnumMap = {
  BackgroundCheckStatus.none: 'none',
  BackgroundCheckStatus.pending: 'pending',
  BackgroundCheckStatus.cleared: 'cleared',
  BackgroundCheckStatus.rejected: 'rejected',
};
