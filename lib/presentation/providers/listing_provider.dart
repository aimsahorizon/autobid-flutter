import 'package:flutter/material.dart';
import '../../data/models/car_model.dart';
import '../../data/services/mock/mock_car_service.dart';

class ListingProvider extends ChangeNotifier {
  final MockCarService _carService;

  ListingProvider(this._carService);

  // Form state for creating/editing listings
  // BASIC INFO
  String? _brand;
  String? _model;
  String? _variant;
  int? _year;

  // MECHANICAL
  String? _engineSize;
  EngineType? _engineType;
  int _cylinders = 4;
  int _horsepower = 150;
  int _torque = 200;
  TransmissionType? _transmission;
  int _transmissionSpeeds = 6;
  DriveType? _driveType;
  FuelType? _fuelType;
  double _fuelConsumption = 7.5;
  int? _electricRange;
  double? _batteryCapacity;
  String? _chargingTime;

  // DIMENSIONS & CAPACITY
  BodyType? _bodyType;
  int _doors = 4;
  int _seats = 5;
  int _curbWeight = 1500;
  int _grossWeight = 2000;
  int _cargoCapacity = 500;
  int? _towingCapacity;
  int? _groundClearance;
  int _length = 4500;
  int _width = 1800;
  int _height = 1500;
  int _wheelbase = 2700;

  // EXTERIOR
  String? _color;
  PaintType? _paintType;
  int _rimSize = 16;
  RimType? _rimType;
  TireCondition _tireCondition = TireCondition.good;

  // CONDITION & HISTORY
  CarCondition? _condition;
  int? _mileage;
  int _numberOfOwners = 1;
  bool _hasAccidentHistory = false;
  bool _floodDamage = false;
  bool _fireDamage = false;
  bool _frameDamage = false;
  bool _isRepainted = false;
  bool _hasModifications = false;
  bool _originalParts = true;
  bool _commercialUse = false;
  bool _smokerVehicle = false;
  bool _serviceHistoryComplete = false;
  DateTime? _registrationExpiry;

  // CUSTOM CONDITION ATTRIBUTES
  // Stores user-added attributes not in predefined list
  // Key: attribute ID (camelCase), Value: toggle state
  Map<String, bool> _customConditionAttributes = {};

  // CUSTOM CONDITION ATTRIBUTES LIST
  // Stores metadata about custom attributes (label, description, category)
  List<Map<String, dynamic>> _customConditionAttributesList = [];

  // LOCATION & AVAILABILITY
  String? _city;
  String? _province;
  bool _availableForTestDrive = false;
  bool _deliveryAvailable = false;

  // DOCUMENTATION
  String? _plateNumber;
  String? _orcrNumber;
  RegistrationStatus _registrationStatus = RegistrationStatus.current;
  String? _registrationStatusOther;
  bool _emissionTestValid = true;
  bool _comprehensiveInsurance = false;

  // SELLER PREFERENCES
  bool _acceptsTrade = false;
  bool _financingAvailable = false;
  bool _priceNegotiable = false;

  // DESCRIPTION
  String _description = '';
  String? _issues;

  // MEDIA
  List<String> _images = [];
  Map<String, List<String>> _categorizedImages = {};
  List<String> _features = [];

  // CUSTOM FEATURES
  // Stores user-added features not in predefined list
  List<String> _customFeatures = [];

  // CUSTOM ENUM VALUES
  // Stores user-added custom values for enum types
  List<String> _customEngineTypes = [];
  List<String> _customTransmissionTypes = [];
  List<String> _customDriveTypes = [];
  List<String> _customFuelTypes = [];
  List<String> _customBodyTypes = [];
  List<String> _customPaintTypes = [];
  List<String> _customRimTypes = [];

  // SELECTED CUSTOM VALUES
  // Tracks which custom values are currently selected
  String? _selectedCustomEngineType;
  String? _selectedCustomTransmission;
  String? _selectedCustomDriveType;
  String? _selectedCustomFuelType;
  String? _selectedCustomBodyType;
  String? _selectedCustomPaintType;
  String? _selectedCustomRimType;

  // Auction settings
  bool _isAuction = false;
  double? _auctionStartingPrice;
  double? _auctionReservePrice;
  int? _auctionDurationDays;
  double? _auctionBuyNowPrice;

  // My Listings state
  List<CarModel> _myListings = [];
  bool _isLoadingListings = false;
  String? _error;

