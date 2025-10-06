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
  bodyType:
      (json['bodyType'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$BodyTypeEnumMap, e))
          .toList() ??
      const [],
  engineSizes:
      (json['engineSizes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  engineTypes:
      (json['engineTypes'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$EngineTypeEnumMap, e))
          .toList() ??
      const [],
  cylinders:
      (json['cylinders'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const [],
  horsepowerMin: (json['horsepowerMin'] as num?)?.toInt(),
  horsepowerMax: (json['horsepowerMax'] as num?)?.toInt(),
  torqueMin: (json['torqueMin'] as num?)?.toInt(),
  torqueMax: (json['torqueMax'] as num?)?.toInt(),
  transmission:
      (json['transmission'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$TransmissionTypeEnumMap, e))
          .toList() ??
      const [],
  transmissionSpeeds:
      (json['transmissionSpeeds'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const [],
  driveTypes:
      (json['driveTypes'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$DriveTypeEnumMap, e))
          .toList() ??
      const [],
  fuelType:
      (json['fuelType'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$FuelTypeEnumMap, e))
          .toList() ??
      const [],
  fuelConsumptionMax: (json['fuelConsumptionMax'] as num?)?.toDouble(),
  electricRangeMin: (json['electricRangeMin'] as num?)?.toInt(),
  seats:
      (json['seats'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const [],
  doors:
      (json['doors'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const [],
  curbWeightMin: (json['curbWeightMin'] as num?)?.toInt(),
  curbWeightMax: (json['curbWeightMax'] as num?)?.toInt(),
  cargoCapacityMin: (json['cargoCapacityMin'] as num?)?.toInt(),
  groundClearanceMin: (json['groundClearanceMin'] as num?)?.toInt(),
  colors:
      (json['colors'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  rimSizes:
      (json['rimSizes'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const [],
  paintTypes:
      (json['paintTypes'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$PaintTypeEnumMap, e))
          .toList() ??
      const [],
  mileageMax: (json['mileageMax'] as num?)?.toInt(),
  ownersMax: (json['ownersMax'] as num?)?.toInt(),
  accidentFree: json['accidentFree'] as bool? ?? false,
  floodFree: json['floodFree'] as bool? ?? false,
  withWarranty: json['withWarranty'] as bool? ?? false,
  completeServiceHistory: json['completeServiceHistory'] as bool? ?? false,
  features:
      (json['features'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  minAirbags: (json['minAirbags'] as num?)?.toInt(),
  hasABS: json['hasABS'] as bool? ?? false,
  hasCameras: json['hasCameras'] as bool? ?? false,
  hasBlindSpot: json['hasBlindSpot'] as bool? ?? false,
  hasLaneAssist: json['hasLaneAssist'] as bool? ?? false,
  hasAdaptiveCruise: json['hasAdaptiveCruise'] as bool? ?? false,
  hasClimateControl: json['hasClimateControl'] as bool? ?? false,
  hasSunroof: json['hasSunroof'] as bool? ?? false,
  hasLeatherSeats: json['hasLeatherSeats'] as bool? ?? false,
  hasPowerSeats: json['hasPowerSeats'] as bool? ?? false,
  minInfotainmentSize: (json['minInfotainmentSize'] as num?)?.toInt(),
  hasCarPlay: json['hasCarPlay'] as bool? ?? false,
  hasAndroidAuto: json['hasAndroidAuto'] as bool? ?? false,
  hasNavigation: json['hasNavigation'] as bool? ?? false,
  hasWirelessCharging: json['hasWirelessCharging'] as bool? ?? false,
  hasPremiumAudio: json['hasPremiumAudio'] as bool? ?? false,
  city: json['city'] as String?,
  province: json['province'] as String?,
  testDriveAvailable: json['testDriveAvailable'] as bool? ?? false,
  deliveryAvailable: json['deliveryAvailable'] as bool? ?? false,
  acceptsTrade: json['acceptsTrade'] as bool? ?? false,
  financingAvailable: json['financingAvailable'] as bool? ?? false,
  negotiable: json['negotiable'] as bool? ?? false,
  auctionsOnly: json['auctionsOnly'] as bool? ?? false,
  sortBy: $enumDecodeNullable(_$SortByEnumMap, json['sortBy']) ?? SortBy.newest,
);

Map<String, dynamic> _$SearchFiltersToJson(
  _SearchFilters instance,
) => <String, dynamic>{
  'keyword': instance.keyword,
  'brands': instance.brands,
  'yearMin': instance.yearMin,
  'yearMax': instance.yearMax,
  'priceMin': instance.priceMin,
  'priceMax': instance.priceMax,
  'bodyType': instance.bodyType.map((e) => _$BodyTypeEnumMap[e]!).toList(),
  'engineSizes': instance.engineSizes,
  'engineTypes': instance.engineTypes
      .map((e) => _$EngineTypeEnumMap[e]!)
      .toList(),
  'cylinders': instance.cylinders,
  'horsepowerMin': instance.horsepowerMin,
  'horsepowerMax': instance.horsepowerMax,
  'torqueMin': instance.torqueMin,
  'torqueMax': instance.torqueMax,
  'transmission': instance.transmission
      .map((e) => _$TransmissionTypeEnumMap[e]!)
      .toList(),
  'transmissionSpeeds': instance.transmissionSpeeds,
  'driveTypes': instance.driveTypes.map((e) => _$DriveTypeEnumMap[e]!).toList(),
  'fuelType': instance.fuelType.map((e) => _$FuelTypeEnumMap[e]!).toList(),
  'fuelConsumptionMax': instance.fuelConsumptionMax,
  'electricRangeMin': instance.electricRangeMin,
  'seats': instance.seats,
  'doors': instance.doors,
  'curbWeightMin': instance.curbWeightMin,
  'curbWeightMax': instance.curbWeightMax,
  'cargoCapacityMin': instance.cargoCapacityMin,
  'groundClearanceMin': instance.groundClearanceMin,
  'colors': instance.colors,
  'rimSizes': instance.rimSizes,
  'paintTypes': instance.paintTypes.map((e) => _$PaintTypeEnumMap[e]!).toList(),
  'mileageMax': instance.mileageMax,
  'ownersMax': instance.ownersMax,
  'accidentFree': instance.accidentFree,
  'floodFree': instance.floodFree,
  'withWarranty': instance.withWarranty,
  'completeServiceHistory': instance.completeServiceHistory,
  'features': instance.features,
  'minAirbags': instance.minAirbags,
  'hasABS': instance.hasABS,
  'hasCameras': instance.hasCameras,
  'hasBlindSpot': instance.hasBlindSpot,
  'hasLaneAssist': instance.hasLaneAssist,
  'hasAdaptiveCruise': instance.hasAdaptiveCruise,
  'hasClimateControl': instance.hasClimateControl,
  'hasSunroof': instance.hasSunroof,
  'hasLeatherSeats': instance.hasLeatherSeats,
  'hasPowerSeats': instance.hasPowerSeats,
  'minInfotainmentSize': instance.minInfotainmentSize,
  'hasCarPlay': instance.hasCarPlay,
  'hasAndroidAuto': instance.hasAndroidAuto,
  'hasNavigation': instance.hasNavigation,
  'hasWirelessCharging': instance.hasWirelessCharging,
  'hasPremiumAudio': instance.hasPremiumAudio,
  'city': instance.city,
  'province': instance.province,
  'testDriveAvailable': instance.testDriveAvailable,
  'deliveryAvailable': instance.deliveryAvailable,
  'acceptsTrade': instance.acceptsTrade,
  'financingAvailable': instance.financingAvailable,
  'negotiable': instance.negotiable,
  'auctionsOnly': instance.auctionsOnly,
  'sortBy': _$SortByEnumMap[instance.sortBy]!,
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

const _$PaintTypeEnumMap = {
  PaintType.solid: 'solid',
  PaintType.metallic: 'metallic',
  PaintType.pearlescent: 'pearlescent',
  PaintType.matte: 'matte',
};

const _$SortByEnumMap = {
  SortBy.priceAsc: 'price_asc',
  SortBy.priceDesc: 'price_desc',
  SortBy.yearNewest: 'year_newest',
  SortBy.yearOldest: 'year_oldest',
  SortBy.mileageLowest: 'mileage_lowest',
  SortBy.mileageHighest: 'mileage_highest',
  SortBy.horsepowerHighest: 'horsepower_highest',
  SortBy.horsepowerLowest: 'horsepower_lowest',
  SortBy.fuelEconomyBest: 'fuel_economy_best',
  SortBy.fuelEconomyWorst: 'fuel_economy_worst',
  SortBy.newest: 'newest',
  SortBy.mostViewed: 'most_viewed',
  SortBy.endingSoon: 'ending_soon',
};
