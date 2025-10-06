// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_filters.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SearchFilters {

 String? get keyword; List<String> get brands; int? get yearMin; int? get yearMax; double? get priceMin; double? get priceMax; int? get mileageMax; List<TransmissionType> get transmission; List<FuelType> get fuelType; List<BodyType> get bodyType; String? get city; String? get province; SortBy get sortBy; bool get auctionsOnly;
/// Create a copy of SearchFilters
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchFiltersCopyWith<SearchFilters> get copyWith => _$SearchFiltersCopyWithImpl<SearchFilters>(this as SearchFilters, _$identity);

  /// Serializes this SearchFilters to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchFilters&&(identical(other.keyword, keyword) || other.keyword == keyword)&&const DeepCollectionEquality().equals(other.brands, brands)&&(identical(other.yearMin, yearMin) || other.yearMin == yearMin)&&(identical(other.yearMax, yearMax) || other.yearMax == yearMax)&&(identical(other.priceMin, priceMin) || other.priceMin == priceMin)&&(identical(other.priceMax, priceMax) || other.priceMax == priceMax)&&(identical(other.mileageMax, mileageMax) || other.mileageMax == mileageMax)&&const DeepCollectionEquality().equals(other.transmission, transmission)&&const DeepCollectionEquality().equals(other.fuelType, fuelType)&&const DeepCollectionEquality().equals(other.bodyType, bodyType)&&(identical(other.city, city) || other.city == city)&&(identical(other.province, province) || other.province == province)&&(identical(other.sortBy, sortBy) || other.sortBy == sortBy)&&(identical(other.auctionsOnly, auctionsOnly) || other.auctionsOnly == auctionsOnly));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,keyword,const DeepCollectionEquality().hash(brands),yearMin,yearMax,priceMin,priceMax,mileageMax,const DeepCollectionEquality().hash(transmission),const DeepCollectionEquality().hash(fuelType),const DeepCollectionEquality().hash(bodyType),city,province,sortBy,auctionsOnly);

@override
String toString() {
  return 'SearchFilters(keyword: $keyword, brands: $brands, yearMin: $yearMin, yearMax: $yearMax, priceMin: $priceMin, priceMax: $priceMax, mileageMax: $mileageMax, transmission: $transmission, fuelType: $fuelType, bodyType: $bodyType, city: $city, province: $province, sortBy: $sortBy, auctionsOnly: $auctionsOnly)';
}


}

