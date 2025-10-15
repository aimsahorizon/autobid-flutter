import 'dart:io';
import '../../models/dispute_model.dart';
import '../../models/transaction_model.dart';
import '../../models/transaction_timeline.dart';
import '../../../core/utils/fee_calculator.dart';

class MockPaymentService {
  static final MockPaymentService _instance = MockPaymentService._internal();
  factory MockPaymentService() => _instance;
  MockPaymentService._internal();

  final List<Transaction> _transactions = [];

  Future<void> initialize() async {
    if (_transactions.isEmpty) {
      _transactions.addAll(_generateMockTransactions());
    }
  }

  Future<Transaction> createTransaction({
    required String auctionId,
    required String carId,
    required String buyerId,
    required String sellerId,
    required String buyerName,
    required String sellerName,
    required String carTitle,
    required double amount,
    double? listingFee, // Optional, fetched from auction if available
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    // Calculate comprehensive fee breakdown using tiered buyer's premium pricing
    // Buyer's Premium Model:
    // - Buyer pays: Sale Price + Transaction Fee
    // - Seller pays: Listing Fee only (deducted from proceeds)
    //
    // Transaction Fee Tiers:
    // - Economy (< ₱800k): 5% buyer's premium
    // - Mid-Range (₱800k - ₱2M): 4% buyer's premium
    // - Premium (> ₱2M): 3% buyer's premium
    final breakdown = FeeCalculator.getFeeBreakdown(
      salePrice: amount,
      includeListingFee: listingFee != null,
    );

    // platformFee = transaction fee paid by buyer
    final platformFee = breakdown.transactionFee;

    // totalAmount = sale price + transaction fee (buyer's total payment)
    final totalAmount = breakdown.totalBuyerAmount;

    final transaction = Transaction(
      id: 'TXN${DateTime.now().millisecondsSinceEpoch}',
      auctionId: auctionId,
      carId: carId,
      buyerId: buyerId,
      sellerId: sellerId,
      buyerName: buyerName,
      sellerName: sellerName,
      carTitle: carTitle,
      amount: amount, // Winning bid amount
      platformFee: platformFee, // Buyer's premium (transaction fee)
      totalAmount: totalAmount, // Total buyer pays (bid + premium)
      escrowStatus: EscrowStatus.pending,
      createdAt: DateTime.now(),
      timeline: [
        TransactionTimeline(
          status: 'created',
          timestamp: DateTime.now(),
          description: 'Transaction created',
          icon: 'receipt',
        ),
      ],
      // Detailed fee breakdown fields
      listingFee: listingFee ?? 0.0,
      transactionFeeRate: breakdown.transactionFeeRate,
      transactionFee: breakdown.transactionFee,
      priceTier: breakdown.priceTier,
      sellerPayout: breakdown.sellerReceives, // Seller gets bid - listing fee
    );

    _transactions.add(transaction);
    return transaction;
  }

  Future<Transaction> submitPayment({
    required String transactionId,
    required PaymentMethodType method,
    required String reference,
    String? proofUrl,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));

    final index = _transactions.indexWhere((t) => t.id == transactionId);
    if (index == -1) throw Exception('Transaction not found');

    final now = DateTime.now();
    final transaction = _transactions[index];

    final updatedTransaction = transaction.copyWith(
      paymentMethod: method,
      paymentReference: reference,
      paymentProof: proofUrl,
      paidAt: now,
      escrowStatus: EscrowStatus.held,
      timeline: [
        ...transaction.timeline,
        TransactionTimeline(
          status: 'payment_submitted',
          timestamp: now,
          description: 'Payment submitted and verified',
          icon: 'payment',
        ),
        TransactionTimeline(
          status: 'escrow_held',
          timestamp: now,
          description: 'Payment secured in escrow',
          icon: 'lock',
        ),
      ],
    );

    _transactions[index] = updatedTransaction;
    return updatedTransaction;
  }

