import 'dart:convert';
import 'package:crypto/crypto.dart';
import '../../../data/models/pre_transaction_model.dart';
import '../../../data/models/kyc_verification_model.dart';
import '../../../data/models/digital_agreement_model.dart';
import '../../../data/models/payment_confirmation_model.dart';
import '../../../data/models/handover_confirmation_model.dart';
import '../../../data/models/audit_log_entry_model.dart';

/// Mock service for RA 8792 compliant pre-transaction workflow
/// Simulates backend operations with realistic delays and Philippine data
class MockRa8792Service {
  // In-memory storage
  final Map<String, PreTransaction> _preTransactions = {};
  final Map<String, KycVerification> _kycVerifications = {};
  final Map<String, DigitalAgreement> _digitalAgreements = {};

  /// Get pre-transaction by ID
  PreTransaction? getPreTransaction(String id) {
    return _preTransactions[id];
  }

  /// Submit KYC verification
  /// Simulates identity verification process (1-2 second delay)
  Future<KycVerification> submitKycVerification({
    required String preTransactionId,
    required String userId,
    required String userName,
    required GovernmentIdType idType,
    required String idNumber,
    required String idPhotoUrl,
    required String selfiePhotoUrl,
    required bool ra8792Consent,
  }) async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate API call

    final verification = KycVerification(
      id: 'kyc_${DateTime.now().millisecondsSinceEpoch}',
      userId: userId,
      userName: userName,
      governmentIdType: idType,
      governmentIdNumber: idNumber,
      governmentIdPhotoUrl: idPhotoUrl,
      selfiePhotoUrl: selfiePhotoUrl,
      ra8792ConsentGiven: ra8792Consent,
      submittedAt: DateTime.now(),
      verifiedAt: DateTime.now(), // Auto-verify for mock
      status: KycVerificationStatus.verified,
    );

    _kycVerifications[verification.id] = verification;

    // Update pre-transaction
    final preTransaction = _preTransactions[preTransactionId];
    if (preTransaction != null) {
      final updatedPreTransaction = preTransaction.copyWith(
        buyerVerification: userId == preTransaction.buyerId
            ? verification
            : preTransaction.buyerVerification,
        sellerVerification: userId == preTransaction.sellerId
            ? verification
            : preTransaction.sellerVerification,
        auditLog: [
          ...preTransaction.auditLog,
          AuditLogEntry(
            id: 'audit_${DateTime.now().millisecondsSinceEpoch}',
            preTransactionId: preTransactionId,
            action: userId == preTransaction.buyerId
                ? 'Buyer KYC Verified'
                : 'Seller KYC Verified',
            actor: userId == preTransaction.buyerId ? 'buyer' : 'seller',
            actorName: userName,
            timestamp: DateTime.now(),
            details: 'Verified with ${_idTypeToString(idType)} (#${idNumber.substring(idNumber.length - 4)})',
          ),
        ],
      );

      // Check if both verified, update status
      if (updatedPreTransaction.buyerVerification != null &&
          updatedPreTransaction.sellerVerification != null) {
        _preTransactions[preTransactionId] = updatedPreTransaction.copyWith(
          status: PreTransactionStatus.verificationComplete,
        );
      } else {
        _preTransactions[preTransactionId] = updatedPreTransaction;
      }
    }

