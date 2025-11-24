import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../data/models/auction_model.dart';
import '../../data/models/bid_model.dart';
import '../../data/models/auto_bid_config.dart';
import '../../data/models/search_filters.dart';
import '../../data/services/mock/mock_auction_service.dart';
import '../../config/app_config.dart';

class AuctionProvider with ChangeNotifier {
  final MockAuctionService _service = MockAuctionService();

  List<Auction> _allAuctions = [];
  List<Auction> _activeAuctions = [];
  List<Bid> _userBids = [];
  List<Auction> _watchlist = [];
  Auction? _selectedAuction;
  List<Bid> _bidHistory = [];
  bool _isLoading = false;
  String? _error;
  SearchFilters _filters = const SearchFilters();

  Timer? _updateTimer;
  StreamSubscription? _auctionSubscription;
  StreamSubscription? _bidSubscription;

  // ignore: prefer_final_fields
  String? _currentUserId = AppConfig.demoUserId; // Use demo user ID from config

  // Getters
  List<Auction> get activeAuctions => _activeAuctions;
  List<Bid> get userBids => _userBids;
  List<Auction> get watchlist => _watchlist;
  Auction? get selectedAuction => _selectedAuction;
  List<Bid> get bidHistory => _bidHistory;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get currentUserId => _currentUserId;
  SearchFilters get filters => _filters;
  bool get hasActiveFilters => !_filters.isEmpty;
  int get activeFilterCount => _filters.activeFilterCount;

  AuctionProvider() {
    _service.initialize();
    _setupListeners();
    loadAuctions();
  }

  void _setupListeners() {
    _auctionSubscription = _service.auctionsStream.listen((auctions) {
      _allAuctions = auctions.where((a) =>
        a.status == AuctionStatus.live || a.status == AuctionStatus.upcoming
      ).toList();
      _applyFiltersAndSort();

      if (_selectedAuction != null) {
        _selectedAuction = auctions.firstWhere(
          (a) => a.id == _selectedAuction!.id,
          orElse: () => _selectedAuction!,
        );
      }

      notifyListeners();
    });

    _bidSubscription = _service.bidsStream.listen((bids) {
      if (_selectedAuction != null) {
        _bidHistory = bids
            .where((b) => b.auctionId == _selectedAuction!.id)
            .toList()
          ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
      }

      if (_currentUserId != null) {
        _userBids = _service.getUserBids(_currentUserId!);
      }

      notifyListeners();
    });

    // Optimized: Use stream updates instead of polling
    // Stream already provides real-time updates from mock service
    // Only refresh user-specific data every 10 seconds (not 5)
    _updateTimer = Timer.periodic(Duration(seconds: 10), (timer) {
      if (_currentUserId != null) {
        // Only update user-specific data, not all auctions
        final updatedBids = _service.getUserBids(_currentUserId!);
        final updatedWatchlist = _service.getUserWatchlist(_currentUserId!);

        // Only notify if data actually changed
        if (updatedBids.length != _userBids.length ||
            updatedWatchlist.length != _watchlist.length) {
          _userBids = updatedBids;
          _watchlist = updatedWatchlist;
          notifyListeners();
        }
      }
    });
  }