  Future<Transaction?> getTransaction(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      return _transactions.firstWhere((t) => t.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<List<Transaction>> getUserTransactions({
    required String userId,
    bool? asBuyer,
  }) async {
    await Future.delayed(const Duration(milliseconds: 400));

    if (asBuyer == null) {
      return _transactions
          .where((t) => t.buyerId == userId || t.sellerId == userId)
          .toList();
    }

    return _transactions
        .where((t) => asBuyer ? t.buyerId == userId : t.sellerId == userId)
        .toList();
  }

  Future<Transaction> releaseEscrow(String transactionId) async {
    await Future.delayed(const Duration(milliseconds: 600));

    final index = _transactions.indexWhere((t) => t.id == transactionId);
    if (index == -1) throw Exception('Transaction not found');

    final now = DateTime.now();
    final transaction = _transactions[index];

    final updatedTransaction = transaction.copyWith(
      escrowStatus: EscrowStatus.released,
      releasedAt: now,
      completedAt: now,
      timeline: [
        ...transaction.timeline,
        TransactionTimeline(
          status: 'delivery_confirmed',
          timestamp: now,
          description: 'Buyer confirmed receipt',
          icon: 'check_circle',
        ),
        TransactionTimeline(
          status: 'payment_released',
          timestamp: now,
          description: 'Payment released to seller',
          icon: 'account_balance',
        ),
      ],
    );

    _transactions[index] = updatedTransaction;
    return updatedTransaction;
  }

  Future<Transaction> refundEscrow(String transactionId) async {
    await Future.delayed(const Duration(milliseconds: 600));

    final index = _transactions.indexWhere((t) => t.id == transactionId);
    if (index == -1) throw Exception('Transaction not found');

    final now = DateTime.now();
    final transaction = _transactions[index];

    final updatedTransaction = transaction.copyWith(
      escrowStatus: EscrowStatus.refunded,
      completedAt: now,
      timeline: [
        ...transaction.timeline,
        TransactionTimeline(
          status: 'refund_requested',
          timestamp: now,
          description: 'Refund requested by buyer',
          icon: 'money_off',
        ),
        TransactionTimeline(
          status: 'refund_approved',
          timestamp: now,
          description: 'Refund approved and processed',
          icon: 'check',
        ),
      ],
    );

    _transactions[index] = updatedTransaction;
    return updatedTransaction;
  }

  Future<Transaction> markAsShipped(String transactionId) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final index = _transactions.indexWhere((t) => t.id == transactionId);
    if (index == -1) throw Exception('Transaction not found');

    final now = DateTime.now();
    final transaction = _transactions[index];

    final updatedTransaction = transaction.copyWith(
      timeline: [
        ...transaction.timeline,
        TransactionTimeline(
          status: 'shipped',
          timestamp: now,
          description: 'Vehicle marked as shipped',
          icon: 'local_shipping',
        ),
      ],
    );

    _transactions[index] = updatedTransaction;
    return updatedTransaction;
  }

  Future<Transaction> submitTransferEvidenceAndValidate(String transactionId) async {
    final index = _transactions.indexWhere((t) => t.id == transactionId);
    if (index == -1) throw Exception('Transaction not found');

    final now = DateTime.now();
    final transaction = _transactions[index];

    // Update status to validating
    final updatedTransaction = transaction.copyWith(
      escrowStatus: EscrowStatus.validating,
      evidenceSubmittedAt: now,
      timeline: [
        ...transaction.timeline,
        TransactionTimeline(
          status: 'evidence_submitted',
          timestamp: now,
          description: 'Transfer evidence submitted for validation',
          icon: 'upload_file',
        ),
        TransactionTimeline(
          status: 'validation_started',
          timestamp: now,
          description: 'Validation in progress (1-3 business days)',
          icon: 'verified_user',
        ),
      ],
    );

    _transactions[index] = updatedTransaction;

    // Simulate validation process (7 seconds in demo, shows as 1-3 days)
    Future.delayed(const Duration(seconds: 7), () async {
      await _completeValidation(transactionId);
    });

    return updatedTransaction;
  }

  Future<Transaction> _completeValidation(String transactionId) async {
    final index = _transactions.indexWhere((t) => t.id == transactionId);
    if (index == -1) throw Exception('Transaction not found');

    final now = DateTime.now();
    final transaction = _transactions[index];

    // Auto-approve and release payment
    final approvedTransaction = transaction.copyWith(
      escrowStatus: EscrowStatus.released,
      validationCompletedAt: now,
      releasedAt: now,
      completedAt: now,
      timeline: [
        ...transaction.timeline,
        TransactionTimeline(
          status: 'validation_approved',
          timestamp: now,
          description: 'Transfer evidence validated successfully',
          icon: 'check_circle',
        ),
        TransactionTimeline(
          status: 'payment_released',
          timestamp: now,
          description: 'Payment released to seller',
          icon: 'account_balance',
        ),
      ],
    );

    _transactions[index] = approvedTransaction;
    return approvedTransaction;
  }

  Future<Transaction> requestRefund({
    required String transactionId,
    required RefundReason reason,
    required String description,
    required List<File> evidencePhotos,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));

    final index = _transactions.indexWhere((t) => t.id == transactionId);
    if (index == -1) throw Exception('Transaction not found');

    final now = DateTime.now();
    final transaction = _transactions[index];

    // Create dispute ID
    final disputeId = 'DIS${now.millisecondsSinceEpoch}';

    // Update transaction to disputed status
    final updatedTransaction = transaction.copyWith(
      escrowStatus: EscrowStatus.disputed,
      disputeId: disputeId,
      disputedAt: now,
      timeline: [
        ...transaction.timeline,
        TransactionTimeline(
          status: 'dispute_opened',
          timestamp: now,
          description: 'Buyer requested refund',
          icon: 'report_problem',
        ),
      ],
    );

    _transactions[index] = updatedTransaction;

    // Auto-approve refund after 5 seconds for demo
    Future.delayed(const Duration(seconds: 5), () async {
      await _autoApproveRefund(transactionId);
    });

    return updatedTransaction;
  }

