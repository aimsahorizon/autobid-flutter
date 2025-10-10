// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pricing_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PricingConfig _$PricingConfigFromJson(Map<String, dynamic> json) =>
    _PricingConfig(
      listingFee: (json['listingFee'] as num?)?.toDouble() ?? 400.0,
      minListingFee: (json['minListingFee'] as num?)?.toDouble() ?? 300.0,
      maxListingFee: (json['maxListingFee'] as num?)?.toDouble() ?? 500.0,
      economyTransactionFeeRate:
          (json['economyTransactionFeeRate'] as num?)?.toDouble() ?? 0.05,
      economyPriceThreshold:
          (json['economyPriceThreshold'] as num?)?.toDouble() ?? 800000.0,
      midRangeTransactionFeeRate:
          (json['midRangeTransactionFeeRate'] as num?)?.toDouble() ?? 0.04,
      midRangePriceThreshold:
          (json['midRangePriceThreshold'] as num?)?.toDouble() ?? 2000000.0,
      premiumTransactionFeeRate:
          (json['premiumTransactionFeeRate'] as num?)?.toDouble() ?? 0.03,
      minTransactionFee: (json['minTransactionFee'] as num?)?.toDouble() ?? 0.0,
      maxTransactionFee: (json['maxTransactionFee'] as num?)?.toDouble(),
      listingFeeRefundable: json['listingFeeRefundable'] as bool? ?? false,
      listingFeeUpfront: json['listingFeeUpfront'] as bool? ?? true,
    );

Map<String, dynamic> _$PricingConfigToJson(_PricingConfig instance) =>
    <String, dynamic>{
      'listingFee': instance.listingFee,
      'minListingFee': instance.minListingFee,
      'maxListingFee': instance.maxListingFee,
      'economyTransactionFeeRate': instance.economyTransactionFeeRate,
      'economyPriceThreshold': instance.economyPriceThreshold,
      'midRangeTransactionFeeRate': instance.midRangeTransactionFeeRate,
      'midRangePriceThreshold': instance.midRangePriceThreshold,
      'premiumTransactionFeeRate': instance.premiumTransactionFeeRate,
      'minTransactionFee': instance.minTransactionFee,
      'maxTransactionFee': instance.maxTransactionFee,
      'listingFeeRefundable': instance.listingFeeRefundable,
      'listingFeeUpfront': instance.listingFeeUpfront,
    };

_FeeBreakdown _$FeeBreakdownFromJson(Map<String, dynamic> json) =>
    _FeeBreakdown(
      salePrice: (json['salePrice'] as num).toDouble(),
      listingFee: (json['listingFee'] as num).toDouble(),
      transactionFeeRate: (json['transactionFeeRate'] as num).toDouble(),
      transactionFee: (json['transactionFee'] as num).toDouble(),
      totalPlatformFees: (json['totalPlatformFees'] as num).toDouble(),
      totalBuyerAmount: (json['totalBuyerAmount'] as num).toDouble(),
      sellerReceives: (json['sellerReceives'] as num).toDouble(),
      priceTier: $enumDecode(_$PriceTierEnumMap, json['priceTier']),
    );

Map<String, dynamic> _$FeeBreakdownToJson(_FeeBreakdown instance) =>
    <String, dynamic>{
      'salePrice': instance.salePrice,
      'listingFee': instance.listingFee,
      'transactionFeeRate': instance.transactionFeeRate,
      'transactionFee': instance.transactionFee,
      'totalPlatformFees': instance.totalPlatformFees,
      'totalBuyerAmount': instance.totalBuyerAmount,
      'sellerReceives': instance.sellerReceives,
      'priceTier': _$PriceTierEnumMap[instance.priceTier]!,
    };

const _$PriceTierEnumMap = {
  PriceTier.economy: 'economy',
  PriceTier.midRange: 'midRange',
  PriceTier.premium: 'premium',
};
