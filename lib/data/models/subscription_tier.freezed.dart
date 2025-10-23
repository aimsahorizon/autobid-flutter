// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription_tier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SubscriptionTier {

 SubscriptionTierType get tierType; String get displayName; String get badge; double get monthlyPrice; double get yearlyPrice; int get monthlyTokenAllocation;// -1 for unlimited (Pro Plus)
 int get maxListingsPerMonth;// Monthly rolling quota
 bool get hasAutoBid; bool get hasPriorityNotifications; bool get hasEarlyAccess; int get earlyAccessHours;// 0 for Free/ProBasic, 2 for ProPlus
 bool get hasFeaturedPlacement; bool get hasWaivedRelistFee; bool get hasMonthlyInsights; bool get hasStreakRewards; String get description; List<String> get features;// DEPRECATED - Old GEMINI fields (kept for migration compatibility)
 int get maxActiveBids; int get maxActiveListings; double get buyersPremiumDiscount;
/// Create a copy of SubscriptionTier
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionTierCopyWith<SubscriptionTier> get copyWith => _$SubscriptionTierCopyWithImpl<SubscriptionTier>(this as SubscriptionTier, _$identity);

  /// Serializes this SubscriptionTier to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionTier&&(identical(other.tierType, tierType) || other.tierType == tierType)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.badge, badge) || other.badge == badge)&&(identical(other.monthlyPrice, monthlyPrice) || other.monthlyPrice == monthlyPrice)&&(identical(other.yearlyPrice, yearlyPrice) || other.yearlyPrice == yearlyPrice)&&(identical(other.monthlyTokenAllocation, monthlyTokenAllocation) || other.monthlyTokenAllocation == monthlyTokenAllocation)&&(identical(other.maxListingsPerMonth, maxListingsPerMonth) || other.maxListingsPerMonth == maxListingsPerMonth)&&(identical(other.hasAutoBid, hasAutoBid) || other.hasAutoBid == hasAutoBid)&&(identical(other.hasPriorityNotifications, hasPriorityNotifications) || other.hasPriorityNotifications == hasPriorityNotifications)&&(identical(other.hasEarlyAccess, hasEarlyAccess) || other.hasEarlyAccess == hasEarlyAccess)&&(identical(other.earlyAccessHours, earlyAccessHours) || other.earlyAccessHours == earlyAccessHours)&&(identical(other.hasFeaturedPlacement, hasFeaturedPlacement) || other.hasFeaturedPlacement == hasFeaturedPlacement)&&(identical(other.hasWaivedRelistFee, hasWaivedRelistFee) || other.hasWaivedRelistFee == hasWaivedRelistFee)&&(identical(other.hasMonthlyInsights, hasMonthlyInsights) || other.hasMonthlyInsights == hasMonthlyInsights)&&(identical(other.hasStreakRewards, hasStreakRewards) || other.hasStreakRewards == hasStreakRewards)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.features, features)&&(identical(other.maxActiveBids, maxActiveBids) || other.maxActiveBids == maxActiveBids)&&(identical(other.maxActiveListings, maxActiveListings) || other.maxActiveListings == maxActiveListings)&&(identical(other.buyersPremiumDiscount, buyersPremiumDiscount) || other.buyersPremiumDiscount == buyersPremiumDiscount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,tierType,displayName,badge,monthlyPrice,yearlyPrice,monthlyTokenAllocation,maxListingsPerMonth,hasAutoBid,hasPriorityNotifications,hasEarlyAccess,earlyAccessHours,hasFeaturedPlacement,hasWaivedRelistFee,hasMonthlyInsights,hasStreakRewards,description,const DeepCollectionEquality().hash(features),maxActiveBids,maxActiveListings,buyersPremiumDiscount]);

@override
String toString() {
  return 'SubscriptionTier(tierType: $tierType, displayName: $displayName, badge: $badge, monthlyPrice: $monthlyPrice, yearlyPrice: $yearlyPrice, monthlyTokenAllocation: $monthlyTokenAllocation, maxListingsPerMonth: $maxListingsPerMonth, hasAutoBid: $hasAutoBid, hasPriorityNotifications: $hasPriorityNotifications, hasEarlyAccess: $hasEarlyAccess, earlyAccessHours: $earlyAccessHours, hasFeaturedPlacement: $hasFeaturedPlacement, hasWaivedRelistFee: $hasWaivedRelistFee, hasMonthlyInsights: $hasMonthlyInsights, hasStreakRewards: $hasStreakRewards, description: $description, features: $features, maxActiveBids: $maxActiveBids, maxActiveListings: $maxActiveListings, buyersPremiumDiscount: $buyersPremiumDiscount)';
}


}

