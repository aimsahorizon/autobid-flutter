// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_method.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PaymentMethod _$PaymentMethodFromJson(Map<String, dynamic> json) =>
    _PaymentMethod(
      type: $enumDecode(_$PaymentMethodTypeEnumMap, json['type']),
      displayName: json['displayName'] as String,
      icon: json['icon'] as String,
      description: json['description'] as String,
      accountNumber: json['accountNumber'] as String?,
      isDefault: json['isDefault'] as bool? ?? false,
    );

Map<String, dynamic> _$PaymentMethodToJson(_PaymentMethod instance) =>
    <String, dynamic>{
      'type': _$PaymentMethodTypeEnumMap[instance.type]!,
      'displayName': instance.displayName,
      'icon': instance.icon,
      'description': instance.description,
      'accountNumber': instance.accountNumber,
      'isDefault': instance.isDefault,
    };

const _$PaymentMethodTypeEnumMap = {
  PaymentMethodType.gcash: 'gcash',
  PaymentMethodType.paymaya: 'paymaya',
  PaymentMethodType.bankTransfer: 'bank_transfer',
  PaymentMethodType.cash: 'cash',
  PaymentMethodType.card: 'card',
};
