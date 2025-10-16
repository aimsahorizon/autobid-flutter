import 'package:freezed_annotation/freezed_annotation.dart';
import 'pre_transaction_message_model.dart';
import 'pre_transaction_confirmation_model.dart';

part 'pre_transaction_model.freezed.dart';
part 'pre_transaction_model.g.dart';

enum PreTransactionStatus {
  @JsonValue('pending_discussion')
  pendingDiscussion,
  @JsonValue('in_discussion')
  inDiscussion,
  @JsonValue('pending_buyer_confirmation')
  pendingBuyerConfirmation,
  @JsonValue('pending_seller_confirmation')
  pendingSellerConfirmation,
  @JsonValue('pending_mutual_confirmation')
  pendingMutualConfirmation,
  @JsonValue('confirmed')
  confirmed,
  @JsonValue('ready_for_payment')
  readyForPayment,
  @JsonValue('cancelled')
  cancelled,
}

@freezed
abstract class PreTransaction with _$PreTransaction {
  const factory PreTransaction({
    required String id,
    required String auctionId,
    required String carId,
    required String carTitle,
    required String buyerId,
    required String sellerId,
    required String buyerName,
    required String sellerName,
    required double finalBidAmount,
    required PreTransactionStatus status,
    @Default([]) List<PreTransactionMessage> messages,
    PreTransactionConfirmation? buyerConfirmation,
    PreTransactionConfirmation? sellerConfirmation,
    required DateTime createdAt,
    DateTime? discussionStartedAt,
    DateTime? buyerConfirmedAt,
    DateTime? sellerConfirmedAt,
    DateTime? mutualConfirmationAt,
    DateTime? readyForPaymentAt,
    String? cancellationReason,
    DateTime? cancelledAt,
  }) = _PreTransaction;

  factory PreTransaction.fromJson(Map<String, dynamic> json) =>
      _$PreTransactionFromJson(json);
}
