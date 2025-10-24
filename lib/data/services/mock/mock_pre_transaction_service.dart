import 'dart:async';
import 'package:uuid/uuid.dart';
import '../../models/pre_transaction_model.dart';
import '../../models/pre_transaction_message_model.dart';
import '../../models/pre_transaction_confirmation_model.dart';

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
    required Map<String, dynamic> formData,
  }) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate processing

    final preTransaction = _preTransactions[preTransactionId];
    if (preTransaction == null) {
      throw Exception('PreTransaction not found');
    }

    // Parse shipping method enum
    ShippingMethod? shippingMethod;
    if (formData['shippingMethod'] != null) {
      final methodStr = formData['shippingMethod'] as String;
      shippingMethod = ShippingMethod.values.firstWhere(
        (e) => e.toString().split('.').last.toLowerCase() == methodStr.toLowerCase(),
        orElse: () => ShippingMethod.pickup,
      );
    }

    // Parse shipping cost responsibility enum
    ShippingCostResponsibility? shippingCostResponsibility;
    if (formData['shippingCostResponsibility'] != null) {
      final costStr = formData['shippingCostResponsibility'] as String;
      shippingCostResponsibility = ShippingCostResponsibility.values.firstWhere(
        (e) => e.toString().split('.').last.toLowerCase() == costStr.toLowerCase(),
        orElse: () => ShippingCostResponsibility.buyer,
      );
    }

    // Parse insurance responsibility enum
    InsuranceResponsibility? insuranceResponsibility;
    if (formData['insuranceResponsibility'] != null) {
      final insuranceStr = formData['insuranceResponsibility'] as String;
      insuranceResponsibility = InsuranceResponsibility.values.firstWhere(
        (e) => e.toString().split('.').last.toLowerCase() == insuranceStr.toLowerCase(),
        orElse: () => InsuranceResponsibility.buyer,
      );
    }

    // Parse inspection method enum
    InspectionMethod? inspectionMethod;
    if (formData['inspectionMethod'] != null) {
      final methodStr = formData['inspectionMethod'] as String;
      inspectionMethod = InspectionMethod.values.firstWhere(
        (e) => e.toString().split('.').last.toLowerCase() == methodStr.toLowerCase().replaceAll('-', '').replaceAll(' ', ''),
        orElse: () => InspectionMethod.inPerson,
      );
    }

    final confirmation = PreTransactionConfirmation(
      id: _uuid.v4(),
      userId: buyerId,
      userName: buyerName,

      // Vehicle identity
      vehicleIdentityConfirmed: formData['vehicleIdentityConfirmed'] ?? formData['priceAndFeesConfirmed'] ?? true,
      conditionAccuratelyRepresented: formData['vehicleIdentityConfirmed'] ?? formData['priceAndFeesConfirmed'] ?? true,

      // Pricing
      finalBidPrice: formData['finalBidPrice'] ?? preTransaction.finalBidAmount,
      additionalFees: (formData['additionalFees'] ?? 0.0).toDouble(),

      // Payment timeline
      paymentTimelineDays: formData['paymentDuration'] ?? 3,
      latePaymentPenaltyAcknowledged: formData['latePaymentPenaltiesAcknowledged'] ?? false,

      // Shipping & delivery
      shippingMethod: shippingMethod,
      shippingCostResponsibility: shippingCostResponsibility,
      insuranceResponsibility: insuranceResponsibility,
      estimatedDeliveryDays: formData['estimatedDeliveryDays'] ?? 7,
      deliveryLocation: formData['deliveryLocation'],
      deliveryDate: formData['deliveryDate'],

      // Inspection & acceptance
      vehicleInspectionPeriodHours: (formData['inspectionDuration'] ?? 2) * 24,
      inspectionMethod: inspectionMethod,
      acceptanceCriteria: formData['acceptanceCriteria'],
      discrepancyProcedure: formData['discrepancyProcedure'],
      buyerConfirmationLimitHours: (formData['buyerConfirmationLimit'] ?? 1) * 24,

      // Legal & documentation
      titleTransferAcknowledged: formData['titleRegistrationAcknowledged'] ?? false,
      noOutstandingLiensAcknowledged: formData['noLiensAcknowledged'] ?? false,
      ownershipTransferProcessAcknowledged: formData['transferProcessAcknowledged'] ?? false,

      // Dispute & protections
      discussionsLoggedAcknowledged: formData['discussionsLoggedConfirmed'] ?? false,
      disputeResolutionProcessAgreed: formData['disputeResolutionAgreed'] ?? false,
      fraudPoliciesAcknowledged: formData['fraudPoliciesAcknowledged'] ?? false,
      additionalProtections: formData['additionalProtections'],

      // Final confirmations
      termsAgreed: formData['termsAgreed'] ?? false,
      uploadedDocuments: List<String>.from(formData['uploadedDocuments'] ?? []),
      confirmedAt: DateTime.now(),
      notes: formData['notes'],
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

  /// Submit seller confirmation
  Future<PreTransaction> submitSellerConfirmation({
    required String preTransactionId,
    required String sellerId,
    required String sellerName,
    required Map<String, dynamic> formData,
  }) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate processing

    final preTransaction = _preTransactions[preTransactionId];
    if (preTransaction == null) {
      throw Exception('PreTransaction not found');
    }

    // Parse shipping method enum
    ShippingMethod? shippingMethod;
    if (formData['shippingMethod'] != null) {
      final methodStr = formData['shippingMethod'] as String;
      shippingMethod = ShippingMethod.values.firstWhere(
        (e) => e.toString().split('.').last.toLowerCase() == methodStr.toLowerCase().replaceAll('-', ''),
        orElse: () => ShippingMethod.pickup,
      );
    }

    // Parse inspection method enum
    InspectionMethod? inspectionMethod;
    if (formData['inspectionMethod'] != null) {
      final methodStr = formData['inspectionMethod'] as String;
      inspectionMethod = InspectionMethod.values.firstWhere(
        (e) => e.toString().split('.').last.toLowerCase() == methodStr.toLowerCase().replaceAll('-', '').replaceAll(' ', ''),
        orElse: () => InspectionMethod.inPerson,
      );
    }

    final confirmation = PreTransactionConfirmation(
      id: _uuid.v4(),
      userId: sellerId,
      userName: sellerName,

      // Vehicle details
      vehicleIdentityConfirmed: formData['vehicleMatchesListing'] ?? formData['vehicleIdentityConfirmed'] ?? true,
      conditionAccuratelyRepresented: formData['conditionAccuratelyRepresented'] ?? true,
      allIssuesDisclosedAccurately: formData['allIssuesDisclosed'] ?? false,
      conditionAsRepresented: formData['conditionAccuratelyRepresented'] ?? false,
      supportingDocumentsUrls: List<String>.from(formData['conditionDocuments'] ?? []),

      // Pricing
      finalBidPrice: preTransaction.finalBidAmount,

      // Legal & ownership
      sellerOwnershipConfirmed: true,
      noOutstandingLiensAcknowledged: formData['noOutstandingLiens'] ?? false,
      specialTransferInstructions: formData['specialTransferInstructions'],

      // Shipping & delivery
      shippingMethod: shippingMethod,
      deliveryLocation: formData['deliveryLocation'],
      deliveryDate: formData['handoverDate'],
      shippingEvidenceCommitment: formData['agreeToSubmitShippingEvidence'] ?? false,
      transitInsuranceAcknowledged: formData['insuranceResponsibilityAcknowledged'] ?? false,
      requiredShippingEvidence: List<String>.from(formData['shippingEvidenceDocuments'] ?? []),

      // Inspection
      inspectionMethod: inspectionMethod,
      sellerInspectionReviewCommitment: formData['willReviewInspectionEvidence'] ?? false,
      inspectionNotes: formData['inspectionNotes'],

      // Dispute & protections
      disputeResolutionProcessAgreed: formData['disputeResolutionAgreed'] ?? false,
      fraudPoliciesAcknowledged: formData['fraudPoliciesAcknowledged'] ?? false,
      sellerProtectionMeasures: formData['sellerProtections'],

      // Final confirmations
      informationAccuracyConfirmed: formData['informationAccuracyConfirmed'] ?? false,
      termsAgreed: formData['termsAgreed'] ?? false,
      uploadedDocuments: List<String>.from(formData['uploadedDocuments'] ?? []),
      confirmedAt: DateTime.now(),
      notes: formData['notes'],
    );

    final now = DateTime.now();

    // Check if both parties have confirmed
    final bothConfirmed = preTransaction.buyerConfirmation != null;

    final updatedMessages = [
      ...preTransaction.messages,
      PreTransactionMessage(
        id: _uuid.v4(),
        preTransactionId: preTransactionId,
        sender: MessageSender.system,
        senderName: 'System',
        type: MessageType.system,
        content: bothConfirmed
            ? 'Both parties have confirmed! Please review and approve the combined details before admin review.'
            : 'Seller has submitted confirmation. Waiting for buyer confirmation...',
        timestamp: now,
      ),
    ];

    _preTransactions[preTransactionId] = preTransaction.copyWith(
      sellerConfirmation: confirmation,
      sellerConfirmedAt: now,
      status: bothConfirmed
          ? PreTransactionStatus.pendingMutualConfirmation
          : PreTransactionStatus.pendingBuyerConfirmation,
      mutualReviewStartedAt: bothConfirmed ? now : null,
      messages: updatedMessages,
    );

    _notifyListeners();

    // Simulate buyer auto-confirmation after 5 seconds (for demo purposes)
    if (!bothConfirmed) {
      _simulateBuyerConfirmation(preTransactionId);
    }

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
      vehicleIdentityConfirmed: true,
      conditionAccuratelyRepresented: true,
      finalBidPrice: preTransaction.finalBidAmount,
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
        content: 'Both parties have confirmed! Please review and approve the combined details before admin review.',
        timestamp: now,
      ),
    ];

    _preTransactions[preTransactionId] = preTransaction.copyWith(
      sellerConfirmation: confirmation,
      sellerConfirmedAt: now,
      status: PreTransactionStatus.pendingMutualConfirmation,
      mutualReviewStartedAt: now,
      messages: updatedMessages,
    );

    _notifyListeners();
  }

  /// Simulate buyer confirmation (for demo purposes)
  Future<void> _simulateBuyerConfirmation(String preTransactionId) async {
    await Future.delayed(const Duration(seconds: 5));

    final preTransaction = _preTransactions[preTransactionId];
    if (preTransaction == null || preTransaction.buyerConfirmation != null) {
      return;
    }

    final confirmation = PreTransactionConfirmation(
      id: _uuid.v4(),
      userId: preTransaction.buyerId,
      userName: preTransaction.buyerName,
      vehicleIdentityConfirmed: true,
      conditionAccuratelyRepresented: true,
      finalBidPrice: preTransaction.finalBidAmount,
      deliveryDate: preTransaction.sellerConfirmation?.deliveryDate,
      deliveryLocation: preTransaction.sellerConfirmation?.deliveryLocation,
      uploadedDocuments: [],
      termsAgreed: true,
      confirmedAt: DateTime.now(),
      notes: 'Confirmed. Looking forward to receiving the vehicle.',
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
        content: 'Both parties have confirmed! Please review and approve the combined details before admin review.',
        timestamp: now,
      ),
    ];

    _preTransactions[preTransactionId] = preTransaction.copyWith(
      buyerConfirmation: confirmation,
      buyerConfirmedAt: now,
      status: PreTransactionStatus.pendingMutualConfirmation,
      mutualReviewStartedAt: now,
      messages: updatedMessages,
    );

    _notifyListeners();
  }

  /// Request edit from the other party during mutual review
  Future<PreTransaction> requestEdit({
    required String preTransactionId,
    required String requestedBy, // 'buyer' or 'seller'
    required String field,
    required String currentValue,
    required String requestedValue,
    required String reason,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final preTransaction = _preTransactions[preTransactionId];
    if (preTransaction == null) {
      throw Exception('PreTransaction not found');
    }

    final requestedFrom = requestedBy == 'buyer' ? 'seller' : 'buyer';
    final editRequest = EditRequest(
      id: _uuid.v4(),
      requestedBy: requestedBy,
      requestedFrom: requestedFrom,
      field: field,
      currentValue: currentValue,
      requestedValue: requestedValue,
      reason: reason,
      requestedAt: DateTime.now(),
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
        content: '${requestedBy == 'buyer' ? 'Buyer' : 'Seller'} requested an edit to "$field"',
        timestamp: now,
      ),
    ];

    final updatedEditRequests = [...preTransaction.editRequests, editRequest];

    _preTransactions[preTransactionId] = preTransaction.copyWith(
      editRequests: updatedEditRequests,
      messages: updatedMessages,
      // Reset approvals when edit is requested
      buyerMutualReviewApproved: false,
      sellerMutualReviewApproved: false,
    );

    _notifyListeners();
    return _preTransactions[preTransactionId]!;
  }

  /// Approve mutual review (buyer or seller)
  Future<PreTransaction> approveMutualReview({
    required String preTransactionId,
    required String approvedBy, // 'buyer' or 'seller'
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final preTransaction = _preTransactions[preTransactionId];
    if (preTransaction == null) {
      throw Exception('PreTransaction not found');
    }

    final now = DateTime.now();
    final isBuyer = approvedBy == 'buyer';

    // Update approval status
    final updatedTransaction = preTransaction.copyWith(
      buyerMutualReviewApproved: isBuyer ? true : preTransaction.buyerMutualReviewApproved,
      sellerMutualReviewApproved: !isBuyer ? true : preTransaction.sellerMutualReviewApproved,
    );

    // Check if both have approved
    final bothApproved = updatedTransaction.buyerMutualReviewApproved &&
                         updatedTransaction.sellerMutualReviewApproved;

    final updatedMessages = [
      ...preTransaction.messages,
      PreTransactionMessage(
        id: _uuid.v4(),
        preTransactionId: preTransactionId,
        sender: MessageSender.system,
        senderName: 'System',
        type: MessageType.system,
        content: bothApproved
            ? '✓ Both parties approved! Submitting to admin for final review...'
            : '${isBuyer ? 'Buyer' : 'Seller'} approved the combined details. Waiting for ${isBuyer ? 'seller' : 'buyer'}...',
        timestamp: now,
      ),
    ];

    _preTransactions[preTransactionId] = updatedTransaction.copyWith(
      messages: updatedMessages,
      mutualReviewCompletedAt: bothApproved ? now : null,
      mutualConfirmationAt: bothApproved ? now : null,
      status: bothApproved ? PreTransactionStatus.pendingAdminReview : PreTransactionStatus.pendingMutualConfirmation,
      adminReviewStartedAt: bothApproved ? now : null,
    );

    _notifyListeners();

    // If both approved, simulate admin review
    if (bothApproved) {
      _simulateAdminReview(preTransactionId);
    }

    return _preTransactions[preTransactionId]!;
  }

  /// Simulate admin review (for demo purposes)
  Future<void> _simulateAdminReview(String preTransactionId) async {
    await Future.delayed(const Duration(seconds: 8)); // Admin review takes 8 seconds

    final preTransaction = _preTransactions[preTransactionId];
    if (preTransaction == null || preTransaction.status != PreTransactionStatus.pendingAdminReview) {
      return;
    }

    final now = DateTime.now();
    final updatedMessages = [
      ...preTransaction.messages,
      PreTransactionMessage(
        id: _uuid.v4(),
        preTransactionId: preTransactionId,
        sender: MessageSender.system,
        senderName: 'System',
        type: MessageType.system,
        content: 'Admin review completed! Transaction approved. Seller can now begin preparing the item for shipment.',
        timestamp: now,
      ),
    ];

    // Transition directly to preparing status (no payment/escrow step)
    _preTransactions[preTransactionId] = preTransaction.copyWith(
      status: PreTransactionStatus.preparing,
      adminReviewCompletedAt: now,
      adminReviewNotes: 'Transaction details verified and approved by admin.',
      preparingStartedAt: now,
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

  /// Clear confirmation to allow editing
  Future<PreTransaction> clearConfirmation({
    required String preTransactionId,
    required bool clearBuyer,
    required bool clearSeller,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final preTransaction = _preTransactions[preTransactionId];
    if (preTransaction == null) {
      throw Exception('PreTransaction not found');
    }

    final now = DateTime.now();
    final updatedMessages = [
      ...preTransaction.messages,
      PreTransactionMessage(
        id: _uuid.v4(),
        preTransactionId: preTransactionId,
        sender: MessageSender.system,
        senderName: 'System',
        type: MessageType.system,
        content: '${clearBuyer ? 'Buyer' : 'Seller'} is editing their confirmation form.',
        timestamp: now,
      ),
    ];

    // Determine new status based on which confirmations remain
    PreTransactionStatus newStatus;
    if (clearBuyer && clearSeller) {
      // Both cleared - back to discussion
      newStatus = PreTransactionStatus.inDiscussion;
    } else if (clearBuyer) {
      // Buyer cleared, seller remains
      newStatus = PreTransactionStatus.pendingBuyerConfirmation;
    } else {
      // Seller cleared, buyer remains
      newStatus = PreTransactionStatus.pendingSellerConfirmation;
    }

    _preTransactions[preTransactionId] = preTransaction.copyWith(
      buyerConfirmation: clearBuyer ? null : preTransaction.buyerConfirmation,
      sellerConfirmation: clearSeller ? null : preTransaction.sellerConfirmation,
      buyerConfirmedAt: clearBuyer ? null : preTransaction.buyerConfirmedAt,
      sellerConfirmedAt: clearSeller ? null : preTransaction.sellerConfirmedAt,
      status: newStatus,
      buyerMutualReviewApproved: false,
      sellerMutualReviewApproved: false,
      mutualReviewStartedAt: null,
      mutualReviewCompletedAt: null,
      messages: updatedMessages,
    );

    _notifyListeners();
    return _preTransactions[preTransactionId]!;
  }

  void _notifyListeners() {
    _preTransactionController.add(_preTransactions.values.toList());
  }

  /// Initialize mock data for seller (simulates various transaction stages)
  void initializeSellerMockData(String sellerId) {
    final now = DateTime.now();

    // Mock data for different stages of seller transaction flow
    final mockData = [
      // 1. Awaiting Discussion (just ended)
      {
        'carTitle': '2022 Toyota Vios E 1.3 MT',
        'buyerName': 'Maria Santos',
        'finalBid': 220000.0,
        'status': PreTransactionStatus.inDiscussion,
        'hoursAgo': 2,
        'hasMessages': 3,
      },

      // 2. Buyer submitted, awaiting seller confirmation
      {
        'carTitle': '2021 Honda CR-V S CVT',
        'buyerName': 'Juan Dela Cruz',
        'finalBid': 850000.0,
        'status': PreTransactionStatus.pendingSellerConfirmation,
        'hoursAgo': 6,
        'hasMessages': 8,
        'buyerConfirmed': true,
      },

      // 3. Both confirmed, awaiting admin review
      {
        'carTitle': '2020 Mitsubishi Montero Sport',
        'buyerName': 'Carlos Reyes',
        'finalBid': 1200000.0,
        'status': PreTransactionStatus.pendingAdminReview,
        'hoursAgo': 12,
        'hasMessages': 12,
        'buyerConfirmed': true,
        'sellerConfirmed': true,
      },

      // 4. Admin approved, awaiting buyer payment
      {
        'carTitle': '2023 Ford Ranger Raptor',
        'buyerName': 'Roberto Garcia',
        'finalBid': 1850000.0,
        'status': PreTransactionStatus.adminApproved,
        'hoursAgo': 18,
        'hasMessages': 15,
        'buyerConfirmed': true,
        'sellerConfirmed': true,
        'adminApproved': true,
      },

      // 5. Payment received, ready for shipping (most common seller action needed)
      {
        'carTitle': '2022 Mazda CX-5 AWD Sport',
        'buyerName': 'Ana Lopez',
        'finalBid': 950000.0,
        'status': PreTransactionStatus.readyForPayment,
        'hoursAgo': 24,
        'hasMessages': 18,
        'buyerConfirmed': true,
        'sellerConfirmed': true,
        'adminApproved': true,
        'paymentReceived': true,
      },
    ];

    for (int i = 0; i < mockData.length; i++) {
      final data = mockData[i];
      final id = 'seller_mock_$i';
      final auctionId = 'auction_seller_mock_$i';
      final carId = 'car_seller_mock_$i';
      final buyerId = 'buyer_mock_$i';

      final createdAt = now.subtract(Duration(hours: data['hoursAgo'] as int));

      // Create initial messages
      final messages = <PreTransactionMessage>[
        PreTransactionMessage(
          id: _uuid.v4(),
          preTransactionId: id,
          sender: MessageSender.system,
          senderName: 'System',
          type: MessageType.system,
          content: 'Auction ended. Transaction initiated.',
          timestamp: createdAt,
        ),
      ];

      // Add buyer/seller chat messages
      final messageCount = data['hasMessages'] as int;
      for (int j = 1; j < messageCount; j++) {
        final isFromBuyer = j % 2 == 1;
        messages.add(
          PreTransactionMessage(
            id: _uuid.v4(),
            preTransactionId: id,
            sender: isFromBuyer ? MessageSender.buyer : MessageSender.seller,
            senderName: isFromBuyer ? (data['buyerName'] as String) : 'You',
            type: MessageType.text,
            content: isFromBuyer
                ? 'When can we arrange the vehicle inspection?'
                : 'I\'m available this week. Let\'s coordinate the details.',
            timestamp: createdAt.add(Duration(minutes: j * 10)),
          ),
        );
      }

      // Add status-specific system messages
      if (data['buyerConfirmed'] == true) {
        messages.add(
          PreTransactionMessage(
            id: _uuid.v4(),
            preTransactionId: id,
            sender: MessageSender.system,
            senderName: 'System',
            type: MessageType.system,
            content: 'Buyer has submitted confirmation. Waiting for seller confirmation...',
            timestamp: createdAt.add(Duration(hours: 1)),
          ),
        );
      }

      if (data['sellerConfirmed'] == true) {
        messages.add(
          PreTransactionMessage(
            id: _uuid.v4(),
            preTransactionId: id,
            sender: MessageSender.system,
            senderName: 'System',
            type: MessageType.system,
            content: 'Both parties confirmed! Submitted to admin for review.',
            timestamp: createdAt.add(Duration(hours: 2)),
          ),
        );
      }

      if (data['adminApproved'] == true) {
        messages.add(
          PreTransactionMessage(
            id: _uuid.v4(),
            preTransactionId: id,
            sender: MessageSender.system,
            senderName: 'System',
            type: MessageType.system,
            content: 'Admin review completed! Transaction approved.',
            timestamp: createdAt.add(Duration(hours: 3)),
          ),
        );
      }

      if (data['paymentReceived'] == true) {
        messages.add(
          PreTransactionMessage(
            id: _uuid.v4(),
            preTransactionId: id,
            sender: MessageSender.system,
            senderName: 'System',
            type: MessageType.system,
            content: '💰 Payment secured in escrow! Please prepare shipping within 3 days.',
            timestamp: createdAt.add(Duration(hours: 4)),
          ),
        );
      }

      // Create confirmations based on status
      PreTransactionConfirmation? buyerConfirmation;
      PreTransactionConfirmation? sellerConfirmation;

      if (data['buyerConfirmed'] == true) {
        buyerConfirmation = PreTransactionConfirmation(
          id: _uuid.v4(),
          userId: buyerId,
          userName: data['buyerName'] as String,
          vehicleIdentityConfirmed: true,
          conditionAccuratelyRepresented: true,
          finalBidPrice: data['finalBid'] as double,
          deliveryDate: now.add(Duration(days: 5)).toIso8601String(),
          deliveryLocation: 'Makati City, Metro Manila',
          termsAgreed: true,
          confirmedAt: createdAt.add(Duration(hours: 1)),
          notes: 'Looking forward to the delivery.',
        );
      }

      if (data['sellerConfirmed'] == true) {
        sellerConfirmation = PreTransactionConfirmation(
          id: _uuid.v4(),
          userId: sellerId,
          userName: 'You',
          vehicleIdentityConfirmed: true,
          conditionAccuratelyRepresented: true,
          finalBidPrice: data['finalBid'] as double,
          deliveryDate: now.add(Duration(days: 5)).toIso8601String(),
          deliveryLocation: 'Makati City, Metro Manila',
          termsAgreed: true,
          confirmedAt: createdAt.add(Duration(hours: 2)),
          notes: 'Vehicle ready for inspection and transfer.',
        );
      }

      final preTransaction = PreTransaction(
        id: id,
        auctionId: auctionId,
        carId: carId,
        carTitle: data['carTitle'] as String,
        buyerId: buyerId,
        sellerId: sellerId,
        buyerName: data['buyerName'] as String,
        sellerName: 'You',
        finalBidAmount: data['finalBid'] as double,
        status: data['status'] as PreTransactionStatus,
        messages: messages,
        buyerConfirmation: buyerConfirmation,
        sellerConfirmation: sellerConfirmation,
        createdAt: createdAt,
        discussionStartedAt: createdAt,
        buyerConfirmedAt: data['buyerConfirmed'] == true ? createdAt.add(Duration(hours: 1)) : null,
        sellerConfirmedAt: data['sellerConfirmed'] == true ? createdAt.add(Duration(hours: 2)) : null,
        mutualConfirmationAt: data['sellerConfirmed'] == true ? createdAt.add(Duration(hours: 2)) : null,
        adminReviewStartedAt: data['sellerConfirmed'] == true ? createdAt.add(Duration(hours: 2)) : null,
        adminReviewCompletedAt: data['adminApproved'] == true ? createdAt.add(Duration(hours: 3)) : null,
        adminReviewNotes: data['adminApproved'] == true ? 'All details verified. Transaction approved.' : null,
        readyForPaymentAt: data['adminApproved'] == true ? createdAt.add(Duration(hours: 3)) : null,
      );

      _preTransactions[id] = preTransaction;
    }

    _notifyListeners();
  }

  /// Get seller's pre-transactions
  List<PreTransaction> getSellerPreTransactions(String sellerId) {
    return _preTransactions.values
        .where((pt) => pt.sellerId == sellerId)
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  /// Update checkpoint status (manual checkpoint progression)
  Future<PreTransaction> updateCheckpointStatus({
    required String preTransactionId,
    required PreTransactionStatus newStatus,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800)); // Simulate processing

    final preTransaction = _preTransactions[preTransactionId];
    if (preTransaction == null) {
      throw Exception('PreTransaction not found');
    }

    final now = DateTime.now();
    final updatedMessages = [
      ...preTransaction.messages,
      PreTransactionMessage(
        id: _uuid.v4(),
        preTransactionId: preTransactionId,
        sender: MessageSender.system,
        senderName: 'System',
        type: MessageType.system,
        content: _getCheckpointUpdateMessage(newStatus),
        timestamp: now,
      ),
    ];

    // Update transaction with new status and timestamp
    PreTransaction updatedTransaction;
    switch (newStatus) {
      case PreTransactionStatus.preparing:
        updatedTransaction = preTransaction.copyWith(
          status: newStatus,
          preparingStartedAt: now,
          messages: updatedMessages,
        );
        break;
      case PreTransactionStatus.shipping:
        updatedTransaction = preTransaction.copyWith(
          status: newStatus,
          shippingStartedAt: now,
          messages: updatedMessages,
        );
        break;
      case PreTransactionStatus.delivered:
        updatedTransaction = preTransaction.copyWith(
          status: newStatus,
          deliveredAt: now,
          messages: updatedMessages,
        );
        break;
      case PreTransactionStatus.paymentSuccess:
        updatedTransaction = preTransaction.copyWith(
          status: newStatus,
          paymentSuccessAt: now,
          messages: updatedMessages,
        );
        break;
      case PreTransactionStatus.transactionComplete:
        updatedTransaction = preTransaction.copyWith(
          status: newStatus,
          transactionCompletedAt: now,
          messages: updatedMessages,
        );
        break;
      default:
        throw Exception('Invalid checkpoint status: $newStatus');
    }

    _preTransactions[preTransactionId] = updatedTransaction;
    _notifyListeners();

    return updatedTransaction;
  }

  String _getCheckpointUpdateMessage(PreTransactionStatus status) {
    switch (status) {
      case PreTransactionStatus.preparing:
        return 'Seller is now preparing the item for shipment.';
      case PreTransactionStatus.shipping:
        return 'Item has been shipped! Tracking details will be available soon.';
      case PreTransactionStatus.delivered:
        return 'Item has been delivered to the buyer!';
      case PreTransactionStatus.paymentSuccess:
        return 'Payment received successfully! Transaction is being finalized.';
      case PreTransactionStatus.transactionComplete:
        return 'Transaction complete! Thank you for using AutoBID.';
      default:
        return 'Status updated.';
    }
  }

  void dispose() {
    _preTransactionController.close();
  }
}
