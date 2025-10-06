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
  engineSize: json['engineSize'] as String,
  engineType: $enumDecode(_$EngineTypeEnumMap, json['engineType']),
  cylinders: (json['cylinders'] as num).toInt(),
  horsepower: (json['horsepower'] as num).toInt(),
  torque: (json['torque'] as num).toInt(),
  transmission: $enumDecode(_$TransmissionTypeEnumMap, json['transmission']),
  transmissionSpeeds: (json['transmissionSpeeds'] as num).toInt(),
  driveType: $enumDecode(_$DriveTypeEnumMap, json['driveType']),
  fuelType: $enumDecode(_$FuelTypeEnumMap, json['fuelType']),
  fuelConsumption: (json['fuelConsumption'] as num).toDouble(),
  electricRange: (json['electricRange'] as num?)?.toInt(),
  batteryCapacity: (json['batteryCapacity'] as num?)?.toDouble(),
  chargingTime: json['chargingTime'] as String?,
  bodyType: $enumDecode(_$BodyTypeEnumMap, json['bodyType']),
  doors: (json['doors'] as num).toInt(),
  seats: (json['seats'] as num).toInt(),
  curbWeight: (json['curbWeight'] as num).toInt(),
  grossWeight: (json['grossWeight'] as num).toInt(),
  cargoCapacity: (json['cargoCapacity'] as num).toInt(),
  towingCapacity: (json['towingCapacity'] as num?)?.toInt(),
  groundClearance: (json['groundClearance'] as num?)?.toInt(),
  length: (json['length'] as num).toInt(),
  width: (json['width'] as num).toInt(),
  height: (json['height'] as num).toInt(),
  wheelbase: (json['wheelbase'] as num).toInt(),
  color: json['color'] as String,
  paintType: $enumDecode(_$PaintTypeEnumMap, json['paintType']),
  rimSize: (json['rimSize'] as num).toInt(),
  rimType: $enumDecode(_$RimTypeEnumMap, json['rimType']),
  tireCondition: $enumDecode(_$TireConditionEnumMap, json['tireCondition']),
  condition: $enumDecode(_$CarConditionEnumMap, json['condition']),
  mileage: (json['mileage'] as num).toInt(),
  numberOfOwners: (json['numberOfOwners'] as num).toInt(),
  hasAccidentHistory: json['hasAccidentHistory'] as bool,
  floodDamage: json['floodDamage'] as bool,
  serviceHistoryComplete: json['serviceHistoryComplete'] as bool,
  warrantyRemaining: json['warrantyRemaining'] as bool,
  registrationExpiry: json['registrationExpiry'] == null
      ? null
      : DateTime.parse(json['registrationExpiry'] as String),
  features:
      (json['features'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  location: CarLocation.fromJson(json['location'] as Map<String, dynamic>),
  availableForTestDrive: json['availableForTestDrive'] as bool? ?? false,
  deliveryAvailable: json['deliveryAvailable'] as bool? ?? false,
  plateNumber: json['plateNumber'] as String,
  orcrNumber: json['orcrNumber'] as String,
  registrationStatus: $enumDecode(
    _$RegistrationStatusEnumMap,
    json['registrationStatus'],
  ),
  emissionTestValid: json['emissionTestValid'] as bool,
  comprehensiveInsurance: json['comprehensiveInsurance'] as bool,
  acceptsTrade: json['acceptsTrade'] as bool? ?? false,
  financingAvailable: json['financingAvailable'] as bool? ?? false,
  priceNegotiable: json['priceNegotiable'] as bool? ?? false,
  description: json['description'] as String,
  issues: json['issues'] as String?,
  images: (json['images'] as List<dynamic>).map((e) => e as String).toList(),
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
  'engineSize': instance.engineSize,
  'engineType': _$EngineTypeEnumMap[instance.engineType]!,
  'cylinders': instance.cylinders,
  'horsepower': instance.horsepower,
  'torque': instance.torque,
  'transmission': _$TransmissionTypeEnumMap[instance.transmission]!,
  'transmissionSpeeds': instance.transmissionSpeeds,
  'driveType': _$DriveTypeEnumMap[instance.driveType]!,
  'fuelType': _$FuelTypeEnumMap[instance.fuelType]!,
  'fuelConsumption': instance.fuelConsumption,
  'electricRange': instance.electricRange,
  'batteryCapacity': instance.batteryCapacity,
  'chargingTime': instance.chargingTime,
  'bodyType': _$BodyTypeEnumMap[instance.bodyType]!,
  'doors': instance.doors,
  'seats': instance.seats,
  'curbWeight': instance.curbWeight,
  'grossWeight': instance.grossWeight,
  'cargoCapacity': instance.cargoCapacity,
  'towingCapacity': instance.towingCapacity,
  'groundClearance': instance.groundClearance,
  'length': instance.length,
  'width': instance.width,
  'height': instance.height,
  'wheelbase': instance.wheelbase,
  'color': instance.color,
  'paintType': _$PaintTypeEnumMap[instance.paintType]!,
  'rimSize': instance.rimSize,
  'rimType': _$RimTypeEnumMap[instance.rimType]!,
  'tireCondition': _$TireConditionEnumMap[instance.tireCondition]!,
  'condition': _$CarConditionEnumMap[instance.condition]!,
  'mileage': instance.mileage,
  'numberOfOwners': instance.numberOfOwners,
  'hasAccidentHistory': instance.hasAccidentHistory,
  'floodDamage': instance.floodDamage,
  'serviceHistoryComplete': instance.serviceHistoryComplete,
  'warrantyRemaining': instance.warrantyRemaining,
  'registrationExpiry': instance.registrationExpiry?.toIso8601String(),
  'features': instance.features,
  'location': instance.location,
  'availableForTestDrive': instance.availableForTestDrive,
  'deliveryAvailable': instance.deliveryAvailable,
  'plateNumber': instance.plateNumber,
  'orcrNumber': instance.orcrNumber,
  'registrationStatus':
      _$RegistrationStatusEnumMap[instance.registrationStatus]!,
  'emissionTestValid': instance.emissionTestValid,
  'comprehensiveInsurance': instance.comprehensiveInsurance,
  'acceptsTrade': instance.acceptsTrade,
  'financingAvailable': instance.financingAvailable,
  'priceNegotiable': instance.priceNegotiable,
  'description': instance.description,
  'issues': instance.issues,
  'images': instance.images,
  'status': _$ListingStatusEnumMap[instance.status]!,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'viewCount': instance.viewCount,
};

const _$EngineTypeEnumMap = {
  EngineType.inline: 'inline',
  EngineType.vType: 'v_type',
  EngineType.boxer: 'boxer',
  EngineType.rotary: 'rotary',
  EngineType.electric: 'electric',
};

const _$TransmissionTypeEnumMap = {
  TransmissionType.automatic: 'automatic',
  TransmissionType.manual: 'manual',
  TransmissionType.cvt: 'cvt',
  TransmissionType.dct: 'dct',
  TransmissionType.amt: 'amt',
};

const _$DriveTypeEnumMap = {
  DriveType.fwd: 'fwd',
  DriveType.rwd: 'rwd',
  DriveType.awd: 'awd',
  DriveType.fourWd: '4wd',
};

const _$FuelTypeEnumMap = {
  FuelType.gasoline: 'gasoline',
  FuelType.diesel: 'diesel',
  FuelType.electric: 'electric',
  FuelType.hybrid: 'hybrid',
  FuelType.plugInHybrid: 'plug_in_hybrid',
  FuelType.hydrogen: 'hydrogen',
  FuelType.cng: 'cng',
  FuelType.lpg: 'lpg',
};

const _$BodyTypeEnumMap = {
  BodyType.sedan: 'sedan',
  BodyType.suv: 'suv',
  BodyType.hatchback: 'hatchback',
  BodyType.pickup: 'pickup',
  BodyType.van: 'van',
  BodyType.coupe: 'coupe',
  BodyType.mpv: 'mpv',
  BodyType.convertible: 'convertible',
  BodyType.wagon: 'wagon',
  BodyType.truck: 'truck',
  BodyType.minivan: 'minivan',
  BodyType.crossover: 'crossover',
};

const _$PaintTypeEnumMap = {
  PaintType.solid: 'solid',
  PaintType.metallic: 'metallic',
  PaintType.pearlescent: 'pearlescent',
  PaintType.matte: 'matte',
};

const _$RimTypeEnumMap = {
  RimType.steel: 'steel',
  RimType.alloy: 'alloy',
  RimType.forged: 'forged',
};

const _$TireConditionEnumMap = {
  TireCondition.newTires: 'new',
  TireCondition.good: 'good',
  TireCondition.fair: 'fair',
  TireCondition.needsReplacement: 'needs_replacement',
};

const _$CarConditionEnumMap = {
  CarCondition.brandNew: 'brand_new',
  CarCondition.almostNew: 'almost_new',
  CarCondition.used: 'used',
  CarCondition.certified: 'certified',
  CarCondition.forParts: 'for_parts',
};

const _$RegistrationStatusEnumMap = {
  RegistrationStatus.current: 'current',
  RegistrationStatus.expiringSoon: 'expiring_soon',
  RegistrationStatus.expired: 'expired',
};

const _$ListingStatusEnumMap = {
  ListingStatus.draft: 'draft',
  ListingStatus.pendingReview: 'pending_review',
  ListingStatus.active: 'active',
  ListingStatus.sold: 'sold',
  ListingStatus.cancelled: 'cancelled',
};
