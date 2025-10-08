import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/models/transaction_model.dart';
import '../../data/services/mock/mock_payment_service.dart';

class TransactionProvider with ChangeNotifier {
  final MockPaymentService _paymentService = MockPaymentService();

  Transaction? _currentTransaction;
  List<Transaction> _userTransactions = [];
  bool _isLoading = false;
  String? _error;

  Transaction? get currentTransaction => _currentTransaction;
  List<Transaction> get userTransactions => _userTransactions;
  bool get isLoading => _isLoading;
  String? get error => _error;

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

  Future<void> loadUserTransactions(String userId, {bool? asBuyer}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _userTransactions = await _paymentService.getUserTransactions(
        userId: userId,
        asBuyer: asBuyer,
      );
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> releaseEscrow(String transactionId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _currentTransaction = await _paymentService.releaseEscrow(transactionId);
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> uploadPaymentProof(String transactionId, XFile imageFile) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // In a real app, this would upload to storage and update transaction
      // For now, we'll just simulate success
      await Future.delayed(const Duration(milliseconds: 500));
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
      _currentTransaction =
          await _paymentService.markAsShipped(transactionId);
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
}
