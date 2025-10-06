// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_filters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SearchFilters _$SearchFiltersFromJson(
  Map<String, dynamic> json,
) => _SearchFilters(
  keyword: json['keyword'] as String?,
  brands:
      (json['brands'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  yearMin: (json['yearMin'] as num?)?.toInt(),
  yearMax: (json['yearMax'] as num?)?.toInt(),
  priceMin: (json['priceMin'] as num?)?.toDouble(),
  priceMax: (json['priceMax'] as num?)?.toDouble(),
  mileageMax: (json['mileageMax'] as num?)?.toInt(),
  transmission:
      (json['transmission'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$TransmissionTypeEnumMap, e))
          .toList() ??
      const [],
  fuelType:
      (json['fuelType'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$FuelTypeEnumMap, e))
          .toList() ??
      const [],
  bodyType:
      (json['bodyType'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$BodyTypeEnumMap, e))
          .toList() ??
      const [],
  city: json['city'] as String?,
  province: json['province'] as String?,
  sortBy: $enumDecodeNullable(_$SortByEnumMap, json['sortBy']) ?? SortBy.newest,
  auctionsOnly: json['auctionsOnly'] as bool? ?? false,
);

Map<String, dynamic> _$SearchFiltersToJson(_SearchFilters instance) =>
    <String, dynamic>{
      'keyword': instance.keyword,
      'brands': instance.brands,
      'yearMin': instance.yearMin,
      'yearMax': instance.yearMax,
      'priceMin': instance.priceMin,
      'priceMax': instance.priceMax,
      'mileageMax': instance.mileageMax,
      'transmission': instance.transmission
          .map((e) => _$TransmissionTypeEnumMap[e]!)
          .toList(),
      'fuelType': instance.fuelType.map((e) => _$FuelTypeEnumMap[e]!).toList(),
      'bodyType': instance.bodyType.map((e) => _$BodyTypeEnumMap[e]!).toList(),
      'city': instance.city,
      'province': instance.province,
      'sortBy': _$SortByEnumMap[instance.sortBy]!,
      'auctionsOnly': instance.auctionsOnly,
    };

const _$TransmissionTypeEnumMap = {
  TransmissionType.automatic: 'automatic',
  TransmissionType.manual: 'manual',
  TransmissionType.cvt: 'cvt',
  TransmissionType.dct: 'dct',
};

const _$FuelTypeEnumMap = {
  FuelType.gasoline: 'gasoline',
  FuelType.diesel: 'diesel',
  FuelType.electric: 'electric',
  FuelType.hybrid: 'hybrid',
};

const _$BodyTypeEnumMap = {
  BodyType.sedan: 'sedan',
  BodyType.suv: 'suv',
  BodyType.hatchback: 'hatchback',
  BodyType.pickup: 'pickup',
  BodyType.van: 'van',
  BodyType.coupe: 'coupe',
  BodyType.mpv: 'mpv',
};

const _$SortByEnumMap = {
  SortBy.priceAsc: 'price_asc',
  SortBy.priceDesc: 'price_desc',
  SortBy.yearDesc: 'year_desc',
  SortBy.mileageAsc: 'mileage_asc',
  SortBy.newest: 'newest',
  SortBy.endingSoon: 'ending_soon',
};