/// @nodoc
abstract mixin class $SubscriptionTierCopyWith<$Res>  {
  factory $SubscriptionTierCopyWith(SubscriptionTier value, $Res Function(SubscriptionTier) _then) = _$SubscriptionTierCopyWithImpl;
@useResult
$Res call({
 SubscriptionTierType tierType, String displayName, String badge, double monthlyPrice, double yearlyPrice, int monthlyTokenAllocation, int maxListingsPerMonth, bool hasAutoBid, bool hasPriorityNotifications, bool hasEarlyAccess, int earlyAccessHours, bool hasFeaturedPlacement, bool hasWaivedRelistFee, bool hasMonthlyInsights, bool hasStreakRewards, String description, List<String> features, int maxActiveBids, int maxActiveListings, double buyersPremiumDiscount
});




}
/// @nodoc
class _$SubscriptionTierCopyWithImpl<$Res>
    implements $SubscriptionTierCopyWith<$Res> {
  _$SubscriptionTierCopyWithImpl(this._self, this._then);

  final SubscriptionTier _self;
  final $Res Function(SubscriptionTier) _then;

/// Create a copy of SubscriptionTier
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tierType = null,Object? displayName = null,Object? badge = null,Object? monthlyPrice = null,Object? yearlyPrice = null,Object? monthlyTokenAllocation = null,Object? maxListingsPerMonth = null,Object? hasAutoBid = null,Object? hasPriorityNotifications = null,Object? hasEarlyAccess = null,Object? earlyAccessHours = null,Object? hasFeaturedPlacement = null,Object? hasWaivedRelistFee = null,Object? hasMonthlyInsights = null,Object? hasStreakRewards = null,Object? description = null,Object? features = null,Object? maxActiveBids = null,Object? maxActiveListings = null,Object? buyersPremiumDiscount = null,}) {
  return _then(_self.copyWith(
tierType: null == tierType ? _self.tierType : tierType // ignore: cast_nullable_to_non_nullable
as SubscriptionTierType,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,badge: null == badge ? _self.badge : badge // ignore: cast_nullable_to_non_nullable
as String,monthlyPrice: null == monthlyPrice ? _self.monthlyPrice : monthlyPrice // ignore: cast_nullable_to_non_nullable
as double,yearlyPrice: null == yearlyPrice ? _self.yearlyPrice : yearlyPrice // ignore: cast_nullable_to_non_nullable
as double,monthlyTokenAllocation: null == monthlyTokenAllocation ? _self.monthlyTokenAllocation : monthlyTokenAllocation // ignore: cast_nullable_to_non_nullable
as int,maxListingsPerMonth: null == maxListingsPerMonth ? _self.maxListingsPerMonth : maxListingsPerMonth // ignore: cast_nullable_to_non_nullable
as int,hasAutoBid: null == hasAutoBid ? _self.hasAutoBid : hasAutoBid // ignore: cast_nullable_to_non_nullable
as bool,hasPriorityNotifications: null == hasPriorityNotifications ? _self.hasPriorityNotifications : hasPriorityNotifications // ignore: cast_nullable_to_non_nullable
as bool,hasEarlyAccess: null == hasEarlyAccess ? _self.hasEarlyAccess : hasEarlyAccess // ignore: cast_nullable_to_non_nullable
as bool,earlyAccessHours: null == earlyAccessHours ? _self.earlyAccessHours : earlyAccessHours // ignore: cast_nullable_to_non_nullable
as int,hasFeaturedPlacement: null == hasFeaturedPlacement ? _self.hasFeaturedPlacement : hasFeaturedPlacement // ignore: cast_nullable_to_non_nullable
as bool,hasWaivedRelistFee: null == hasWaivedRelistFee ? _self.hasWaivedRelistFee : hasWaivedRelistFee // ignore: cast_nullable_to_non_nullable
as bool,hasMonthlyInsights: null == hasMonthlyInsights ? _self.hasMonthlyInsights : hasMonthlyInsights // ignore: cast_nullable_to_non_nullable
as bool,hasStreakRewards: null == hasStreakRewards ? _self.hasStreakRewards : hasStreakRewards // ignore: cast_nullable_to_non_nullable
as bool,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,features: null == features ? _self.features : features // ignore: cast_nullable_to_non_nullable
as List<String>,maxActiveBids: null == maxActiveBids ? _self.maxActiveBids : maxActiveBids // ignore: cast_nullable_to_non_nullable
as int,maxActiveListings: null == maxActiveListings ? _self.maxActiveListings : maxActiveListings // ignore: cast_nullable_to_non_nullable
as int,buyersPremiumDiscount: null == buyersPremiumDiscount ? _self.buyersPremiumDiscount : buyersPremiumDiscount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [SubscriptionTier].
extension SubscriptionTierPatterns on SubscriptionTier {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubscriptionTier value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubscriptionTier() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubscriptionTier value)  $default,){
final _that = this;
switch (_that) {
case _SubscriptionTier():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubscriptionTier value)?  $default,){
final _that = this;
switch (_that) {
case _SubscriptionTier() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SubscriptionTierType tierType,  String displayName,  String badge,  double monthlyPrice,  double yearlyPrice,  int monthlyTokenAllocation,  int maxListingsPerMonth,  bool hasAutoBid,  bool hasPriorityNotifications,  bool hasEarlyAccess,  int earlyAccessHours,  bool hasFeaturedPlacement,  bool hasWaivedRelistFee,  bool hasMonthlyInsights,  bool hasStreakRewards,  String description,  List<String> features,  int maxActiveBids,  int maxActiveListings,  double buyersPremiumDiscount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubscriptionTier() when $default != null:
return $default(_that.tierType,_that.displayName,_that.badge,_that.monthlyPrice,_that.yearlyPrice,_that.monthlyTokenAllocation,_that.maxListingsPerMonth,_that.hasAutoBid,_that.hasPriorityNotifications,_that.hasEarlyAccess,_that.earlyAccessHours,_that.hasFeaturedPlacement,_that.hasWaivedRelistFee,_that.hasMonthlyInsights,_that.hasStreakRewards,_that.description,_that.features,_that.maxActiveBids,_that.maxActiveListings,_that.buyersPremiumDiscount);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SubscriptionTierType tierType,  String displayName,  String badge,  double monthlyPrice,  double yearlyPrice,  int monthlyTokenAllocation,  int maxListingsPerMonth,  bool hasAutoBid,  bool hasPriorityNotifications,  bool hasEarlyAccess,  int earlyAccessHours,  bool hasFeaturedPlacement,  bool hasWaivedRelistFee,  bool hasMonthlyInsights,  bool hasStreakRewards,  String description,  List<String> features,  int maxActiveBids,  int maxActiveListings,  double buyersPremiumDiscount)  $default,) {final _that = this;
switch (_that) {
case _SubscriptionTier():
return $default(_that.tierType,_that.displayName,_that.badge,_that.monthlyPrice,_that.yearlyPrice,_that.monthlyTokenAllocation,_that.maxListingsPerMonth,_that.hasAutoBid,_that.hasPriorityNotifications,_that.hasEarlyAccess,_that.earlyAccessHours,_that.hasFeaturedPlacement,_that.hasWaivedRelistFee,_that.hasMonthlyInsights,_that.hasStreakRewards,_that.description,_that.features,_that.maxActiveBids,_that.maxActiveListings,_that.buyersPremiumDiscount);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SubscriptionTierType tierType,  String displayName,  String badge,  double monthlyPrice,  double yearlyPrice,  int monthlyTokenAllocation,  int maxListingsPerMonth,  bool hasAutoBid,  bool hasPriorityNotifications,  bool hasEarlyAccess,  int earlyAccessHours,  bool hasFeaturedPlacement,  bool hasWaivedRelistFee,  bool hasMonthlyInsights,  bool hasStreakRewards,  String description,  List<String> features,  int maxActiveBids,  int maxActiveListings,  double buyersPremiumDiscount)?  $default,) {final _that = this;
switch (_that) {
case _SubscriptionTier() when $default != null:
return $default(_that.tierType,_that.displayName,_that.badge,_that.monthlyPrice,_that.yearlyPrice,_that.monthlyTokenAllocation,_that.maxListingsPerMonth,_that.hasAutoBid,_that.hasPriorityNotifications,_that.hasEarlyAccess,_that.earlyAccessHours,_that.hasFeaturedPlacement,_that.hasWaivedRelistFee,_that.hasMonthlyInsights,_that.hasStreakRewards,_that.description,_that.features,_that.maxActiveBids,_that.maxActiveListings,_that.buyersPremiumDiscount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubscriptionTier implements SubscriptionTier {
  const _SubscriptionTier({required this.tierType, required this.displayName, required this.badge, required this.monthlyPrice, required this.yearlyPrice, required this.monthlyTokenAllocation, required this.maxListingsPerMonth, required this.hasAutoBid, required this.hasPriorityNotifications, required this.hasEarlyAccess, required this.earlyAccessHours, required this.hasFeaturedPlacement, required this.hasWaivedRelistFee, required this.hasMonthlyInsights, required this.hasStreakRewards, required this.description, required final  List<String> features, this.maxActiveBids = 0, this.maxActiveListings = 0, this.buyersPremiumDiscount = 0.0}): _features = features;
  factory _SubscriptionTier.fromJson(Map<String, dynamic> json) => _$SubscriptionTierFromJson(json);

@override final  SubscriptionTierType tierType;
@override final  String displayName;
@override final  String badge;
@override final  double monthlyPrice;
@override final  double yearlyPrice;
@override final  int monthlyTokenAllocation;
// -1 for unlimited (Pro Plus)
@override final  int maxListingsPerMonth;
// Monthly rolling quota
@override final  bool hasAutoBid;
@override final  bool hasPriorityNotifications;
@override final  bool hasEarlyAccess;
@override final  int earlyAccessHours;
// 0 for Free/ProBasic, 2 for ProPlus
@override final  bool hasFeaturedPlacement;
@override final  bool hasWaivedRelistFee;
@override final  bool hasMonthlyInsights;
@override final  bool hasStreakRewards;
@override final  String description;
 final  List<String> _features;
@override List<String> get features {
  if (_features is EqualUnmodifiableListView) return _features;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_features);
}

// DEPRECATED - Old GEMINI fields (kept for migration compatibility)
@override@JsonKey() final  int maxActiveBids;
@override@JsonKey() final  int maxActiveListings;
@override@JsonKey() final  double buyersPremiumDiscount;

/// Create a copy of SubscriptionTier
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubscriptionTierCopyWith<_SubscriptionTier> get copyWith => __$SubscriptionTierCopyWithImpl<_SubscriptionTier>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubscriptionTierToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubscriptionTier&&(identical(other.tierType, tierType) || other.tierType == tierType)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.badge, badge) || other.badge == badge)&&(identical(other.monthlyPrice, monthlyPrice) || other.monthlyPrice == monthlyPrice)&&(identical(other.yearlyPrice, yearlyPrice) || other.yearlyPrice == yearlyPrice)&&(identical(other.monthlyTokenAllocation, monthlyTokenAllocation) || other.monthlyTokenAllocation == monthlyTokenAllocation)&&(identical(other.maxListingsPerMonth, maxListingsPerMonth) || other.maxListingsPerMonth == maxListingsPerMonth)&&(identical(other.hasAutoBid, hasAutoBid) || other.hasAutoBid == hasAutoBid)&&(identical(other.hasPriorityNotifications, hasPriorityNotifications) || other.hasPriorityNotifications == hasPriorityNotifications)&&(identical(other.hasEarlyAccess, hasEarlyAccess) || other.hasEarlyAccess == hasEarlyAccess)&&(identical(other.earlyAccessHours, earlyAccessHours) || other.earlyAccessHours == earlyAccessHours)&&(identical(other.hasFeaturedPlacement, hasFeaturedPlacement) || other.hasFeaturedPlacement == hasFeaturedPlacement)&&(identical(other.hasWaivedRelistFee, hasWaivedRelistFee) || other.hasWaivedRelistFee == hasWaivedRelistFee)&&(identical(other.hasMonthlyInsights, hasMonthlyInsights) || other.hasMonthlyInsights == hasMonthlyInsights)&&(identical(other.hasStreakRewards, hasStreakRewards) || other.hasStreakRewards == hasStreakRewards)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._features, _features)&&(identical(other.maxActiveBids, maxActiveBids) || other.maxActiveBids == maxActiveBids)&&(identical(other.maxActiveListings, maxActiveListings) || other.maxActiveListings == maxActiveListings)&&(identical(other.buyersPremiumDiscount, buyersPremiumDiscount) || other.buyersPremiumDiscount == buyersPremiumDiscount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,tierType,displayName,badge,monthlyPrice,yearlyPrice,monthlyTokenAllocation,maxListingsPerMonth,hasAutoBid,hasPriorityNotifications,hasEarlyAccess,earlyAccessHours,hasFeaturedPlacement,hasWaivedRelistFee,hasMonthlyInsights,hasStreakRewards,description,const DeepCollectionEquality().hash(_features),maxActiveBids,maxActiveListings,buyersPremiumDiscount]);

@override
String toString() {
  return 'SubscriptionTier(tierType: $tierType, displayName: $displayName, badge: $badge, monthlyPrice: $monthlyPrice, yearlyPrice: $yearlyPrice, monthlyTokenAllocation: $monthlyTokenAllocation, maxListingsPerMonth: $maxListingsPerMonth, hasAutoBid: $hasAutoBid, hasPriorityNotifications: $hasPriorityNotifications, hasEarlyAccess: $hasEarlyAccess, earlyAccessHours: $earlyAccessHours, hasFeaturedPlacement: $hasFeaturedPlacement, hasWaivedRelistFee: $hasWaivedRelistFee, hasMonthlyInsights: $hasMonthlyInsights, hasStreakRewards: $hasStreakRewards, description: $description, features: $features, maxActiveBids: $maxActiveBids, maxActiveListings: $maxActiveListings, buyersPremiumDiscount: $buyersPremiumDiscount)';
}


}

