// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_confirmation_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PaymentConfirmation {

 String get id; String get preTransactionId;// ===== BUYER PAYMENT INITIATION =====
/// Whether buyer has initiated payment
 bool get buyerInitiated;/// Timestamp when buyer initiated payment
 DateTime? get buyerInitiatedAt;/// URLs to proof of payment (bank receipts, screenshots, etc.)
 List<String> get proofOfPaymentUrls;/// Payment method used
 PaymentMethod? get paymentMethod;/// Payment reference number (e.g., bank transaction ID)
 String? get paymentReferenceNumber;/// Optional notes from buyer about payment
 String? get buyerNotes;// ===== SELLER CONFIRMATION =====
/// Whether seller has confirmed payment receipt
 bool get sellerConfirmed;/// Timestamp when seller confirmed payment
 DateTime? get sellerConfirmedAt;/// Optional notes from seller about payment confirmation
 String? get sellerNotes;// ===== RA 8792 ACKNOWLEDGMENT =====
/// Legal acknowledgment text
/// "This payment confirmation is an electronic acknowledgment under the
/// Electronic Commerce Act of 2000 (RA 8792), Section 11. This electronic
/// record has the same legal validity as a written receipt."
 String get ra8792Acknowledgment;// ===== METADATA =====
/// Current status of payment confirmation
 PaymentConfirmationStatus get status;/// Amount paid (should match agreement total)
 double get amountPaid;/// Timestamp when payment confirmation was created
 DateTime get createdAt;
/// Create a copy of PaymentConfirmation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentConfirmationCopyWith<PaymentConfirmation> get copyWith => _$PaymentConfirmationCopyWithImpl<PaymentConfirmation>(this as PaymentConfirmation, _$identity);

  /// Serializes this PaymentConfirmation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentConfirmation&&(identical(other.id, id) || other.id == id)&&(identical(other.preTransactionId, preTransactionId) || other.preTransactionId == preTransactionId)&&(identical(other.buyerInitiated, buyerInitiated) || other.buyerInitiated == buyerInitiated)&&(identical(other.buyerInitiatedAt, buyerInitiatedAt) || other.buyerInitiatedAt == buyerInitiatedAt)&&const DeepCollectionEquality().equals(other.proofOfPaymentUrls, proofOfPaymentUrls)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.paymentReferenceNumber, paymentReferenceNumber) || other.paymentReferenceNumber == paymentReferenceNumber)&&(identical(other.buyerNotes, buyerNotes) || other.buyerNotes == buyerNotes)&&(identical(other.sellerConfirmed, sellerConfirmed) || other.sellerConfirmed == sellerConfirmed)&&(identical(other.sellerConfirmedAt, sellerConfirmedAt) || other.sellerConfirmedAt == sellerConfirmedAt)&&(identical(other.sellerNotes, sellerNotes) || other.sellerNotes == sellerNotes)&&(identical(other.ra8792Acknowledgment, ra8792Acknowledgment) || other.ra8792Acknowledgment == ra8792Acknowledgment)&&(identical(other.status, status) || other.status == status)&&(identical(other.amountPaid, amountPaid) || other.amountPaid == amountPaid)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,preTransactionId,buyerInitiated,buyerInitiatedAt,const DeepCollectionEquality().hash(proofOfPaymentUrls),paymentMethod,paymentReferenceNumber,buyerNotes,sellerConfirmed,sellerConfirmedAt,sellerNotes,ra8792Acknowledgment,status,amountPaid,createdAt);