  Future<Transaction> _autoApproveRefund(String transactionId) async {
    final index = _transactions.indexWhere((t) => t.id == transactionId);
    if (index == -1) throw Exception('Transaction not found');

    final now = DateTime.now();
    final transaction = _transactions[index];

    final refundedTransaction = transaction.copyWith(
      escrowStatus: EscrowStatus.refunded,
      refundedAt: now,
      completedAt: now,
      timeline: [
        ...transaction.timeline,
        TransactionTimeline(
          status: 'refund_approved',
          timestamp: now,
          description: 'Refund request approved',
          icon: 'check_circle',
        ),
        TransactionTimeline(
          status: 'refund_processed',
          timestamp: now,
          description: 'Refund processed to buyer',
          icon: 'account_balance',
        ),
      ],
    );

    _transactions[index] = refundedTransaction;
    return refundedTransaction;
  }

  List<Transaction> _generateMockTransactions() {
    final now = DateTime.now();

    // Helper to create transaction with proper fee breakdown
    // Using Buyer's Premium Model
    Transaction _createMockTransaction({
      required String id,
      required String auctionId,
      required String carId,
      required String buyerId,
      required String sellerId,
      required String buyerName,
      required String sellerName,
      required String carTitle,
      required double amount,
      required EscrowStatus escrowStatus,
      PaymentMethodType? paymentMethod,
      String? paymentReference,
      required DateTime createdAt,
      DateTime? paidAt,
      DateTime? releasedAt,
      DateTime? completedAt,
      required List<TransactionTimeline> timeline,
      double listingFee = 400.0,
    }) {
      final breakdown = FeeCalculator.getFeeBreakdown(
        salePrice: amount,
        includeListingFee: true,
      );

      return Transaction(
        id: id,
        auctionId: auctionId,
        carId: carId,
        buyerId: buyerId,
        sellerId: sellerId,
        buyerName: buyerName,
        sellerName: sellerName,
        carTitle: carTitle,
        amount: amount, // Winning bid
        platformFee: breakdown.transactionFee, // Buyer's premium
        totalAmount: breakdown.totalBuyerAmount, // Bid + premium
        escrowStatus: escrowStatus,
        paymentMethod: paymentMethod,
        paymentReference: paymentReference,
        createdAt: createdAt,
        paidAt: paidAt,
        releasedAt: releasedAt,
        completedAt: completedAt,
        timeline: timeline,
        // Fee breakdown fields
        listingFee: listingFee,
        transactionFeeRate: breakdown.transactionFeeRate,
        transactionFee: breakdown.transactionFee,
        priceTier: breakdown.priceTier,
        sellerPayout: breakdown.sellerReceives, // Seller gets bid - listing fee
      );
    }

    return [
      // As Buyer - Completed transaction
      _createMockTransaction(
        id: 'TXN1001',
        auctionId: 'AUC001',
        carId: 'CAR001',
        buyerId: 'user123',
        sellerId: 'seller456',
        buyerName: 'Juan Dela Cruz',
        sellerName: 'Pedro Santos',
        carTitle: '2020 Toyota Vios',
        amount: 450000,
        escrowStatus: EscrowStatus.released,
        paymentMethod: PaymentMethodType.gcash,
        paymentReference: 'GC123456789',
        createdAt: now.subtract(const Duration(days: 10)),
        paidAt: now.subtract(const Duration(days: 9)),
        releasedAt: now.subtract(const Duration(days: 2)),
        completedAt: now.subtract(const Duration(days: 2)),
        timeline: [
          TransactionTimeline(
            status: 'created',
            timestamp: now.subtract(const Duration(days: 10)),
            description: 'Transaction created',
            icon: 'receipt',
          ),
          TransactionTimeline(
            status: 'payment_submitted',
            timestamp: now.subtract(const Duration(days: 9)),
            description: 'Payment submitted via GCash',
            icon: 'payment',
          ),
          TransactionTimeline(
            status: 'escrow_held',
            timestamp: now.subtract(const Duration(days: 9)),
            description: 'Payment secured in escrow',
            icon: 'lock',
          ),
          TransactionTimeline(
            status: 'shipped',
            timestamp: now.subtract(const Duration(days: 5)),
            description: 'Vehicle shipped',
            icon: 'local_shipping',
          ),
          TransactionTimeline(
            status: 'delivery_confirmed',
            timestamp: now.subtract(const Duration(days: 2)),
            description: 'Buyer confirmed receipt',
            icon: 'check_circle',
          ),
          TransactionTimeline(
            status: 'payment_released',
            timestamp: now.subtract(const Duration(days: 2)),
            description: 'Payment released to seller',
            icon: 'account_balance',
          ),
        ],
      ),

      // As Seller - Completed sale
      _createMockTransaction(
        id: 'TXN2001',
        auctionId: 'AUC101',
        carId: 'CAR101',
        buyerId: 'buyer789',
        sellerId: 'user123',
        buyerName: 'Maria Garcia',
        sellerName: 'Juan Dela Cruz',
        carTitle: '2019 Honda Civic',
        amount: 680000,
        escrowStatus: EscrowStatus.released,
        paymentMethod: PaymentMethodType.bankTransfer,
        paymentReference: 'BPI123456789',
        createdAt: now.subtract(const Duration(days: 15)),
        paidAt: now.subtract(const Duration(days: 14)),
        releasedAt: now.subtract(const Duration(days: 5)),
        completedAt: now.subtract(const Duration(days: 5)),
        timeline: [
          TransactionTimeline(
            status: 'created',
            timestamp: now.subtract(const Duration(days: 15)),
            description: 'Transaction created',
            icon: 'receipt',
          ),
          TransactionTimeline(
            status: 'payment_submitted',
            timestamp: now.subtract(const Duration(days: 14)),
            description: 'Payment submitted via Bank Transfer',
            icon: 'payment',
          ),
          TransactionTimeline(
            status: 'escrow_held',
            timestamp: now.subtract(const Duration(days: 14)),
            description: 'Payment secured in escrow',
            icon: 'lock',
          ),
          TransactionTimeline(
            status: 'shipped',
            timestamp: now.subtract(const Duration(days: 8)),
            description: 'Vehicle shipped',
            icon: 'local_shipping',
          ),
          TransactionTimeline(
            status: 'delivery_confirmed',
            timestamp: now.subtract(const Duration(days: 5)),
            description: 'Buyer confirmed receipt',
            icon: 'check_circle',
          ),
          TransactionTimeline(
            status: 'payment_released',
            timestamp: now.subtract(const Duration(days: 5)),
            description: 'Payment released to seller',
            icon: 'account_balance',
          ),
        ],
      ),

      // As Seller - In Escrow (buyer paid, waiting for shipment)
      _createMockTransaction(
        id: 'TXN2002',
        auctionId: 'AUC102',
        carId: 'CAR102',
        buyerId: 'buyer456',
        sellerId: 'user123',
        buyerName: 'Carlos Reyes',
        sellerName: 'Juan Dela Cruz',
        carTitle: '2021 Mitsubishi Montero',
        amount: 1250000,
        escrowStatus: EscrowStatus.held,
        paymentMethod: PaymentMethodType.paymaya,
        paymentReference: 'PM987654321',
        createdAt: now.subtract(const Duration(days: 2)),
        paidAt: now.subtract(const Duration(days: 1)),
        timeline: [
          TransactionTimeline(
            status: 'created',
            timestamp: now.subtract(const Duration(days: 2)),
            description: 'Transaction created',
            icon: 'receipt',
          ),
          TransactionTimeline(
            status: 'payment_submitted',
            timestamp: now.subtract(const Duration(days: 1)),
            description: 'Payment submitted via PayMaya',
            icon: 'payment',
          ),
          TransactionTimeline(
            status: 'escrow_held',
            timestamp: now.subtract(const Duration(days: 1)),
            description: 'Payment secured in escrow',
            icon: 'lock',
          ),
        ],
      ),

      // As Seller - Pending payment
      _createMockTransaction(
        id: 'TXN2003',
        auctionId: 'AUC103',
        carId: 'CAR103',
        buyerId: 'buyer111',
        sellerId: 'user123',
        buyerName: 'Ana Lopez',
        sellerName: 'Juan Dela Cruz',
        carTitle: '2018 Ford Ranger',
        amount: 580000,
        escrowStatus: EscrowStatus.pending,
        createdAt: now.subtract(const Duration(hours: 6)),
        timeline: [
          TransactionTimeline(
            status: 'created',
            timestamp: now.subtract(const Duration(hours: 6)),
            description: 'Transaction created',
            icon: 'receipt',
          ),
        ],
      ),
    ];
  }
}