/// @nodoc
abstract mixin class _$SubscriptionTierCopyWith<$Res> implements $SubscriptionTierCopyWith<$Res> {
  factory _$SubscriptionTierCopyWith(_SubscriptionTier value, $Res Function(_SubscriptionTier) _then) = __$SubscriptionTierCopyWithImpl;
@override @useResult
$Res call({
 SubscriptionTierType tierType, String displayName, String badge, double monthlyPrice, double yearlyPrice, int monthlyTokenAllocation, int maxListingsPerMonth, bool hasAutoBid, bool hasPriorityNotifications, bool hasEarlyAccess, int earlyAccessHours, bool hasFeaturedPlacement, bool hasWaivedRelistFee, bool hasMonthlyInsights, bool hasStreakRewards, String description, List<String> features, int maxActiveBids, int maxActiveListings, double buyersPremiumDiscount
});




}
/// @nodoc
class __$SubscriptionTierCopyWithImpl<$Res>
    implements _$SubscriptionTierCopyWith<$Res> {
  __$SubscriptionTierCopyWithImpl(this._self, this._then);

  final _SubscriptionTier _self;
  final $Res Function(_SubscriptionTier) _then;

/// Create a copy of SubscriptionTier
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tierType = null,Object? displayName = null,Object? badge = null,Object? monthlyPrice = null,Object? yearlyPrice = null,Object? monthlyTokenAllocation = null,Object? maxListingsPerMonth = null,Object? hasAutoBid = null,Object? hasPriorityNotifications = null,Object? hasEarlyAccess = null,Object? earlyAccessHours = null,Object? hasFeaturedPlacement = null,Object? hasWaivedRelistFee = null,Object? hasMonthlyInsights = null,Object? hasStreakRewards = null,Object? description = null,Object? features = null,Object? maxActiveBids = null,Object? maxActiveListings = null,Object? buyersPremiumDiscount = null,}) {
  return _then(_SubscriptionTier(
tierType: null == tierType ? _self.tierType : tierType // ignore: cast_nullable_to_non_nullable
as SubscriptionTierType,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,badge: null == badge ? _self.badge : badge // ignore: cast_nullable_to_non_nullable
as String,monthlyPrice: null == monthlyPrice ? _self.monthlyPrice : monthlyPrice // ignore: cast_nullable_to_non_nullable
as double,yearlyPrice: null == yearlyPrice ? _self.yearlyPrice : yearlyPrice // ignore: cast_nullable_to_non_nullable
as double,monthlyTokenAllocation: null == monthlyTokenAllocation ? _self.monthlyTokenAllocation : monthlyTokenAllocation // ignore: cast_nullable_to_non_nullable
as int,maxListingsPerMonth: null == maxListingsPerMonth ? _self.maxListingsPerMonth : maxListingsPerMonth // ignore: cast_nullable_to_non_nullable
as int,hasAutoBid: null == hasAutoBid ? _self.hasAutoBid : hasAutoBid // ignore: cast_nullable_to_non_nullable
as bool,hasPriorityNotifications: null == hasPriorityNotifications ? _self.hasPriorityNotifications : hasPriorityNotifications // ignore: cast_nullable_to_non_nullable
as bool,hasEarlyAccess: null == hasEarlyAccess ? _self.hasEarlyAccess : hasEarlyAccess // ignore: cast_nullable_to_non_nullable
as bool,earlyAccessHours: null == earlyAccessHours ? _self.earlyAccessHours : earlyAccessHours // ignore: cast_nullable_to_non_nullable
as int,hasFeaturedPlacement: null == hasFeaturedPlacement ? _self.hasFeaturedPlacement : hasFeaturedPlacement // ignore: cast_nullable_to_non_nullable
as bool,hasWaivedRelistFee: null == hasWaivedRelistFee ? _self.hasWaivedRelistFee : hasWaivedRelistFee // ignore: cast_nullable_to_non_nullable
as bool,hasMonthlyInsights: null == hasMonthlyInsights ? _self.hasMonthlyInsights : hasMonthlyInsights // ignore: cast_nullable_to_non_nullable
as bool,hasStreakRewards: null == hasStreakRewards ? _self.hasStreakRewards : hasStreakRewards // ignore: cast_nullable_to_non_nullable
as bool,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,features: null == features ? _self._features : features // ignore: cast_nullable_to_non_nullable
as List<String>,maxActiveBids: null == maxActiveBids ? _self.maxActiveBids : maxActiveBids // ignore: cast_nullable_to_non_nullable
as int,maxActiveListings: null == maxActiveListings ? _self.maxActiveListings : maxActiveListings // ignore: cast_nullable_to_non_nullable
as int,buyersPremiumDiscount: null == buyersPremiumDiscount ? _self.buyersPremiumDiscount : buyersPremiumDiscount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$UserSubscription {

 String get id; String get userId; SubscriptionTierType get tierType; BillingCycle get billingCycle; SubscriptionStatus get status; DateTime get startDate; DateTime? get endDate; DateTime get nextBillingDate; double get amountPaid; String? get paymentGatewaySubscriptionId;// Stripe, PayMongo, etc.
 DateTime? get cancelledAt; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of UserSubscription
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserSubscriptionCopyWith<UserSubscription> get copyWith => _$UserSubscriptionCopyWithImpl<UserSubscription>(this as UserSubscription, _$identity);

  /// Serializes this UserSubscription to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserSubscription&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.tierType, tierType) || other.tierType == tierType)&&(identical(other.billingCycle, billingCycle) || other.billingCycle == billingCycle)&&(identical(other.status, status) || other.status == status)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.nextBillingDate, nextBillingDate) || other.nextBillingDate == nextBillingDate)&&(identical(other.amountPaid, amountPaid) || other.amountPaid == amountPaid)&&(identical(other.paymentGatewaySubscriptionId, paymentGatewaySubscriptionId) || other.paymentGatewaySubscriptionId == paymentGatewaySubscriptionId)&&(identical(other.cancelledAt, cancelledAt) || other.cancelledAt == cancelledAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,tierType,billingCycle,status,startDate,endDate,nextBillingDate,amountPaid,paymentGatewaySubscriptionId,cancelledAt,createdAt,updatedAt);

@override
String toString() {
  return 'UserSubscription(id: $id, userId: $userId, tierType: $tierType, billingCycle: $billingCycle, status: $status, startDate: $startDate, endDate: $endDate, nextBillingDate: $nextBillingDate, amountPaid: $amountPaid, paymentGatewaySubscriptionId: $paymentGatewaySubscriptionId, cancelledAt: $cancelledAt, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $UserSubscriptionCopyWith<$Res>  {
  factory $UserSubscriptionCopyWith(UserSubscription value, $Res Function(UserSubscription) _then) = _$UserSubscriptionCopyWithImpl;
@useResult
$Res call({
 String id, String userId, SubscriptionTierType tierType, BillingCycle billingCycle, SubscriptionStatus status, DateTime startDate, DateTime? endDate, DateTime nextBillingDate, double amountPaid, String? paymentGatewaySubscriptionId, DateTime? cancelledAt, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$UserSubscriptionCopyWithImpl<$Res>
    implements $UserSubscriptionCopyWith<$Res> {
  _$UserSubscriptionCopyWithImpl(this._self, this._then);

  final UserSubscription _self;
  final $Res Function(UserSubscription) _then;

/// Create a copy of UserSubscription
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? tierType = null,Object? billingCycle = null,Object? status = null,Object? startDate = null,Object? endDate = freezed,Object? nextBillingDate = null,Object? amountPaid = null,Object? paymentGatewaySubscriptionId = freezed,Object? cancelledAt = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,tierType: null == tierType ? _self.tierType : tierType // ignore: cast_nullable_to_non_nullable
as SubscriptionTierType,billingCycle: null == billingCycle ? _self.billingCycle : billingCycle // ignore: cast_nullable_to_non_nullable
as BillingCycle,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SubscriptionStatus,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,nextBillingDate: null == nextBillingDate ? _self.nextBillingDate : nextBillingDate // ignore: cast_nullable_to_non_nullable
as DateTime,amountPaid: null == amountPaid ? _self.amountPaid : amountPaid // ignore: cast_nullable_to_non_nullable
as double,paymentGatewaySubscriptionId: freezed == paymentGatewaySubscriptionId ? _self.paymentGatewaySubscriptionId : paymentGatewaySubscriptionId // ignore: cast_nullable_to_non_nullable
as String?,cancelledAt: freezed == cancelledAt ? _self.cancelledAt : cancelledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserSubscription].
extension UserSubscriptionPatterns on UserSubscription {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserSubscription value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserSubscription() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserSubscription value)  $default,){
final _that = this;
switch (_that) {
case _UserSubscription():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserSubscription value)?  $default,){
final _that = this;
switch (_that) {
case _UserSubscription() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  SubscriptionTierType tierType,  BillingCycle billingCycle,  SubscriptionStatus status,  DateTime startDate,  DateTime? endDate,  DateTime nextBillingDate,  double amountPaid,  String? paymentGatewaySubscriptionId,  DateTime? cancelledAt,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserSubscription() when $default != null:
return $default(_that.id,_that.userId,_that.tierType,_that.billingCycle,_that.status,_that.startDate,_that.endDate,_that.nextBillingDate,_that.amountPaid,_that.paymentGatewaySubscriptionId,_that.cancelledAt,_that.createdAt,_that.updatedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  SubscriptionTierType tierType,  BillingCycle billingCycle,  SubscriptionStatus status,  DateTime startDate,  DateTime? endDate,  DateTime nextBillingDate,  double amountPaid,  String? paymentGatewaySubscriptionId,  DateTime? cancelledAt,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _UserSubscription():
return $default(_that.id,_that.userId,_that.tierType,_that.billingCycle,_that.status,_that.startDate,_that.endDate,_that.nextBillingDate,_that.amountPaid,_that.paymentGatewaySubscriptionId,_that.cancelledAt,_that.createdAt,_that.updatedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  SubscriptionTierType tierType,  BillingCycle billingCycle,  SubscriptionStatus status,  DateTime startDate,  DateTime? endDate,  DateTime nextBillingDate,  double amountPaid,  String? paymentGatewaySubscriptionId,  DateTime? cancelledAt,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _UserSubscription() when $default != null:
return $default(_that.id,_that.userId,_that.tierType,_that.billingCycle,_that.status,_that.startDate,_that.endDate,_that.nextBillingDate,_that.amountPaid,_that.paymentGatewaySubscriptionId,_that.cancelledAt,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserSubscription implements UserSubscription {
  const _UserSubscription({required this.id, required this.userId, required this.tierType, required this.billingCycle, required this.status, required this.startDate, required this.endDate, required this.nextBillingDate, required this.amountPaid, this.paymentGatewaySubscriptionId, this.cancelledAt, this.createdAt, this.updatedAt});
  factory _UserSubscription.fromJson(Map<String, dynamic> json) => _$UserSubscriptionFromJson(json);

@override final  String id;
@override final  String userId;
@override final  SubscriptionTierType tierType;
@override final  BillingCycle billingCycle;
@override final  SubscriptionStatus status;
@override final  DateTime startDate;
@override final  DateTime? endDate;
@override final  DateTime nextBillingDate;
@override final  double amountPaid;
@override final  String? paymentGatewaySubscriptionId;
// Stripe, PayMongo, etc.
@override final  DateTime? cancelledAt;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of UserSubscription
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserSubscriptionCopyWith<_UserSubscription> get copyWith => __$UserSubscriptionCopyWithImpl<_UserSubscription>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserSubscriptionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserSubscription&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.tierType, tierType) || other.tierType == tierType)&&(identical(other.billingCycle, billingCycle) || other.billingCycle == billingCycle)&&(identical(other.status, status) || other.status == status)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.nextBillingDate, nextBillingDate) || other.nextBillingDate == nextBillingDate)&&(identical(other.amountPaid, amountPaid) || other.amountPaid == amountPaid)&&(identical(other.paymentGatewaySubscriptionId, paymentGatewaySubscriptionId) || other.paymentGatewaySubscriptionId == paymentGatewaySubscriptionId)&&(identical(other.cancelledAt, cancelledAt) || other.cancelledAt == cancelledAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,tierType,billingCycle,status,startDate,endDate,nextBillingDate,amountPaid,paymentGatewaySubscriptionId,cancelledAt,createdAt,updatedAt);

@override
String toString() {
  return 'UserSubscription(id: $id, userId: $userId, tierType: $tierType, billingCycle: $billingCycle, status: $status, startDate: $startDate, endDate: $endDate, nextBillingDate: $nextBillingDate, amountPaid: $amountPaid, paymentGatewaySubscriptionId: $paymentGatewaySubscriptionId, cancelledAt: $cancelledAt, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$UserSubscriptionCopyWith<$Res> implements $UserSubscriptionCopyWith<$Res> {
  factory _$UserSubscriptionCopyWith(_UserSubscription value, $Res Function(_UserSubscription) _then) = __$UserSubscriptionCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, SubscriptionTierType tierType, BillingCycle billingCycle, SubscriptionStatus status, DateTime startDate, DateTime? endDate, DateTime nextBillingDate, double amountPaid, String? paymentGatewaySubscriptionId, DateTime? cancelledAt, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$UserSubscriptionCopyWithImpl<$Res>
    implements _$UserSubscriptionCopyWith<$Res> {
  __$UserSubscriptionCopyWithImpl(this._self, this._then);

  final _UserSubscription _self;
  final $Res Function(_UserSubscription) _then;

/// Create a copy of UserSubscription
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? tierType = null,Object? billingCycle = null,Object? status = null,Object? startDate = null,Object? endDate = freezed,Object? nextBillingDate = null,Object? amountPaid = null,Object? paymentGatewaySubscriptionId = freezed,Object? cancelledAt = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_UserSubscription(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,tierType: null == tierType ? _self.tierType : tierType // ignore: cast_nullable_to_non_nullable
as SubscriptionTierType,billingCycle: null == billingCycle ? _self.billingCycle : billingCycle // ignore: cast_nullable_to_non_nullable
as BillingCycle,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SubscriptionStatus,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,nextBillingDate: null == nextBillingDate ? _self.nextBillingDate : nextBillingDate // ignore: cast_nullable_to_non_nullable
as DateTime,amountPaid: null == amountPaid ? _self.amountPaid : amountPaid // ignore: cast_nullable_to_non_nullable
as double,paymentGatewaySubscriptionId: freezed == paymentGatewaySubscriptionId ? _self.paymentGatewaySubscriptionId : paymentGatewaySubscriptionId // ignore: cast_nullable_to_non_nullable
as String?,cancelledAt: freezed == cancelledAt ? _self.cancelledAt : cancelledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
