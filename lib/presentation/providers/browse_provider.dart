import 'dart:async';
import 'package:flutter/material.dart';
import '../../data/models/car_model.dart';
import '../../data/models/search_filters.dart';
import '../../data/services/mock/mock_car_service.dart';

class BrowseProvider extends ChangeNotifier {
  final MockCarService _carService;

  BrowseProvider(this._carService);

  // State
  List<CarModel> _allCars = [];
  List<CarModel> _filteredCars = [];
  SearchFilters _searchFilters = const SearchFilters();
  String _searchKeyword = '';
  bool _isLoading = false;
  String? _error;

  // Debounce timer for search
  Timer? _debounceTimer;

  // Getters
  List<CarModel> get allCars => _allCars;
  List<CarModel> get filteredCars => _filteredCars;
  SearchFilters get searchFilters => _searchFilters;
  String get searchKeyword => _searchKeyword;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasActiveFilters => _searchFilters.activeFilterCount > 0;
  int get activeFilterCount => _searchFilters.activeFilterCount;

  // Load all cars
  Future<void> loadAllCars() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _allCars = await _carService.getAllActiveCars();
      _filteredCars = _allCars;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Apply filters
  Future<void> applyFilters({SearchFilters? filters}) async {
    if (filters != null) {
      _searchFilters = filters;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _filteredCars = await _carService.searchCars(_searchFilters);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Clear filters
  Future<void> clearFilters() async {
    _searchFilters = const SearchFilters();
    _searchKeyword = '';
    await applyFilters();
  }

  // Search with debounce
  void searchCars(String keyword) {
    _searchKeyword = keyword;

    // Cancel previous timer
    _debounceTimer?.cancel();

    // Start new timer
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      // Update filters with keyword
      _searchFilters = _searchFilters.copyWith(keyword: keyword.isEmpty ? null : keyword);
      applyFilters();
    });

    notifyListeners();
  }

  // Update specific filter
  void updateFilters(SearchFilters filters) {
    _searchFilters = filters;
    notifyListeners();
  }

  // Update brands filter
  void toggleBrand(String brand) {
    final brands = List<String>.from(_searchFilters.brands);
    if (brands.contains(brand)) {
      brands.remove(brand);
    } else {
      brands.add(brand);
    }
    _searchFilters = _searchFilters.copyWith(brands: brands);
    notifyListeners();
  }

  // Update transmission filter
  void toggleTransmission(TransmissionType transmission) {
    final transmissions = List<TransmissionType>.from(_searchFilters.transmission);
    if (transmissions.contains(transmission)) {
      transmissions.remove(transmission);
    } else {
      transmissions.add(transmission);
    }
    _searchFilters = _searchFilters.copyWith(transmission: transmissions);
    notifyListeners();
  }

  // Update fuel type filter
  void toggleFuelType(FuelType fuelType) {
    final fuelTypes = List<FuelType>.from(_searchFilters.fuelType);
    if (fuelTypes.contains(fuelType)) {
      fuelTypes.remove(fuelType);
    } else {
      fuelTypes.add(fuelType);
    }
    _searchFilters = _searchFilters.copyWith(fuelType: fuelTypes);
    notifyListeners();
  }

  // Update body type filter
  void toggleBodyType(BodyType bodyType) {
    final bodyTypes = List<BodyType>.from(_searchFilters.bodyType);
    if (bodyTypes.contains(bodyType)) {
      bodyTypes.remove(bodyType);
    } else {
      bodyTypes.add(bodyType);
    }
    _searchFilters = _searchFilters.copyWith(bodyType: bodyTypes);
    notifyListeners();
  }

  // Update sort
  void updateSort(SortBy sortBy) {
    _searchFilters = _searchFilters.copyWith(sortBy: sortBy);
    applyFilters();
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}
