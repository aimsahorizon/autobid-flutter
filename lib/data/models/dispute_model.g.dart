// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dispute_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DisputeModel _$DisputeModelFromJson(Map<String, dynamic> json) =>
    _DisputeModel(
      id: json['id'] as String,
      transactionId: json['transactionId'] as String,
      initiatorId: json['initiatorId'] as String,
      reason: $enumDecode(_$RefundReasonEnumMap, json['reason']),
      description: json['description'] as String,
      evidencePhotos: (json['evidencePhotos'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      evidenceVideo: json['evidenceVideo'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      sellerResponse: json['sellerResponse'] as String?,
      sellerCounterEvidence: (json['sellerCounterEvidence'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      sellerRespondedAt: json['sellerRespondedAt'] == null
          ? null
          : DateTime.parse(json['sellerRespondedAt'] as String),
      adminDecision: json['adminDecision'] as String?,
      adminNotes: json['adminNotes'] as String?,
      resolvedAt: json['resolvedAt'] == null
          ? null
          : DateTime.parse(json['resolvedAt'] as String),
    );

Map<String, dynamic> _$DisputeModelToJson(_DisputeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'transactionId': instance.transactionId,
      'initiatorId': instance.initiatorId,
      'reason': _$RefundReasonEnumMap[instance.reason]!,
      'description': instance.description,
      'evidencePhotos': instance.evidencePhotos,
      'evidenceVideo': instance.evidenceVideo,
      'createdAt': instance.createdAt.toIso8601String(),
      'sellerResponse': instance.sellerResponse,
      'sellerCounterEvidence': instance.sellerCounterEvidence,
      'sellerRespondedAt': instance.sellerRespondedAt?.toIso8601String(),
      'adminDecision': instance.adminDecision,
      'adminNotes': instance.adminNotes,
      'resolvedAt': instance.resolvedAt?.toIso8601String(),
    };

const _$RefundReasonEnumMap = {
  RefundReason.conditionMismatch: 'conditionMismatch',
  RefundReason.wrongVehicle: 'wrongVehicle',
  RefundReason.missingDocuments: 'missingDocuments',
  RefundReason.sellerMisrepresentation: 'sellerMisrepresentation',
  RefundReason.other: 'other',
};
