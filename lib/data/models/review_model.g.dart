// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CategoryRating _$CategoryRatingFromJson(Map<String, dynamic> json) =>
    _CategoryRating(
      communication: (json['communication'] as num).toDouble(),
      accuracy: (json['accuracy'] as num).toDouble(),
      condition: (json['condition'] as num).toDouble(),
      process: (json['process'] as num).toDouble(),
    );

Map<String, dynamic> _$CategoryRatingToJson(_CategoryRating instance) =>
    <String, dynamic>{
      'communication': instance.communication,
      'accuracy': instance.accuracy,
      'condition': instance.condition,
      'process': instance.process,
    };

_ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) => _ReviewModel(
  id: json['id'] as String,
  transactionId: json['transactionId'] as String,
  buyerId: json['buyerId'] as String,
  sellerId: json['sellerId'] as String,
  overallRating: (json['overallRating'] as num).toDouble(),
  categoryRatings: CategoryRating.fromJson(
    json['categoryRatings'] as Map<String, dynamic>,
  ),
  comment: json['comment'] as String?,
  isAnonymous: json['isAnonymous'] as bool,
  createdAt: DateTime.parse(json['createdAt'] as String),
  sellerResponse: json['sellerResponse'] as String?,
  sellerRespondedAt: json['sellerRespondedAt'] == null
      ? null
      : DateTime.parse(json['sellerRespondedAt'] as String),
  isFlagged: json['isFlagged'] as bool? ?? false,
  flagReason: json['flagReason'] as String?,
);

Map<String, dynamic> _$ReviewModelToJson(_ReviewModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'transactionId': instance.transactionId,
      'buyerId': instance.buyerId,
      'sellerId': instance.sellerId,
      'overallRating': instance.overallRating,
      'categoryRatings': instance.categoryRatings,
      'comment': instance.comment,
      'isAnonymous': instance.isAnonymous,
      'createdAt': instance.createdAt.toIso8601String(),
      'sellerResponse': instance.sellerResponse,
      'sellerRespondedAt': instance.sellerRespondedAt?.toIso8601String(),
      'isFlagged': instance.isFlagged,
      'flagReason': instance.flagReason,
    };
