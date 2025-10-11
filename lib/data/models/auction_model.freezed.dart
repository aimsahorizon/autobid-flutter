// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auction_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Auction {

 String get id; String get carId; String get sellerId; double get startingPrice; double get currentBid; double get reservePrice; double? get buyNowPrice; DateTime get startTime; DateTime get endTime; AuctionStatus get status; int get totalBids; String? get topBidderId; String? get topBidderName; bool get autoBidEnabled; List<String> get watchers; DateTime get createdAt; DateTime get updatedAt; CarModel? get car;// ===== EXTENDED: Listing Fee =====
/// Listing fee charged to seller when creating this auction (PHP 300-500)
/// This is a fixed upfront fee covering operational costs:
/// - Platform hosting and bandwidth
/// - Image storage and processing
/// - Auction management overhead
///
/// Industry reference: Similar to Copart ($59-$189), Manheim ($75-$300)
/// Default value of 400 PHP aligns with mid-tier industry standards
 double get listingFee;/// Whether the listing fee has been paid by the seller
/// In production, this would be tracked through payment gateway
 bool get listingFeePaid;/// When the listing fee was paid (if applicable)
 DateTime? get listingFeePaidAt;
/// Create a copy of Auction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuctionCopyWith<Auction> get copyWith => _$AuctionCopyWithImpl<Auction>(this as Auction, _$identity);

  /// Serializes this Auction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Auction&&(identical(other.id, id) || other.id == id)&&(identical(other.carId, carId) || other.carId == carId)&&(identical(other.sellerId, sellerId) || other.sellerId == sellerId)&&(identical(other.startingPrice, startingPrice) || other.startingPrice == startingPrice)&&(identical(other.currentBid, currentBid) || other.currentBid == currentBid)&&(identical(other.reservePrice, reservePrice) || other.reservePrice == reservePrice)&&(identical(other.buyNowPrice, buyNowPrice) || other.buyNowPrice == buyNowPrice)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.status, status) || other.status == status)&&(identical(other.totalBids, totalBids) || other.totalBids == totalBids)&&(identical(other.topBidderId, topBidderId) || other.topBidderId == topBidderId)&&(identical(other.topBidderName, topBidderName) || other.topBidderName == topBidderName)&&(identical(other.autoBidEnabled, autoBidEnabled) || other.autoBidEnabled == autoBidEnabled)&&const DeepCollectionEquality().equals(other.watchers, watchers)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.car, car) || other.car == car)&&(identical(other.listingFee, listingFee) || other.listingFee == listingFee)&&(identical(other.listingFeePaid, listingFeePaid) || other.listingFeePaid == listingFeePaid)&&(identical(other.listingFeePaidAt, listingFeePaidAt) || other.listingFeePaidAt == listingFeePaidAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,carId,sellerId,startingPrice,currentBid,reservePrice,buyNowPrice,startTime,endTime,status,totalBids,topBidderId,topBidderName,autoBidEnabled,const DeepCollectionEquality().hash(watchers),createdAt,updatedAt,car,listingFee,listingFeePaid,listingFeePaidAt]);

@override
String toString() {
  return 'Auction(id: $id, carId: $carId, sellerId: $sellerId, startingPrice: $startingPrice, currentBid: $currentBid, reservePrice: $reservePrice, buyNowPrice: $buyNowPrice, startTime: $startTime, endTime: $endTime, status: $status, totalBids: $totalBids, topBidderId: $topBidderId, topBidderName: $topBidderName, autoBidEnabled: $autoBidEnabled, watchers: $watchers, createdAt: $createdAt, updatedAt: $updatedAt, car: $car, listingFee: $listingFee, listingFeePaid: $listingFeePaid, listingFeePaidAt: $listingFeePaidAt)';
}


}