/// @nodoc
abstract mixin class $SearchFiltersCopyWith<$Res>  {
  factory $SearchFiltersCopyWith(SearchFilters value, $Res Function(SearchFilters) _then) = _$SearchFiltersCopyWithImpl;
@useResult
$Res call({
 String? keyword, List<String> brands, int? yearMin, int? yearMax, double? priceMin, double? priceMax, int? mileageMax, List<TransmissionType> transmission, List<FuelType> fuelType, List<BodyType> bodyType, String? city, String? province, SortBy sortBy, bool auctionsOnly
});




}
/// @nodoc
class _$SearchFiltersCopyWithImpl<$Res>
    implements $SearchFiltersCopyWith<$Res> {
  _$SearchFiltersCopyWithImpl(this._self, this._then);

  final SearchFilters _self;
  final $Res Function(SearchFilters) _then;

/// Create a copy of SearchFilters
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? keyword = freezed,Object? brands = null,Object? yearMin = freezed,Object? yearMax = freezed,Object? priceMin = freezed,Object? priceMax = freezed,Object? mileageMax = freezed,Object? transmission = null,Object? fuelType = null,Object? bodyType = null,Object? city = freezed,Object? province = freezed,Object? sortBy = null,Object? auctionsOnly = null,}) {
  return _then(_self.copyWith(
keyword: freezed == keyword ? _self.keyword : keyword // ignore: cast_nullable_to_non_nullable
as String?,brands: null == brands ? _self.brands : brands // ignore: cast_nullable_to_non_nullable
as List<String>,yearMin: freezed == yearMin ? _self.yearMin : yearMin // ignore: cast_nullable_to_non_nullable
as int?,yearMax: freezed == yearMax ? _self.yearMax : yearMax // ignore: cast_nullable_to_non_nullable
as int?,priceMin: freezed == priceMin ? _self.priceMin : priceMin // ignore: cast_nullable_to_non_nullable
as double?,priceMax: freezed == priceMax ? _self.priceMax : priceMax // ignore: cast_nullable_to_non_nullable
as double?,mileageMax: freezed == mileageMax ? _self.mileageMax : mileageMax // ignore: cast_nullable_to_non_nullable
as int?,transmission: null == transmission ? _self.transmission : transmission // ignore: cast_nullable_to_non_nullable
as List<TransmissionType>,fuelType: null == fuelType ? _self.fuelType : fuelType // ignore: cast_nullable_to_non_nullable
as List<FuelType>,bodyType: null == bodyType ? _self.bodyType : bodyType // ignore: cast_nullable_to_non_nullable
as List<BodyType>,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,province: freezed == province ? _self.province : province // ignore: cast_nullable_to_non_nullable
as String?,sortBy: null == sortBy ? _self.sortBy : sortBy // ignore: cast_nullable_to_non_nullable
as SortBy,auctionsOnly: null == auctionsOnly ? _self.auctionsOnly : auctionsOnly // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SearchFilters].
extension SearchFiltersPatterns on SearchFilters {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SearchFilters value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchFilters() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchFilters value)  $default,){
final _that = this;
switch (_that) {
case _SearchFilters():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchFilters value)?  $default,){
final _that = this;
switch (_that) {
case _SearchFilters() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? keyword,  List<String> brands,  int? yearMin,  int? yearMax,  double? priceMin,  double? priceMax,  int? mileageMax,  List<TransmissionType> transmission,  List<FuelType> fuelType,  List<BodyType> bodyType,  String? city,  String? province,  SortBy sortBy,  bool auctionsOnly)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchFilters() when $default != null:
return $default(_that.keyword,_that.brands,_that.yearMin,_that.yearMax,_that.priceMin,_that.priceMax,_that.mileageMax,_that.transmission,_that.fuelType,_that.bodyType,_that.city,_that.province,_that.sortBy,_that.auctionsOnly);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? keyword,  List<String> brands,  int? yearMin,  int? yearMax,  double? priceMin,  double? priceMax,  int? mileageMax,  List<TransmissionType> transmission,  List<FuelType> fuelType,  List<BodyType> bodyType,  String? city,  String? province,  SortBy sortBy,  bool auctionsOnly)  $default,) {final _that = this;
switch (_that) {
case _SearchFilters():
return $default(_that.keyword,_that.brands,_that.yearMin,_that.yearMax,_that.priceMin,_that.priceMax,_that.mileageMax,_that.transmission,_that.fuelType,_that.bodyType,_that.city,_that.province,_that.sortBy,_that.auctionsOnly);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? keyword,  List<String> brands,  int? yearMin,  int? yearMax,  double? priceMin,  double? priceMax,  int? mileageMax,  List<TransmissionType> transmission,  List<FuelType> fuelType,  List<BodyType> bodyType,  String? city,  String? province,  SortBy sortBy,  bool auctionsOnly)?  $default,) {final _that = this;
switch (_that) {
case _SearchFilters() when $default != null:
return $default(_that.keyword,_that.brands,_that.yearMin,_that.yearMax,_that.priceMin,_that.priceMax,_that.mileageMax,_that.transmission,_that.fuelType,_that.bodyType,_that.city,_that.province,_that.sortBy,_that.auctionsOnly);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SearchFilters extends SearchFilters {
  const _SearchFilters({this.keyword, final  List<String> brands = const [], this.yearMin, this.yearMax, this.priceMin, this.priceMax, this.mileageMax, final  List<TransmissionType> transmission = const [], final  List<FuelType> fuelType = const [], final  List<BodyType> bodyType = const [], this.city, this.province, this.sortBy = SortBy.newest, this.auctionsOnly = false}): _brands = brands,_transmission = transmission,_fuelType = fuelType,_bodyType = bodyType,super._();
  factory _SearchFilters.fromJson(Map<String, dynamic> json) => _$SearchFiltersFromJson(json);

@override final  String? keyword;
 final  List<String> _brands;
@override@JsonKey() List<String> get brands {
  if (_brands is EqualUnmodifiableListView) return _brands;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_brands);
}

@override final  int? yearMin;
@override final  int? yearMax;
@override final  double? priceMin;
@override final  double? priceMax;
@override final  int? mileageMax;
 final  List<TransmissionType> _transmission;
@override@JsonKey() List<TransmissionType> get transmission {
  if (_transmission is EqualUnmodifiableListView) return _transmission;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_transmission);
}

 final  List<FuelType> _fuelType;
@override@JsonKey() List<FuelType> get fuelType {
  if (_fuelType is EqualUnmodifiableListView) return _fuelType;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_fuelType);
}

 final  List<BodyType> _bodyType;
@override@JsonKey() List<BodyType> get bodyType {
  if (_bodyType is EqualUnmodifiableListView) return _bodyType;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bodyType);
}

@override final  String? city;
@override final  String? province;
@override@JsonKey() final  SortBy sortBy;
@override@JsonKey() final  bool auctionsOnly;