  // Current listing being edited
  String? _editingListingId;

  // Draft management
  int _lastCompletedStep = 0;
  int _currentStep = 1;

  // Getters
  // BASIC INFO
  String? get brand => _brand;
  String? get model => _model;
  String? get variant => _variant;
  int? get year => _year;

  // MECHANICAL
  String? get engineSize => _engineSize;
  EngineType? get engineType => _engineType;
  int get cylinders => _cylinders;
  int get horsepower => _horsepower;
  int get torque => _torque;
  TransmissionType? get transmission => _transmission;
  int get transmissionSpeeds => _transmissionSpeeds;
  DriveType? get driveType => _driveType;
  FuelType? get fuelType => _fuelType;
  double get fuelConsumption => _fuelConsumption;
  int? get electricRange => _electricRange;
  double? get batteryCapacity => _batteryCapacity;
  String? get chargingTime => _chargingTime;

  // DIMENSIONS & CAPACITY
  BodyType? get bodyType => _bodyType;
  int get doors => _doors;
  int get seats => _seats;
  int get curbWeight => _curbWeight;
  int get grossWeight => _grossWeight;
  int get cargoCapacity => _cargoCapacity;
  int? get towingCapacity => _towingCapacity;
  int? get groundClearance => _groundClearance;
  int get length => _length;
  int get width => _width;
  int get height => _height;
  int get wheelbase => _wheelbase;

  // EXTERIOR
  String? get color => _color;
  PaintType? get paintType => _paintType;
  int get rimSize => _rimSize;
  RimType? get rimType => _rimType;
  TireCondition get tireCondition => _tireCondition;

  // CONDITION & HISTORY
  CarCondition? get condition => _condition;
  int? get mileage => _mileage;
  int get numberOfOwners => _numberOfOwners;
  bool get hasAccidentHistory => _hasAccidentHistory;
  bool get floodDamage => _floodDamage;
  bool get fireDamage => _fireDamage;
  bool get frameDamage => _frameDamage;
  bool get isRepainted => _isRepainted;
  bool get hasModifications => _hasModifications;
  bool get originalParts => _originalParts;
  bool get commercialUse => _commercialUse;
  bool get smokerVehicle => _smokerVehicle;
  bool get serviceHistoryComplete => _serviceHistoryComplete;
  DateTime? get registrationExpiry => _registrationExpiry;
  Map<String, bool> get customConditionAttributes => _customConditionAttributes;
  List<Map<String, dynamic>> get customConditionAttributesList => _customConditionAttributesList;

  // LOCATION & AVAILABILITY
  String? get city => _city;
  String? get province => _province;
  bool get availableForTestDrive => _availableForTestDrive;
  bool get deliveryAvailable => _deliveryAvailable;

  // DOCUMENTATION
  String? get plateNumber => _plateNumber;
  String? get orcrNumber => _orcrNumber;
  RegistrationStatus get registrationStatus => _registrationStatus;
  String? get registrationStatusOther => _registrationStatusOther;
  bool get emissionTestValid => _emissionTestValid;
  bool get comprehensiveInsurance => _comprehensiveInsurance;

  // SELLER PREFERENCES
  bool get acceptsTrade => _acceptsTrade;
  bool get financingAvailable => _financingAvailable;
  bool get priceNegotiable => _priceNegotiable;

  // DESCRIPTION
  String get description => _description;
  String? get issues => _issues;

  // MEDIA
  List<String> get images => _images;
  Map<String, List<String>> get categorizedImages => _categorizedImages;
  List<String> get features => _features;
  List<String> get customFeatures => _customFeatures;
  List<String> get customEngineTypes => _customEngineTypes;
  List<String> get customTransmissionTypes => _customTransmissionTypes;
  List<String> get customDriveTypes => _customDriveTypes;
  List<String> get customFuelTypes => _customFuelTypes;
  List<String> get customBodyTypes => _customBodyTypes;
  List<String> get customPaintTypes => _customPaintTypes;
  List<String> get customRimTypes => _customRimTypes;
  String? get selectedCustomEngineType => _selectedCustomEngineType;
  String? get selectedCustomTransmission => _selectedCustomTransmission;
  String? get selectedCustomDriveType => _selectedCustomDriveType;
  String? get selectedCustomFuelType => _selectedCustomFuelType;
  String? get selectedCustomBodyType => _selectedCustomBodyType;
  String? get selectedCustomPaintType => _selectedCustomPaintType;
  String? get selectedCustomRimType => _selectedCustomRimType;

