import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/models/dispute_model.dart';
import '../../data/models/review_model.dart';
import '../../data/models/transaction_model.dart';
import '../../data/services/mock/mock_payment_service.dart';
import '../../data/services/mock/mock_review_service.dart';

class TransactionProvider with ChangeNotifier {
  final MockPaymentService _paymentService = MockPaymentService();
  final MockReviewService _reviewService = MockReviewService();

  Transaction? _currentTransaction;
  List<Transaction> _userTransactions = [];
  ReviewModel? _currentReview;
  bool _isLoading = false;
  String? _error;

  Transaction? get currentTransaction => _currentTransaction;
  List<Transaction> get userTransactions => _userTransactions;
  ReviewModel? get currentReview => _currentReview;
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

  Future<bool> requestRefund(
    String transactionId,
    RefundReason reason,
    String description,
    List<File> evidencePhotos,
  ) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _currentTransaction = await _paymentService.requestRefund(
        transactionId: transactionId,
        reason: reason,
        description: description,
        evidencePhotos: evidencePhotos,
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

  Future<bool> submitReview(
    String transactionId,
    double overallRating,
    double communicationRating,
    double accuracyRating,
    double conditionRating,
    double processRating,
    String? comment,
    bool isAnonymous,
  ) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Get transaction to extract buyerId and sellerId
      final transaction = _currentTransaction ??
          await _paymentService.getTransaction(transactionId);

      if (transaction == null) {
        throw Exception('Transaction not found');
      }

      _currentReview = await _reviewService.submitReview(
        transactionId: transactionId,
        buyerId: transaction.buyerId,
        sellerId: transaction.sellerId,
        overallRating: overallRating,
        communicationRating: communicationRating,
        accuracyRating: accuracyRating,
        conditionRating: conditionRating,
        processRating: processRating,
        comment: comment,
        isAnonymous: isAnonymous,
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

  Future<ReviewModel?> checkExistingReview(String transactionId) async {
    try {
      _currentReview =
          await _reviewService.getReviewByTransaction(transactionId);
      return _currentReview;
    } catch (e) {
      return null;
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
