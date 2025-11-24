import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/pre_transaction_model.dart';
import '../../data/models/kyc_verification_model.dart';
import '../../data/models/payment_confirmation_model.dart';
import '../../data/services/mock/mock_ra_8792_service.dart';

part 'ra_8792_pre_transaction_provider.g.dart';

/// RA 8792 compliant pre-transaction provider
/// Manages the entire pre-transaction workflow with legal compliance
@riverpod
class Ra8792PreTransactionNotifier extends _$Ra8792PreTransactionNotifier {
  final MockRa8792Service _service = MockRa8792Service();

  @override
  PreTransaction? build(String preTransactionId) {
    // Load pre-transaction from service
    return _service.getPreTransaction(preTransactionId);
  }

  /// Initialize pre-transaction (called when entering RA 8792 flow)
  Future<void> initialize(PreTransaction preTransaction) async {
    _service.createPreTransaction(preTransaction);
    state = _service.getPreTransaction(preTransaction.id);
  }

  /// Submit KYC verification for buyer or seller
  /// Complies with RA 8792 identity verification requirements
  Future<void> submitKycVerification({
    required String userId,
    required String userName,
    required GovernmentIdType idType,
    required String idNumber,
    required String idPhotoUrl,
    required String selfiePhotoUrl,
    required bool ra8792Consent,
  }) async {
    if (state == null) return;

    try {
      // Submit to service
      await _service.submitKycVerification(
        preTransactionId: state!.id,
        userId: userId,
        userName: userName,
        idType: idType,
        idNumber: idNumber,
        idPhotoUrl: idPhotoUrl,
        selfiePhotoUrl: selfiePhotoUrl,
        ra8792Consent: ra8792Consent,
      );

      // Refresh state
      state = _service.getPreTransaction(state!.id);
    } catch (e) {
      // Error handling - in production, show error to user
      rethrow;
    }
  }

  /// Generate digital agreement
  /// Creates legally binding electronic contract under RA 8792
  Future<void> generateDigitalAgreement() async {
    if (state == null) return;

    try {
      await _service.generateDigitalAgreement(
        preTransactionId: state!.id,
      );

      // Refresh state
      state = _service.getPreTransaction(state!.id);
    } catch (e) {
      rethrow;
    }
  }

  /// Sign digital agreement (buyer or seller)
  /// Electronic signatures are legally binding under RA 8792 Section 8
  Future<void> signAgreement({
    required String userId,
    required String signature,
  }) async {
    if (state == null) return;

    try {
      await _service.signAgreement(
        preTransactionId: state!.id,
        userId: userId,
        signature: signature,
      );

      // Refresh state
      state = _service.getPreTransaction(state!.id);
    } catch (e) {
      rethrow;
    }
  }

  /// Initiate payment (buyer)
  /// Electronic payment confirmation under RA 8792 Section 11
  Future<void> initiatePayment({
    required List<String> proofUrls,
    required PaymentMethod method,
    required String? referenceNumber,
    required double amount,
  }) async {
    if (state == null) return;

    try {
      await _service.initiatePayment(
        preTransactionId: state!.id,
        proofUrls: proofUrls,
        method: method,
        referenceNumber: referenceNumber,
        amount: amount,
      );

      // Refresh state
      state = _service.getPreTransaction(state!.id);
    } catch (e) {
      rethrow;
    }
  }

  /// Confirm payment received (seller)
  /// Creates electronic receipt under RA 8792
  Future<void> confirmPaymentReceived() async {
    if (state == null) return;

    try {
      await _service.confirmPaymentReceived(
        preTransactionId: state!.id,
      );

      // Refresh state
      state = _service.getPreTransaction(state!.id);
    } catch (e) {
      rethrow;
    }
  }

  /// Release vehicle (seller)
  /// Documents vehicle transfer with photos and location
  Future<void> releaseVehicle({
    required List<String> photoUrls,
    required String location,
  }) async {
    if (state == null) return;

    try {
      await _service.releaseVehicle(
        preTransactionId: state!.id,
        photoUrls: photoUrls,
        location: location,
      );

      // Refresh state
      state = _service.getPreTransaction(state!.id);
    } catch (e) {
      rethrow;
    }
  }

  /// Confirm vehicle received (buyer)
  /// Final step completing the transaction
  Future<void> confirmVehicleReceived({
    required bool conditionAccepted,
    required String? notes,
  }) async {
    if (state == null) return;

    try {
      await _service.confirmVehicleReceived(
        preTransactionId: state!.id,
        conditionAccepted: conditionAccepted,
        notes: notes,
      );

      // Refresh state
      state = _service.getPreTransaction(state!.id);
    } catch (e) {
      rethrow;
    }
  }

  /// Helper getters for UI state
  bool get isBuyerVerified => state?.buyerVerification?.status == KycVerificationStatus.verified;
  bool get isSellerVerified => state?.sellerVerification?.status == KycVerificationStatus.verified;
  bool get isBothVerified => isBuyerVerified && isSellerVerified;
  bool get isAgreementGenerated => state?.digitalAgreement != null;
  bool get isBuyerSigned => state?.digitalAgreement?.buyerSignature != null;
  bool get isSellerSigned => state?.digitalAgreement?.sellerSignature != null;
  bool get isBothSigned => isBuyerSigned && isSellerSigned;
  bool get isPaymentInitiated => state?.paymentConfirmation?.buyerInitiated ?? false;
  bool get isPaymentConfirmed => state?.paymentConfirmation?.sellerConfirmed ?? false;
  bool get isVehicleReleased => state?.handoverConfirmation?.sellerReleased ?? false;
  bool get isVehicleReceived => state?.handoverConfirmation?.buyerReceived ?? false;
  bool get isTransactionCompleted => state?.status == PreTransactionStatus.transactionCompleted;
}