  bool get isAuction => _isAuction;
  double? get auctionStartingPrice => _auctionStartingPrice;
  double? get auctionReservePrice => _auctionReservePrice;
  int? get auctionDurationDays => _auctionDurationDays;
  double? get auctionBuyNowPrice => _auctionBuyNowPrice;

  List<CarModel> get myListings => _myListings;
  bool get isLoadingListings => _isLoadingListings;
  String? get error => _error;
  int get lastCompletedStep => _lastCompletedStep;
  String? get editingListingId => _editingListingId;
  bool get isEditing => _editingListingId != null;
  int get currentStep => _currentStep;

  void setCurrentStep(int step) {
    _currentStep = step;
  }

  // Setters for form fields
  void setBrand(String? value) {
    _brand = value;
    notifyListeners();
  }

  void setModel(String? value) {
    _model = value;
    notifyListeners();
  }

  void setVariant(String? value) {
    _variant = value;
    notifyListeners();
  }

  void setYear(int? value) {
    _year = value;
    notifyListeners();
  }

  void setMileage(int? value) {
    _mileage = value;
    notifyListeners();
  }

  void setTransmission(TransmissionType? value) {
    _transmission = value;
    notifyListeners();
  }

  void setFuelType(FuelType? value) {
    _fuelType = value;
    notifyListeners();
  }

  void setBodyType(BodyType? value) {
    _bodyType = value;
    notifyListeners();
  }

  void setColor(String? value) {
    _color = value;
    notifyListeners();
  }

  void setEngineSize(String? value) {
    _engineSize = value;
    notifyListeners();
  }

  void setEngineType(EngineType? value) {
    if (value != null) {
      _engineType = value;
      notifyListeners();
    }
  }

  void setCylinders(int value) {
    _cylinders = value;
    notifyListeners();
  }

  void setHorsepower(int value) {
    _horsepower = value;
    notifyListeners();
  }

  void setTorque(int value) {
    _torque = value;
    notifyListeners();
  }

  void setTransmissionSpeeds(int value) {
    _transmissionSpeeds = value;
    notifyListeners();
  }

  void setDriveType(DriveType? value) {
    if (value != null) {
      _driveType = value;
      notifyListeners();
    }
  }

  void setFuelConsumption(double value) {
    _fuelConsumption = value;
    notifyListeners();
  }

  void setElectricRange(int? value) {
    _electricRange = value;
    notifyListeners();
  }

  void setBatteryCapacity(double? value) {
    _batteryCapacity = value;
    notifyListeners();
  }

  void setChargingTime(String? value) {
    _chargingTime = value;
    notifyListeners();
  }

  void setSeats(int value) {
    _seats = value;
    notifyListeners();
  }

  void setDoors(int value) {
    _doors = value;
    notifyListeners();
  }

  void setCurbWeight(int value) {
    _curbWeight = value;
    notifyListeners();
  }

  void setGrossWeight(int value) {
    _grossWeight = value;
    notifyListeners();
  }

  void setCargoCapacity(int value) {
    _cargoCapacity = value;
    notifyListeners();
  }

  void setTowingCapacity(int? value) {
    _towingCapacity = value;
    notifyListeners();
  }

  void setGroundClearance(int? value) {
    _groundClearance = value;
    notifyListeners();
  }

  void setLength(int value) {
    _length = value;
    notifyListeners();
  }

  void setWidth(int value) {
    _width = value;
    notifyListeners();
  }

  void setHeight(int value) {
    _height = value;
    notifyListeners();
  }

  void setWheelbase(int value) {
    _wheelbase = value;
    notifyListeners();
  }

  void setPaintType(PaintType? value) {
    if (value != null) {
      _paintType = value;
      notifyListeners();
    }
  }

  void setRimSize(int value) {
    _rimSize = value;
    notifyListeners();
  }

  void setRimType(RimType? value) {
    if (value != null) {
      _rimType = value;
      notifyListeners();
    }
  }

  void setTireCondition(TireCondition value) {
    _tireCondition = value;
    notifyListeners();
  }

  void setFloodDamage(bool value) {
    _floodDamage = value;
    notifyListeners();
  }

  void setRegistrationExpiry(DateTime? value) {
    _registrationExpiry = value;
    notifyListeners();
  }

