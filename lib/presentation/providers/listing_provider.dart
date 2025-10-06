import 'package:flutter/material.dart';
import '../../data/models/car_model.dart';
import '../../data/services/mock/mock_car_service.dart';

class ListingProvider extends ChangeNotifier {
  final MockCarService _carService;

  ListingProvider(this._carService);

  // Form state for creating/editing listings
  String? _brand;
  String? _model;
  String? _variant;
  int? _year;
  int? _mileage;
  TransmissionType? _transmission;
  FuelType? _fuelType;
  BodyType? _bodyType;
  String? _color;
  String? _engineSize;
  int _seats = 5;
  int _doors = 4;
  String? _plateNumber;
  String? _orcrNumber;
  String? _city;
  String? _province;
  int _numberOfOwners = 1;
  bool _serviceHistoryComplete = false;
  bool _hasAccidentHistory = false;
  CarCondition? _condition;
  String _description = '';
  String? _issues;
  List<String> _images = [];
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

  // Getters
  String? get brand => _brand;
  String? get model => _model;
  String? get variant => _variant;
  int? get year => _year;
  int? get mileage => _mileage;
  TransmissionType? get transmission => _transmission;
  FuelType? get fuelType => _fuelType;
  BodyType? get bodyType => _bodyType;
  String? get color => _color;
  String? get engineSize => _engineSize;
  int get seats => _seats;
  int get doors => _doors;
  String? get plateNumber => _plateNumber;
  String? get orcrNumber => _orcrNumber;
  String? get city => _city;
  String? get province => _province;
  int get numberOfOwners => _numberOfOwners;
  bool get serviceHistoryComplete => _serviceHistoryComplete;
  bool get hasAccidentHistory => _hasAccidentHistory;
  CarCondition? get condition => _condition;
  String get description => _description;
  String? get issues => _issues;
  List<String> get images => _images;
  List<String> get features => _features;

  bool get isAuction => _isAuction;
  double? get auctionStartingPrice => _auctionStartingPrice;
  double? get auctionReservePrice => _auctionReservePrice;
  int? get auctionDurationDays => _auctionDurationDays;
  double? get auctionBuyNowPrice => _auctionBuyNowPrice;

  List<CarModel> get myListings => _myListings;
  bool get isLoadingListings => _isLoadingListings;
  String? get error => _error;
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

  void setSeats(int value) {
    _seats = value;
    notifyListeners();
  }

  void setDoors(int value) {
    _doors = value;
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
    return _mileage != null &&
        _transmission != null &&
        _fuelType != null &&
        _bodyType != null &&
        _color != null &&
        _color!.isNotEmpty &&
        _engineSize != null &&
        _engineSize!.isNotEmpty;
  }

  bool validateStep3() {
    return _plateNumber != null &&
        _plateNumber!.isNotEmpty &&
        _orcrNumber != null &&
        _orcrNumber!.isNotEmpty &&
        _city != null &&
        _city!.isNotEmpty &&
        _province != null &&
        _province!.isNotEmpty;
  }

  bool validateStep4() {
    return _condition != null && _description.length >= 50;
  }

  bool validateStep5() {
    return _images.length >= 5;
  }

  // Create/Update listing
  Future<CarModel> createListing(String userId, String userName,
      {bool isDraft = false}) async {
    final listing = CarModel(
      id: _editingListingId ?? 'car-${DateTime.now().millisecondsSinceEpoch}',
      sellerId: userId,
      sellerName: userName,
      brand: _brand!,
      model: _model!,
      variant: _variant!,
      year: _year!,
      mileage: _mileage!,
      transmission: _transmission!,
      fuelType: _fuelType!,
      bodyType: _bodyType!,
      color: _color!,
      engineSize: _engineSize!,
      seats: _seats,
      doors: _doors,
      plateNumber: _plateNumber!,
      orcrNumber: _orcrNumber!,
      location: CarLocation(city: _city!, province: _province!),
      numberOfOwners: _numberOfOwners,
      serviceHistoryComplete: _serviceHistoryComplete,
      hasAccidentHistory: _hasAccidentHistory,
      condition: _condition!,
      description: _description,
      issues: _issues,
      images: _images,
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
    _brand = car.brand;
    _model = car.model;
    _variant = car.variant;
    _year = car.year;
    _mileage = car.mileage;
    _transmission = car.transmission;
    _fuelType = car.fuelType;
    _bodyType = car.bodyType;
    _color = car.color;
    _engineSize = car.engineSize;
    _seats = car.seats;
    _doors = car.doors;
    _plateNumber = car.plateNumber;
    _orcrNumber = car.orcrNumber;
    _city = car.location.city;
    _province = car.location.province;
    _numberOfOwners = car.numberOfOwners;
    _serviceHistoryComplete = car.serviceHistoryComplete;
    _hasAccidentHistory = car.hasAccidentHistory;
    _condition = car.condition;
    _description = car.description;
    _issues = car.issues;
    _images = List.from(car.images);
    _features = List.from(car.features);
    notifyListeners();
  }

  // Reset form
  void reset() {
    _editingListingId = null;
    _brand = null;
    _model = null;
    _variant = null;
    _year = null;
    _mileage = null;
    _transmission = null;
    _fuelType = null;
    _bodyType = null;
    _color = null;
    _engineSize = null;
    _seats = 5;
    _doors = 4;
    _plateNumber = null;
    _orcrNumber = null;
    _city = null;
    _province = null;
    _numberOfOwners = 1;
    _serviceHistoryComplete = false;
    _hasAccidentHistory = false;
    _condition = null;
    _description = '';
    _issues = null;
    _images = [];
    _features = [];
    notifyListeners();
  }
}
