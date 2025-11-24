// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auto_bid_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AutoBidConfig _$AutoBidConfigFromJson(Map<String, dynamic> json) =>
    _AutoBidConfig(
      maxBidAmount: (json['maxBidAmount'] as num).toDouble(),
      incrementAmount: (json['incrementAmount'] as num).toDouble(),
      isActive: json['isActive'] as bool? ?? true,
    );

Map<String, dynamic> _$AutoBidConfigToJson(_AutoBidConfig instance) =>
    <String, dynamic>{
      'maxBidAmount': instance.maxBidAmount,
      'incrementAmount': instance.incrementAmount,
      'isActive': instance.isActive,
    };
