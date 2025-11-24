// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'handover_confirmation_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HandoverConfirmation {

 String get id; String get preTransactionId;// ===== SELLER VEHICLE RELEASE =====
/// Whether seller has released the vehicle
 bool get sellerReleased;/// Timestamp when seller released vehicle
 DateTime? get sellerReleasedAt;/// URLs to photos taken by seller at release (vehicle condition, etc.)
 List<String> get sellerPhotoUrls;/// Location where vehicle was released (e.g., "Quezon City, Metro Manila")
 String? get releaseLocation;/// Optional notes from seller about release
 String? get sellerNotes;// ===== BUYER VEHICLE RECEIPT =====
/// Whether buyer has received the vehicle
 bool get buyerReceived;/// Timestamp when buyer received vehicle
 DateTime? get buyerReceivedAt;/// Whether buyer accepted the vehicle condition
 bool get buyerConditionAccepted;/// URLs to photos taken by buyer at receipt
 List<String> get buyerPhotoUrls;/// Optional notes from buyer about vehicle condition
 String? get buyerNotes;// ===== OWNERSHIP TRANSFER =====
/// Whether ownership documents were transferred
 bool get ownershipDocumentsTransferred;/// List of ownership documents transferred (e.g., "OR/CR", "Deed of Sale")
 List<String> get ownershipDocuments;// ===== METADATA =====
/// Current status of handover confirmation
 HandoverConfirmationStatus get status;/// Timestamp when handover confirmation was created
 DateTime get createdAt;
/// Create a copy of HandoverConfirmation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HandoverConfirmationCopyWith<HandoverConfirmation> get copyWith => _$HandoverConfirmationCopyWithImpl<HandoverConfirmation>(this as HandoverConfirmation, _$identity);

  /// Serializes this HandoverConfirmation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HandoverConfirmation&&(identical(other.id, id) || other.id == id)&&(identical(other.preTransactionId, preTransactionId) || other.preTransactionId == preTransactionId)&&(identical(other.sellerReleased, sellerReleased) || other.sellerReleased == sellerReleased)&&(identical(other.sellerReleasedAt, sellerReleasedAt) || other.sellerReleasedAt == sellerReleasedAt)&&const DeepCollectionEquality().equals(other.sellerPhotoUrls, sellerPhotoUrls)&&(identical(other.releaseLocation, releaseLocation) || other.releaseLocation == releaseLocation)&&(identical(other.sellerNotes, sellerNotes) || other.sellerNotes == sellerNotes)&&(identical(other.buyerReceived, buyerReceived) || other.buyerReceived == buyerReceived)&&(identical(other.buyerReceivedAt, buyerReceivedAt) || other.buyerReceivedAt == buyerReceivedAt)&&(identical(other.buyerConditionAccepted, buyerConditionAccepted) || other.buyerConditionAccepted == buyerConditionAccepted)&&const DeepCollectionEquality().equals(other.buyerPhotoUrls, buyerPhotoUrls)&&(identical(other.buyerNotes, buyerNotes) || other.buyerNotes == buyerNotes)&&(identical(other.ownershipDocumentsTransferred, ownershipDocumentsTransferred) || other.ownershipDocumentsTransferred == ownershipDocumentsTransferred)&&const DeepCollectionEquality().equals(other.ownershipDocuments, ownershipDocuments)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,preTransactionId,sellerReleased,sellerReleasedAt,const DeepCollectionEquality().hash(sellerPhotoUrls),releaseLocation,sellerNotes,buyerReceived,buyerReceivedAt,buyerConditionAccepted,const DeepCollectionEquality().hash(buyerPhotoUrls),buyerNotes,ownershipDocumentsTransferred,const DeepCollectionEquality().hash(ownershipDocuments),status,createdAt);

