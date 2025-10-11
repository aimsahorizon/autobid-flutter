// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pricing_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PricingConfig {

/// Fixed listing fee charged when creating an auction (PHP 300-500)
/// Industry: Similar to Copart ($59-$189) and Manheim ($75-$300)
 double get listingFee;/// Minimum listing fee allowed (PHP)
 double get minListingFee;/// Maximum listing fee allowed (PHP)
 double get maxListingFee;/// Transaction fee for economy vehicles (< ₱800,000): 5%
/// Industry: Higher than premium to offset lower absolute revenue
/// Similar to Copart's buyer premium for lower-value vehicles
 double get economyTransactionFeeRate;/// Price threshold for economy vehicles (PHP)
 double get economyPriceThreshold;/// Transaction fee for mid-range vehicles (₱800k - ₱2M): 4%
/// Industry: Standard rate balancing volume and revenue
/// Comparable to Escrow.com's mid-tier rates (~3-4%)
 double get midRangeTransactionFeeRate;/// Price threshold for mid-range vehicles (PHP)
 double get midRangePriceThreshold;/// Transaction fee for premium vehicles (> ₱2M): 3%
/// Industry: Lower rate for high-value transactions
/// Similar to Escrow.com's premium tier (0.89% - 3.25%)
 double get premiumTransactionFeeRate;/// Minimum transaction fee (PHP)
/// Set to 0 to use pure percentage-based fees
 double get minTransactionFee;/// Maximum transaction fee cap (PHP) - optional ceiling
/// Set to null for no maximum cap
 double? get maxTransactionFee;/// Whether listing fee is refundable if auction doesn't complete
 bool get listingFeeRefundable;/// Whether listing fee is charged upfront or deducted from sale
 bool get listingFeeUpfront;
/// Create a copy of PricingConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PricingConfigCopyWith<PricingConfig> get copyWith => _$PricingConfigCopyWithImpl<PricingConfig>(this as PricingConfig, _$identity);

  /// Serializes this PricingConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PricingConfig&&(identical(other.listingFee, listingFee) || other.listingFee == listingFee)&&(identical(other.minListingFee, minListingFee) || other.minListingFee == minListingFee)&&(identical(other.maxListingFee, maxListingFee) || other.maxListingFee == maxListingFee)&&(identical(other.economyTransactionFeeRate, economyTransactionFeeRate) || other.economyTransactionFeeRate == economyTransactionFeeRate)&&(identical(other.economyPriceThreshold, economyPriceThreshold) || other.economyPriceThreshold == economyPriceThreshold)&&(identical(other.midRangeTransactionFeeRate, midRangeTransactionFeeRate) || other.midRangeTransactionFeeRate == midRangeTransactionFeeRate)&&(identical(other.midRangePriceThreshold, midRangePriceThreshold) || other.midRangePriceThreshold == midRangePriceThreshold)&&(identical(other.premiumTransactionFeeRate, premiumTransactionFeeRate) || other.premiumTransactionFeeRate == premiumTransactionFeeRate)&&(identical(other.minTransactionFee, minTransactionFee) || other.minTransactionFee == minTransactionFee)&&(identical(other.maxTransactionFee, maxTransactionFee) || other.maxTransactionFee == maxTransactionFee)&&(identical(other.listingFeeRefundable, listingFeeRefundable) || other.listingFeeRefundable == listingFeeRefundable)&&(identical(other.listingFeeUpfront, listingFeeUpfront) || other.listingFeeUpfront == listingFeeUpfront));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,listingFee,minListingFee,maxListingFee,economyTransactionFeeRate,economyPriceThreshold,midRangeTransactionFeeRate,midRangePriceThreshold,premiumTransactionFeeRate,minTransactionFee,maxTransactionFee,listingFeeRefundable,listingFeeUpfront);

@override
String toString() {
  return 'PricingConfig(listingFee: $listingFee, minListingFee: $minListingFee, maxListingFee: $maxListingFee, economyTransactionFeeRate: $economyTransactionFeeRate, economyPriceThreshold: $economyPriceThreshold, midRangeTransactionFeeRate: $midRangeTransactionFeeRate, midRangePriceThreshold: $midRangePriceThreshold, premiumTransactionFeeRate: $premiumTransactionFeeRate, minTransactionFee: $minTransactionFee, maxTransactionFee: $maxTransactionFee, listingFeeRefundable: $listingFeeRefundable, listingFeeUpfront: $listingFeeUpfront)';
}


}

