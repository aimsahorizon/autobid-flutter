// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_evidence_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TransferEvidence _$TransferEvidenceFromJson(Map<String, dynamic> json) =>
    _TransferEvidence(
      id: json['id'] as String,
      transactionId: json['transactionId'] as String,
      buyerId: json['buyerId'] as String,
      submittedAt: DateTime.parse(json['submittedAt'] as String),
      deedOfSaleUrl: json['deedOfSaleUrl'] as String?,
      crOrTransferUrl: json['crOrTransferUrl'] as String?,
      officialReceiptUrl: json['officialReceiptUrl'] as String?,
      vehiclePhotoUrls: (json['vehiclePhotoUrls'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      odometerPhotoUrl: json['odometerPhotoUrl'] as String?,
      vinPhotoUrl: json['vinPhotoUrl'] as String?,
      odometerReading: (json['odometerReading'] as num?)?.toInt(),
      conditionPhotoUrls: (json['conditionPhotoUrls'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      damagePhotoUrls: (json['damagePhotoUrls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      deliveryReceiptUrl: json['deliveryReceiptUrl'] as String?,
      buyerNotes: json['buyerNotes'] as String?,
      buyerSignature: json['buyerSignature'] as bool? ?? false,
      status: $enumDecode(_$ValidationStatusEnumMap, json['status']),
      validatedAt: json['validatedAt'] == null
          ? null
          : DateTime.parse(json['validatedAt'] as String),
      validatedBy: json['validatedBy'] as String?,
      rejectionReason: json['rejectionReason'] as String?,
    );

Map<String, dynamic> _$TransferEvidenceToJson(_TransferEvidence instance) =>
    <String, dynamic>{
      'id': instance.id,
      'transactionId': instance.transactionId,
      'buyerId': instance.buyerId,
      'submittedAt': instance.submittedAt.toIso8601String(),
      'deedOfSaleUrl': instance.deedOfSaleUrl,
      'crOrTransferUrl': instance.crOrTransferUrl,
      'officialReceiptUrl': instance.officialReceiptUrl,
      'vehiclePhotoUrls': instance.vehiclePhotoUrls,
      'odometerPhotoUrl': instance.odometerPhotoUrl,
      'vinPhotoUrl': instance.vinPhotoUrl,
      'odometerReading': instance.odometerReading,
      'conditionPhotoUrls': instance.conditionPhotoUrls,
      'damagePhotoUrls': instance.damagePhotoUrls,
      'deliveryReceiptUrl': instance.deliveryReceiptUrl,
      'buyerNotes': instance.buyerNotes,
      'buyerSignature': instance.buyerSignature,
      'status': _$ValidationStatusEnumMap[instance.status]!,
      'validatedAt': instance.validatedAt?.toIso8601String(),
      'validatedBy': instance.validatedBy,
      'rejectionReason': instance.rejectionReason,
    };

const _$ValidationStatusEnumMap = {
  ValidationStatus.pending: 'pending',
  ValidationStatus.underReview: 'under_review',
  ValidationStatus.approved: 'approved',
  ValidationStatus.rejected: 'rejected',
  ValidationStatus.moreInfoNeeded: 'more_info_needed',
};