  Future<void> loadAuctions() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await Future.delayed(Duration(milliseconds: 100)); // Optimized: Reduced from 300ms
      _allAuctions = _service.getActiveAuctions();
      _applyFiltersAndSort();
      if (_currentUserId != null) {
        _userBids = _service.getUserBids(_currentUserId!);
        _watchlist = _service.getUserWatchlist(_currentUserId!);
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void applyFilters({required SearchFilters filters}) {
    _filters = filters;
    _applyFiltersAndSort();
    notifyListeners();
  }

  void clearFilters() {
    _filters = const SearchFilters();
    _applyFiltersAndSort();
    notifyListeners();
  }

  void _applyFiltersAndSort() {
    var filtered = List<Auction>.from(_allAuctions);

    // Filter by car properties
    filtered = filtered.where((auction) {
      final car = auction.car;
      if (car == null) return true; // Include auctions without car data

      // Filter by brands
      if (_filters.brands.isNotEmpty) {
        final brandMatch = _filters.brands.any((brand) =>
          car.brand.toLowerCase().contains(brand.toLowerCase())
        );
        if (!brandMatch) return false;
      }

      // Filter by year range
      if (_filters.yearMin != null && car.year < _filters.yearMin!) {
        return false;
      }
      if (_filters.yearMax != null && car.year > _filters.yearMax!) {
        return false;
      }

      // Filter by mileage
      if (_filters.mileageMax != null && car.mileage > _filters.mileageMax!) {
        return false;
      }

      // Filter by transmission
      if (_filters.transmission.isNotEmpty) {
        final transmissionMatch = _filters.transmission.contains(car.transmission);
        if (!transmissionMatch) return false;
      }

      // Filter by fuel type
      if (_filters.fuelType.isNotEmpty) {
        final fuelMatch = _filters.fuelType.contains(car.fuelType);
        if (!fuelMatch) return false;
      }

      // Filter by body type
      if (_filters.bodyType.isNotEmpty) {
        final bodyMatch = _filters.bodyType.contains(car.bodyType);
        if (!bodyMatch) return false;
      }

      // Filter by location (city/province)
      if (_filters.city != null) {
        if (!car.location.city.toLowerCase().contains(_filters.city!.toLowerCase())) {
          return false;
        }
      }
      if (_filters.province != null) {
        if (!car.location.province.toLowerCase().contains(_filters.province!.toLowerCase())) {
          return false;
        }
      }

      return true;
    }).toList();

    // Apply sorting
    _activeAuctions = _sortAuctions(filtered);
  }

  List<Auction> _sortAuctions(List<Auction> auctions) {
    final sorted = List<Auction>.from(auctions);

    switch (_filters.sortBy) {
      case SortBy.priceAsc:
        sorted.sort((a, b) => a.currentBid.compareTo(b.currentBid));
        break;
      case SortBy.priceDesc:
        sorted.sort((a, b) => b.currentBid.compareTo(a.currentBid));
        break;
      case SortBy.endingSoon:
        sorted.sort((a, b) => a.endTime.compareTo(b.endTime));
        break;
      case SortBy.newest:
        sorted.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      default:
        sorted.sort((a, b) => a.endTime.compareTo(b.endTime));
    }

    return sorted;
  }

  Future<void> loadAuctionDetail(String auctionId, {bool isCarId = false}) async {
    try {
      if (isCarId) {
        _selectedAuction = _service.getAuctionByCarId(auctionId);
      } else {
        _selectedAuction = _service.getAuctionById(auctionId);
      }

      if (_selectedAuction != null) {
        _bidHistory = _service.getAuctionBids(_selectedAuction!.id);
      }
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<bool> placeBid(String auctionId, double amount) async {
    if (_currentUserId == null) return false;

    try {
      final success = await _service.placeBid(
        auctionId: auctionId,
        userId: _currentUserId!,
        amount: amount,
      );

      if (success) {
        await loadAuctionDetail(auctionId);
        _userBids = _service.getUserBids(_currentUserId!);
      }

      return success;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  void setupAutoBid(String auctionId, AutoBidConfig config) {
    if (_currentUserId == null) return;

    _service.setupAutoBid(auctionId, _currentUserId!, config);
    notifyListeners();
  }

  AutoBidConfig? getAutoBidConfig(String auctionId) {
    if (_currentUserId == null) return null;
    return _service.getAutoBidConfig(auctionId, _currentUserId!);
  }

  void watchAuction(String auctionId) {
    if (_currentUserId == null) return;

    _service.watchAuction(auctionId, _currentUserId!);
    _watchlist = _service.getUserWatchlist(_currentUserId!);
    notifyListeners();
  }

  void unwatchAuction(String auctionId) {
    if (_currentUserId == null) return;

    _service.unwatchAuction(auctionId, _currentUserId!);
    _watchlist = _service.getUserWatchlist(_currentUserId!);
    notifyListeners();
  }

  bool isWatching(String auctionId) {
    return _watchlist.any((a) => a.id == auctionId);
  }

  BidStatus? getUserBidStatus(String auctionId) {
    final userBidsForAuction = _userBids
        .where((b) => b.auctionId == auctionId)
        .toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));

    return userBidsForAuction.isNotEmpty ? userBidsForAuction.first.status : null;
  }

  double? getUserBidAmount(String auctionId) {
    final userBidsForAuction = _userBids
        .where((b) => b.auctionId == auctionId)
        .toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));

    return userBidsForAuction.isNotEmpty ? userBidsForAuction.first.amount : null;
  }

  List<Auction> getUserActiveAuctions() {
    if (_currentUserId == null) return [];
    return _service.getUserActiveAuctions(_currentUserId!);
  }

  List<Auction> getUserWonAuctions() {
    if (_currentUserId == null) return [];
    return _service.getUserWonAuctions(_currentUserId!);
  }

  List<Auction> getUserLostAuctions() {
    if (_currentUserId == null) return [];
    return _service.getUserLostAuctions(_currentUserId!);
  }

  @override
  void dispose() {
    _updateTimer?.cancel();
    _auctionSubscription?.cancel();
    _bidSubscription?.cancel();
    _service.dispose();
    super.dispose();
  }
}
