// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kyc_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_KycModel _$KycModelFromJson(Map<String, dynamic> json) => _KycModel(
  id: json['id'] as String,
  userId: json['userId'] as String,
  idType: $enumDecode(_$IdTypeEnumMap, json['idType']),
  idNumber: json['idNumber'] as String,
  idImageUrl: json['idImageUrl'] as String,
  secondaryIdImageUrl: json['secondaryIdImageUrl'] as String?,
  selfieUrl: json['selfieUrl'] as String,
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

Map<String, dynamic> _$KycModelToJson(_KycModel instance) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'idType': _$IdTypeEnumMap[instance.idType]!,
  'idNumber': instance.idNumber,
  'idImageUrl': instance.idImageUrl,
  'secondaryIdImageUrl': instance.secondaryIdImageUrl,
  'selfieUrl': instance.selfieUrl,
  'verificationStatus':
      _$KycVerificationStatusEnumMap[instance.verificationStatus]!,
  'submittedAt': instance.submittedAt.toIso8601String(),
  'verifiedAt': instance.verifiedAt?.toIso8601String(),
  'rejectionReason': instance.rejectionReason,
};

const _$IdTypeEnumMap = {
  IdType.nationalId: 'national_id',
  IdType.driversLicense: 'drivers_license',
  IdType.passport: 'passport',
  IdType.votersId: 'voters_id',
};

const _$KycVerificationStatusEnumMap = {
  KycVerificationStatus.pending: 'pending',
  KycVerificationStatus.verified: 'verified',
  KycVerificationStatus.rejected: 'rejected',
};