@override
String toString() {
  return 'HandoverConfirmation(id: $id, preTransactionId: $preTransactionId, sellerReleased: $sellerReleased, sellerReleasedAt: $sellerReleasedAt, sellerPhotoUrls: $sellerPhotoUrls, releaseLocation: $releaseLocation, sellerNotes: $sellerNotes, buyerReceived: $buyerReceived, buyerReceivedAt: $buyerReceivedAt, buyerConditionAccepted: $buyerConditionAccepted, buyerPhotoUrls: $buyerPhotoUrls, buyerNotes: $buyerNotes, ownershipDocumentsTransferred: $ownershipDocumentsTransferred, ownershipDocuments: $ownershipDocuments, status: $status, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $HandoverConfirmationCopyWith<$Res>  {
  factory $HandoverConfirmationCopyWith(HandoverConfirmation value, $Res Function(HandoverConfirmation) _then) = _$HandoverConfirmationCopyWithImpl;
@useResult
$Res call({
 String id, String preTransactionId, bool sellerReleased, DateTime? sellerReleasedAt, List<String> sellerPhotoUrls, String? releaseLocation, String? sellerNotes, bool buyerReceived, DateTime? buyerReceivedAt, bool buyerConditionAccepted, List<String> buyerPhotoUrls, String? buyerNotes, bool ownershipDocumentsTransferred, List<String> ownershipDocuments, HandoverConfirmationStatus status, DateTime createdAt
});




}
/// @nodoc
class _$HandoverConfirmationCopyWithImpl<$Res>
    implements $HandoverConfirmationCopyWith<$Res> {
  _$HandoverConfirmationCopyWithImpl(this._self, this._then);

  final HandoverConfirmation _self;
  final $Res Function(HandoverConfirmation) _then;

/// Create a copy of HandoverConfirmation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? preTransactionId = null,Object? sellerReleased = null,Object? sellerReleasedAt = freezed,Object? sellerPhotoUrls = null,Object? releaseLocation = freezed,Object? sellerNotes = freezed,Object? buyerReceived = null,Object? buyerReceivedAt = freezed,Object? buyerConditionAccepted = null,Object? buyerPhotoUrls = null,Object? buyerNotes = freezed,Object? ownershipDocumentsTransferred = null,Object? ownershipDocuments = null,Object? status = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,preTransactionId: null == preTransactionId ? _self.preTransactionId : preTransactionId // ignore: cast_nullable_to_non_nullable
as String,sellerReleased: null == sellerReleased ? _self.sellerReleased : sellerReleased // ignore: cast_nullable_to_non_nullable
as bool,sellerReleasedAt: freezed == sellerReleasedAt ? _self.sellerReleasedAt : sellerReleasedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,sellerPhotoUrls: null == sellerPhotoUrls ? _self.sellerPhotoUrls : sellerPhotoUrls // ignore: cast_nullable_to_non_nullable
as List<String>,releaseLocation: freezed == releaseLocation ? _self.releaseLocation : releaseLocation // ignore: cast_nullable_to_non_nullable
as String?,sellerNotes: freezed == sellerNotes ? _self.sellerNotes : sellerNotes // ignore: cast_nullable_to_non_nullable
as String?,buyerReceived: null == buyerReceived ? _self.buyerReceived : buyerReceived // ignore: cast_nullable_to_non_nullable
as bool,buyerReceivedAt: freezed == buyerReceivedAt ? _self.buyerReceivedAt : buyerReceivedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,buyerConditionAccepted: null == buyerConditionAccepted ? _self.buyerConditionAccepted : buyerConditionAccepted // ignore: cast_nullable_to_non_nullable
as bool,buyerPhotoUrls: null == buyerPhotoUrls ? _self.buyerPhotoUrls : buyerPhotoUrls // ignore: cast_nullable_to_non_nullable
as List<String>,buyerNotes: freezed == buyerNotes ? _self.buyerNotes : buyerNotes // ignore: cast_nullable_to_non_nullable
as String?,ownershipDocumentsTransferred: null == ownershipDocumentsTransferred ? _self.ownershipDocumentsTransferred : ownershipDocumentsTransferred // ignore: cast_nullable_to_non_nullable
as bool,ownershipDocuments: null == ownershipDocuments ? _self.ownershipDocuments : ownershipDocuments // ignore: cast_nullable_to_non_nullable
as List<String>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as HandoverConfirmationStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [HandoverConfirmation].
extension HandoverConfirmationPatterns on HandoverConfirmation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HandoverConfirmation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HandoverConfirmation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HandoverConfirmation value)  $default,){
final _that = this;
switch (_that) {
case _HandoverConfirmation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HandoverConfirmation value)?  $default,){
final _that = this;
switch (_that) {
case _HandoverConfirmation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String preTransactionId,  bool sellerReleased,  DateTime? sellerReleasedAt,  List<String> sellerPhotoUrls,  String? releaseLocation,  String? sellerNotes,  bool buyerReceived,  DateTime? buyerReceivedAt,  bool buyerConditionAccepted,  List<String> buyerPhotoUrls,  String? buyerNotes,  bool ownershipDocumentsTransferred,  List<String> ownershipDocuments,  HandoverConfirmationStatus status,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HandoverConfirmation() when $default != null:
return $default(_that.id,_that.preTransactionId,_that.sellerReleased,_that.sellerReleasedAt,_that.sellerPhotoUrls,_that.releaseLocation,_that.sellerNotes,_that.buyerReceived,_that.buyerReceivedAt,_that.buyerConditionAccepted,_that.buyerPhotoUrls,_that.buyerNotes,_that.ownershipDocumentsTransferred,_that.ownershipDocuments,_that.status,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String preTransactionId,  bool sellerReleased,  DateTime? sellerReleasedAt,  List<String> sellerPhotoUrls,  String? releaseLocation,  String? sellerNotes,  bool buyerReceived,  DateTime? buyerReceivedAt,  bool buyerConditionAccepted,  List<String> buyerPhotoUrls,  String? buyerNotes,  bool ownershipDocumentsTransferred,  List<String> ownershipDocuments,  HandoverConfirmationStatus status,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _HandoverConfirmation():
return $default(_that.id,_that.preTransactionId,_that.sellerReleased,_that.sellerReleasedAt,_that.sellerPhotoUrls,_that.releaseLocation,_that.sellerNotes,_that.buyerReceived,_that.buyerReceivedAt,_that.buyerConditionAccepted,_that.buyerPhotoUrls,_that.buyerNotes,_that.ownershipDocumentsTransferred,_that.ownershipDocuments,_that.status,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String preTransactionId,  bool sellerReleased,  DateTime? sellerReleasedAt,  List<String> sellerPhotoUrls,  String? releaseLocation,  String? sellerNotes,  bool buyerReceived,  DateTime? buyerReceivedAt,  bool buyerConditionAccepted,  List<String> buyerPhotoUrls,  String? buyerNotes,  bool ownershipDocumentsTransferred,  List<String> ownershipDocuments,  HandoverConfirmationStatus status,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _HandoverConfirmation() when $default != null:
return $default(_that.id,_that.preTransactionId,_that.sellerReleased,_that.sellerReleasedAt,_that.sellerPhotoUrls,_that.releaseLocation,_that.sellerNotes,_that.buyerReceived,_that.buyerReceivedAt,_that.buyerConditionAccepted,_that.buyerPhotoUrls,_that.buyerNotes,_that.ownershipDocumentsTransferred,_that.ownershipDocuments,_that.status,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HandoverConfirmation implements HandoverConfirmation {
  const _HandoverConfirmation({required this.id, required this.preTransactionId, this.sellerReleased = false, this.sellerReleasedAt, final  List<String> sellerPhotoUrls = const [], this.releaseLocation, this.sellerNotes, this.buyerReceived = false, this.buyerReceivedAt, this.buyerConditionAccepted = false, final  List<String> buyerPhotoUrls = const [], this.buyerNotes, this.ownershipDocumentsTransferred = false, final  List<String> ownershipDocuments = const [], this.status = HandoverConfirmationStatus.pending, required this.createdAt}): _sellerPhotoUrls = sellerPhotoUrls,_buyerPhotoUrls = buyerPhotoUrls,_ownershipDocuments = ownershipDocuments;
  factory _HandoverConfirmation.fromJson(Map<String, dynamic> json) => _$HandoverConfirmationFromJson(json);

@override final  String id;
@override final  String preTransactionId;
// ===== SELLER VEHICLE RELEASE =====
/// Whether seller has released the vehicle
@override@JsonKey() final  bool sellerReleased;
/// Timestamp when seller released vehicle
@override final  DateTime? sellerReleasedAt;
/// URLs to photos taken by seller at release (vehicle condition, etc.)
 final  List<String> _sellerPhotoUrls;
/// URLs to photos taken by seller at release (vehicle condition, etc.)
@override@JsonKey() List<String> get sellerPhotoUrls {
  if (_sellerPhotoUrls is EqualUnmodifiableListView) return _sellerPhotoUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sellerPhotoUrls);
}

/// Location where vehicle was released (e.g., "Quezon City, Metro Manila")
@override final  String? releaseLocation;
/// Optional notes from seller about release
@override final  String? sellerNotes;
// ===== BUYER VEHICLE RECEIPT =====
/// Whether buyer has received the vehicle
@override@JsonKey() final  bool buyerReceived;
/// Timestamp when buyer received vehicle
@override final  DateTime? buyerReceivedAt;
/// Whether buyer accepted the vehicle condition
@override@JsonKey() final  bool buyerConditionAccepted;
/// URLs to photos taken by buyer at receipt
 final  List<String> _buyerPhotoUrls;
/// URLs to photos taken by buyer at receipt
@override@JsonKey() List<String> get buyerPhotoUrls {
  if (_buyerPhotoUrls is EqualUnmodifiableListView) return _buyerPhotoUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_buyerPhotoUrls);
}

/// Optional notes from buyer about vehicle condition
@override final  String? buyerNotes;
// ===== OWNERSHIP TRANSFER =====
/// Whether ownership documents were transferred
@override@JsonKey() final  bool ownershipDocumentsTransferred;
/// List of ownership documents transferred (e.g., "OR/CR", "Deed of Sale")
 final  List<String> _ownershipDocuments;
/// List of ownership documents transferred (e.g., "OR/CR", "Deed of Sale")
@override@JsonKey() List<String> get ownershipDocuments {
  if (_ownershipDocuments is EqualUnmodifiableListView) return _ownershipDocuments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_ownershipDocuments);
}

// ===== METADATA =====
/// Current status of handover confirmation
@override@JsonKey() final  HandoverConfirmationStatus status;
/// Timestamp when handover confirmation was created
@override final  DateTime createdAt;

/// Create a copy of HandoverConfirmation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HandoverConfirmationCopyWith<_HandoverConfirmation> get copyWith => __$HandoverConfirmationCopyWithImpl<_HandoverConfirmation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HandoverConfirmationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HandoverConfirmation&&(identical(other.id, id) || other.id == id)&&(identical(other.preTransactionId, preTransactionId) || other.preTransactionId == preTransactionId)&&(identical(other.sellerReleased, sellerReleased) || other.sellerReleased == sellerReleased)&&(identical(other.sellerReleasedAt, sellerReleasedAt) || other.sellerReleasedAt == sellerReleasedAt)&&const DeepCollectionEquality().equals(other._sellerPhotoUrls, _sellerPhotoUrls)&&(identical(other.releaseLocation, releaseLocation) || other.releaseLocation == releaseLocation)&&(identical(other.sellerNotes, sellerNotes) || other.sellerNotes == sellerNotes)&&(identical(other.buyerReceived, buyerReceived) || other.buyerReceived == buyerReceived)&&(identical(other.buyerReceivedAt, buyerReceivedAt) || other.buyerReceivedAt == buyerReceivedAt)&&(identical(other.buyerConditionAccepted, buyerConditionAccepted) || other.buyerConditionAccepted == buyerConditionAccepted)&&const DeepCollectionEquality().equals(other._buyerPhotoUrls, _buyerPhotoUrls)&&(identical(other.buyerNotes, buyerNotes) || other.buyerNotes == buyerNotes)&&(identical(other.ownershipDocumentsTransferred, ownershipDocumentsTransferred) || other.ownershipDocumentsTransferred == ownershipDocumentsTransferred)&&const DeepCollectionEquality().equals(other._ownershipDocuments, _ownershipDocuments)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,preTransactionId,sellerReleased,sellerReleasedAt,const DeepCollectionEquality().hash(_sellerPhotoUrls),releaseLocation,sellerNotes,buyerReceived,buyerReceivedAt,buyerConditionAccepted,const DeepCollectionEquality().hash(_buyerPhotoUrls),buyerNotes,ownershipDocumentsTransferred,const DeepCollectionEquality().hash(_ownershipDocuments),status,createdAt);

@override
String toString() {
  return 'HandoverConfirmation(id: $id, preTransactionId: $preTransactionId, sellerReleased: $sellerReleased, sellerReleasedAt: $sellerReleasedAt, sellerPhotoUrls: $sellerPhotoUrls, releaseLocation: $releaseLocation, sellerNotes: $sellerNotes, buyerReceived: $buyerReceived, buyerReceivedAt: $buyerReceivedAt, buyerConditionAccepted: $buyerConditionAccepted, buyerPhotoUrls: $buyerPhotoUrls, buyerNotes: $buyerNotes, ownershipDocumentsTransferred: $ownershipDocumentsTransferred, ownershipDocuments: $ownershipDocuments, status: $status, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$HandoverConfirmationCopyWith<$Res> implements $HandoverConfirmationCopyWith<$Res> {
  factory _$HandoverConfirmationCopyWith(_HandoverConfirmation value, $Res Function(_HandoverConfirmation) _then) = __$HandoverConfirmationCopyWithImpl;
@override @useResult
$Res call({
 String id, String preTransactionId, bool sellerReleased, DateTime? sellerReleasedAt, List<String> sellerPhotoUrls, String? releaseLocation, String? sellerNotes, bool buyerReceived, DateTime? buyerReceivedAt, bool buyerConditionAccepted, List<String> buyerPhotoUrls, String? buyerNotes, bool ownershipDocumentsTransferred, List<String> ownershipDocuments, HandoverConfirmationStatus status, DateTime createdAt
});




}
/// @nodoc
class __$HandoverConfirmationCopyWithImpl<$Res>
    implements _$HandoverConfirmationCopyWith<$Res> {
  __$HandoverConfirmationCopyWithImpl(this._self, this._then);

  final _HandoverConfirmation _self;
  final $Res Function(_HandoverConfirmation) _then;

/// Create a copy of HandoverConfirmation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? preTransactionId = null,Object? sellerReleased = null,Object? sellerReleasedAt = freezed,Object? sellerPhotoUrls = null,Object? releaseLocation = freezed,Object? sellerNotes = freezed,Object? buyerReceived = null,Object? buyerReceivedAt = freezed,Object? buyerConditionAccepted = null,Object? buyerPhotoUrls = null,Object? buyerNotes = freezed,Object? ownershipDocumentsTransferred = null,Object? ownershipDocuments = null,Object? status = null,Object? createdAt = null,}) {
  return _then(_HandoverConfirmation(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,preTransactionId: null == preTransactionId ? _self.preTransactionId : preTransactionId // ignore: cast_nullable_to_non_nullable
as String,sellerReleased: null == sellerReleased ? _self.sellerReleased : sellerReleased // ignore: cast_nullable_to_non_nullable
as bool,sellerReleasedAt: freezed == sellerReleasedAt ? _self.sellerReleasedAt : sellerReleasedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,sellerPhotoUrls: null == sellerPhotoUrls ? _self._sellerPhotoUrls : sellerPhotoUrls // ignore: cast_nullable_to_non_nullable
as List<String>,releaseLocation: freezed == releaseLocation ? _self.releaseLocation : releaseLocation // ignore: cast_nullable_to_non_nullable
as String?,sellerNotes: freezed == sellerNotes ? _self.sellerNotes : sellerNotes // ignore: cast_nullable_to_non_nullable
as String?,buyerReceived: null == buyerReceived ? _self.buyerReceived : buyerReceived // ignore: cast_nullable_to_non_nullable
as bool,buyerReceivedAt: freezed == buyerReceivedAt ? _self.buyerReceivedAt : buyerReceivedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,buyerConditionAccepted: null == buyerConditionAccepted ? _self.buyerConditionAccepted : buyerConditionAccepted // ignore: cast_nullable_to_non_nullable
as bool,buyerPhotoUrls: null == buyerPhotoUrls ? _self._buyerPhotoUrls : buyerPhotoUrls // ignore: cast_nullable_to_non_nullable
as List<String>,buyerNotes: freezed == buyerNotes ? _self.buyerNotes : buyerNotes // ignore: cast_nullable_to_non_nullable
as String?,ownershipDocumentsTransferred: null == ownershipDocumentsTransferred ? _self.ownershipDocumentsTransferred : ownershipDocumentsTransferred // ignore: cast_nullable_to_non_nullable
as bool,ownershipDocuments: null == ownershipDocuments ? _self._ownershipDocuments : ownershipDocuments // ignore: cast_nullable_to_non_nullable
as List<String>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as HandoverConfirmationStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
