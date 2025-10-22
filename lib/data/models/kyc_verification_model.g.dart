// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kyc_verification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_KycVerification _$KycVerificationFromJson(Map<String, dynamic> json) =>
    _KycVerification(
      id: json['id'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      governmentIdType: $enumDecode(
        _$GovernmentIdTypeEnumMap,
        json['governmentIdType'],
      ),
      governmentIdNumber: json['governmentIdNumber'] as String,
      governmentIdPhotoUrl: json['governmentIdPhotoUrl'] as String,
      selfiePhotoUrl: json['selfiePhotoUrl'] as String,
      ra8792ConsentGiven: json['ra8792ConsentGiven'] as bool? ?? false,
      verifiedAt: json['verifiedAt'] == null
          ? null
          : DateTime.parse(json['verifiedAt'] as String),
      status:
          $enumDecodeNullable(_$KycVerificationStatusEnumMap, json['status']) ??
          KycVerificationStatus.pending,
      rejectionReason: json['rejectionReason'] as String?,
      submittedAt: DateTime.parse(json['submittedAt'] as String),
    );

Map<String, dynamic> _$KycVerificationToJson(_KycVerification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'userName': instance.userName,
      'governmentIdType': _$GovernmentIdTypeEnumMap[instance.governmentIdType]!,
      'governmentIdNumber': instance.governmentIdNumber,
      'governmentIdPhotoUrl': instance.governmentIdPhotoUrl,
      'selfiePhotoUrl': instance.selfiePhotoUrl,
      'ra8792ConsentGiven': instance.ra8792ConsentGiven,
      'verifiedAt': instance.verifiedAt?.toIso8601String(),
      'status': _$KycVerificationStatusEnumMap[instance.status]!,
      'rejectionReason': instance.rejectionReason,
      'submittedAt': instance.submittedAt.toIso8601String(),
    };

const _$GovernmentIdTypeEnumMap = {
  GovernmentIdType.driversLicense: 'drivers_license',
  GovernmentIdType.passport: 'passport',
  GovernmentIdType.nationalId: 'national_id',
  GovernmentIdType.umid: 'umid',
  GovernmentIdType.sss: 'sss',
  GovernmentIdType.gsis: 'gsis',
  GovernmentIdType.philhealth: 'philhealth',
  GovernmentIdType.votersId: 'voters_id',
  GovernmentIdType.prcId: 'prc_id',
};

const _$KycVerificationStatusEnumMap = {
  KycVerificationStatus.pending: 'pending',
  KycVerificationStatus.verified: 'verified',
  KycVerificationStatus.rejected: 'rejected',
};
