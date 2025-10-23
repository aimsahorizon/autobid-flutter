// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bidding_deposit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BiddingDeposit _$BiddingDepositFromJson(Map<String, dynamic> json) =>
    _BiddingDeposit(
      id: json['id'] as String,
      userId: json['userId'] as String,
      amount: (json['amount'] as num).toDouble(),
      status: $enumDecode(_$DepositStatusEnumMap, json['status']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      paidAt: json['paidAt'] == null
          ? null
          : DateTime.parse(json['paidAt'] as String),
      creditedAt: json['creditedAt'] == null
          ? null
          : DateTime.parse(json['creditedAt'] as String),
      refundedAt: json['refundedAt'] == null
          ? null
          : DateTime.parse(json['refundedAt'] as String),
      transactionId: json['transactionId'] as String?,
      paymentMethod: json['paymentMethod'] as String?,
      paymentReference: json['paymentReference'] as String?,
      auctionIdCredited: json['auctionIdCredited'] as String?,
      amountCredited: (json['amountCredited'] as num?)?.toDouble(),
      amountRefunded: (json['amountRefunded'] as num?)?.toDouble(),
      refundTransactionId: json['refundTransactionId'] as String?,
      expiresAt: json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
      notes: json['notes'] as String?,
      winnerDisposition: $enumDecodeNullable(
        _$DepositDispositionEnumMap,
        json['winnerDisposition'],
      ),
      isWinner: json['isWinner'] as bool?,
    );

Map<String, dynamic> _$BiddingDepositToJson(
  _BiddingDeposit instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'amount': instance.amount,
  'status': _$DepositStatusEnumMap[instance.status]!,
  'createdAt': instance.createdAt.toIso8601String(),
  'paidAt': instance.paidAt?.toIso8601String(),
  'creditedAt': instance.creditedAt?.toIso8601String(),
  'refundedAt': instance.refundedAt?.toIso8601String(),
  'transactionId': instance.transactionId,
  'paymentMethod': instance.paymentMethod,
  'paymentReference': instance.paymentReference,
  'auctionIdCredited': instance.auctionIdCredited,
  'amountCredited': instance.amountCredited,
  'amountRefunded': instance.amountRefunded,
  'refundTransactionId': instance.refundTransactionId,
  'expiresAt': instance.expiresAt?.toIso8601String(),
  'notes': instance.notes,
  'winnerDisposition': _$DepositDispositionEnumMap[instance.winnerDisposition],
  'isWinner': instance.isWinner,
};

const _$DepositStatusEnumMap = {
  DepositStatus.pending: 'pending',
  DepositStatus.paid: 'paid',
  DepositStatus.credited: 'credited',
  DepositStatus.refunded: 'refunded',
  DepositStatus.forfeited: 'forfeited',
};

const _$DepositDispositionEnumMap = {
  DepositDisposition.creditToPayment: 'creditToPayment',
  DepositDisposition.fullRefund: 'fullRefund',
};
