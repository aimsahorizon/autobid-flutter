import 'package:flutter/foundation.dart';
import '../../data/models/auto_bid_config.dart';
import '../../data/models/auction_model.dart';
import '../../core/utils/bid_validator.dart';

class BidProvider with ChangeNotifier {
  double? _bidAmount;
  AutoBidConfig? _autoBidConfig;
  String? _validationError;

  double? get bidAmount => _bidAmount;
  AutoBidConfig? get autoBidConfig => _autoBidConfig;
  String? get validationError => _validationError;

  void setBidAmount(double? amount) {
    _bidAmount = amount;
    notifyListeners();
  }

  void setAutoBidConfig(AutoBidConfig? config) {
    _autoBidConfig = config;
    notifyListeners();
  }

  bool validateBid(double amount, Auction auction) {
    _validationError = BidValidator.validateBid(amount, auction);
    notifyListeners();
    return _validationError == null;
  }

  bool validateAutoBid(double maxBid, double currentBid, double? buyNowPrice) {
    _validationError = BidValidator.validateAutoBid(maxBid, currentBid, buyNowPrice);
    notifyListeners();
    return _validationError == null;
  }

  Future<bool> submitBid(
    Auction auction,
    double amount,
    Future<bool> Function(String, double) placeBidCallback,
  ) async {
    if (!validateBid(amount, auction)) {
      return false;
    }

    final success = await placeBidCallback(auction.id, amount);

    if (success) {
      _bidAmount = null;
      _validationError = null;
      notifyListeners();
    }

    return success;
  }

  void clearBidAmount() {
    _bidAmount = null;
    _validationError = null;
    notifyListeners();
  }

  void clearAutoBidConfig() {
    _autoBidConfig = null;
    notifyListeners();
  }

  void reset() {
    _bidAmount = null;
    _autoBidConfig = null;
    _validationError = null;
    notifyListeners();
  }
}
