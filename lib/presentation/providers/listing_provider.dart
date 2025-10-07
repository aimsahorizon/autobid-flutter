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
  EngineType _engineType = EngineType.inline;
  int _cylinders = 4;
  int _horsepower = 150;
  int _torque = 200;
  TransmissionType? _transmission;
  int _transmissionSpeeds = 6;
  DriveType _driveType = DriveType.fwd;
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
  PaintType _paintType = PaintType.solid;
  int _rimSize = 16;
  RimType _rimType = RimType.alloy;
  TireCondition _tireCondition = TireCondition.good;

  // CONDITION & HISTORY
  CarCondition? _condition;
  int? _mileage;
  int _numberOfOwners = 1;
  bool _hasAccidentHistory = false;
  bool _floodDamage = false;
  bool _serviceHistoryComplete = false;
  bool _warrantyRemaining = false;
  DateTime? _registrationExpiry;

  // LOCATION & AVAILABILITY
  String? _city;
  String? _province;
  bool _availableForTestDrive = false;
  bool _deliveryAvailable = false;

  // DOCUMENTATION
  String? _plateNumber;
  String? _orcrNumber;
  RegistrationStatus _registrationStatus = RegistrationStatus.current;
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
  int _lastCompletedStep = 0; // Track last completed step for drafts

  // Getters
  // BASIC INFO
  String? get brand => _brand;
  String? get model => _model;
  String? get variant => _variant;
  int? get year => _year;

  // MECHANICAL
  String? get engineSize => _engineSize;
  EngineType get engineType => _engineType;
  int get cylinders => _cylinders;
  int get horsepower => _horsepower;
  int get torque => _torque;
  TransmissionType? get transmission => _transmission;
  int get transmissionSpeeds => _transmissionSpeeds;
  DriveType get driveType => _driveType;
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
  PaintType get paintType => _paintType;
  int get rimSize => _rimSize;
  RimType get rimType => _rimType;
  TireCondition get tireCondition => _tireCondition;

  // CONDITION & HISTORY
  CarCondition? get condition => _condition;
  int? get mileage => _mileage;
  int get numberOfOwners => _numberOfOwners;
  bool get hasAccidentHistory => _hasAccidentHistory;
  bool get floodDamage => _floodDamage;
  bool get serviceHistoryComplete => _serviceHistoryComplete;
  bool get warrantyRemaining => _warrantyRemaining;
  DateTime? get registrationExpiry => _registrationExpiry;

  // LOCATION & AVAILABILITY
  String? get city => _city;
  String? get province => _province;
  bool get availableForTestDrive => _availableForTestDrive;
  bool get deliveryAvailable => _deliveryAvailable;

  // DOCUMENTATION
  String? get plateNumber => _plateNumber;
  String? get orcrNumber => _orcrNumber;
  RegistrationStatus get registrationStatus => _registrationStatus;
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

  void setEngineType(EngineType value) {
    _engineType = value;
    notifyListeners();
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

  void setDriveType(DriveType value) {
    _driveType = value;
    notifyListeners();
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

  void setPaintType(PaintType value) {
    _paintType = value;
    notifyListeners();
  }

  void setRimSize(int value) {
    _rimSize = value;
    notifyListeners();
  }

  void setRimType(RimType value) {
    _rimType = value;
    notifyListeners();
  }

  void setTireCondition(TireCondition value) {
    _tireCondition = value;
    notifyListeners();
  }

  void setFloodDamage(bool value) {
    _floodDamage = value;
    notifyListeners();
  }

  void setWarrantyRemaining(bool value) {
    _warrantyRemaining = value;
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
    return _engineSize != null &&
        _engineSize!.isNotEmpty &&
        _transmission != null &&
        _fuelType != null;
  }

  bool validateStep3() {
    // Dimensions & Capacity
    return _bodyType != null;
  }

  bool validateStep4() {
    // Exterior Details
    return _color != null && _color!.isNotEmpty;
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
    final listing = CarModel(
      id: _editingListingId ?? 'car-${DateTime.now().millisecondsSinceEpoch}',
      sellerId: userId,
      sellerName: userName,
      // BASIC INFO
      brand: _brand!,
      model: _model!,
      variant: _variant!,
      year: _year!,
      // MECHANICAL
      engineSize: _engineSize!,
      engineType: _engineType,
      cylinders: _cylinders,
      horsepower: _horsepower,
      torque: _torque,
      transmission: _transmission!,
      transmissionSpeeds: _transmissionSpeeds,
      driveType: _driveType,
      fuelType: _fuelType!,
      fuelConsumption: _fuelConsumption,
      electricRange: _electricRange,
      batteryCapacity: _batteryCapacity,
      chargingTime: _chargingTime,
      // DIMENSIONS & CAPACITY
      bodyType: _bodyType!,
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
      // EXTERIOR
      color: _color!,
      paintType: _paintType,
      rimSize: _rimSize,
      rimType: _rimType,
      tireCondition: _tireCondition,
      // CONDITION & HISTORY
      condition: _condition!,
      mileage: _mileage!,
      numberOfOwners: _numberOfOwners,
      hasAccidentHistory: _hasAccidentHistory,
      floodDamage: _floodDamage,
      serviceHistoryComplete: _serviceHistoryComplete,
      warrantyRemaining: _warrantyRemaining,
      registrationExpiry: _registrationExpiry,
      // LOCATION & AVAILABILITY
      location: CarLocation(city: _city!, province: _province!),
      availableForTestDrive: _availableForTestDrive,
      deliveryAvailable: _deliveryAvailable,
      // DOCUMENTATION
      plateNumber: _plateNumber!,
      orcrNumber: _orcrNumber!,
      registrationStatus: _registrationStatus,
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
    _serviceHistoryComplete = car.serviceHistoryComplete;
    _warrantyRemaining = car.warrantyRemaining;
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
    _engineType = EngineType.inline;
    _cylinders = 4;
    _horsepower = 150;
    _torque = 200;
    _transmission = null;
    _transmissionSpeeds = 6;
    _driveType = DriveType.fwd;
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
    _paintType = PaintType.solid;
    _rimSize = 16;
    _rimType = RimType.alloy;
    _tireCondition = TireCondition.good;
    // CONDITION & HISTORY
    _condition = null;
    _mileage = null;
    _numberOfOwners = 1;
    _hasAccidentHistory = false;
    _floodDamage = false;
    _serviceHistoryComplete = false;
    _warrantyRemaining = false;
    _registrationExpiry = null;
    // LOCATION & AVAILABILITY
    _city = null;
    _province = null;
    _availableForTestDrive = false;
    _deliveryAvailable = false;
    // DOCUMENTATION
    _plateNumber = null;
    _orcrNumber = null;
    _registrationStatus = RegistrationStatus.current;
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
    _lastCompletedStep = 0;
    notifyListeners();
  }

  // Save draft with current step
  Future<CarModel> saveDraft(String userId, String userName, int completedStep) async {
    _lastCompletedStep = completedStep;

    final draft = await createListing(userId, userName, isDraft: true);

    // Update the listing with the last completed step info
    // In production, this would be saved to backend

    return draft;
  }

  // Set last completed step (for draft restoration)
  void setLastCompletedStep(int step) {
    _lastCompletedStep = step;
    notifyListeners();
  }
}
