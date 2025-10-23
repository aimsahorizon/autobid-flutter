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
  grossWeightMin: (json['grossWeightMin'] as num?)?.toInt(),
  grossWeightMax: (json['grossWeightMax'] as num?)?.toInt(),
  cargoCapacityMin: (json['cargoCapacityMin'] as num?)?.toInt(),
  towingCapacityMin: (json['towingCapacityMin'] as num?)?.toInt(),
  groundClearanceMin: (json['groundClearanceMin'] as num?)?.toInt(),
  lengthMin: (json['lengthMin'] as num?)?.toInt(),
  lengthMax: (json['lengthMax'] as num?)?.toInt(),
  widthMin: (json['widthMin'] as num?)?.toInt(),
  widthMax: (json['widthMax'] as num?)?.toInt(),
  heightMin: (json['heightMin'] as num?)?.toInt(),
  heightMax: (json['heightMax'] as num?)?.toInt(),
  wheelbaseMin: (json['wheelbaseMin'] as num?)?.toInt(),
  wheelbaseMax: (json['wheelbaseMax'] as num?)?.toInt(),
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
  rimTypes:
      (json['rimTypes'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$RimTypeEnumMap, e))
          .toList() ??
      const [],
  tireConditions:
      (json['tireConditions'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$TireConditionEnumMap, e))
          .toList() ??
      const [],
  mileageMin: (json['mileageMin'] as num?)?.toInt(),
  mileageMax: (json['mileageMax'] as num?)?.toInt(),
  ownersMax: (json['ownersMax'] as num?)?.toInt(),
  accidentFree: json['accidentFree'] as bool? ?? false,
  floodFree: json['floodFree'] as bool? ?? false,
  withWarranty: json['withWarranty'] as bool? ?? false,
  completeServiceHistory: json['completeServiceHistory'] as bool? ?? false,
  conditions:
      (json['conditions'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$CarConditionEnumMap, e))
          .toList() ??
      const [],
  registrationStatuses:
      (json['registrationStatuses'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$RegistrationStatusEnumMap, e))
          .toList() ??
      const [],
  emissionTestValid: json['emissionTestValid'] as bool? ?? false,
  comprehensiveInsurance: json['comprehensiveInsurance'] as bool? ?? false,
  features:
      (json['features'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  minAirbags: (json['minAirbags'] as num?)?.toInt(),
  hasABS: json['hasABS'] as bool? ?? false,
  hasTractionControl: json['hasTractionControl'] as bool? ?? false,
  hasStabilityControl: json['hasStabilityControl'] as bool? ?? false,
  hasCameras: json['hasCameras'] as bool? ?? false,
  hasRearCamera: json['hasRearCamera'] as bool? ?? false,
  has360Camera: json['has360Camera'] as bool? ?? false,
  hasBlindSpot: json['hasBlindSpot'] as bool? ?? false,
  hasLaneDepartureWarning: json['hasLaneDepartureWarning'] as bool? ?? false,
  hasLaneAssist: json['hasLaneAssist'] as bool? ?? false,
  hasAdaptiveCruise: json['hasAdaptiveCruise'] as bool? ?? false,
  hasForwardCollisionWarning:
      json['hasForwardCollisionWarning'] as bool? ?? false,
  hasAutomaticEmergencyBraking:
      json['hasAutomaticEmergencyBraking'] as bool? ?? false,
  hasHillStartAssist: json['hasHillStartAssist'] as bool? ?? false,
  hasHillDescentControl: json['hasHillDescentControl'] as bool? ?? false,
  hasParkingSensors: json['hasParkingSensors'] as bool? ?? false,
  hasFrontParkingSensors: json['hasFrontParkingSensors'] as bool? ?? false,
  hasRearParkingSensors: json['hasRearParkingSensors'] as bool? ?? false,
  hasClimateControl: json['hasClimateControl'] as bool? ?? false,
  hasDualClimateControl: json['hasDualClimateControl'] as bool? ?? false,
  hasSunroof: json['hasSunroof'] as bool? ?? false,
  hasPanoramicSunroof: json['hasPanoramicSunroof'] as bool? ?? false,
  hasLeatherSeats: json['hasLeatherSeats'] as bool? ?? false,
  hasPowerSeats: json['hasPowerSeats'] as bool? ?? false,
  hasHeatedSeats: json['hasHeatedSeats'] as bool? ?? false,
  hasVentilatedSeats: json['hasVentilatedSeats'] as bool? ?? false,
  hasMemorySeats: json['hasMemorySeats'] as bool? ?? false,
  hasKeylessEntry: json['hasKeylessEntry'] as bool? ?? false,
  hasPushStart: json['hasPushStart'] as bool? ?? false,
  hasPowerWindows: json['hasPowerWindows'] as bool? ?? false,
  hasPowerMirrors: json['hasPowerMirrors'] as bool? ?? false,
  hasAutoFoldingMirrors: json['hasAutoFoldingMirrors'] as bool? ?? false,
  hasPowerTailgate: json['hasPowerTailgate'] as bool? ?? false,
  hasCruiseControl: json['hasCruiseControl'] as bool? ?? false,
  minInfotainmentSize: (json['minInfotainmentSize'] as num?)?.toInt(),
  hasTouchscreen: json['hasTouchscreen'] as bool? ?? false,
  hasCarPlay: json['hasCarPlay'] as bool? ?? false,
  hasAndroidAuto: json['hasAndroidAuto'] as bool? ?? false,
  hasNavigation: json['hasNavigation'] as bool? ?? false,
  hasBluetooth: json['hasBluetooth'] as bool? ?? false,
  hasWirelessCharging: json['hasWirelessCharging'] as bool? ?? false,
  hasPremiumAudio: json['hasPremiumAudio'] as bool? ?? false,
  minSpeakerCount: (json['minSpeakerCount'] as num?)?.toInt(),
  hasHeadUpDisplay: json['hasHeadUpDisplay'] as bool? ?? false,
  hasDigitalCluster: json['hasDigitalCluster'] as bool? ?? false,
  hasWifiHotspot: json['hasWifiHotspot'] as bool? ?? false,
  minUSBPorts: (json['minUSBPorts'] as num?)?.toInt(),
  region: json['region'] as String?,
  province: json['province'] as String?,
  city: json['city'] as String?,
  distanceRadius: (json['distanceRadius'] as num?)?.toInt(),
  testDriveAvailable: json['testDriveAvailable'] as bool? ?? false,
  deliveryAvailable: json['deliveryAvailable'] as bool? ?? false,
  homeDelivery: json['homeDelivery'] as bool? ?? false,
  dealershipPickup: json['dealershipPickup'] as bool? ?? false,
  acceptsTrade: json['acceptsTrade'] as bool? ?? false,
  financingAvailable: json['financingAvailable'] as bool? ?? false,
  bankFinancing: json['bankFinancing'] as bool? ?? false,
  inHouseFinancing: json['inHouseFinancing'] as bool? ?? false,
  negotiable: json['negotiable'] as bool? ?? false,
  cashOnly: json['cashOnly'] as bool? ?? false,
  auctionsOnly: json['auctionsOnly'] as bool? ?? false,
  directSaleOnly: json['directSaleOnly'] as bool? ?? false,
  liveAuctionsOnly: json['liveAuctionsOnly'] as bool? ?? false,
  upcomingAuctionsOnly: json['upcomingAuctionsOnly'] as bool? ?? false,
  endingSoonOnly: json['endingSoonOnly'] as bool? ?? false,
  hasBuyNowPrice: json['hasBuyNowPrice'] as bool? ?? false,
  belowReservePrice: json['belowReservePrice'] as bool? ?? false,
  noBidsYet: json['noBidsYet'] as bool? ?? false,
  featuredOnly: json['featuredOnly'] as bool? ?? false,
  verifiedSeller: json['verifiedSeller'] as bool? ?? false,
  dealerOnly: json['dealerOnly'] as bool? ?? false,
  privateSellerOnly: json['privateSellerOnly'] as bool? ?? false,
  recentlyAddedDays: (json['recentlyAddedDays'] as num?)?.toInt(),
  recentlyUpdatedDays: (json['recentlyUpdatedDays'] as num?)?.toInt(),
  priceReduced: json['priceReduced'] as bool? ?? false,
  newListing: json['newListing'] as bool? ?? false,
  minViewCount: (json['minViewCount'] as num?)?.toInt(),
  minPhotoCount: (json['minPhotoCount'] as num?)?.toInt(),
  hasVideo: json['hasVideo'] as bool? ?? false,
  has360View: json['has360View'] as bool? ?? false,
  hasInteriorPhotos: json['hasInteriorPhotos'] as bool? ?? false,
  hasEnginePhotos: json['hasEnginePhotos'] as bool? ?? false,
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
  'grossWeightMin': instance.grossWeightMin,
  'grossWeightMax': instance.grossWeightMax,
  'cargoCapacityMin': instance.cargoCapacityMin,
  'towingCapacityMin': instance.towingCapacityMin,
  'groundClearanceMin': instance.groundClearanceMin,
  'lengthMin': instance.lengthMin,
  'lengthMax': instance.lengthMax,
  'widthMin': instance.widthMin,
  'widthMax': instance.widthMax,
  'heightMin': instance.heightMin,
  'heightMax': instance.heightMax,
  'wheelbaseMin': instance.wheelbaseMin,
  'wheelbaseMax': instance.wheelbaseMax,
  'colors': instance.colors,
  'rimSizes': instance.rimSizes,
  'paintTypes': instance.paintTypes.map((e) => _$PaintTypeEnumMap[e]!).toList(),
  'rimTypes': instance.rimTypes.map((e) => _$RimTypeEnumMap[e]!).toList(),
  'tireConditions': instance.tireConditions
      .map((e) => _$TireConditionEnumMap[e]!)
      .toList(),
  'mileageMin': instance.mileageMin,
  'mileageMax': instance.mileageMax,
  'ownersMax': instance.ownersMax,
  'accidentFree': instance.accidentFree,
  'floodFree': instance.floodFree,
  'withWarranty': instance.withWarranty,
  'completeServiceHistory': instance.completeServiceHistory,
  'conditions': instance.conditions
      .map((e) => _$CarConditionEnumMap[e]!)
      .toList(),
  'registrationStatuses': instance.registrationStatuses
      .map((e) => _$RegistrationStatusEnumMap[e]!)
      .toList(),
  'emissionTestValid': instance.emissionTestValid,
  'comprehensiveInsurance': instance.comprehensiveInsurance,
  'features': instance.features,
  'minAirbags': instance.minAirbags,
  'hasABS': instance.hasABS,
  'hasTractionControl': instance.hasTractionControl,
  'hasStabilityControl': instance.hasStabilityControl,
  'hasCameras': instance.hasCameras,
  'hasRearCamera': instance.hasRearCamera,
  'has360Camera': instance.has360Camera,
  'hasBlindSpot': instance.hasBlindSpot,
  'hasLaneDepartureWarning': instance.hasLaneDepartureWarning,
  'hasLaneAssist': instance.hasLaneAssist,
  'hasAdaptiveCruise': instance.hasAdaptiveCruise,
  'hasForwardCollisionWarning': instance.hasForwardCollisionWarning,
  'hasAutomaticEmergencyBraking': instance.hasAutomaticEmergencyBraking,
  'hasHillStartAssist': instance.hasHillStartAssist,
  'hasHillDescentControl': instance.hasHillDescentControl,
  'hasParkingSensors': instance.hasParkingSensors,
  'hasFrontParkingSensors': instance.hasFrontParkingSensors,
  'hasRearParkingSensors': instance.hasRearParkingSensors,
  'hasClimateControl': instance.hasClimateControl,
  'hasDualClimateControl': instance.hasDualClimateControl,
  'hasSunroof': instance.hasSunroof,
  'hasPanoramicSunroof': instance.hasPanoramicSunroof,
  'hasLeatherSeats': instance.hasLeatherSeats,
  'hasPowerSeats': instance.hasPowerSeats,
  'hasHeatedSeats': instance.hasHeatedSeats,
  'hasVentilatedSeats': instance.hasVentilatedSeats,
  'hasMemorySeats': instance.hasMemorySeats,
  'hasKeylessEntry': instance.hasKeylessEntry,
  'hasPushStart': instance.hasPushStart,
  'hasPowerWindows': instance.hasPowerWindows,
  'hasPowerMirrors': instance.hasPowerMirrors,
  'hasAutoFoldingMirrors': instance.hasAutoFoldingMirrors,
  'hasPowerTailgate': instance.hasPowerTailgate,
  'hasCruiseControl': instance.hasCruiseControl,
  'minInfotainmentSize': instance.minInfotainmentSize,
  'hasTouchscreen': instance.hasTouchscreen,
  'hasCarPlay': instance.hasCarPlay,
  'hasAndroidAuto': instance.hasAndroidAuto,
  'hasNavigation': instance.hasNavigation,
  'hasBluetooth': instance.hasBluetooth,
  'hasWirelessCharging': instance.hasWirelessCharging,
  'hasPremiumAudio': instance.hasPremiumAudio,
  'minSpeakerCount': instance.minSpeakerCount,
  'hasHeadUpDisplay': instance.hasHeadUpDisplay,
  'hasDigitalCluster': instance.hasDigitalCluster,
  'hasWifiHotspot': instance.hasWifiHotspot,
  'minUSBPorts': instance.minUSBPorts,
  'region': instance.region,
  'province': instance.province,
  'city': instance.city,
  'distanceRadius': instance.distanceRadius,
  'testDriveAvailable': instance.testDriveAvailable,
  'deliveryAvailable': instance.deliveryAvailable,
  'homeDelivery': instance.homeDelivery,
  'dealershipPickup': instance.dealershipPickup,
  'acceptsTrade': instance.acceptsTrade,
  'financingAvailable': instance.financingAvailable,
  'bankFinancing': instance.bankFinancing,
  'inHouseFinancing': instance.inHouseFinancing,
  'negotiable': instance.negotiable,
  'cashOnly': instance.cashOnly,
  'auctionsOnly': instance.auctionsOnly,
  'directSaleOnly': instance.directSaleOnly,
  'liveAuctionsOnly': instance.liveAuctionsOnly,
  'upcomingAuctionsOnly': instance.upcomingAuctionsOnly,
  'endingSoonOnly': instance.endingSoonOnly,
  'hasBuyNowPrice': instance.hasBuyNowPrice,
  'belowReservePrice': instance.belowReservePrice,
  'noBidsYet': instance.noBidsYet,
  'featuredOnly': instance.featuredOnly,
  'verifiedSeller': instance.verifiedSeller,
  'dealerOnly': instance.dealerOnly,
  'privateSellerOnly': instance.privateSellerOnly,
  'recentlyAddedDays': instance.recentlyAddedDays,
  'recentlyUpdatedDays': instance.recentlyUpdatedDays,
  'priceReduced': instance.priceReduced,
  'newListing': instance.newListing,
  'minViewCount': instance.minViewCount,
  'minPhotoCount': instance.minPhotoCount,
  'hasVideo': instance.hasVideo,
  'has360View': instance.has360View,
  'hasInteriorPhotos': instance.hasInteriorPhotos,
  'hasEnginePhotos': instance.hasEnginePhotos,
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
  RegistrationStatus.forRenewal: 'for_renewal',
  RegistrationStatus.pendingRenewal: 'pending_renewal',
  RegistrationStatus.delinquent: 'delinquent',
  RegistrationStatus.underAlarm: 'under_alarm',
  RegistrationStatus.carnapped: 'carnapped',
  RegistrationStatus.other: 'other',
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