@override
String toString() {
  return 'PaymentConfirmation(id: $id, preTransactionId: $preTransactionId, buyerInitiated: $buyerInitiated, buyerInitiatedAt: $buyerInitiatedAt, proofOfPaymentUrls: $proofOfPaymentUrls, paymentMethod: $paymentMethod, paymentReferenceNumber: $paymentReferenceNumber, buyerNotes: $buyerNotes, sellerConfirmed: $sellerConfirmed, sellerConfirmedAt: $sellerConfirmedAt, sellerNotes: $sellerNotes, ra8792Acknowledgment: $ra8792Acknowledgment, status: $status, amountPaid: $amountPaid, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $PaymentConfirmationCopyWith<$Res>  {
  factory $PaymentConfirmationCopyWith(PaymentConfirmation value, $Res Function(PaymentConfirmation) _then) = _$PaymentConfirmationCopyWithImpl;
@useResult
$Res call({
 String id, String preTransactionId, bool buyerInitiated, DateTime? buyerInitiatedAt, List<String> proofOfPaymentUrls, PaymentMethod? paymentMethod, String? paymentReferenceNumber, String? buyerNotes, bool sellerConfirmed, DateTime? sellerConfirmedAt, String? sellerNotes, String ra8792Acknowledgment, PaymentConfirmationStatus status, double amountPaid, DateTime createdAt
});




}
/// @nodoc
class _$PaymentConfirmationCopyWithImpl<$Res>
    implements $PaymentConfirmationCopyWith<$Res> {
  _$PaymentConfirmationCopyWithImpl(this._self, this._then);

  final PaymentConfirmation _self;
  final $Res Function(PaymentConfirmation) _then;

/// Create a copy of PaymentConfirmation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? preTransactionId = null,Object? buyerInitiated = null,Object? buyerInitiatedAt = freezed,Object? proofOfPaymentUrls = null,Object? paymentMethod = freezed,Object? paymentReferenceNumber = freezed,Object? buyerNotes = freezed,Object? sellerConfirmed = null,Object? sellerConfirmedAt = freezed,Object? sellerNotes = freezed,Object? ra8792Acknowledgment = null,Object? status = null,Object? amountPaid = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,preTransactionId: null == preTransactionId ? _self.preTransactionId : preTransactionId // ignore: cast_nullable_to_non_nullable
as String,buyerInitiated: null == buyerInitiated ? _self.buyerInitiated : buyerInitiated // ignore: cast_nullable_to_non_nullable
as bool,buyerInitiatedAt: freezed == buyerInitiatedAt ? _self.buyerInitiatedAt : buyerInitiatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,proofOfPaymentUrls: null == proofOfPaymentUrls ? _self.proofOfPaymentUrls : proofOfPaymentUrls // ignore: cast_nullable_to_non_nullable
as List<String>,paymentMethod: freezed == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethod?,paymentReferenceNumber: freezed == paymentReferenceNumber ? _self.paymentReferenceNumber : paymentReferenceNumber // ignore: cast_nullable_to_non_nullable
as String?,buyerNotes: freezed == buyerNotes ? _self.buyerNotes : buyerNotes // ignore: cast_nullable_to_non_nullable
as String?,sellerConfirmed: null == sellerConfirmed ? _self.sellerConfirmed : sellerConfirmed // ignore: cast_nullable_to_non_nullable
as bool,sellerConfirmedAt: freezed == sellerConfirmedAt ? _self.sellerConfirmedAt : sellerConfirmedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,sellerNotes: freezed == sellerNotes ? _self.sellerNotes : sellerNotes // ignore: cast_nullable_to_non_nullable
as String?,ra8792Acknowledgment: null == ra8792Acknowledgment ? _self.ra8792Acknowledgment : ra8792Acknowledgment // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PaymentConfirmationStatus,amountPaid: null == amountPaid ? _self.amountPaid : amountPaid // ignore: cast_nullable_to_non_nullable
as double,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [PaymentConfirmation].
extension PaymentConfirmationPatterns on PaymentConfirmation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentConfirmation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentConfirmation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentConfirmation value)  $default,){
final _that = this;
switch (_that) {
case _PaymentConfirmation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentConfirmation value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentConfirmation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String preTransactionId,  bool buyerInitiated,  DateTime? buyerInitiatedAt,  List<String> proofOfPaymentUrls,  PaymentMethod? paymentMethod,  String? paymentReferenceNumber,  String? buyerNotes,  bool sellerConfirmed,  DateTime? sellerConfirmedAt,  String? sellerNotes,  String ra8792Acknowledgment,  PaymentConfirmationStatus status,  double amountPaid,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentConfirmation() when $default != null:
return $default(_that.id,_that.preTransactionId,_that.buyerInitiated,_that.buyerInitiatedAt,_that.proofOfPaymentUrls,_that.paymentMethod,_that.paymentReferenceNumber,_that.buyerNotes,_that.sellerConfirmed,_that.sellerConfirmedAt,_that.sellerNotes,_that.ra8792Acknowledgment,_that.status,_that.amountPaid,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String preTransactionId,  bool buyerInitiated,  DateTime? buyerInitiatedAt,  List<String> proofOfPaymentUrls,  PaymentMethod? paymentMethod,  String? paymentReferenceNumber,  String? buyerNotes,  bool sellerConfirmed,  DateTime? sellerConfirmedAt,  String? sellerNotes,  String ra8792Acknowledgment,  PaymentConfirmationStatus status,  double amountPaid,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _PaymentConfirmation():
return $default(_that.id,_that.preTransactionId,_that.buyerInitiated,_that.buyerInitiatedAt,_that.proofOfPaymentUrls,_that.paymentMethod,_that.paymentReferenceNumber,_that.buyerNotes,_that.sellerConfirmed,_that.sellerConfirmedAt,_that.sellerNotes,_that.ra8792Acknowledgment,_that.status,_that.amountPaid,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String preTransactionId,  bool buyerInitiated,  DateTime? buyerInitiatedAt,  List<String> proofOfPaymentUrls,  PaymentMethod? paymentMethod,  String? paymentReferenceNumber,  String? buyerNotes,  bool sellerConfirmed,  DateTime? sellerConfirmedAt,  String? sellerNotes,  String ra8792Acknowledgment,  PaymentConfirmationStatus status,  double amountPaid,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _PaymentConfirmation() when $default != null:
return $default(_that.id,_that.preTransactionId,_that.buyerInitiated,_that.buyerInitiatedAt,_that.proofOfPaymentUrls,_that.paymentMethod,_that.paymentReferenceNumber,_that.buyerNotes,_that.sellerConfirmed,_that.sellerConfirmedAt,_that.sellerNotes,_that.ra8792Acknowledgment,_that.status,_that.amountPaid,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaymentConfirmation implements PaymentConfirmation {
  const _PaymentConfirmation({required this.id, required this.preTransactionId, this.buyerInitiated = false, this.buyerInitiatedAt, final  List<String> proofOfPaymentUrls = const [], this.paymentMethod, this.paymentReferenceNumber, this.buyerNotes, this.sellerConfirmed = false, this.sellerConfirmedAt, this.sellerNotes, required this.ra8792Acknowledgment, this.status = PaymentConfirmationStatus.pending, required this.amountPaid, required this.createdAt}): _proofOfPaymentUrls = proofOfPaymentUrls;
  factory _PaymentConfirmation.fromJson(Map<String, dynamic> json) => _$PaymentConfirmationFromJson(json);

@override final  String id;
@override final  String preTransactionId;
// ===== BUYER PAYMENT INITIATION =====
/// Whether buyer has initiated payment
@override@JsonKey() final  bool buyerInitiated;
/// Timestamp when buyer initiated payment
@override final  DateTime? buyerInitiatedAt;
/// URLs to proof of payment (bank receipts, screenshots, etc.)
 final  List<String> _proofOfPaymentUrls;
/// URLs to proof of payment (bank receipts, screenshots, etc.)
@override@JsonKey() List<String> get proofOfPaymentUrls {
  if (_proofOfPaymentUrls is EqualUnmodifiableListView) return _proofOfPaymentUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_proofOfPaymentUrls);
}

/// Payment method used
@override final  PaymentMethod? paymentMethod;
/// Payment reference number (e.g., bank transaction ID)
@override final  String? paymentReferenceNumber;
/// Optional notes from buyer about payment
@override final  String? buyerNotes;
// ===== SELLER CONFIRMATION =====
/// Whether seller has confirmed payment receipt
@override@JsonKey() final  bool sellerConfirmed;
/// Timestamp when seller confirmed payment
@override final  DateTime? sellerConfirmedAt;
/// Optional notes from seller about payment confirmation
@override final  String? sellerNotes;
// ===== RA 8792 ACKNOWLEDGMENT =====
/// Legal acknowledgment text
/// "This payment confirmation is an electronic acknowledgment under the
/// Electronic Commerce Act of 2000 (RA 8792), Section 11. This electronic
/// record has the same legal validity as a written receipt."
@override final  String ra8792Acknowledgment;
// ===== METADATA =====
/// Current status of payment confirmation
@override@JsonKey() final  PaymentConfirmationStatus status;
/// Amount paid (should match agreement total)
@override final  double amountPaid;
/// Timestamp when payment confirmation was created
@override final  DateTime createdAt;

/// Create a copy of PaymentConfirmation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentConfirmationCopyWith<_PaymentConfirmation> get copyWith => __$PaymentConfirmationCopyWithImpl<_PaymentConfirmation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentConfirmationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentConfirmation&&(identical(other.id, id) || other.id == id)&&(identical(other.preTransactionId, preTransactionId) || other.preTransactionId == preTransactionId)&&(identical(other.buyerInitiated, buyerInitiated) || other.buyerInitiated == buyerInitiated)&&(identical(other.buyerInitiatedAt, buyerInitiatedAt) || other.buyerInitiatedAt == buyerInitiatedAt)&&const DeepCollectionEquality().equals(other._proofOfPaymentUrls, _proofOfPaymentUrls)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.paymentReferenceNumber, paymentReferenceNumber) || other.paymentReferenceNumber == paymentReferenceNumber)&&(identical(other.buyerNotes, buyerNotes) || other.buyerNotes == buyerNotes)&&(identical(other.sellerConfirmed, sellerConfirmed) || other.sellerConfirmed == sellerConfirmed)&&(identical(other.sellerConfirmedAt, sellerConfirmedAt) || other.sellerConfirmedAt == sellerConfirmedAt)&&(identical(other.sellerNotes, sellerNotes) || other.sellerNotes == sellerNotes)&&(identical(other.ra8792Acknowledgment, ra8792Acknowledgment) || other.ra8792Acknowledgment == ra8792Acknowledgment)&&(identical(other.status, status) || other.status == status)&&(identical(other.amountPaid, amountPaid) || other.amountPaid == amountPaid)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,preTransactionId,buyerInitiated,buyerInitiatedAt,const DeepCollectionEquality().hash(_proofOfPaymentUrls),paymentMethod,paymentReferenceNumber,buyerNotes,sellerConfirmed,sellerConfirmedAt,sellerNotes,ra8792Acknowledgment,status,amountPaid,createdAt);

@override
String toString() {
  return 'PaymentConfirmation(id: $id, preTransactionId: $preTransactionId, buyerInitiated: $buyerInitiated, buyerInitiatedAt: $buyerInitiatedAt, proofOfPaymentUrls: $proofOfPaymentUrls, paymentMethod: $paymentMethod, paymentReferenceNumber: $paymentReferenceNumber, buyerNotes: $buyerNotes, sellerConfirmed: $sellerConfirmed, sellerConfirmedAt: $sellerConfirmedAt, sellerNotes: $sellerNotes, ra8792Acknowledgment: $ra8792Acknowledgment, status: $status, amountPaid: $amountPaid, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$PaymentConfirmationCopyWith<$Res> implements $PaymentConfirmationCopyWith<$Res> {
  factory _$PaymentConfirmationCopyWith(_PaymentConfirmation value, $Res Function(_PaymentConfirmation) _then) = __$PaymentConfirmationCopyWithImpl;
@override @useResult
$Res call({
 String id, String preTransactionId, bool buyerInitiated, DateTime? buyerInitiatedAt, List<String> proofOfPaymentUrls, PaymentMethod? paymentMethod, String? paymentReferenceNumber, String? buyerNotes, bool sellerConfirmed, DateTime? sellerConfirmedAt, String? sellerNotes, String ra8792Acknowledgment, PaymentConfirmationStatus status, double amountPaid, DateTime createdAt
});




}
/// @nodoc
class __$PaymentConfirmationCopyWithImpl<$Res>
    implements _$PaymentConfirmationCopyWith<$Res> {
  __$PaymentConfirmationCopyWithImpl(this._self, this._then);

  final _PaymentConfirmation _self;
  final $Res Function(_PaymentConfirmation) _then;

/// Create a copy of PaymentConfirmation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? preTransactionId = null,Object? buyerInitiated = null,Object? buyerInitiatedAt = freezed,Object? proofOfPaymentUrls = null,Object? paymentMethod = freezed,Object? paymentReferenceNumber = freezed,Object? buyerNotes = freezed,Object? sellerConfirmed = null,Object? sellerConfirmedAt = freezed,Object? sellerNotes = freezed,Object? ra8792Acknowledgment = null,Object? status = null,Object? amountPaid = null,Object? createdAt = null,}) {
  return _then(_PaymentConfirmation(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,preTransactionId: null == preTransactionId ? _self.preTransactionId : preTransactionId // ignore: cast_nullable_to_non_nullable
as String,buyerInitiated: null == buyerInitiated ? _self.buyerInitiated : buyerInitiated // ignore: cast_nullable_to_non_nullable
as bool,buyerInitiatedAt: freezed == buyerInitiatedAt ? _self.buyerInitiatedAt : buyerInitiatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,proofOfPaymentUrls: null == proofOfPaymentUrls ? _self._proofOfPaymentUrls : proofOfPaymentUrls // ignore: cast_nullable_to_non_nullable
as List<String>,paymentMethod: freezed == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethod?,paymentReferenceNumber: freezed == paymentReferenceNumber ? _self.paymentReferenceNumber : paymentReferenceNumber // ignore: cast_nullable_to_non_nullable
as String?,buyerNotes: freezed == buyerNotes ? _self.buyerNotes : buyerNotes // ignore: cast_nullable_to_non_nullable
as String?,sellerConfirmed: null == sellerConfirmed ? _self.sellerConfirmed : sellerConfirmed // ignore: cast_nullable_to_non_nullable
as bool,sellerConfirmedAt: freezed == sellerConfirmedAt ? _self.sellerConfirmedAt : sellerConfirmedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,sellerNotes: freezed == sellerNotes ? _self.sellerNotes : sellerNotes // ignore: cast_nullable_to_non_nullable
as String?,ra8792Acknowledgment: null == ra8792Acknowledgment ? _self.ra8792Acknowledgment : ra8792Acknowledgment // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PaymentConfirmationStatus,amountPaid: null == amountPaid ? _self.amountPaid : amountPaid // ignore: cast_nullable_to_non_nullable
as double,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
