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
        return 'Electric';
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
      case RegistrationStatus.forRenewal:
        return 'For Renewal';
      case RegistrationStatus.pendingRenewal:
        return 'Pending Renewal';
      case RegistrationStatus.delinquent:
        return 'Delinquent';
      case RegistrationStatus.underAlarm:
        return 'Under Alarm';
      case RegistrationStatus.carnapped:
        return 'Carnapped';
      case RegistrationStatus.other:
        return 'Other';
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
}
