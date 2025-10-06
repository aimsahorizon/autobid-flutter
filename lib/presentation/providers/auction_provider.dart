import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../data/models/auction_model.dart';
import '../../data/models/bid_model.dart';
import '../../data/models/auto_bid_config.dart';
import '../../data/services/mock/mock_auction_service.dart';

class AuctionProvider with ChangeNotifier {
  final MockAuctionService _service = MockAuctionService();

  List<Auction> _activeAuctions = [];
  List<Bid> _userBids = [];
  List<Auction> _watchlist = [];
  Auction? _selectedAuction;
  List<Bid> _bidHistory = [];
  bool _isLoading = false;
  String? _error;

  Timer? _updateTimer;
  StreamSubscription? _auctionSubscription;
  StreamSubscription? _bidSubscription;

  // ignore: prefer_final_fields
  String? _currentUserId = 'current_user_123'; // Mock user ID

  // Getters
  List<Auction> get activeAuctions => _activeAuctions;
  List<Bid> get userBids => _userBids;
  List<Auction> get watchlist => _watchlist;
  Auction? get selectedAuction => _selectedAuction;
  List<Bid> get bidHistory => _bidHistory;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get currentUserId => _currentUserId;

  AuctionProvider() {
    _service.initialize();
    _setupListeners();
    loadAuctions();
  }

  void _setupListeners() {
    _auctionSubscription = _service.auctionsStream.listen((auctions) {
      _activeAuctions = auctions.where((a) =>
        a.status == AuctionStatus.live || a.status == AuctionStatus.upcoming
      ).toList()..sort((a, b) => a.endTime.compareTo(b.endTime));

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

    // Update every 5 seconds for real-time feel
    _updateTimer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (_selectedAuction != null) {
        loadAuctionDetail(_selectedAuction!.id);
      }
      if (_currentUserId != null) {
        _userBids = _service.getUserBids(_currentUserId!);
        _watchlist = _service.getUserWatchlist(_currentUserId!);
      }
    });
  }

  Future<void> loadAuctions() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await Future.delayed(Duration(milliseconds: 300)); // Simulate network delay
      _activeAuctions = _service.getActiveAuctions();
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

  Future<void> loadAuctionDetail(String auctionId) async {
    try {
      _selectedAuction = _service.getAuctionById(auctionId);
      _bidHistory = _service.getAuctionBids(auctionId);
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