/// @nodoc
abstract mixin class $AuctionCopyWith<$Res>  {
  factory $AuctionCopyWith(Auction value, $Res Function(Auction) _then) = _$AuctionCopyWithImpl;
@useResult
$Res call({
 String id, String carId, String sellerId, double startingPrice, double currentBid, double reservePrice, double? buyNowPrice, DateTime startTime, DateTime endTime, AuctionStatus status, int totalBids, String? topBidderId, String? topBidderName, bool autoBidEnabled, List<String> watchers, DateTime createdAt, DateTime updatedAt, CarModel? car, double listingFee, bool listingFeePaid, DateTime? listingFeePaidAt
});


$CarModelCopyWith<$Res>? get car;

}
/// @nodoc
class _$AuctionCopyWithImpl<$Res>
    implements $AuctionCopyWith<$Res> {
  _$AuctionCopyWithImpl(this._self, this._then);

  final Auction _self;
  final $Res Function(Auction) _then;

/// Create a copy of Auction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? carId = null,Object? sellerId = null,Object? startingPrice = null,Object? currentBid = null,Object? reservePrice = null,Object? buyNowPrice = freezed,Object? startTime = null,Object? endTime = null,Object? status = null,Object? totalBids = null,Object? topBidderId = freezed,Object? topBidderName = freezed,Object? autoBidEnabled = null,Object? watchers = null,Object? createdAt = null,Object? updatedAt = null,Object? car = freezed,Object? listingFee = null,Object? listingFeePaid = null,Object? listingFeePaidAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,carId: null == carId ? _self.carId : carId // ignore: cast_nullable_to_non_nullable
as String,sellerId: null == sellerId ? _self.sellerId : sellerId // ignore: cast_nullable_to_non_nullable
as String,startingPrice: null == startingPrice ? _self.startingPrice : startingPrice // ignore: cast_nullable_to_non_nullable
as double,currentBid: null == currentBid ? _self.currentBid : currentBid // ignore: cast_nullable_to_non_nullable
as double,reservePrice: null == reservePrice ? _self.reservePrice : reservePrice // ignore: cast_nullable_to_non_nullable
as double,buyNowPrice: freezed == buyNowPrice ? _self.buyNowPrice : buyNowPrice // ignore: cast_nullable_to_non_nullable
as double?,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AuctionStatus,totalBids: null == totalBids ? _self.totalBids : totalBids // ignore: cast_nullable_to_non_nullable
as int,topBidderId: freezed == topBidderId ? _self.topBidderId : topBidderId // ignore: cast_nullable_to_non_nullable
as String?,topBidderName: freezed == topBidderName ? _self.topBidderName : topBidderName // ignore: cast_nullable_to_non_nullable
as String?,autoBidEnabled: null == autoBidEnabled ? _self.autoBidEnabled : autoBidEnabled // ignore: cast_nullable_to_non_nullable
as bool,watchers: null == watchers ? _self.watchers : watchers // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,car: freezed == car ? _self.car : car // ignore: cast_nullable_to_non_nullable
as CarModel?,listingFee: null == listingFee ? _self.listingFee : listingFee // ignore: cast_nullable_to_non_nullable
as double,listingFeePaid: null == listingFeePaid ? _self.listingFeePaid : listingFeePaid // ignore: cast_nullable_to_non_nullable
as bool,listingFeePaidAt: freezed == listingFeePaidAt ? _self.listingFeePaidAt : listingFeePaidAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of Auction
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CarModelCopyWith<$Res>? get car {
    if (_self.car == null) {
    return null;
  }

  return $CarModelCopyWith<$Res>(_self.car!, (value) {
    return _then(_self.copyWith(car: value));
  });
}
}


