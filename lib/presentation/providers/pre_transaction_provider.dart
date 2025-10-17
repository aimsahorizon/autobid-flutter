import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../data/models/pre_transaction_model.dart';
import '../../data/models/pre_transaction_message_model.dart';
import '../../data/services/mock/mock_pre_transaction_service.dart';

class PreTransactionProvider with ChangeNotifier {
  final MockPreTransactionService _service = MockPreTransactionService();

  PreTransaction? _currentPreTransaction;
  List<PreTransaction> _userPreTransactions = [];
  bool _isLoading = false;
  String? _error;

  StreamSubscription? _preTransactionSubscription;

  // Getters
  PreTransaction? get currentPreTransaction => _currentPreTransaction;
  List<PreTransaction> get userPreTransactions => _userPreTransactions;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isReadyForPayment =>
      _currentPreTransaction?.status == PreTransactionStatus.readyForPayment;
  bool get isBuyerConfirmed => _currentPreTransaction?.buyerConfirmation != null;
  bool get isSellerConfirmed => _currentPreTransaction?.sellerConfirmation != null;

  PreTransactionProvider() {
    _setupListeners();
  }

  void _setupListeners() {
    _preTransactionSubscription = _service.preTransactionsStream.listen((preTransactions) {
      if (_currentPreTransaction != null) {
        try {
          _currentPreTransaction = preTransactions.firstWhere(
            (pt) => pt.id == _currentPreTransaction!.id,
          );
        } catch (e) {
          // PreTransaction not found in stream
        }
      }
      notifyListeners();
    });
  }

  /// Create a new pre-transaction after auction win
  Future<PreTransaction?> createPreTransaction({
    required String auctionId,
    required String carId,
    required String carTitle,
    required String buyerId,
    required String sellerId,
    required String buyerName,
    required String sellerName,
    required double finalBidAmount,
  }) async {
    _isLoading = true;
    _error = null; // Clear any previous errors
    notifyListeners();

    try {
      final preTransaction = await _service.createPreTransaction(
        auctionId: auctionId,
        carId: carId,
        carTitle: carTitle,
        buyerId: buyerId,
        sellerId: sellerId,
        buyerName: buyerName,
        sellerName: sellerName,
        finalBidAmount: finalBidAmount,
      );

      _currentPreTransaction = preTransaction;
      _error = null; // Ensure error is cleared on success
      return preTransaction;
    } catch (e) {
      _error = e.toString();
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Load a pre-transaction by ID
  Future<void> loadPreTransaction(String id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await Future.delayed(const Duration(milliseconds: 300)); // Simulate loading
      _currentPreTransaction = _service.getPreTransaction(id);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Load pre-transaction by auction ID
  /// Returns true if found, false if not found (no error state set)
  Future<bool> loadPreTransactionByAuctionId(String auctionId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await Future.delayed(const Duration(milliseconds: 300));
      _currentPreTransaction = _service.getPreTransactionByAuctionId(auctionId);
      return true;
    } catch (e) {
      // Don't set error for "not found" - this is expected on first load
      _currentPreTransaction = null;
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Add a new message to the discussion
  Future<bool> addMessage({
    required MessageSender sender,
    required String senderName,
    required String content,
    MessageType type = MessageType.text,
    String? imageUrl,
    String? fileName,
  }) async {
    if (_currentPreTransaction == null) return false;

    try {
      await _service.addMessage(
        preTransactionId: _currentPreTransaction!.id,
        sender: sender,
        senderName: senderName,
        content: content,
        type: type,
        imageUrl: imageUrl,
        fileName: fileName,
      );

      // Reload to get updated messages
      await loadPreTransaction(_currentPreTransaction!.id);
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  /// Submit buyer confirmation
  Future<bool> submitBuyerConfirmation({
    required String buyerId,
    required String buyerName,
    required Map<String, dynamic> formData,
  }) async {
    if (_currentPreTransaction == null) return false;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final updatedPreTransaction = await _service.submitBuyerConfirmation(
        preTransactionId: _currentPreTransaction!.id,
        buyerId: buyerId,
        buyerName: buyerName,
        formData: formData,
      );

      _currentPreTransaction = updatedPreTransaction;
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Submit seller confirmation
  Future<bool> submitSellerConfirmation({
    required String sellerId,
    required String sellerName,
    required Map<String, dynamic> formData,
  }) async {
    if (_currentPreTransaction == null) return false;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final updatedPreTransaction = await _service.submitSellerConfirmation(
        preTransactionId: _currentPreTransaction!.id,
        sellerId: sellerId,
        sellerName: sellerName,
        formData: formData,
      );

      _currentPreTransaction = updatedPreTransaction;
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Load user's pre-transactions
  Future<void> loadUserPreTransactions(String userId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await Future.delayed(const Duration(milliseconds: 300));
      _userPreTransactions = _service.getUserPreTransactions(userId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Request edit during combined review phase
  Future<bool> requestEdit({
    required String requestedBy, // 'buyer' or 'seller'
    required String field,
    required String currentValue,
    required String requestedValue,
    required String reason,
  }) async {
    if (_currentPreTransaction == null) return false;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final updatedPreTransaction = await _service.requestEdit(
        preTransactionId: _currentPreTransaction!.id,
        requestedBy: requestedBy,
        field: field,
        currentValue: currentValue,
        requestedValue: requestedValue,
        reason: reason,
      );

      _currentPreTransaction = updatedPreTransaction;
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Approve mutual review (buyer or seller)
  Future<bool> approveMutualReview({
    required String approvedBy, // 'buyer' or 'seller'
  }) async {
    if (_currentPreTransaction == null) return false;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final updatedPreTransaction = await _service.approveMutualReview(
        preTransactionId: _currentPreTransaction!.id,
        approvedBy: approvedBy,
      );

      _currentPreTransaction = updatedPreTransaction;
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Cancel pre-transaction
  Future<bool> cancelPreTransaction(String reason) async {
    if (_currentPreTransaction == null) return false;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _service.cancelPreTransaction(
        preTransactionId: _currentPreTransaction!.id,
        reason: reason,
      );

      await loadPreTransaction(_currentPreTransaction!.id);
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Clear confirmation to allow editing
  Future<bool> clearConfirmation({
    required bool clearBuyer,
    required bool clearSeller,
  }) async {
    if (_currentPreTransaction == null) return false;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final updatedPreTransaction = await _service.clearConfirmation(
        preTransactionId: _currentPreTransaction!.id,
        clearBuyer: clearBuyer,
        clearSeller: clearSeller,
      );

      _currentPreTransaction = updatedPreTransaction;
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  void clearCurrentPreTransaction() {
    _currentPreTransaction = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _preTransactionSubscription?.cancel();
    _service.dispose();
    super.dispose();
  }
}