  void setAvailableForTestDrive(bool value) {
    _availableForTestDrive = value;
    notifyListeners();
  }

  void setDeliveryAvailable(bool value) {
    _deliveryAvailable = value;
    notifyListeners();
  }

  void setRegistrationStatus(RegistrationStatus value) {
    _registrationStatus = value;
    // Clear the other field if not "other"
    if (value != RegistrationStatus.other) {
      _registrationStatusOther = null;
    }
    notifyListeners();
  }

  void setRegistrationStatusOther(String? value) {
    _registrationStatusOther = value;
    notifyListeners();
  }

  void setEmissionTestValid(bool value) {
    _emissionTestValid = value;
    notifyListeners();
  }

  void setComprehensiveInsurance(bool value) {
    _comprehensiveInsurance = value;
    notifyListeners();
  }

  void setAcceptsTrade(bool value) {
    _acceptsTrade = value;
    notifyListeners();
  }

  void setFinancingAvailable(bool value) {
    _financingAvailable = value;
    notifyListeners();
  }

  void setPriceNegotiable(bool value) {
    _priceNegotiable = value;
    notifyListeners();
  }

  void setPlateNumber(String? value) {
    _plateNumber = value;
    notifyListeners();
  }

  void setOrcrNumber(String? value) {
    _orcrNumber = value;
    notifyListeners();
  }

  void setCity(String? value) {
    _city = value;
    notifyListeners();
  }

  void setProvince(String? value) {
    _province = value;
    notifyListeners();
  }

  void setNumberOfOwners(int value) {
    _numberOfOwners = value;
    notifyListeners();
  }

  void setServiceHistoryComplete(bool value) {
    _serviceHistoryComplete = value;
    notifyListeners();
  }

  void setHasAccidentHistory(bool value) {
    _hasAccidentHistory = value;
    notifyListeners();
  }

  void setFireDamage(bool value) {
    _fireDamage = value;
    notifyListeners();
  }

  void setFrameDamage(bool value) {
    _frameDamage = value;
    notifyListeners();
  }

  void setIsRepainted(bool value) {
    _isRepainted = value;
    notifyListeners();
  }

  void setHasModifications(bool value) {
    _hasModifications = value;
    notifyListeners();
  }

  void setOriginalParts(bool value) {
    _originalParts = value;
    notifyListeners();
  }

  void setCommercialUse(bool value) {
    _commercialUse = value;
    notifyListeners();
  }

  void setSmokerVehicle(bool value) {
    _smokerVehicle = value;
    notifyListeners();
  }

  void setCustomConditionAttribute(String id, bool value) {
    _customConditionAttributes[id] = value;
    notifyListeners();
  }

  void addCustomConditionAttribute({
    required String id,
    required String label,
    required String description,
    required String category,
  }) {
    // Check if attribute already exists
    final exists = _customConditionAttributesList.any((attr) => attr['id'] == id);
    if (!exists) {
      _customConditionAttributesList.add({
        'id': id,
        'label': label,
        'description': description,
        'category': category,
        'addedAt': DateTime.now().toIso8601String(),
      });
      // Initialize with false value
      _customConditionAttributes[id] = false;
      notifyListeners();
    }
  }

  void removeCustomConditionAttribute(String id) {
    _customConditionAttributesList.removeWhere((attr) => attr['id'] == id);
    _customConditionAttributes.remove(id);
    notifyListeners();
  }

  void setCondition(CarCondition? value) {
    _condition = value;
    notifyListeners();
  }

  void setDescription(String value) {
    _description = value;
    notifyListeners();
  }

  void setIssues(String? value) {
    _issues = value;
    notifyListeners();
  }

  void setImages(List<String> value) {
    _images = value;
    notifyListeners();
  }

  void addImage(String image) {
    _images.add(image);
    notifyListeners();
  }

  void removeImage(String image) {
    _images.remove(image);
    notifyListeners();
  }

  void reorderImages(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final image = _images.removeAt(oldIndex);
    _images.insert(newIndex, image);
    notifyListeners();
  }

  void setCategorizedImages(Map<String, List<String>> value) {
    _categorizedImages = value;
    notifyListeners();
  }

  void addCategorizedImage(String category, String imageUrl) {
    if (_categorizedImages[category] == null) {
      _categorizedImages[category] = [];
    }
    _categorizedImages[category]!.add(imageUrl);
    notifyListeners();
  }