/// Adds pattern-matching-related methods to [Auction].
extension AuctionPatterns on Auction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Auction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Auction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Auction value)  $default,){
final _that = this;
switch (_that) {
case _Auction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Auction value)?  $default,){
final _that = this;
switch (_that) {
case _Auction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String carId,  String sellerId,  double startingPrice,  double currentBid,  double reservePrice,  double? buyNowPrice,  DateTime startTime,  DateTime endTime,  AuctionStatus status,  int totalBids,  String? topBidderId,  String? topBidderName,  bool autoBidEnabled,  List<String> watchers,  DateTime createdAt,  DateTime updatedAt,  CarModel? car,  double listingFee,  bool listingFeePaid,  DateTime? listingFeePaidAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Auction() when $default != null:
return $default(_that.id,_that.carId,_that.sellerId,_that.startingPrice,_that.currentBid,_that.reservePrice,_that.buyNowPrice,_that.startTime,_that.endTime,_that.status,_that.totalBids,_that.topBidderId,_that.topBidderName,_that.autoBidEnabled,_that.watchers,_that.createdAt,_that.updatedAt,_that.car,_that.listingFee,_that.listingFeePaid,_that.listingFeePaidAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String carId,  String sellerId,  double startingPrice,  double currentBid,  double reservePrice,  double? buyNowPrice,  DateTime startTime,  DateTime endTime,  AuctionStatus status,  int totalBids,  String? topBidderId,  String? topBidderName,  bool autoBidEnabled,  List<String> watchers,  DateTime createdAt,  DateTime updatedAt,  CarModel? car,  double listingFee,  bool listingFeePaid,  DateTime? listingFeePaidAt)  $default,) {final _that = this;
switch (_that) {
case _Auction():
return $default(_that.id,_that.carId,_that.sellerId,_that.startingPrice,_that.currentBid,_that.reservePrice,_that.buyNowPrice,_that.startTime,_that.endTime,_that.status,_that.totalBids,_that.topBidderId,_that.topBidderName,_that.autoBidEnabled,_that.watchers,_that.createdAt,_that.updatedAt,_that.car,_that.listingFee,_that.listingFeePaid,_that.listingFeePaidAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String carId,  String sellerId,  double startingPrice,  double currentBid,  double reservePrice,  double? buyNowPrice,  DateTime startTime,  DateTime endTime,  AuctionStatus status,  int totalBids,  String? topBidderId,  String? topBidderName,  bool autoBidEnabled,  List<String> watchers,  DateTime createdAt,  DateTime updatedAt,  CarModel? car,  double listingFee,  bool listingFeePaid,  DateTime? listingFeePaidAt)?  $default,) {final _that = this;
switch (_that) {
case _Auction() when $default != null:
return $default(_that.id,_that.carId,_that.sellerId,_that.startingPrice,_that.currentBid,_that.reservePrice,_that.buyNowPrice,_that.startTime,_that.endTime,_that.status,_that.totalBids,_that.topBidderId,_that.topBidderName,_that.autoBidEnabled,_that.watchers,_that.createdAt,_that.updatedAt,_that.car,_that.listingFee,_that.listingFeePaid,_that.listingFeePaidAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Auction implements Auction {
  const _Auction({required this.id, required this.carId, required this.sellerId, required this.startingPrice, required this.currentBid, required this.reservePrice, this.buyNowPrice, required this.startTime, required this.endTime, required this.status, this.totalBids = 0, this.topBidderId, this.topBidderName, this.autoBidEnabled = false, final  List<String> watchers = const [], required this.createdAt, required this.updatedAt, this.car, this.listingFee = 400.0, this.listingFeePaid = false, this.listingFeePaidAt}): _watchers = watchers;
  factory _Auction.fromJson(Map<String, dynamic> json) => _$AuctionFromJson(json);

@override final  String id;
@override final  String carId;
@override final  String sellerId;
@override final  double startingPrice;
@override final  double currentBid;
@override final  double reservePrice;
@override final  double? buyNowPrice;
@override final  DateTime startTime;
@override final  DateTime endTime;
@override final  AuctionStatus status;
@override@JsonKey() final  int totalBids;
@override final  String? topBidderId;
@override final  String? topBidderName;
@override@JsonKey() final  bool autoBidEnabled;
 final  List<String> _watchers;
@override@JsonKey() List<String> get watchers {
  if (_watchers is EqualUnmodifiableListView) return _watchers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_watchers);
}

@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  CarModel? car;
// ===== EXTENDED: Listing Fee =====
/// Listing fee charged to seller when creating this auction (PHP 300-500)
/// This is a fixed upfront fee covering operational costs:
/// - Platform hosting and bandwidth
/// - Image storage and processing
/// - Auction management overhead
///
/// Industry reference: Similar to Copart ($59-$189), Manheim ($75-$300)
/// Default value of 400 PHP aligns with mid-tier industry standards
@override@JsonKey() final  double listingFee;
/// Whether the listing fee has been paid by the seller
/// In production, this would be tracked through payment gateway
@override@JsonKey() final  bool listingFeePaid;
/// When the listing fee was paid (if applicable)
@override final  DateTime? listingFeePaidAt;

/// Create a copy of Auction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuctionCopyWith<_Auction> get copyWith => __$AuctionCopyWithImpl<_Auction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuctionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Auction&&(identical(other.id, id) || other.id == id)&&(identical(other.carId, carId) || other.carId == carId)&&(identical(other.sellerId, sellerId) || other.sellerId == sellerId)&&(identical(other.startingPrice, startingPrice) || other.startingPrice == startingPrice)&&(identical(other.currentBid, currentBid) || other.currentBid == currentBid)&&(identical(other.reservePrice, reservePrice) || other.reservePrice == reservePrice)&&(identical(other.buyNowPrice, buyNowPrice) || other.buyNowPrice == buyNowPrice)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.status, status) || other.status == status)&&(identical(other.totalBids, totalBids) || other.totalBids == totalBids)&&(identical(other.topBidderId, topBidderId) || other.topBidderId == topBidderId)&&(identical(other.topBidderName, topBidderName) || other.topBidderName == topBidderName)&&(identical(other.autoBidEnabled, autoBidEnabled) || other.autoBidEnabled == autoBidEnabled)&&const DeepCollectionEquality().equals(other._watchers, _watchers)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.car, car) || other.car == car)&&(identical(other.listingFee, listingFee) || other.listingFee == listingFee)&&(identical(other.listingFeePaid, listingFeePaid) || other.listingFeePaid == listingFeePaid)&&(identical(other.listingFeePaidAt, listingFeePaidAt) || other.listingFeePaidAt == listingFeePaidAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,carId,sellerId,startingPrice,currentBid,reservePrice,buyNowPrice,startTime,endTime,status,totalBids,topBidderId,topBidderName,autoBidEnabled,const DeepCollectionEquality().hash(_watchers),createdAt,updatedAt,car,listingFee,listingFeePaid,listingFeePaidAt]);

@override
String toString() {
  return 'Auction(id: $id, carId: $carId, sellerId: $sellerId, startingPrice: $startingPrice, currentBid: $currentBid, reservePrice: $reservePrice, buyNowPrice: $buyNowPrice, startTime: $startTime, endTime: $endTime, status: $status, totalBids: $totalBids, topBidderId: $topBidderId, topBidderName: $topBidderName, autoBidEnabled: $autoBidEnabled, watchers: $watchers, createdAt: $createdAt, updatedAt: $updatedAt, car: $car, listingFee: $listingFee, listingFeePaid: $listingFeePaid, listingFeePaidAt: $listingFeePaidAt)';
}


}

/// @nodoc
abstract mixin class _$AuctionCopyWith<$Res> implements $AuctionCopyWith<$Res> {
  factory _$AuctionCopyWith(_Auction value, $Res Function(_Auction) _then) = __$AuctionCopyWithImpl;
@override @useResult
$Res call({
 String id, String carId, String sellerId, double startingPrice, double currentBid, double reservePrice, double? buyNowPrice, DateTime startTime, DateTime endTime, AuctionStatus status, int totalBids, String? topBidderId, String? topBidderName, bool autoBidEnabled, List<String> watchers, DateTime createdAt, DateTime updatedAt, CarModel? car, double listingFee, bool listingFeePaid, DateTime? listingFeePaidAt
});


@override $CarModelCopyWith<$Res>? get car;

}
/// @nodoc
class __$AuctionCopyWithImpl<$Res>
    implements _$AuctionCopyWith<$Res> {
  __$AuctionCopyWithImpl(this._self, this._then);

  final _Auction _self;
  final $Res Function(_Auction) _then;

/// Create a copy of Auction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? carId = null,Object? sellerId = null,Object? startingPrice = null,Object? currentBid = null,Object? reservePrice = null,Object? buyNowPrice = freezed,Object? startTime = null,Object? endTime = null,Object? status = null,Object? totalBids = null,Object? topBidderId = freezed,Object? topBidderName = freezed,Object? autoBidEnabled = null,Object? watchers = null,Object? createdAt = null,Object? updatedAt = null,Object? car = freezed,Object? listingFee = null,Object? listingFeePaid = null,Object? listingFeePaidAt = freezed,}) {
  return _then(_Auction(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,carId: null == carId ? _self.carId : carId // ignore: cast_nullable_to_non_nullable
as String,sellerId: null == sellerId ? _self.sellerId : sellerId // ignore: cast_nullable_to_non_nullable
as String,startingPrice: null == startingPrice ? _self.startingPrice : startingPrice // ignore: cast_nullable_to_non_nullable
as double,currentBid: null == currentBid ? _self.currentBid : currentBid // ignore: cast_nullable_to_non_nullable
as double,reservePrice: null == reservePrice ? _self.reservePrice : reservePrice // ignore: cast_nullable_to_non_nullable
as double,buyNowPrice: freezed == buyNowPrice ? _self.buyNowPrice : buyNowPrice // ignore: cast_nullable_to_non_nullable
as double?,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AuctionStatus,totalBids: null == totalBids ? _self.totalBids : totalBids // ignore: cast_nullable_to_non_nullable
as int,topBidderId: freezed == topBidderId ? _self.topBidderId : topBidderId // ignore: cast_nullable_to_non_nullable
as String?,topBidderName: freezed == topBidderName ? _self.topBidderName : topBidderName // ignore: cast_nullable_to_non_nullable
as String?,autoBidEnabled: null == autoBidEnabled ? _self.autoBidEnabled : autoBidEnabled // ignore: cast_nullable_to_non_nullable
as bool,watchers: null == watchers ? _self._watchers : watchers // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,car: freezed == car ? _self.car : car // ignore: cast_nullable_to_non_nullable
as CarModel?,listingFee: null == listingFee ? _self.listingFee : listingFee // ignore: cast_nullable_to_non_nullable
as double,listingFeePaid: null == listingFeePaid ? _self.listingFeePaid : listingFeePaid // ignore: cast_nullable_to_non_nullable
as bool,listingFeePaidAt: freezed == listingFeePaidAt ? _self.listingFeePaidAt : listingFeePaidAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of Auction
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CarModelCopyWith<$Res>? get car {
    if (_self.car == null) {
    return null;
  }

  return $CarModelCopyWith<$Res>(_self.car!, (value) {
    return _then(_self.copyWith(car: value));
  });
}
}

// dart format on