    return verification;
  }

  /// Generate digital agreement
  /// Creates legally binding electronic contract
  Future<DigitalAgreement> generateDigitalAgreement({
    required String preTransactionId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 1500));

    final preTransaction = _preTransactions[preTransactionId];
    if (preTransaction == null) {
      throw Exception('Pre-transaction not found');
    }

    // Generate document hash (simplified SHA-256)
    final agreementContent = '${preTransaction.buyerId}_${preTransaction.sellerId}_${preTransaction.finalBidAmount}';
    final bytes = utf8.encode(agreementContent);
    final hash = sha256.convert(bytes).toString();

    final agreement = DigitalAgreement(
      id: 'agreement_${DateTime.now().millisecondsSinceEpoch}',
      auctionId: preTransaction.auctionId,
      preTransactionId: preTransactionId,
      buyerId: preTransaction.buyerId,
      buyerName: preTransaction.buyerName,
      sellerId: preTransaction.sellerId,
      sellerName: preTransaction.sellerName,
      vehicleMake: 'Toyota', // Mock data - would come from listing
      vehicleModel: 'Vios',
      vehicleYear: '2018',
      vinNumber: preTransaction.buyerConfirmation?.vinNumber ?? 'MOCK123456789VIN',
      licensePlate: preTransaction.buyerConfirmation?.licensePlate ?? 'ABC 1234',
      vehicleColor: 'White',
      finalBidPrice: preTransaction.finalBidAmount,
      additionalFees: preTransaction.buyerConfirmation?.additionalFees ?? 0.0,
      totalAmount: preTransaction.finalBidAmount + (preTransaction.buyerConfirmation?.additionalFees ?? 0.0),
      paymentTerms: 'Full payment within 3 days of agreement signing',
      deliveryMethod: 'Seller-arranged delivery to buyer location',
      legalConsentText: 'This digital agreement is legally binding under the Electronic Commerce Act of 2000 (RA 8792), Sections 6-10. Electronic signatures have the same legal effect as handwritten signatures.',
      disputeClause: 'Any disputes arising from this agreement shall be resolved through the AutoBID dispute resolution process in accordance with Philippine law.',
      documentHash: hash.substring(0, 16), // Shortened for display
      agreementGeneratedAt: DateTime.now(),
      status: DigitalAgreementStatus.draft,
    );

    _digitalAgreements[agreement.id] = agreement;

    // Update pre-transaction
    _preTransactions[preTransactionId] = preTransaction.copyWith(
      digitalAgreement: agreement,
      status: PreTransactionStatus.agreementDraft,
      auditLog: [
        ...preTransaction.auditLog,
        AuditLogEntry(
          id: 'audit_${DateTime.now().millisecondsSinceEpoch}',
          preTransactionId: preTransactionId,
          action: 'Digital Agreement Generated',
          actor: 'system',
          actorName: 'AutoBID System',
          timestamp: DateTime.now(),
          details: 'Legal agreement created with document hash: ${hash.substring(0, 16)}',
        ),
      ],
    );

    return agreement;
  }

  /// Sign digital agreement
  /// Records electronic signature (RA 8792 compliant)
  Future<DigitalAgreement> signAgreement({
    required String preTransactionId,
    required String userId,
    required String signature,
  }) async {
    await Future.delayed(const Duration(milliseconds: 1000));

    final preTransaction = _preTransactions[preTransactionId];
    if (preTransaction?.digitalAgreement == null) {
      throw Exception('Digital agreement not found');
    }

    final agreement = preTransaction!.digitalAgreement!;
    final isBuyer = userId == preTransaction.buyerId;

    final updatedAgreement = isBuyer
        ? agreement.copyWith(
            buyerSignature: signature,
            buyerSignedAt: DateTime.now(),
            status: agreement.sellerSignature != null
                ? DigitalAgreementStatus.fullySigned
                : DigitalAgreementStatus.partialSigned,
          )
        : agreement.copyWith(
            sellerSignature: signature,
            sellerSignedAt: DateTime.now(),
            status: agreement.buyerSignature != null
                ? DigitalAgreementStatus.fullySigned
                : DigitalAgreementStatus.partialSigned,
          );

    _digitalAgreements[agreement.id] = updatedAgreement;

    // Update pre-transaction
    final updatedPreTransaction = preTransaction.copyWith(
      digitalAgreement: updatedAgreement,
      auditLog: [
        ...preTransaction.auditLog,
        AuditLogEntry(
          id: 'audit_${DateTime.now().millisecondsSinceEpoch}',
          preTransactionId: preTransactionId,
          action: isBuyer ? 'Buyer Signed Agreement' : 'Seller Signed Agreement',
          actor: isBuyer ? 'buyer' : 'seller',
          actorName: isBuyer ? preTransaction.buyerName : preTransaction.sellerName,
          timestamp: DateTime.now(),
          details: 'Electronic signature recorded under RA 8792',
        ),
      ],
    );

    // If both signed, update status
    if (updatedAgreement.status == DigitalAgreementStatus.fullySigned) {
      _preTransactions[preTransactionId] = updatedPreTransaction.copyWith(
        status: PreTransactionStatus.agreementSigned,
      );
    } else {
      _preTransactions[preTransactionId] = updatedPreTransaction;
    }

    return updatedAgreement;
  }

  /// Initiate payment
  /// Buyer uploads proof of payment
  Future<PaymentConfirmation> initiatePayment({
    required String preTransactionId,
    required List<String> proofUrls,
    required PaymentMethod method,
    required String? referenceNumber,
    required double amount,
  }) async {
    await Future.delayed(const Duration(milliseconds: 1500));

    final preTransaction = _preTransactions[preTransactionId];
    if (preTransaction == null) {
      throw Exception('Pre-transaction not found');
    }

    final payment = PaymentConfirmation(
      id: 'payment_${DateTime.now().millisecondsSinceEpoch}',
      preTransactionId: preTransactionId,
      buyerInitiated: true,
      buyerInitiatedAt: DateTime.now(),
      proofOfPaymentUrls: proofUrls,
      paymentMethod: method,
      paymentReferenceNumber: referenceNumber,
      ra8792Acknowledgment: 'This payment confirmation is an electronic acknowledgment under the Electronic Commerce Act of 2000 (RA 8792), Section 11. This electronic record has the same legal validity as a written receipt.',
      amountPaid: amount,
      createdAt: DateTime.now(),
      status: PaymentConfirmationStatus.initiated,
    );

    _preTransactions[preTransactionId] = preTransaction.copyWith(
      paymentConfirmation: payment,
      status: PreTransactionStatus.paymentPending,
      auditLog: [
        ...preTransaction.auditLog,
        AuditLogEntry(
          id: 'audit_${DateTime.now().millisecondsSinceEpoch}',
          preTransactionId: preTransactionId,
          action: 'Payment Initiated',
          actor: 'buyer',
          actorName: preTransaction.buyerName,
          timestamp: DateTime.now(),
          details: 'Payment of ₱${amount.toStringAsFixed(2)} via ${_paymentMethodToString(method)}',
        ),
      ],
    );

    return payment;
  }

  /// Confirm payment received (seller)
  Future<PaymentConfirmation> confirmPaymentReceived({
    required String preTransactionId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 1000));

    final preTransaction = _preTransactions[preTransactionId];
    if (preTransaction?.paymentConfirmation == null) {
      throw Exception('Payment not initiated');
    }

    final updatedPayment = preTransaction!.paymentConfirmation!.copyWith(
      sellerConfirmed: true,
      sellerConfirmedAt: DateTime.now(),
      status: PaymentConfirmationStatus.confirmed,
    );

    _preTransactions[preTransactionId] = preTransaction.copyWith(
      paymentConfirmation: updatedPayment,
      status: PreTransactionStatus.paymentConfirmed,
      auditLog: [
        ...preTransaction.auditLog,
        AuditLogEntry(
          id: 'audit_${DateTime.now().millisecondsSinceEpoch}',
          preTransactionId: preTransactionId,
          action: 'Payment Confirmed',
          actor: 'seller',
          actorName: preTransaction.sellerName,
          timestamp: DateTime.now(),
          details: 'Seller confirmed receipt of payment',
        ),
      ],
    );

    return updatedPayment;
  }

  /// Release vehicle (seller)
  Future<HandoverConfirmation> releaseVehicle({
    required String preTransactionId,
    required List<String> photoUrls,
    required String location,
  }) async {
    await Future.delayed(const Duration(milliseconds: 1500));

    final preTransaction = _preTransactions[preTransactionId];
    if (preTransaction == null) {
      throw Exception('Pre-transaction not found');
    }

    final handover = HandoverConfirmation(
      id: 'handover_${DateTime.now().millisecondsSinceEpoch}',
      preTransactionId: preTransactionId,
      sellerReleased: true,
      sellerReleasedAt: DateTime.now(),
      sellerPhotoUrls: photoUrls,
      releaseLocation: location,
      createdAt: DateTime.now(),
      status: HandoverConfirmationStatus.released,
    );

    _preTransactions[preTransactionId] = preTransaction.copyWith(
      handoverConfirmation: handover,
      status: PreTransactionStatus.handoverPending,
      auditLog: [
        ...preTransaction.auditLog,
        AuditLogEntry(
          id: 'audit_${DateTime.now().millisecondsSinceEpoch}',
          preTransactionId: preTransactionId,
          action: 'Vehicle Released',
          actor: 'seller',
          actorName: preTransaction.sellerName,
          timestamp: DateTime.now(),
          details: 'Vehicle released at $location',
        ),
      ],
    );

    return handover;
  }

  /// Confirm vehicle received (buyer)
  Future<HandoverConfirmation> confirmVehicleReceived({
    required String preTransactionId,
    required bool conditionAccepted,
    required String? notes,
  }) async {
    await Future.delayed(const Duration(milliseconds: 1000));

    final preTransaction = _preTransactions[preTransactionId];
    if (preTransaction?.handoverConfirmation == null) {
      throw Exception('Vehicle not released');
    }

    final updatedHandover = preTransaction!.handoverConfirmation!.copyWith(
      buyerReceived: true,
      buyerReceivedAt: DateTime.now(),
      buyerConditionAccepted: conditionAccepted,
      buyerNotes: notes,
      ownershipDocumentsTransferred: true,
      ownershipDocuments: ['Official Receipt (OR)', 'Certificate of Registration (CR)', 'Deed of Sale'],
      status: HandoverConfirmationStatus.completed,
    );

    _preTransactions[preTransactionId] = preTransaction.copyWith(
      handoverConfirmation: updatedHandover,
      status: PreTransactionStatus.transactionCompleted,
      auditLog: [
        ...preTransaction.auditLog,
        AuditLogEntry(
          id: 'audit_${DateTime.now().millisecondsSinceEpoch}',
          preTransactionId: preTransactionId,
          action: 'Vehicle Received',
          actor: 'buyer',
          actorName: preTransaction.buyerName,
          timestamp: DateTime.now(),
          details: conditionAccepted
              ? 'Vehicle received and condition accepted'
              : 'Vehicle received with notes: $notes',
        ),
        AuditLogEntry(
          id: 'audit_${DateTime.now().millisecondsSinceEpoch + 1}',
          preTransactionId: preTransactionId,
          action: 'Transaction Completed',
          actor: 'system',
          actorName: 'AutoBID System',
          timestamp: DateTime.now(),
          details: 'All steps completed successfully under RA 8792 compliance',
        ),
      ],
    );

    return updatedHandover;
  }

  /// Create initial pre-transaction (called when entering RA 8792 flow)
  void createPreTransaction(PreTransaction preTransaction) {
    _preTransactions[preTransaction.id] = preTransaction.copyWith(
      status: PreTransactionStatus.pendingVerification,
      auditLog: [
        AuditLogEntry(
          id: 'audit_${DateTime.now().millisecondsSinceEpoch}',
          preTransactionId: preTransaction.id,
          action: 'Pre-Transaction Created',
          actor: 'system',
          actorName: 'AutoBID System',
          timestamp: DateTime.now(),
          details: 'RA 8792 compliant pre-transaction workflow initiated',
        ),
      ],
    );
  }

  // Helper methods
  String _idTypeToString(GovernmentIdType type) {
    switch (type) {
      case GovernmentIdType.driversLicense:
        return "Driver's License";
      case GovernmentIdType.passport:
        return 'Passport';
      case GovernmentIdType.nationalId:
        return 'National ID';
      case GovernmentIdType.umid:
        return 'UMID';
      case GovernmentIdType.sss:
        return 'SSS ID';
      case GovernmentIdType.gsis:
        return 'GSIS ID';
      case GovernmentIdType.philhealth:
        return 'PhilHealth ID';
      case GovernmentIdType.votersId:
        return "Voter's ID";
      case GovernmentIdType.prcId:
        return 'PRC ID';
    }
  }

  String _paymentMethodToString(PaymentMethod method) {
    switch (method) {
      case PaymentMethod.cash:
        return 'Cash';
      case PaymentMethod.bankTransfer:
        return 'Bank Transfer';
      case PaymentMethod.gcash:
        return 'GCash';
      case PaymentMethod.paymaya:
        return 'PayMaya';
      case PaymentMethod.bankCheck:
        return 'Bank Check';
      case PaymentMethod.other:
        return 'Other';
    }
  }
}
