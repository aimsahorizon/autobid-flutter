// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pre_transaction_confirmation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PreTransactionConfirmation _$PreTransactionConfirmationFromJson(
  Map<String, dynamic> json,
) => _PreTransactionConfirmation(
  id: json['id'] as String,
  userId: json['userId'] as String,
  userName: json['userName'] as String,
  vehicleDetailsConfirmed: json['vehicleDetailsConfirmed'] as bool,
  preferredPaymentMethod: $enumDecodeNullable(
    _$PaymentMethodTypeEnumMap,
    json['preferredPaymentMethod'],
  ),
  deliveryDate: json['deliveryDate'] as String?,
  deliveryLocation: json['deliveryLocation'] as String?,
  uploadedDocuments:
      (json['uploadedDocuments'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  termsAgreed: json['termsAgreed'] as bool,
  confirmedAt: DateTime.parse(json['confirmedAt'] as String),
  notes: json['notes'] as String?,
);

Map<String, dynamic> _$PreTransactionConfirmationToJson(
  _PreTransactionConfirmation instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'userName': instance.userName,
  'vehicleDetailsConfirmed': instance.vehicleDetailsConfirmed,
  'preferredPaymentMethod':
      _$PaymentMethodTypeEnumMap[instance.preferredPaymentMethod],
  'deliveryDate': instance.deliveryDate,
  'deliveryLocation': instance.deliveryLocation,
  'uploadedDocuments': instance.uploadedDocuments,
  'termsAgreed': instance.termsAgreed,
  'confirmedAt': instance.confirmedAt.toIso8601String(),
  'notes': instance.notes,
};

const _$PaymentMethodTypeEnumMap = {
  PaymentMethodType.gcash: 'gcash',
  PaymentMethodType.paymaya: 'paymaya',
  PaymentMethodType.bankTransfer: 'bank_transfer',
  PaymentMethodType.cash: 'cash',
  PaymentMethodType.card: 'card',
};