/// Create a copy of SearchFilters
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchFiltersCopyWith<_SearchFilters> get copyWith => __$SearchFiltersCopyWithImpl<_SearchFilters>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SearchFiltersToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchFilters&&(identical(other.keyword, keyword) || other.keyword == keyword)&&const DeepCollectionEquality().equals(other._brands, _brands)&&(identical(other.yearMin, yearMin) || other.yearMin == yearMin)&&(identical(other.yearMax, yearMax) || other.yearMax == yearMax)&&(identical(other.priceMin, priceMin) || other.priceMin == priceMin)&&(identical(other.priceMax, priceMax) || other.priceMax == priceMax)&&(identical(other.mileageMax, mileageMax) || other.mileageMax == mileageMax)&&const DeepCollectionEquality().equals(other._transmission, _transmission)&&const DeepCollectionEquality().equals(other._fuelType, _fuelType)&&const DeepCollectionEquality().equals(other._bodyType, _bodyType)&&(identical(other.city, city) || other.city == city)&&(identical(other.province, province) || other.province == province)&&(identical(other.sortBy, sortBy) || other.sortBy == sortBy)&&(identical(other.auctionsOnly, auctionsOnly) || other.auctionsOnly == auctionsOnly));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,keyword,const DeepCollectionEquality().hash(_brands),yearMin,yearMax,priceMin,priceMax,mileageMax,const DeepCollectionEquality().hash(_transmission),const DeepCollectionEquality().hash(_fuelType),const DeepCollectionEquality().hash(_bodyType),city,province,sortBy,auctionsOnly);

@override
String toString() {
  return 'SearchFilters(keyword: $keyword, brands: $brands, yearMin: $yearMin, yearMax: $yearMax, priceMin: $priceMin, priceMax: $priceMax, mileageMax: $mileageMax, transmission: $transmission, fuelType: $fuelType, bodyType: $bodyType, city: $city, province: $province, sortBy: $sortBy, auctionsOnly: $auctionsOnly)';
}


}

/// @nodoc
abstract mixin class _$SearchFiltersCopyWith<$Res> implements $SearchFiltersCopyWith<$Res> {
  factory _$SearchFiltersCopyWith(_SearchFilters value, $Res Function(_SearchFilters) _then) = __$SearchFiltersCopyWithImpl;
@override @useResult
$Res call({
 String? keyword, List<String> brands, int? yearMin, int? yearMax, double? priceMin, double? priceMax, int? mileageMax, List<TransmissionType> transmission, List<FuelType> fuelType, List<BodyType> bodyType, String? city, String? province, SortBy sortBy, bool auctionsOnly
});




}
/// @nodoc
class __$SearchFiltersCopyWithImpl<$Res>
    implements _$SearchFiltersCopyWith<$Res> {
  __$SearchFiltersCopyWithImpl(this._self, this._then);

  final _SearchFilters _self;
  final $Res Function(_SearchFilters) _then;

/// Create a copy of SearchFilters
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? keyword = freezed,Object? brands = null,Object? yearMin = freezed,Object? yearMax = freezed,Object? priceMin = freezed,Object? priceMax = freezed,Object? mileageMax = freezed,Object? transmission = null,Object? fuelType = null,Object? bodyType = null,Object? city = freezed,Object? province = freezed,Object? sortBy = null,Object? auctionsOnly = null,}) {
  return _then(_SearchFilters(
keyword: freezed == keyword ? _self.keyword : keyword // ignore: cast_nullable_to_non_nullable
as String?,brands: null == brands ? _self._brands : brands // ignore: cast_nullable_to_non_nullable
as List<String>,yearMin: freezed == yearMin ? _self.yearMin : yearMin // ignore: cast_nullable_to_non_nullable
as int?,yearMax: freezed == yearMax ? _self.yearMax : yearMax // ignore: cast_nullable_to_non_nullable
as int?,priceMin: freezed == priceMin ? _self.priceMin : priceMin // ignore: cast_nullable_to_non_nullable
as double?,priceMax: freezed == priceMax ? _self.priceMax : priceMax // ignore: cast_nullable_to_non_nullable
as double?,mileageMax: freezed == mileageMax ? _self.mileageMax : mileageMax // ignore: cast_nullable_to_non_nullable
as int?,transmission: null == transmission ? _self._transmission : transmission // ignore: cast_nullable_to_non_nullable
as List<TransmissionType>,fuelType: null == fuelType ? _self._fuelType : fuelType // ignore: cast_nullable_to_non_nullable
as List<FuelType>,bodyType: null == bodyType ? _self._bodyType : bodyType // ignore: cast_nullable_to_non_nullable
as List<BodyType>,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,province: freezed == province ? _self.province : province // ignore: cast_nullable_to_non_nullable
as String?,sortBy: null == sortBy ? _self.sortBy : sortBy // ignore: cast_nullable_to_non_nullable
as SortBy,auctionsOnly: null == auctionsOnly ? _self.auctionsOnly : auctionsOnly // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
