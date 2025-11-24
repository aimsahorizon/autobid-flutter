// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'handover_confirmation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HandoverConfirmation _$HandoverConfirmationFromJson(
  Map<String, dynamic> json,
) => _HandoverConfirmation(
  id: json['id'] as String,
  preTransactionId: json['preTransactionId'] as String,
  sellerReleased: json['sellerReleased'] as bool? ?? false,
  sellerReleasedAt: json['sellerReleasedAt'] == null
      ? null
      : DateTime.parse(json['sellerReleasedAt'] as String),
  sellerPhotoUrls:
      (json['sellerPhotoUrls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  releaseLocation: json['releaseLocation'] as String?,
  sellerNotes: json['sellerNotes'] as String?,
  buyerReceived: json['buyerReceived'] as bool? ?? false,
  buyerReceivedAt: json['buyerReceivedAt'] == null
      ? null
      : DateTime.parse(json['buyerReceivedAt'] as String),
  buyerConditionAccepted: json['buyerConditionAccepted'] as bool? ?? false,
  buyerPhotoUrls:
      (json['buyerPhotoUrls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  buyerNotes: json['buyerNotes'] as String?,
  ownershipDocumentsTransferred:
      json['ownershipDocumentsTransferred'] as bool? ?? false,
  ownershipDocuments:
      (json['ownershipDocuments'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  status:
      $enumDecodeNullable(
        _$HandoverConfirmationStatusEnumMap,
        json['status'],
      ) ??
      HandoverConfirmationStatus.pending,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$HandoverConfirmationToJson(
  _HandoverConfirmation instance,
) => <String, dynamic>{
  'id': instance.id,
  'preTransactionId': instance.preTransactionId,
  'sellerReleased': instance.sellerReleased,
  'sellerReleasedAt': instance.sellerReleasedAt?.toIso8601String(),
  'sellerPhotoUrls': instance.sellerPhotoUrls,
  'releaseLocation': instance.releaseLocation,
  'sellerNotes': instance.sellerNotes,
  'buyerReceived': instance.buyerReceived,
  'buyerReceivedAt': instance.buyerReceivedAt?.toIso8601String(),
  'buyerConditionAccepted': instance.buyerConditionAccepted,
  'buyerPhotoUrls': instance.buyerPhotoUrls,
  'buyerNotes': instance.buyerNotes,
  'ownershipDocumentsTransferred': instance.ownershipDocumentsTransferred,
  'ownershipDocuments': instance.ownershipDocuments,
  'status': _$HandoverConfirmationStatusEnumMap[instance.status]!,
  'createdAt': instance.createdAt.toIso8601String(),
};

const _$HandoverConfirmationStatusEnumMap = {
  HandoverConfirmationStatus.pending: 'pending',
  HandoverConfirmationStatus.released: 'released',
  HandoverConfirmationStatus.received: 'received',
  HandoverConfirmationStatus.completed: 'completed',
};