/// @nodoc
abstract mixin class $PricingConfigCopyWith<$Res>  {
  factory $PricingConfigCopyWith(PricingConfig value, $Res Function(PricingConfig) _then) = _$PricingConfigCopyWithImpl;
@useResult
$Res call({
 double listingFee, double minListingFee, double maxListingFee, double economyTransactionFeeRate, double economyPriceThreshold, double midRangeTransactionFeeRate, double midRangePriceThreshold, double premiumTransactionFeeRate, double minTransactionFee, double? maxTransactionFee, bool listingFeeRefundable, bool listingFeeUpfront
});




}
/// @nodoc
class _$PricingConfigCopyWithImpl<$Res>
    implements $PricingConfigCopyWith<$Res> {
  _$PricingConfigCopyWithImpl(this._self, this._then);

  final PricingConfig _self;
  final $Res Function(PricingConfig) _then;

/// Create a copy of PricingConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? listingFee = null,Object? minListingFee = null,Object? maxListingFee = null,Object? economyTransactionFeeRate = null,Object? economyPriceThreshold = null,Object? midRangeTransactionFeeRate = null,Object? midRangePriceThreshold = null,Object? premiumTransactionFeeRate = null,Object? minTransactionFee = null,Object? maxTransactionFee = freezed,Object? listingFeeRefundable = null,Object? listingFeeUpfront = null,}) {
  return _then(_self.copyWith(
listingFee: null == listingFee ? _self.listingFee : listingFee // ignore: cast_nullable_to_non_nullable
as double,minListingFee: null == minListingFee ? _self.minListingFee : minListingFee // ignore: cast_nullable_to_non_nullable
as double,maxListingFee: null == maxListingFee ? _self.maxListingFee : maxListingFee // ignore: cast_nullable_to_non_nullable
as double,economyTransactionFeeRate: null == economyTransactionFeeRate ? _self.economyTransactionFeeRate : economyTransactionFeeRate // ignore: cast_nullable_to_non_nullable
as double,economyPriceThreshold: null == economyPriceThreshold ? _self.economyPriceThreshold : economyPriceThreshold // ignore: cast_nullable_to_non_nullable
as double,midRangeTransactionFeeRate: null == midRangeTransactionFeeRate ? _self.midRangeTransactionFeeRate : midRangeTransactionFeeRate // ignore: cast_nullable_to_non_nullable
as double,midRangePriceThreshold: null == midRangePriceThreshold ? _self.midRangePriceThreshold : midRangePriceThreshold // ignore: cast_nullable_to_non_nullable
as double,premiumTransactionFeeRate: null == premiumTransactionFeeRate ? _self.premiumTransactionFeeRate : premiumTransactionFeeRate // ignore: cast_nullable_to_non_nullable
as double,minTransactionFee: null == minTransactionFee ? _self.minTransactionFee : minTransactionFee // ignore: cast_nullable_to_non_nullable
as double,maxTransactionFee: freezed == maxTransactionFee ? _self.maxTransactionFee : maxTransactionFee // ignore: cast_nullable_to_non_nullable
as double?,listingFeeRefundable: null == listingFeeRefundable ? _self.listingFeeRefundable : listingFeeRefundable // ignore: cast_nullable_to_non_nullable
as bool,listingFeeUpfront: null == listingFeeUpfront ? _self.listingFeeUpfront : listingFeeUpfront // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PricingConfig].
extension PricingConfigPatterns on PricingConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PricingConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PricingConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PricingConfig value)  $default,){
final _that = this;
switch (_that) {
case _PricingConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PricingConfig value)?  $default,){
final _that = this;
switch (_that) {
case _PricingConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double listingFee,  double minListingFee,  double maxListingFee,  double economyTransactionFeeRate,  double economyPriceThreshold,  double midRangeTransactionFeeRate,  double midRangePriceThreshold,  double premiumTransactionFeeRate,  double minTransactionFee,  double? maxTransactionFee,  bool listingFeeRefundable,  bool listingFeeUpfront)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PricingConfig() when $default != null:
return $default(_that.listingFee,_that.minListingFee,_that.maxListingFee,_that.economyTransactionFeeRate,_that.economyPriceThreshold,_that.midRangeTransactionFeeRate,_that.midRangePriceThreshold,_that.premiumTransactionFeeRate,_that.minTransactionFee,_that.maxTransactionFee,_that.listingFeeRefundable,_that.listingFeeUpfront);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double listingFee,  double minListingFee,  double maxListingFee,  double economyTransactionFeeRate,  double economyPriceThreshold,  double midRangeTransactionFeeRate,  double midRangePriceThreshold,  double premiumTransactionFeeRate,  double minTransactionFee,  double? maxTransactionFee,  bool listingFeeRefundable,  bool listingFeeUpfront)  $default,) {final _that = this;
switch (_that) {
case _PricingConfig():
return $default(_that.listingFee,_that.minListingFee,_that.maxListingFee,_that.economyTransactionFeeRate,_that.economyPriceThreshold,_that.midRangeTransactionFeeRate,_that.midRangePriceThreshold,_that.premiumTransactionFeeRate,_that.minTransactionFee,_that.maxTransactionFee,_that.listingFeeRefundable,_that.listingFeeUpfront);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double listingFee,  double minListingFee,  double maxListingFee,  double economyTransactionFeeRate,  double economyPriceThreshold,  double midRangeTransactionFeeRate,  double midRangePriceThreshold,  double premiumTransactionFeeRate,  double minTransactionFee,  double? maxTransactionFee,  bool listingFeeRefundable,  bool listingFeeUpfront)?  $default,) {final _that = this;
switch (_that) {
case _PricingConfig() when $default != null:
return $default(_that.listingFee,_that.minListingFee,_that.maxListingFee,_that.economyTransactionFeeRate,_that.economyPriceThreshold,_that.midRangeTransactionFeeRate,_that.midRangePriceThreshold,_that.premiumTransactionFeeRate,_that.minTransactionFee,_that.maxTransactionFee,_that.listingFeeRefundable,_that.listingFeeUpfront);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PricingConfig implements PricingConfig {
  const _PricingConfig({this.listingFee = 400.0, this.minListingFee = 300.0, this.maxListingFee = 500.0, this.economyTransactionFeeRate = 0.05, this.economyPriceThreshold = 800000.0, this.midRangeTransactionFeeRate = 0.04, this.midRangePriceThreshold = 2000000.0, this.premiumTransactionFeeRate = 0.03, this.minTransactionFee = 0.0, this.maxTransactionFee, this.listingFeeRefundable = false, this.listingFeeUpfront = true});
  factory _PricingConfig.fromJson(Map<String, dynamic> json) => _$PricingConfigFromJson(json);

/// Fixed listing fee charged when creating an auction (PHP 300-500)
/// Industry: Similar to Copart ($59-$189) and Manheim ($75-$300)
@override@JsonKey() final  double listingFee;
/// Minimum listing fee allowed (PHP)
@override@JsonKey() final  double minListingFee;
/// Maximum listing fee allowed (PHP)
@override@JsonKey() final  double maxListingFee;
/// Transaction fee for economy vehicles (< ₱800,000): 5%
/// Industry: Higher than premium to offset lower absolute revenue
/// Similar to Copart's buyer premium for lower-value vehicles
@override@JsonKey() final  double economyTransactionFeeRate;
/// Price threshold for economy vehicles (PHP)
@override@JsonKey() final  double economyPriceThreshold;
/// Transaction fee for mid-range vehicles (₱800k - ₱2M): 4%
/// Industry: Standard rate balancing volume and revenue
/// Comparable to Escrow.com's mid-tier rates (~3-4%)
@override@JsonKey() final  double midRangeTransactionFeeRate;
/// Price threshold for mid-range vehicles (PHP)
@override@JsonKey() final  double midRangePriceThreshold;
/// Transaction fee for premium vehicles (> ₱2M): 3%
/// Industry: Lower rate for high-value transactions
/// Similar to Escrow.com's premium tier (0.89% - 3.25%)
@override@JsonKey() final  double premiumTransactionFeeRate;
/// Minimum transaction fee (PHP)
/// Set to 0 to use pure percentage-based fees
@override@JsonKey() final  double minTransactionFee;
/// Maximum transaction fee cap (PHP) - optional ceiling
/// Set to null for no maximum cap
@override final  double? maxTransactionFee;
/// Whether listing fee is refundable if auction doesn't complete
@override@JsonKey() final  bool listingFeeRefundable;
/// Whether listing fee is charged upfront or deducted from sale
@override@JsonKey() final  bool listingFeeUpfront;

/// Create a copy of PricingConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PricingConfigCopyWith<_PricingConfig> get copyWith => __$PricingConfigCopyWithImpl<_PricingConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PricingConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PricingConfig&&(identical(other.listingFee, listingFee) || other.listingFee == listingFee)&&(identical(other.minListingFee, minListingFee) || other.minListingFee == minListingFee)&&(identical(other.maxListingFee, maxListingFee) || other.maxListingFee == maxListingFee)&&(identical(other.economyTransactionFeeRate, economyTransactionFeeRate) || other.economyTransactionFeeRate == economyTransactionFeeRate)&&(identical(other.economyPriceThreshold, economyPriceThreshold) || other.economyPriceThreshold == economyPriceThreshold)&&(identical(other.midRangeTransactionFeeRate, midRangeTransactionFeeRate) || other.midRangeTransactionFeeRate == midRangeTransactionFeeRate)&&(identical(other.midRangePriceThreshold, midRangePriceThreshold) || other.midRangePriceThreshold == midRangePriceThreshold)&&(identical(other.premiumTransactionFeeRate, premiumTransactionFeeRate) || other.premiumTransactionFeeRate == premiumTransactionFeeRate)&&(identical(other.minTransactionFee, minTransactionFee) || other.minTransactionFee == minTransactionFee)&&(identical(other.maxTransactionFee, maxTransactionFee) || other.maxTransactionFee == maxTransactionFee)&&(identical(other.listingFeeRefundable, listingFeeRefundable) || other.listingFeeRefundable == listingFeeRefundable)&&(identical(other.listingFeeUpfront, listingFeeUpfront) || other.listingFeeUpfront == listingFeeUpfront));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,listingFee,minListingFee,maxListingFee,economyTransactionFeeRate,economyPriceThreshold,midRangeTransactionFeeRate,midRangePriceThreshold,premiumTransactionFeeRate,minTransactionFee,maxTransactionFee,listingFeeRefundable,listingFeeUpfront);

@override
String toString() {
  return 'PricingConfig(listingFee: $listingFee, minListingFee: $minListingFee, maxListingFee: $maxListingFee, economyTransactionFeeRate: $economyTransactionFeeRate, economyPriceThreshold: $economyPriceThreshold, midRangeTransactionFeeRate: $midRangeTransactionFeeRate, midRangePriceThreshold: $midRangePriceThreshold, premiumTransactionFeeRate: $premiumTransactionFeeRate, minTransactionFee: $minTransactionFee, maxTransactionFee: $maxTransactionFee, listingFeeRefundable: $listingFeeRefundable, listingFeeUpfront: $listingFeeUpfront)';
}


}

/// @nodoc
abstract mixin class _$PricingConfigCopyWith<$Res> implements $PricingConfigCopyWith<$Res> {
  factory _$PricingConfigCopyWith(_PricingConfig value, $Res Function(_PricingConfig) _then) = __$PricingConfigCopyWithImpl;
@override @useResult
$Res call({
 double listingFee, double minListingFee, double maxListingFee, double economyTransactionFeeRate, double economyPriceThreshold, double midRangeTransactionFeeRate, double midRangePriceThreshold, double premiumTransactionFeeRate, double minTransactionFee, double? maxTransactionFee, bool listingFeeRefundable, bool listingFeeUpfront
});




}
/// @nodoc
class __$PricingConfigCopyWithImpl<$Res>
    implements _$PricingConfigCopyWith<$Res> {
  __$PricingConfigCopyWithImpl(this._self, this._then);

  final _PricingConfig _self;
  final $Res Function(_PricingConfig) _then;

/// Create a copy of PricingConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? listingFee = null,Object? minListingFee = null,Object? maxListingFee = null,Object? economyTransactionFeeRate = null,Object? economyPriceThreshold = null,Object? midRangeTransactionFeeRate = null,Object? midRangePriceThreshold = null,Object? premiumTransactionFeeRate = null,Object? minTransactionFee = null,Object? maxTransactionFee = freezed,Object? listingFeeRefundable = null,Object? listingFeeUpfront = null,}) {
  return _then(_PricingConfig(
listingFee: null == listingFee ? _self.listingFee : listingFee // ignore: cast_nullable_to_non_nullable
as double,minListingFee: null == minListingFee ? _self.minListingFee : minListingFee // ignore: cast_nullable_to_non_nullable
as double,maxListingFee: null == maxListingFee ? _self.maxListingFee : maxListingFee // ignore: cast_nullable_to_non_nullable
as double,economyTransactionFeeRate: null == economyTransactionFeeRate ? _self.economyTransactionFeeRate : economyTransactionFeeRate // ignore: cast_nullable_to_non_nullable
as double,economyPriceThreshold: null == economyPriceThreshold ? _self.economyPriceThreshold : economyPriceThreshold // ignore: cast_nullable_to_non_nullable
as double,midRangeTransactionFeeRate: null == midRangeTransactionFeeRate ? _self.midRangeTransactionFeeRate : midRangeTransactionFeeRate // ignore: cast_nullable_to_non_nullable
as double,midRangePriceThreshold: null == midRangePriceThreshold ? _self.midRangePriceThreshold : midRangePriceThreshold // ignore: cast_nullable_to_non_nullable
as double,premiumTransactionFeeRate: null == premiumTransactionFeeRate ? _self.premiumTransactionFeeRate : premiumTransactionFeeRate // ignore: cast_nullable_to_non_nullable
as double,minTransactionFee: null == minTransactionFee ? _self.minTransactionFee : minTransactionFee // ignore: cast_nullable_to_non_nullable
as double,maxTransactionFee: freezed == maxTransactionFee ? _self.maxTransactionFee : maxTransactionFee // ignore: cast_nullable_to_non_nullable
as double?,listingFeeRefundable: null == listingFeeRefundable ? _self.listingFeeRefundable : listingFeeRefundable // ignore: cast_nullable_to_non_nullable
as bool,listingFeeUpfront: null == listingFeeUpfront ? _self.listingFeeUpfront : listingFeeUpfront // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$FeeBreakdown {

/// Original sale price before fees
 double get salePrice;/// Listing fee charged to seller
 double get listingFee;/// Transaction fee rate applied (as percentage, e.g., 0.05 = 5%)
 double get transactionFeeRate;/// Calculated transaction fee amount
 double get transactionFee;/// Total platform fees (listing fee + transaction fee)
 double get totalPlatformFees;/// Total amount buyer pays (sale price + buyer portion if applicable)
 double get totalBuyerAmount;/// Amount seller receives after fees
 double get sellerReceives;/// Price tier used for calculation
 PriceTier get priceTier;
/// Create a copy of FeeBreakdown
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeeBreakdownCopyWith<FeeBreakdown> get copyWith => _$FeeBreakdownCopyWithImpl<FeeBreakdown>(this as FeeBreakdown, _$identity);

  /// Serializes this FeeBreakdown to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeeBreakdown&&(identical(other.salePrice, salePrice) || other.salePrice == salePrice)&&(identical(other.listingFee, listingFee) || other.listingFee == listingFee)&&(identical(other.transactionFeeRate, transactionFeeRate) || other.transactionFeeRate == transactionFeeRate)&&(identical(other.transactionFee, transactionFee) || other.transactionFee == transactionFee)&&(identical(other.totalPlatformFees, totalPlatformFees) || other.totalPlatformFees == totalPlatformFees)&&(identical(other.totalBuyerAmount, totalBuyerAmount) || other.totalBuyerAmount == totalBuyerAmount)&&(identical(other.sellerReceives, sellerReceives) || other.sellerReceives == sellerReceives)&&(identical(other.priceTier, priceTier) || other.priceTier == priceTier));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,salePrice,listingFee,transactionFeeRate,transactionFee,totalPlatformFees,totalBuyerAmount,sellerReceives,priceTier);

@override
String toString() {
  return 'FeeBreakdown(salePrice: $salePrice, listingFee: $listingFee, transactionFeeRate: $transactionFeeRate, transactionFee: $transactionFee, totalPlatformFees: $totalPlatformFees, totalBuyerAmount: $totalBuyerAmount, sellerReceives: $sellerReceives, priceTier: $priceTier)';
}


}

/// @nodoc
abstract mixin class $FeeBreakdownCopyWith<$Res>  {
  factory $FeeBreakdownCopyWith(FeeBreakdown value, $Res Function(FeeBreakdown) _then) = _$FeeBreakdownCopyWithImpl;
@useResult
$Res call({
 double salePrice, double listingFee, double transactionFeeRate, double transactionFee, double totalPlatformFees, double totalBuyerAmount, double sellerReceives, PriceTier priceTier
});




}
/// @nodoc
class _$FeeBreakdownCopyWithImpl<$Res>
    implements $FeeBreakdownCopyWith<$Res> {
  _$FeeBreakdownCopyWithImpl(this._self, this._then);

  final FeeBreakdown _self;
  final $Res Function(FeeBreakdown) _then;

/// Create a copy of FeeBreakdown
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? salePrice = null,Object? listingFee = null,Object? transactionFeeRate = null,Object? transactionFee = null,Object? totalPlatformFees = null,Object? totalBuyerAmount = null,Object? sellerReceives = null,Object? priceTier = null,}) {
  return _then(_self.copyWith(
salePrice: null == salePrice ? _self.salePrice : salePrice // ignore: cast_nullable_to_non_nullable
as double,listingFee: null == listingFee ? _self.listingFee : listingFee // ignore: cast_nullable_to_non_nullable
as double,transactionFeeRate: null == transactionFeeRate ? _self.transactionFeeRate : transactionFeeRate // ignore: cast_nullable_to_non_nullable
as double,transactionFee: null == transactionFee ? _self.transactionFee : transactionFee // ignore: cast_nullable_to_non_nullable
as double,totalPlatformFees: null == totalPlatformFees ? _self.totalPlatformFees : totalPlatformFees // ignore: cast_nullable_to_non_nullable
as double,totalBuyerAmount: null == totalBuyerAmount ? _self.totalBuyerAmount : totalBuyerAmount // ignore: cast_nullable_to_non_nullable
as double,sellerReceives: null == sellerReceives ? _self.sellerReceives : sellerReceives // ignore: cast_nullable_to_non_nullable
as double,priceTier: null == priceTier ? _self.priceTier : priceTier // ignore: cast_nullable_to_non_nullable
as PriceTier,
  ));
}

}


/// Adds pattern-matching-related methods to [FeeBreakdown].
extension FeeBreakdownPatterns on FeeBreakdown {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeeBreakdown value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeeBreakdown() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeeBreakdown value)  $default,){
final _that = this;
switch (_that) {
case _FeeBreakdown():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeeBreakdown value)?  $default,){
final _that = this;
switch (_that) {
case _FeeBreakdown() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double salePrice,  double listingFee,  double transactionFeeRate,  double transactionFee,  double totalPlatformFees,  double totalBuyerAmount,  double sellerReceives,  PriceTier priceTier)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeeBreakdown() when $default != null:
return $default(_that.salePrice,_that.listingFee,_that.transactionFeeRate,_that.transactionFee,_that.totalPlatformFees,_that.totalBuyerAmount,_that.sellerReceives,_that.priceTier);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double salePrice,  double listingFee,  double transactionFeeRate,  double transactionFee,  double totalPlatformFees,  double totalBuyerAmount,  double sellerReceives,  PriceTier priceTier)  $default,) {final _that = this;
switch (_that) {
case _FeeBreakdown():
return $default(_that.salePrice,_that.listingFee,_that.transactionFeeRate,_that.transactionFee,_that.totalPlatformFees,_that.totalBuyerAmount,_that.sellerReceives,_that.priceTier);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double salePrice,  double listingFee,  double transactionFeeRate,  double transactionFee,  double totalPlatformFees,  double totalBuyerAmount,  double sellerReceives,  PriceTier priceTier)?  $default,) {final _that = this;
switch (_that) {
case _FeeBreakdown() when $default != null:
return $default(_that.salePrice,_that.listingFee,_that.transactionFeeRate,_that.transactionFee,_that.totalPlatformFees,_that.totalBuyerAmount,_that.sellerReceives,_that.priceTier);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FeeBreakdown implements FeeBreakdown {
  const _FeeBreakdown({required this.salePrice, required this.listingFee, required this.transactionFeeRate, required this.transactionFee, required this.totalPlatformFees, required this.totalBuyerAmount, required this.sellerReceives, required this.priceTier});
  factory _FeeBreakdown.fromJson(Map<String, dynamic> json) => _$FeeBreakdownFromJson(json);

/// Original sale price before fees
@override final  double salePrice;
/// Listing fee charged to seller
@override final  double listingFee;
/// Transaction fee rate applied (as percentage, e.g., 0.05 = 5%)
@override final  double transactionFeeRate;
/// Calculated transaction fee amount
@override final  double transactionFee;
/// Total platform fees (listing fee + transaction fee)
@override final  double totalPlatformFees;
/// Total amount buyer pays (sale price + buyer portion if applicable)
@override final  double totalBuyerAmount;
/// Amount seller receives after fees
@override final  double sellerReceives;
/// Price tier used for calculation
@override final  PriceTier priceTier;

/// Create a copy of FeeBreakdown
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeeBreakdownCopyWith<_FeeBreakdown> get copyWith => __$FeeBreakdownCopyWithImpl<_FeeBreakdown>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeeBreakdownToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeeBreakdown&&(identical(other.salePrice, salePrice) || other.salePrice == salePrice)&&(identical(other.listingFee, listingFee) || other.listingFee == listingFee)&&(identical(other.transactionFeeRate, transactionFeeRate) || other.transactionFeeRate == transactionFeeRate)&&(identical(other.transactionFee, transactionFee) || other.transactionFee == transactionFee)&&(identical(other.totalPlatformFees, totalPlatformFees) || other.totalPlatformFees == totalPlatformFees)&&(identical(other.totalBuyerAmount, totalBuyerAmount) || other.totalBuyerAmount == totalBuyerAmount)&&(identical(other.sellerReceives, sellerReceives) || other.sellerReceives == sellerReceives)&&(identical(other.priceTier, priceTier) || other.priceTier == priceTier));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,salePrice,listingFee,transactionFeeRate,transactionFee,totalPlatformFees,totalBuyerAmount,sellerReceives,priceTier);

@override
String toString() {
  return 'FeeBreakdown(salePrice: $salePrice, listingFee: $listingFee, transactionFeeRate: $transactionFeeRate, transactionFee: $transactionFee, totalPlatformFees: $totalPlatformFees, totalBuyerAmount: $totalBuyerAmount, sellerReceives: $sellerReceives, priceTier: $priceTier)';
}


}