  void removeCategorizedImage(String category, String imageUrl) {
    _categorizedImages[category]?.remove(imageUrl);
    notifyListeners();
  }

  void reorderCategorizedImages(String category, int oldIndex, int newIndex) {
    final images = _categorizedImages[category];
    if (images == null) return;

    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final image = images.removeAt(oldIndex);
    images.insert(newIndex, image);
    notifyListeners();
  }

  void setFeatures(List<String> value) {
    _features = value;
    notifyListeners();
  }

  void toggleFeature(String feature) {
    if (_features.contains(feature)) {
      _features.remove(feature);
    } else {
      _features.add(feature);
    }
    notifyListeners();
  }

  void addCustomFeature(String feature) {
    if (!_customFeatures.contains(feature)) {
      _customFeatures.add(feature);
      // Also add to regular features list
      _features.add(feature);
      notifyListeners();
    }
  }

  void removeCustomFeature(String feature) {
    _customFeatures.remove(feature);
    _features.remove(feature);
    notifyListeners();
  }

  void addCustomEngineType(String type) {
    if (!_customEngineTypes.contains(type)) {
      _customEngineTypes.add(type);
      notifyListeners();
    }
  }

  void addCustomTransmissionType(String type) {
    if (!_customTransmissionTypes.contains(type)) {
      _customTransmissionTypes.add(type);
      notifyListeners();
    }
  }

  void addCustomDriveType(String type) {
    if (!_customDriveTypes.contains(type)) {
      _customDriveTypes.add(type);
      notifyListeners();
    }
  }

  void addCustomFuelType(String type) {
    if (!_customFuelTypes.contains(type)) {
      _customFuelTypes.add(type);
      notifyListeners();
    }
  }

  void addCustomBodyType(String type) {
    if (!_customBodyTypes.contains(type)) {
      _customBodyTypes.add(type);
      notifyListeners();
    }
  }

  void addCustomPaintType(String type) {
    if (!_customPaintTypes.contains(type)) {
      _customPaintTypes.add(type);
      notifyListeners();
    }
  }

  void addCustomRimType(String type) {
    if (!_customRimTypes.contains(type)) {
      _customRimTypes.add(type);
      notifyListeners();
    }
  }

  // Setters for selected custom values
  void setSelectedCustomEngineType(String? value) {
    _selectedCustomEngineType = value;
    notifyListeners();
  }

  void setSelectedCustomTransmission(String? value) {
    _selectedCustomTransmission = value;
    notifyListeners();
  }

  void setSelectedCustomDriveType(String? value) {
    _selectedCustomDriveType = value;
    notifyListeners();
  }

  void setSelectedCustomFuelType(String? value) {
    _selectedCustomFuelType = value;
    notifyListeners();
  }

  void setSelectedCustomBodyType(String? value) {
    _selectedCustomBodyType = value;
    notifyListeners();
  }

  void setSelectedCustomPaintType(String? value) {
    _selectedCustomPaintType = value;
    notifyListeners();
  }

  void setSelectedCustomRimType(String? value) {
    _selectedCustomRimType = value;
    notifyListeners();
  }

  void setIsAuction(bool value) {
    _isAuction = value;
    notifyListeners();
  }

  void setAuctionSettings({
    required double startingPrice,
    required double reservePrice,
    required int durationDays,
    double? buyNowPrice,
  }) {
    _auctionStartingPrice = startingPrice;
    _auctionReservePrice = reservePrice;
    _auctionDurationDays = durationDays;
    _auctionBuyNowPrice = buyNowPrice;
    notifyListeners();
  }

  // Validation
  bool validateStep1() {
    return _brand != null &&
        _brand!.isNotEmpty &&
        _model != null &&
        _model!.isNotEmpty &&
        _variant != null &&
        _variant!.isNotEmpty &&
        _year != null;
  }

  bool validateStep2() {
    // Mechanical Specifications
    final hasEngineType = _engineType != null || _selectedCustomEngineType != null;
    final hasTransmission = _transmission != null || _selectedCustomTransmission != null;
    final hasDriveType = _driveType != null || _selectedCustomDriveType != null;
    final hasFuelType = _fuelType != null || _selectedCustomFuelType != null;

    return _engineSize != null &&
        _engineSize!.isNotEmpty &&
        hasEngineType &&
        hasTransmission &&
        hasDriveType &&
        hasFuelType;
  }

