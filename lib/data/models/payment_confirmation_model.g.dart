// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_confirmation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PaymentConfirmation _$PaymentConfirmationFromJson(Map<String, dynamic> json) =>
    _PaymentConfirmation(
      id: json['id'] as String,
      preTransactionId: json['preTransactionId'] as String,
      buyerInitiated: json['buyerInitiated'] as bool? ?? false,
      buyerInitiatedAt: json['buyerInitiatedAt'] == null
          ? null
          : DateTime.parse(json['buyerInitiatedAt'] as String),
      proofOfPaymentUrls:
          (json['proofOfPaymentUrls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      paymentMethod: $enumDecodeNullable(
        _$PaymentMethodEnumMap,
        json['paymentMethod'],
      ),
      paymentReferenceNumber: json['paymentReferenceNumber'] as String?,
      buyerNotes: json['buyerNotes'] as String?,
      sellerConfirmed: json['sellerConfirmed'] as bool? ?? false,
      sellerConfirmedAt: json['sellerConfirmedAt'] == null
          ? null
          : DateTime.parse(json['sellerConfirmedAt'] as String),
      sellerNotes: json['sellerNotes'] as String?,
      ra8792Acknowledgment: json['ra8792Acknowledgment'] as String,
      status:
          $enumDecodeNullable(
            _$PaymentConfirmationStatusEnumMap,
            json['status'],
          ) ??
          PaymentConfirmationStatus.pending,
      amountPaid: (json['amountPaid'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$PaymentConfirmationToJson(
  _PaymentConfirmation instance,
) => <String, dynamic>{
  'id': instance.id,
  'preTransactionId': instance.preTransactionId,
  'buyerInitiated': instance.buyerInitiated,
  'buyerInitiatedAt': instance.buyerInitiatedAt?.toIso8601String(),
  'proofOfPaymentUrls': instance.proofOfPaymentUrls,
  'paymentMethod': _$PaymentMethodEnumMap[instance.paymentMethod],
  'paymentReferenceNumber': instance.paymentReferenceNumber,
  'buyerNotes': instance.buyerNotes,
  'sellerConfirmed': instance.sellerConfirmed,
  'sellerConfirmedAt': instance.sellerConfirmedAt?.toIso8601String(),
  'sellerNotes': instance.sellerNotes,
  'ra8792Acknowledgment': instance.ra8792Acknowledgment,
  'status': _$PaymentConfirmationStatusEnumMap[instance.status]!,
  'amountPaid': instance.amountPaid,
  'createdAt': instance.createdAt.toIso8601String(),
};

const _$PaymentMethodEnumMap = {
  PaymentMethod.cash: 'cash',
  PaymentMethod.bankTransfer: 'bank_transfer',
  PaymentMethod.gcash: 'gcash',
  PaymentMethod.paymaya: 'paymaya',
  PaymentMethod.bankCheck: 'bank_check',
  PaymentMethod.other: 'other',
};

const _$PaymentConfirmationStatusEnumMap = {
  PaymentConfirmationStatus.pending: 'pending',
  PaymentConfirmationStatus.initiated: 'initiated',
  PaymentConfirmationStatus.confirmed: 'confirmed',
  PaymentConfirmationStatus.disputed: 'disputed',
};
