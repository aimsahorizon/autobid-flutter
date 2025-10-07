import '../../data/models/car_model.dart';

extension TransmissionTypeExtension on TransmissionType {
  String get displayName {
    switch (this) {
      case TransmissionType.automatic:
        return 'Automatic';
      case TransmissionType.manual:
        return 'Manual';
      case TransmissionType.cvt:
        return 'CVT';
      case TransmissionType.dct:
        return 'DCT';
      case TransmissionType.amt:
        return 'AMT';
    }
  }
}

extension FuelTypeExtension on FuelType {
  String get displayName {
    switch (this) {
      case FuelType.gasoline:
        return 'Gasoline';
      case FuelType.diesel:
        return 'Diesel';
      case FuelType.electric:
        return 'Electric';
      case FuelType.hybrid:
        return 'Hybrid';
      case FuelType.plugInHybrid:
        return 'Plug-in Hybrid';
      case FuelType.hydrogen:
        return 'Hydrogen';
      case FuelType.cng:
        return 'CNG';
      case FuelType.lpg:
        return 'LPG';
    }
  }
}

extension BodyTypeExtension on BodyType {
  String get displayName {
    switch (this) {
      case BodyType.sedan:
        return 'Sedan';
      case BodyType.suv:
        return 'SUV';
      case BodyType.hatchback:
        return 'Hatchback';
      case BodyType.pickup:
        return 'Pickup';
      case BodyType.van:
        return 'Van';
      case BodyType.coupe:
        return 'Coupe';
      case BodyType.mpv:
        return 'MPV';
      case BodyType.convertible:
        return 'Convertible';
      case BodyType.wagon:
        return 'Wagon';
      case BodyType.truck:
        return 'Truck';
      case BodyType.minivan:
        return 'Minivan';
      case BodyType.crossover:
        return 'Crossover';
    }
  }
}

extension CarConditionExtension on CarCondition {
  String get displayName {
    switch (this) {
      case CarCondition.brandNew:
        return 'Brand New';
      case CarCondition.almostNew:
        return 'Almost New';
      case CarCondition.used:
        return 'Used';
      case CarCondition.certified:
        return 'Certified Pre-Owned';
      case CarCondition.forParts:
        return 'For Parts';
    }
  }

  String get description {
    switch (this) {
      case CarCondition.brandNew:
        return 'Never been registered, comes with manufacturer warranty';
      case CarCondition.almostNew:
        return 'Less than 1 year old with minimal mileage';
      case CarCondition.used:
        return 'Previously owned vehicle in good condition';
      case CarCondition.certified:
        return 'Certified by dealership with extended warranty';
      case CarCondition.forParts:
        return 'Not roadworthy, suitable for parts or restoration';
    }
  }
}

extension ListingStatusExtension on ListingStatus {
  String get displayName {
    switch (this) {
      case ListingStatus.draft:
        return 'Draft';
      case ListingStatus.pendingReview:
        return 'Pending Review';
      case ListingStatus.active:
        return 'Active';
      case ListingStatus.sold:
        return 'Sold';
      case ListingStatus.cancelled:
        return 'Cancelled';
    }
  }
}

extension EngineTypeExtension on EngineType {
  String get displayName {
    switch (this) {
      case EngineType.inline:
        return 'Inline';
      case EngineType.vType:
        return 'V-Type';
      case EngineType.boxer:
        return 'Boxer';
      case EngineType.rotary:
        return 'Rotary';
      case EngineType.electric:
        return 'Electric Motor';
    }
  }
}

extension DriveTypeExtension on DriveType {
  String get displayName {
    switch (this) {
      case DriveType.fwd:
        return 'FWD';
      case DriveType.rwd:
        return 'RWD';
      case DriveType.awd:
        return 'AWD';
      case DriveType.fourWd:
        return '4WD';
    }
  }

  String get fullName {
    switch (this) {
      case DriveType.fwd:
        return 'Front-Wheel Drive';
      case DriveType.rwd:
        return 'Rear-Wheel Drive';
      case DriveType.awd:
        return 'All-Wheel Drive';
      case DriveType.fourWd:
        return 'Four-Wheel Drive';
    }
  }
}

extension PaintTypeExtension on PaintType {
  String get displayName {
    switch (this) {
      case PaintType.solid:
        return 'Solid';
      case PaintType.metallic:
        return 'Metallic';
      case PaintType.pearlescent:
        return 'Pearlescent';
      case PaintType.matte:
        return 'Matte';
    }
  }
}

extension RimTypeExtension on RimType {
  String get displayName {
    switch (this) {
      case RimType.steel:
        return 'Steel';
      case RimType.alloy:
        return 'Alloy';
      case RimType.forged:
        return 'Forged';
    }
  }
}

extension TireConditionExtension on TireCondition {
  String get displayName {
    switch (this) {
      case TireCondition.newTires:
        return 'New';
      case TireCondition.good:
        return 'Good';
      case TireCondition.fair:
        return 'Fair';
      case TireCondition.needsReplacement:
        return 'Needs Replacement';
    }
  }
}

extension RegistrationStatusExtension on RegistrationStatus {
  String get displayName {
    switch (this) {
      case RegistrationStatus.current:
        return 'Current';
      case RegistrationStatus.expiringSoon:
        return 'Expiring Soon';
      case RegistrationStatus.expired:
        return 'Expired';
    }
  }
}