  bool validateStep3() {
    // Dimensions & Capacity
    return _bodyType != null || _selectedCustomBodyType != null;
  }

  bool validateStep4() {
    // Exterior Details
    final hasPaintType = _paintType != null || _selectedCustomPaintType != null;
    final hasRimType = _rimType != null || _selectedCustomRimType != null;
    return _color != null && _color!.isNotEmpty && hasPaintType && hasRimType;
  }

  bool validateStep5() {
    // Condition & History
    return _condition != null && _mileage != null;
  }

  bool validateStep6() {
    // Documentation & Location
    return _plateNumber != null &&
        _plateNumber!.isNotEmpty &&
        _orcrNumber != null &&
        _orcrNumber!.isNotEmpty &&
        _city != null &&
        _city!.isNotEmpty &&
        _province != null &&
        _province!.isNotEmpty;
  }

  bool validateStep7() {
    // Categorized Photos - check all required images
    final exteriorCount = _categorizedImages['exterior']?.length ?? 0;
    final interiorCount = _categorizedImages['interior']?.length ?? 0;
    final engineCount = _categorizedImages['engine']?.length ?? 0;
    final detailsCount = _categorizedImages['details']?.length ?? 0;

    return exteriorCount >= 15 &&
        interiorCount >= 12 &&
        engineCount >= 6 &&
        detailsCount >= 13;
  }

  bool validateStep8() {
    // Description & Features
    return _description.length >= 50;
  }