/// @nodoc
abstract mixin class _$FeeBreakdownCopyWith<$Res> implements $FeeBreakdownCopyWith<$Res> {
  factory _$FeeBreakdownCopyWith(_FeeBreakdown value, $Res Function(_FeeBreakdown) _then) = __$FeeBreakdownCopyWithImpl;
@override @useResult
$Res call({
 double salePrice, double listingFee, double transactionFeeRate, double transactionFee, double totalPlatformFees, double totalBuyerAmount, double sellerReceives, PriceTier priceTier
});




}
/// @nodoc
class __$FeeBreakdownCopyWithImpl<$Res>
    implements _$FeeBreakdownCopyWith<$Res> {
  __$FeeBreakdownCopyWithImpl(this._self, this._then);

  final _FeeBreakdown _self;
  final $Res Function(_FeeBreakdown) _then;

/// Create a copy of FeeBreakdown
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? salePrice = null,Object? listingFee = null,Object? transactionFeeRate = null,Object? transactionFee = null,Object? totalPlatformFees = null,Object? totalBuyerAmount = null,Object? sellerReceives = null,Object? priceTier = null,}) {
  return _then(_FeeBreakdown(
salePrice: null == salePrice ? _self.salePrice : salePrice // ignore: cast_nullable_to_non_nullable
as double,listingFee: null == listingFee ? _self.listingFee : listingFee // ignore: cast_nullable_to_non_nullable
as double,transactionFeeRate: null == transactionFeeRate ? _self.transactionFeeRate : transactionFeeRate // ignore: cast_nullable_to_non_nullable
as double,transactionFee: null == transactionFee ? _self.transactionFee : transactionFee // ignore: cast_nullable_to_non_nullable
as double,totalPlatformFees: null == totalPlatformFees ? _self.totalPlatformFees : totalPlatformFees // ignore: cast_nullable_to_non_nullable
as double,totalBuyerAmount: null == totalBuyerAmount ? _self.totalBuyerAmount : totalBuyerAmount // ignore: cast_nullable_to_non_nullable
as double,sellerReceives: null == sellerReceives ? _self.sellerReceives : sellerReceives // ignore: cast_nullable_to_non_nullable
as double,priceTier: null == priceTier ? _self.priceTier : priceTier // ignore: cast_nullable_to_non_nullable
as PriceTier,
  ));
}


}

// dart format on
