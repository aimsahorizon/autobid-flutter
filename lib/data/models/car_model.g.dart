// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CarLocation _$CarLocationFromJson(Map<String, dynamic> json) => _CarLocation(
  city: json['city'] as String,
  province: json['province'] as String,
);

Map<String, dynamic> _$CarLocationToJson(_CarLocation instance) =>
    <String, dynamic>{'city': instance.city, 'province': instance.province};

_CarModel _$CarModelFromJson(Map<String, dynamic> json) => _CarModel(
  id: json['id'] as String,
  sellerId: json['sellerId'] as String,
  sellerName: json['sellerName'] as String,
  brand: json['brand'] as String,
  model: json['model'] as String,
  variant: json['variant'] as String,
  year: (json['year'] as num).toInt(),
  mileage: (json['mileage'] as num).toInt(),
  transmission: $enumDecode(_$TransmissionTypeEnumMap, json['transmission']),
  fuelType: $enumDecode(_$FuelTypeEnumMap, json['fuelType']),
  bodyType: $enumDecode(_$BodyTypeEnumMap, json['bodyType']),
  color: json['color'] as String,
  engineSize: json['engineSize'] as String,
  seats: (json['seats'] as num).toInt(),
  doors: (json['doors'] as num).toInt(),
  plateNumber: json['plateNumber'] as String,
  orcrNumber: json['orcrNumber'] as String,
  location: CarLocation.fromJson(json['location'] as Map<String, dynamic>),
  numberOfOwners: (json['numberOfOwners'] as num).toInt(),
  serviceHistoryComplete: json['serviceHistoryComplete'] as bool,
  hasAccidentHistory: json['hasAccidentHistory'] as bool,
  condition: $enumDecode(_$CarConditionEnumMap, json['condition']),
  description: json['description'] as String,
  issues: json['issues'] as String?,
  images: (json['images'] as List<dynamic>).map((e) => e as String).toList(),
  features:
      (json['features'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  status: $enumDecode(_$ListingStatusEnumMap, json['status']),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  viewCount: (json['viewCount'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$CarModelToJson(_CarModel instance) => <String, dynamic>{
  'id': instance.id,
  'sellerId': instance.sellerId,
  'sellerName': instance.sellerName,
  'brand': instance.brand,
  'model': instance.model,
  'variant': instance.variant,
  'year': instance.year,
  'mileage': instance.mileage,
  'transmission': _$TransmissionTypeEnumMap[instance.transmission]!,
  'fuelType': _$FuelTypeEnumMap[instance.fuelType]!,
  'bodyType': _$BodyTypeEnumMap[instance.bodyType]!,
  'color': instance.color,
  'engineSize': instance.engineSize,
  'seats': instance.seats,
  'doors': instance.doors,
  'plateNumber': instance.plateNumber,
  'orcrNumber': instance.orcrNumber,
  'location': instance.location,
  'numberOfOwners': instance.numberOfOwners,
  'serviceHistoryComplete': instance.serviceHistoryComplete,
  'hasAccidentHistory': instance.hasAccidentHistory,
  'condition': _$CarConditionEnumMap[instance.condition]!,
  'description': instance.description,
  'issues': instance.issues,
  'images': instance.images,
  'features': instance.features,
  'status': _$ListingStatusEnumMap[instance.status]!,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'viewCount': instance.viewCount,
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

const _$CarConditionEnumMap = {
  CarCondition.brandNew: 'brand_new',
  CarCondition.almostNew: 'almost_new',
  CarCondition.used: 'used',
  CarCondition.forParts: 'for_parts',
};

const _$ListingStatusEnumMap = {
  ListingStatus.draft: 'draft',
  ListingStatus.pendingReview: 'pending_review',
  ListingStatus.active: 'active',
  ListingStatus.sold: 'sold',
  ListingStatus.cancelled: 'cancelled',
};
