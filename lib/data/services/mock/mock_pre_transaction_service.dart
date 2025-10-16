import 'dart:async';
import 'package:uuid/uuid.dart';
import '../../models/pre_transaction_model.dart';
import '../../models/pre_transaction_message_model.dart';
import '../../models/pre_transaction_confirmation_model.dart';
import '../../models/transaction_model.dart';

class MockPreTransactionService {
  final _uuid = const Uuid();
  final Map<String, PreTransaction> _preTransactions = {};
  final _preTransactionController = StreamController<List<PreTransaction>>.broadcast();

  Stream<List<PreTransaction>> get preTransactionsStream => _preTransactionController.stream;

  /// Create a new pre-transaction after auction win
  Future<PreTransaction> createPreTransaction({
    required String auctionId,
    required String carId,
    required String carTitle,
    required String buyerId,
    required String sellerId,
    required String buyerName,
    required String sellerName,
    required double finalBidAmount,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay

    final id = _uuid.v4();
    final now = DateTime.now();

    // Create initial system messages
    final messages = [
      PreTransactionMessage(
        id: _uuid.v4(),
        preTransactionId: id,
        sender: MessageSender.system,
        senderName: 'System',
        type: MessageType.system,
        content: 'Auction ended. Congratulations on winning! Please discuss delivery details and confirm the transaction.',
        timestamp: now,
      ),
      PreTransactionMessage(
        id: _uuid.v4(),
        preTransactionId: id,
        sender: MessageSender.seller,
        senderName: sellerName,
        type: MessageType.text,
        content: 'Congratulations! The vehicle is ready for transfer. Let\'s discuss the delivery arrangements.',
        timestamp: now.add(const Duration(minutes: 2)),
      ),
    ];

    final preTransaction = PreTransaction(
      id: id,
      auctionId: auctionId,
      carId: carId,
      carTitle: carTitle,
      buyerId: buyerId,
      sellerId: sellerId,
      buyerName: buyerName,
      sellerName: sellerName,
      finalBidAmount: finalBidAmount,
      status: PreTransactionStatus.inDiscussion,
      messages: messages,
      createdAt: now,
      discussionStartedAt: now,
    );

    _preTransactions[id] = preTransaction;
    _notifyListeners();

    return preTransaction;
  }

  /// Get pre-transaction by ID
  PreTransaction? getPreTransaction(String id) {
    return _preTransactions[id];
  }

  /// Get pre-transaction by auction ID
  PreTransaction? getPreTransactionByAuctionId(String auctionId) {
    return _preTransactions.values.firstWhere(
      (pt) => pt.auctionId == auctionId,
      orElse: () => throw Exception('PreTransaction not found'),
    );
  }

  /// Add a message to the discussion
  Future<PreTransactionMessage> addMessage({
    required String preTransactionId,
    required MessageSender sender,
    required String senderName,
    required String content,
    MessageType type = MessageType.text,
    String? imageUrl,
    String? fileName,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final preTransaction = _preTransactions[preTransactionId];
    if (preTransaction == null) {
      throw Exception('PreTransaction not found');
    }

    final message = PreTransactionMessage(
      id: _uuid.v4(),
      preTransactionId: preTransactionId,
      sender: sender,
      senderName: senderName,
      type: type,
      content: content,
      imageUrl: imageUrl,
      fileName: fileName,
      timestamp: DateTime.now(),
    );

    final updatedMessages = [...preTransaction.messages, message];
    _preTransactions[preTransactionId] = preTransaction.copyWith(
      messages: updatedMessages,
    );

    _notifyListeners();
    return message;
  }

  /// Submit buyer confirmation
  Future<PreTransaction> submitBuyerConfirmation({
    required String preTransactionId,
    required String buyerId,
    required String buyerName,
    required bool vehicleDetailsConfirmed,
    PaymentMethodType? preferredPaymentMethod,
    String? deliveryDate,
    String? deliveryLocation,
    List<String> uploadedDocuments = const [],
    required bool termsAgreed,
    String? notes,
  }) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate processing

    final preTransaction = _preTransactions[preTransactionId];
    if (preTransaction == null) {
      throw Exception('PreTransaction not found');
    }

    final confirmation = PreTransactionConfirmation(
      id: _uuid.v4(),
      userId: buyerId,
      userName: buyerName,
      vehicleDetailsConfirmed: vehicleDetailsConfirmed,
      preferredPaymentMethod: preferredPaymentMethod,
      deliveryDate: deliveryDate,
      deliveryLocation: deliveryLocation,
      uploadedDocuments: uploadedDocuments,
      termsAgreed: termsAgreed,
      confirmedAt: DateTime.now(),
      notes: notes,
    );

    final now = DateTime.now();
    final updatedMessages = [
      ...preTransaction.messages,
      PreTransactionMessage(
        id: _uuid.v4(),
        preTransactionId: preTransactionId,
        sender: MessageSender.system,
        senderName: 'System',
        type: MessageType.system,
        content: 'Buyer has submitted confirmation. Waiting for seller confirmation...',
        timestamp: now,
      ),
    ];

    _preTransactions[preTransactionId] = preTransaction.copyWith(
      buyerConfirmation: confirmation,
      buyerConfirmedAt: now,
      status: PreTransactionStatus.pendingSellerConfirmation,
      messages: updatedMessages,
    );

    _notifyListeners();

    // Simulate seller auto-confirmation after 5 seconds
    _simulateSellerConfirmation(preTransactionId);

    return _preTransactions[preTransactionId]!;
  }

  /// Simulate seller confirmation (for demo purposes)
  Future<void> _simulateSellerConfirmation(String preTransactionId) async {
    await Future.delayed(const Duration(seconds: 5));

    final preTransaction = _preTransactions[preTransactionId];
    if (preTransaction == null || preTransaction.sellerConfirmation != null) {
      return;
    }

    final confirmation = PreTransactionConfirmation(
      id: _uuid.v4(),
      userId: preTransaction.sellerId,
      userName: preTransaction.sellerName,
      vehicleDetailsConfirmed: true,
      deliveryDate: preTransaction.buyerConfirmation?.deliveryDate,
      deliveryLocation: preTransaction.buyerConfirmation?.deliveryLocation,
      uploadedDocuments: [],
      termsAgreed: true,
      confirmedAt: DateTime.now(),
      notes: 'Ready to proceed with the transaction.',
    );

    final now = DateTime.now();
    final updatedMessages = [
      ...preTransaction.messages,
      PreTransactionMessage(
        id: _uuid.v4(),
        preTransactionId: preTransactionId,
        sender: MessageSender.system,
        senderName: 'System',
        type: MessageType.system,
        content: 'Both parties have confirmed! You can now proceed to payment.',
        timestamp: now,
      ),
    ];

    _preTransactions[preTransactionId] = preTransaction.copyWith(
      sellerConfirmation: confirmation,
      sellerConfirmedAt: now,
      mutualConfirmationAt: now,
      status: PreTransactionStatus.readyForPayment,
      readyForPaymentAt: now,
      messages: updatedMessages,
    );

    _notifyListeners();
  }

  /// Get all pre-transactions for a user
  List<PreTransaction> getUserPreTransactions(String userId) {
    return _preTransactions.values
        .where((pt) => pt.buyerId == userId || pt.sellerId == userId)
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  /// Cancel pre-transaction
  Future<void> cancelPreTransaction({
    required String preTransactionId,
    required String reason,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final preTransaction = _preTransactions[preTransactionId];
    if (preTransaction == null) {
      throw Exception('PreTransaction not found');
    }

    final now = DateTime.now();
    _preTransactions[preTransactionId] = preTransaction.copyWith(
      status: PreTransactionStatus.cancelled,
      cancellationReason: reason,
      cancelledAt: now,
    );

    _notifyListeners();
  }

  void _notifyListeners() {
    _preTransactionController.add(_preTransactions.values.toList());
  }

  void dispose() {
    _preTransactionController.close();
  }
}
