// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Transaction _$TransactionFromJson(Map<String, dynamic> json) => _Transaction(
  id: json['id'] as String,
  auctionId: json['auctionId'] as String,
  carId: json['carId'] as String,
  buyerId: json['buyerId'] as String,
  sellerId: json['sellerId'] as String,
  buyerName: json['buyerName'] as String,
  sellerName: json['sellerName'] as String,
  carTitle: json['carTitle'] as String,
  amount: (json['amount'] as num).toDouble(),
  platformFee: (json['platformFee'] as num).toDouble(),
  totalAmount: (json['totalAmount'] as num).toDouble(),
  escrowStatus: $enumDecode(_$EscrowStatusEnumMap, json['escrowStatus']),
  paymentMethod: $enumDecodeNullable(
    _$PaymentMethodTypeEnumMap,
    json['paymentMethod'],
  ),
  paymentReference: json['paymentReference'] as String?,
  paymentProof: json['paymentProof'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  paidAt: json['paidAt'] == null
      ? null
      : DateTime.parse(json['paidAt'] as String),
  releasedAt: json['releasedAt'] == null
      ? null
      : DateTime.parse(json['releasedAt'] as String),
  completedAt: json['completedAt'] == null
      ? null
      : DateTime.parse(json['completedAt'] as String),
  timeline:
      (json['timeline'] as List<dynamic>?)
          ?.map((e) => TransactionTimeline.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  transferEvidenceId: json['transferEvidenceId'] as String?,
  evidenceSubmittedAt: json['evidenceSubmittedAt'] == null
      ? null
      : DateTime.parse(json['evidenceSubmittedAt'] as String),
  validationCompletedAt: json['validationCompletedAt'] == null
      ? null
      : DateTime.parse(json['validationCompletedAt'] as String),
  disputeId: json['disputeId'] as String?,
  disputedAt: json['disputedAt'] == null
      ? null
      : DateTime.parse(json['disputedAt'] as String),
  refundedAt: json['refundedAt'] == null
      ? null
      : DateTime.parse(json['refundedAt'] as String),
);

Map<String, dynamic> _$TransactionToJson(
  _Transaction instance,
) => <String, dynamic>{
  'id': instance.id,
  'auctionId': instance.auctionId,
  'carId': instance.carId,
  'buyerId': instance.buyerId,
  'sellerId': instance.sellerId,
  'buyerName': instance.buyerName,
  'sellerName': instance.sellerName,
  'carTitle': instance.carTitle,
  'amount': instance.amount,
  'platformFee': instance.platformFee,
  'totalAmount': instance.totalAmount,
  'escrowStatus': _$EscrowStatusEnumMap[instance.escrowStatus]!,
  'paymentMethod': _$PaymentMethodTypeEnumMap[instance.paymentMethod],
  'paymentReference': instance.paymentReference,
  'paymentProof': instance.paymentProof,
  'createdAt': instance.createdAt.toIso8601String(),
  'paidAt': instance.paidAt?.toIso8601String(),
  'releasedAt': instance.releasedAt?.toIso8601String(),
  'completedAt': instance.completedAt?.toIso8601String(),
  'timeline': instance.timeline,
  'transferEvidenceId': instance.transferEvidenceId,
  'evidenceSubmittedAt': instance.evidenceSubmittedAt?.toIso8601String(),
  'validationCompletedAt': instance.validationCompletedAt?.toIso8601String(),
  'disputeId': instance.disputeId,
  'disputedAt': instance.disputedAt?.toIso8601String(),
  'refundedAt': instance.refundedAt?.toIso8601String(),
};

const _$EscrowStatusEnumMap = {
  EscrowStatus.pending: 'pending',
  EscrowStatus.held: 'held',
  EscrowStatus.validating: 'validating',
  EscrowStatus.released: 'released',
  EscrowStatus.refunded: 'refunded',
  EscrowStatus.disputed: 'disputed',
  EscrowStatus.underReview: 'underReview',
};

const _$PaymentMethodTypeEnumMap = {
  PaymentMethodType.gcash: 'gcash',
  PaymentMethodType.paymaya: 'paymaya',
  PaymentMethodType.bankTransfer: 'bank_transfer',
  PaymentMethodType.cash: 'cash',
  PaymentMethodType.card: 'card',
};