  // Create/Update listing
  Future<CarModel> createListing(String userId, String userName,
      {bool isDraft = false}) async {
    // For drafts, provide default values for required fields that might be null
    final listing = CarModel(
      id: _editingListingId ?? 'car-${DateTime.now().millisecondsSinceEpoch}',
      sellerId: userId,
      sellerName: userName,
      // BASIC INFO - Use defaults for drafts if null
      brand: _brand ?? 'Draft',
      model: _model ?? 'Draft',
      variant: _variant ?? 'Draft',
      year: _year ?? DateTime.now().year,
      // MECHANICAL - Use defaults for drafts if null
      engineSize: _engineSize ?? 'TBD',
      engineType: _engineType ?? EngineType.inline,
      cylinders: _cylinders,
      horsepower: _horsepower,
      torque: _torque,
      transmission: _transmission ?? TransmissionType.automatic,
      transmissionSpeeds: _transmissionSpeeds,
      driveType: _driveType ?? DriveType.fwd,
      fuelType: _fuelType ?? FuelType.gasoline,
      fuelConsumption: _fuelConsumption,
      electricRange: _electricRange,
      batteryCapacity: _batteryCapacity,
      chargingTime: _chargingTime,
      // DIMENSIONS & CAPACITY - Use defaults for drafts if null
      bodyType: _bodyType ?? BodyType.sedan,
      doors: _doors,
      seats: _seats,
      curbWeight: _curbWeight,
      grossWeight: _grossWeight,
      cargoCapacity: _cargoCapacity,
      towingCapacity: _towingCapacity,
      groundClearance: _groundClearance,
      length: _length,
      width: _width,
      height: _height,
      wheelbase: _wheelbase,
      // EXTERIOR - Use defaults for drafts if null
      color: _color ?? 'TBD',
      paintType: _paintType ?? PaintType.solid,
      rimSize: _rimSize,
      rimType: _rimType ?? RimType.alloy,
      tireCondition: _tireCondition,
      // CONDITION & HISTORY - Use defaults for drafts if null
      condition: _condition ?? CarCondition.used,
      mileage: _mileage ?? 0,
      numberOfOwners: _numberOfOwners,
      hasAccidentHistory: _hasAccidentHistory,
      floodDamage: _floodDamage,
      fireDamage: _fireDamage,
      frameDamage: _frameDamage,
      isRepainted: _isRepainted,
      hasModifications: _hasModifications,
      originalParts: _originalParts,
      commercialUse: _commercialUse,
      smokerVehicle: _smokerVehicle,
      serviceHistoryComplete: _serviceHistoryComplete,
      registrationExpiry: _registrationExpiry,
      // LOCATION & AVAILABILITY - Use defaults for drafts if null
      location: CarLocation(
        city: _city ?? 'TBD',
        province: _province ?? 'TBD',
      ),
      availableForTestDrive: _availableForTestDrive,
      deliveryAvailable: _deliveryAvailable,
      // DOCUMENTATION - Use defaults for drafts if null
      plateNumber: _plateNumber ?? 'TBD',
      orcrNumber: _orcrNumber ?? 'TBD',
      registrationStatus: _registrationStatus,
      registrationStatusOther: _registrationStatusOther,
      emissionTestValid: _emissionTestValid,
      comprehensiveInsurance: _comprehensiveInsurance,
      // SELLER PREFERENCES
      acceptsTrade: _acceptsTrade,
      financingAvailable: _financingAvailable,
      priceNegotiable: _priceNegotiable,
      // DESCRIPTION & MEDIA
      description: _description,
      issues: _issues,
      images: _images,
      categorizedImages: _categorizedImages,
      features: _features,
      status: isDraft ? ListingStatus.draft : ListingStatus.pendingReview,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    if (_editingListingId != null) {
      return await _carService.updateListing(_editingListingId!, listing);
    } else {
      return await _carService.createListing(listing);
    }
  }

  // Load listings
  Future<void> loadMyListings(String userId, {ListingStatus? status}) async {
    _isLoadingListings = true;
    _error = null;
    notifyListeners();

    try {
      _myListings = await _carService.getMyListings(userId, status: status);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoadingListings = false;
      notifyListeners();
    }
  }

  // Delete listing
  Future<void> deleteListing(String carId) async {
    try {
      await _carService.deleteListing(carId);
      _myListings.removeWhere((l) => l.id == carId);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  // Load listing for editing
  void loadListingForEdit(CarModel car) {
    _editingListingId = car.id;
    // BASIC INFO
    _brand = car.brand;
    _model = car.model;
    _variant = car.variant;
    _year = car.year;
    // MECHANICAL
    _engineSize = car.engineSize;
    _engineType = car.engineType;
    _cylinders = car.cylinders;
    _horsepower = car.horsepower;
    _torque = car.torque;
    _transmission = car.transmission;
    _transmissionSpeeds = car.transmissionSpeeds;
    _driveType = car.driveType;
    _fuelType = car.fuelType;
    _fuelConsumption = car.fuelConsumption;
    _electricRange = car.electricRange;
    _batteryCapacity = car.batteryCapacity;
    _chargingTime = car.chargingTime;
    // DIMENSIONS & CAPACITY
    _bodyType = car.bodyType;
    _doors = car.doors;
    _seats = car.seats;
    _curbWeight = car.curbWeight;
    _grossWeight = car.grossWeight;
    _cargoCapacity = car.cargoCapacity;
    _towingCapacity = car.towingCapacity;
    _groundClearance = car.groundClearance;
    _length = car.length;
    _width = car.width;
    _height = car.height;
    _wheelbase = car.wheelbase;
    // EXTERIOR
    _color = car.color;
    _paintType = car.paintType;
    _rimSize = car.rimSize;
    _rimType = car.rimType;
    _tireCondition = car.tireCondition;
    // CONDITION & HISTORY
    _condition = car.condition;
    _mileage = car.mileage;
    _numberOfOwners = car.numberOfOwners;
    _hasAccidentHistory = car.hasAccidentHistory;
    _floodDamage = car.floodDamage;
    _fireDamage = car.fireDamage;
    _frameDamage = car.frameDamage;
    _isRepainted = car.isRepainted;
    _hasModifications = car.hasModifications;
    _originalParts = car.originalParts;
    _commercialUse = car.commercialUse;
    _smokerVehicle = car.smokerVehicle;
    _serviceHistoryComplete = car.serviceHistoryComplete;
    _registrationExpiry = car.registrationExpiry;
    // LOCATION & AVAILABILITY
    _city = car.location.city;
    _province = car.location.province;
    _availableForTestDrive = car.availableForTestDrive;
    _deliveryAvailable = car.deliveryAvailable;
    // DOCUMENTATION
    _plateNumber = car.plateNumber;
    _orcrNumber = car.orcrNumber;
    _registrationStatus = car.registrationStatus;
    _registrationStatusOther = car.registrationStatusOther;
    _emissionTestValid = car.emissionTestValid;
    _comprehensiveInsurance = car.comprehensiveInsurance;
    // SELLER PREFERENCES
    _acceptsTrade = car.acceptsTrade;
    _financingAvailable = car.financingAvailable;
    _priceNegotiable = car.priceNegotiable;
    // DESCRIPTION & MEDIA
    _description = car.description;
    _issues = car.issues;
    _images = List.from(car.images);
    _categorizedImages = Map.from(car.categorizedImages);
    _features = List.from(car.features);

    // Calculate last completed step dynamically based on validation
    _lastCompletedStep = _calculateLastCompletedStep();

    notifyListeners();
  }

  /// Calculates the last completed step based on current validation state
  int _calculateLastCompletedStep() {
    int lastStep = 0;
    if (validateStep1()) lastStep = 1;
    if (validateStep2()) lastStep = 2;
    if (validateStep3()) lastStep = 3;
    if (validateStep4()) lastStep = 4;
    if (validateStep5()) lastStep = 5;
    if (validateStep6()) lastStep = 6;
    if (validateStep7()) lastStep = 7;
    if (validateStep8()) lastStep = 8;
    return lastStep;
  }

  // Reset form
  void reset() {
    _editingListingId = null;
    // BASIC INFO
    _brand = null;
    _model = null;
    _variant = null;
    _year = null;
    // MECHANICAL
    _engineSize = null;
    _engineType = null;
    _cylinders = 4;
    _horsepower = 150;
    _torque = 200;
    _transmission = null;
    _transmissionSpeeds = 6;
    _driveType = null;
    _fuelType = null;
    _fuelConsumption = 7.5;
    _electricRange = null;
    _batteryCapacity = null;
    _chargingTime = null;
    // DIMENSIONS & CAPACITY
    _bodyType = null;
    _doors = 4;
    _seats = 5;
    _curbWeight = 1500;
    _grossWeight = 2000;
    _cargoCapacity = 500;
    _towingCapacity = null;
    _groundClearance = null;
    _length = 4500;
    _width = 1800;
    _height = 1500;
    _wheelbase = 2700;
    // EXTERIOR
    _color = null;
    _paintType = null;
    _rimSize = 16;
    _rimType = null;
    _tireCondition = TireCondition.good;
    // CONDITION & HISTORY
    _condition = null;
    _mileage = null;
    _numberOfOwners = 1;
    _hasAccidentHistory = false;
    _floodDamage = false;
    _fireDamage = false;
    _frameDamage = false;
    _isRepainted = false;
    _hasModifications = false;
    _originalParts = true;
    _commercialUse = false;
    _smokerVehicle = false;
    _serviceHistoryComplete = false;
    _registrationExpiry = null;
    _customConditionAttributes = {};
    _customConditionAttributesList = [];
    // LOCATION & AVAILABILITY
    _city = null;
    _province = null;
    _availableForTestDrive = false;
    _deliveryAvailable = false;
    // DOCUMENTATION
    _plateNumber = null;
    _orcrNumber = null;
    _registrationStatus = RegistrationStatus.current;
    _registrationStatusOther = null;
    _emissionTestValid = true;
    _comprehensiveInsurance = false;
    // SELLER PREFERENCES
    _acceptsTrade = false;
    _financingAvailable = false;
    _priceNegotiable = false;
    // DESCRIPTION & MEDIA
    _description = '';
    _issues = null;
    _images = [];
    _categorizedImages = {};
    _features = [];
    _customFeatures = [];
    _customEngineTypes = [];
    _customTransmissionTypes = [];
    _customDriveTypes = [];
    _customFuelTypes = [];
    _customBodyTypes = [];
    _customPaintTypes = [];
    _customRimTypes = [];
    _selectedCustomEngineType = null;
    _selectedCustomTransmission = null;
    _selectedCustomDriveType = null;
    _selectedCustomFuelType = null;
    _selectedCustomBodyType = null;
    _selectedCustomPaintType = null;
    _selectedCustomRimType = null;
    _lastCompletedStep = 0;
    _currentStep = 1;
    notifyListeners();
  }

  // Save draft with current step
  Future<CarModel> saveDraft(String userId, String userName, int stepNumber) async {
    _lastCompletedStep = stepNumber;

    final draft = await createListing(userId, userName, isDraft: true);

    // Add or update the draft in the local listings
    final existingIndex = _myListings.indexWhere((l) => l.id == draft.id);
    if (existingIndex != -1) {
      // Update existing draft
      _myListings[existingIndex] = draft;
    } else {
      // Add new draft
      _myListings.insert(0, draft);
    }
    notifyListeners();

    return draft;
  }

  // Set last completed step (for draft restoration)
  void setLastCompletedStep(int step) {
    _lastCompletedStep = step;
    notifyListeners();
  }
}
