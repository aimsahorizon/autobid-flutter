// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TokenTransaction _$TokenTransactionFromJson(Map<String, dynamic> json) =>
    _TokenTransaction(
      id: json['id'] as String,
      userId: json['userId'] as String,
      amount: (json['amount'] as num).toInt(),
      type: $enumDecode(_$TokenTransactionTypeEnumMap, json['type']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      relatedAuctionId: json['relatedAuctionId'] as String?,
      relatedPurchaseId: json['relatedPurchaseId'] as String?,
      relatedSubscriptionId: json['relatedSubscriptionId'] as String?,
      description: json['description'] as String?,
      balanceAfter: (json['balanceAfter'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TokenTransactionToJson(_TokenTransaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'amount': instance.amount,
      'type': _$TokenTransactionTypeEnumMap[instance.type]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'relatedAuctionId': instance.relatedAuctionId,
      'relatedPurchaseId': instance.relatedPurchaseId,
      'relatedSubscriptionId': instance.relatedSubscriptionId,
      'description': instance.description,
      'balanceAfter': instance.balanceAfter,
    };

const _$TokenTransactionTypeEnumMap = {
  TokenTransactionType.purchase: 'purchase',
  TokenTransactionType.subscriptionAllocation: 'subscriptionAllocation',
  TokenTransactionType.bidPlaced: 'bidPlaced',
  TokenTransactionType.bidRefund: 'bidRefund',
  TokenTransactionType.adminAdjustment: 'adminAdjustment',
  TokenTransactionType.promotionalGrant: 'promotionalGrant',
};

_TokenPurchase _$TokenPurchaseFromJson(Map<String, dynamic> json) =>
    _TokenPurchase(
      id: json['id'] as String,
      userId: json['userId'] as String,
      tier: $enumDecode(_$TokenPurchaseTierEnumMap, json['tier']),
      tokensAdded: (json['tokensAdded'] as num).toInt(),
      amountPaid: (json['amountPaid'] as num).toDouble(),
      purchasedAt: DateTime.parse(json['purchasedAt'] as String),
      paymentTransactionId: json['paymentTransactionId'] as String?,
      paymentMethod: json['paymentMethod'] as String?,
      paymentReference: json['paymentReference'] as String?,
      status: $enumDecodeNullable(_$TokenPurchaseStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$TokenPurchaseToJson(_TokenPurchase instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'tier': _$TokenPurchaseTierEnumMap[instance.tier]!,
      'tokensAdded': instance.tokensAdded,
      'amountPaid': instance.amountPaid,
      'purchasedAt': instance.purchasedAt.toIso8601String(),
      'paymentTransactionId': instance.paymentTransactionId,
      'paymentMethod': instance.paymentMethod,
      'paymentReference': instance.paymentReference,
      'status': _$TokenPurchaseStatusEnumMap[instance.status],
    };

const _$TokenPurchaseTierEnumMap = {
  TokenPurchaseTier.tier99: 'tier99',
  TokenPurchaseTier.tier349: 'tier349',
  // TokenPurchaseTier.tier599: 'tier599',
  TokenPurchaseTier.tier1299: 'tier1299',
};

const _$TokenPurchaseStatusEnumMap = {
  TokenPurchaseStatus.pending: 'pending',
  TokenPurchaseStatus.completed: 'completed',
  TokenPurchaseStatus.failed: 'failed',
  TokenPurchaseStatus.refunded: 'refunded',
};
