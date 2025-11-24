import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/models/payment_method.dart';
import '../../data/models/transaction_model.dart';
import '../../data/services/mock/mock_payment_service.dart';

class PaymentProvider with ChangeNotifier {
  final MockPaymentService _paymentService = MockPaymentService();

  PaymentMethod? _selectedPaymentMethod;
  Transaction? _currentTransaction;
  List<Transaction> _buyerTransactions = [];
  List<Transaction> _sellerTransactions = [];
  bool _isLoading = false;
  String? _error;
  XFile? _paymentProof;
  String _paymentReference = '';

  PaymentMethod? get selectedPaymentMethod => _selectedPaymentMethod;
  Transaction? get currentTransaction => _currentTransaction;
  List<Transaction> get buyerTransactions => _buyerTransactions;
  List<Transaction> get sellerTransactions => _sellerTransactions;
  bool get isLoading => _isLoading;
  String? get error => _error;
  XFile? get paymentProof => _paymentProof;
  String get paymentReference => _paymentReference;

  void setSelectedPaymentMethod(PaymentMethod method) {
    _selectedPaymentMethod = method;
    notifyListeners();
  }

  void setPaymentReference(String reference) {
    _paymentReference = reference;
    notifyListeners();
  }

  void setPaymentProof(XFile? file) {
    _paymentProof = file;
    notifyListeners();
  }

  Future<void> createTransaction({
    required String auctionId,
    required String carId,
    required String buyerId,
    required String sellerId,
    required String buyerName,
    required String sellerName,
    required String carTitle,
    required double amount,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _currentTransaction = await _paymentService.createTransaction(
        auctionId: auctionId,
        carId: carId,
        buyerId: buyerId,
        sellerId: sellerId,
        buyerName: buyerName,
        sellerName: sellerName,
        carTitle: carTitle,
        amount: amount,
      );
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> submitPayment() async {
    if (_currentTransaction == null || _selectedPaymentMethod == null) {
      _error = 'Missing transaction or payment method';
      notifyListeners();
      return false;
    }

    if (_paymentReference.isEmpty) {
      _error = 'Payment reference is required';
      notifyListeners();
      return false;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _currentTransaction = await _paymentService.submitPayment(
        transactionId: _currentTransaction!.id,
        method: _selectedPaymentMethod!.type,
        reference: _paymentReference,
        proofUrl: _paymentProof?.path,
      );
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadTransaction(String id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _currentTransaction = await _paymentService.getTransaction(id);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadUserTransactions(String userId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _buyerTransactions = await _paymentService.getUserTransactions(
        userId: userId,
        asBuyer: true,
      );
      _sellerTransactions = await _paymentService.getUserTransactions(
        userId: userId,
        asBuyer: false,
      );
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Transaction? getTransactionByAuctionId(String auctionId) {
    // Check buyer transactions first
    try {
      return _buyerTransactions.firstWhere((t) => t.auctionId == auctionId);
    } catch (e) {
      // If not found in buyer, check seller
      try {
        return _sellerTransactions.firstWhere((t) => t.auctionId == auctionId);
      } catch (e) {
        return null;
      }
    }
  }

  int getPendingActionsCount(String userId) {
    int count = 0;

    // Pending payments (buyer)
    count += _buyerTransactions
        .where((t) => t.escrowStatus == EscrowStatus.pending)
        .length;

    // Awaiting confirmation (buyer with held status)
    count += _buyerTransactions
        .where((t) => t.escrowStatus == EscrowStatus.held)
        .length;

    return count;
  }

  Future<bool> confirmReceipt(String transactionId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final transaction = await _paymentService.releaseEscrow(transactionId);
      _currentTransaction = transaction;
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> requestRefund(String transactionId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final transaction = await _paymentService.refundEscrow(transactionId);
      _currentTransaction = transaction;
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> markAsShipped(String transactionId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final transaction =
          await _paymentService.markAsShipped(transactionId);
      _currentTransaction = transaction;
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> submitTransferEvidence(String transactionId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Submit evidence and start validation process
      final transaction = await _paymentService.submitTransferEvidenceAndValidate(transactionId);
      _currentTransaction = transaction;

      // Reload transactions to reflect new status
      await loadUserTransactions('user123');

      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void reset() {
    _selectedPaymentMethod = null;
    _currentTransaction = null;
    _paymentProof = null;
    _paymentReference = '';
    _error = null;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
