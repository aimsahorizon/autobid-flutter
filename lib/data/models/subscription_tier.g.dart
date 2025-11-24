// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_tier.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SubscriptionTier _$SubscriptionTierFromJson(Map<String, dynamic> json) =>
    _SubscriptionTier(
      tierType: $enumDecode(_$SubscriptionTierTypeEnumMap, json['tierType']),
      displayName: json['displayName'] as String,
      badge: json['badge'] as String,
      monthlyPrice: (json['monthlyPrice'] as num).toDouble(),
      yearlyPrice: (json['yearlyPrice'] as num).toDouble(),
      monthlyTokenAllocation: (json['monthlyTokenAllocation'] as num).toInt(),
      maxListingsPerMonth: (json['maxListingsPerMonth'] as num).toInt(),
      hasAutoBid: json['hasAutoBid'] as bool,
      hasPriorityNotifications: json['hasPriorityNotifications'] as bool,
      hasEarlyAccess: json['hasEarlyAccess'] as bool,
      earlyAccessHours: (json['earlyAccessHours'] as num).toInt(),
      hasFeaturedPlacement: json['hasFeaturedPlacement'] as bool,
      hasWaivedRelistFee: json['hasWaivedRelistFee'] as bool,
      hasMonthlyInsights: json['hasMonthlyInsights'] as bool,
      hasStreakRewards: json['hasStreakRewards'] as bool,
      description: json['description'] as String,
      features: (json['features'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      maxActiveBids: (json['maxActiveBids'] as num?)?.toInt() ?? 0,
      maxActiveListings: (json['maxActiveListings'] as num?)?.toInt() ?? 0,
      buyersPremiumDiscount:
          (json['buyersPremiumDiscount'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$SubscriptionTierToJson(_SubscriptionTier instance) =>
    <String, dynamic>{
      'tierType': _$SubscriptionTierTypeEnumMap[instance.tierType]!,
      'displayName': instance.displayName,
      'badge': instance.badge,
      'monthlyPrice': instance.monthlyPrice,
      'yearlyPrice': instance.yearlyPrice,
      'monthlyTokenAllocation': instance.monthlyTokenAllocation,
      'maxListingsPerMonth': instance.maxListingsPerMonth,
      'hasAutoBid': instance.hasAutoBid,
      'hasPriorityNotifications': instance.hasPriorityNotifications,
      'hasEarlyAccess': instance.hasEarlyAccess,
      'earlyAccessHours': instance.earlyAccessHours,
      'hasFeaturedPlacement': instance.hasFeaturedPlacement,
      'hasWaivedRelistFee': instance.hasWaivedRelistFee,
      'hasMonthlyInsights': instance.hasMonthlyInsights,
      'hasStreakRewards': instance.hasStreakRewards,
      'description': instance.description,
      'features': instance.features,
      'maxActiveBids': instance.maxActiveBids,
      'maxActiveListings': instance.maxActiveListings,
      'buyersPremiumDiscount': instance.buyersPremiumDiscount,
    };

const _$SubscriptionTierTypeEnumMap = {
  SubscriptionTierType.free: 'free',
  SubscriptionTierType.proBasic: 'proBasic',
  SubscriptionTierType.proPlus: 'proPlus',
};

_UserSubscription _$UserSubscriptionFromJson(Map<String, dynamic> json) =>
    _UserSubscription(
      id: json['id'] as String,
      userId: json['userId'] as String,
      tierType: $enumDecode(_$SubscriptionTierTypeEnumMap, json['tierType']),
      billingCycle: $enumDecode(_$BillingCycleEnumMap, json['billingCycle']),
      status: $enumDecode(_$SubscriptionStatusEnumMap, json['status']),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      nextBillingDate: DateTime.parse(json['nextBillingDate'] as String),
      amountPaid: (json['amountPaid'] as num).toDouble(),
      paymentGatewaySubscriptionId:
          json['paymentGatewaySubscriptionId'] as String?,
      cancelledAt: json['cancelledAt'] == null
          ? null
          : DateTime.parse(json['cancelledAt'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$UserSubscriptionToJson(_UserSubscription instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'tierType': _$SubscriptionTierTypeEnumMap[instance.tierType]!,
      'billingCycle': _$BillingCycleEnumMap[instance.billingCycle]!,
      'status': _$SubscriptionStatusEnumMap[instance.status]!,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'nextBillingDate': instance.nextBillingDate.toIso8601String(),
      'amountPaid': instance.amountPaid,
      'paymentGatewaySubscriptionId': instance.paymentGatewaySubscriptionId,
      'cancelledAt': instance.cancelledAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$BillingCycleEnumMap = {
  BillingCycle.monthly: 'monthly',
  BillingCycle.yearly: 'yearly',
};

const _$SubscriptionStatusEnumMap = {
  SubscriptionStatus.active: 'active',
  SubscriptionStatus.cancelled: 'cancelled',
  SubscriptionStatus.expired: 'expired',
  SubscriptionStatus.pendingPayment: 'pendingPayment',
  SubscriptionStatus.suspended: 'suspended',
};
