// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pre_transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PreTransaction _$PreTransactionFromJson(Map<String, dynamic> json) =>
    _PreTransaction(
      id: json['id'] as String,
      auctionId: json['auctionId'] as String,
      carId: json['carId'] as String,
      carTitle: json['carTitle'] as String,
      buyerId: json['buyerId'] as String,
      sellerId: json['sellerId'] as String,
      buyerName: json['buyerName'] as String,
      sellerName: json['sellerName'] as String,
      finalBidAmount: (json['finalBidAmount'] as num).toDouble(),
      status: $enumDecode(_$PreTransactionStatusEnumMap, json['status']),
      messages:
          (json['messages'] as List<dynamic>?)
              ?.map(
                (e) =>
                    PreTransactionMessage.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      buyerConfirmation: json['buyerConfirmation'] == null
          ? null
          : PreTransactionConfirmation.fromJson(
              json['buyerConfirmation'] as Map<String, dynamic>,
            ),
      sellerConfirmation: json['sellerConfirmation'] == null
          ? null
          : PreTransactionConfirmation.fromJson(
              json['sellerConfirmation'] as Map<String, dynamic>,
            ),
      createdAt: DateTime.parse(json['createdAt'] as String),
      discussionStartedAt: json['discussionStartedAt'] == null
          ? null
          : DateTime.parse(json['discussionStartedAt'] as String),
      buyerConfirmedAt: json['buyerConfirmedAt'] == null
          ? null
          : DateTime.parse(json['buyerConfirmedAt'] as String),
      sellerConfirmedAt: json['sellerConfirmedAt'] == null
          ? null
          : DateTime.parse(json['sellerConfirmedAt'] as String),
      mutualConfirmationAt: json['mutualConfirmationAt'] == null
          ? null
          : DateTime.parse(json['mutualConfirmationAt'] as String),
      adminReviewStartedAt: json['adminReviewStartedAt'] == null
          ? null
          : DateTime.parse(json['adminReviewStartedAt'] as String),
      adminReviewCompletedAt: json['adminReviewCompletedAt'] == null
          ? null
          : DateTime.parse(json['adminReviewCompletedAt'] as String),
      adminReviewNotes: json['adminReviewNotes'] as String?,
      readyForPaymentAt: json['readyForPaymentAt'] == null
          ? null
          : DateTime.parse(json['readyForPaymentAt'] as String),
      cancellationReason: json['cancellationReason'] as String?,
      cancelledAt: json['cancelledAt'] == null
          ? null
          : DateTime.parse(json['cancelledAt'] as String),
    );

Map<String, dynamic> _$PreTransactionToJson(
  _PreTransaction instance,
) => <String, dynamic>{
  'id': instance.id,
  'auctionId': instance.auctionId,
  'carId': instance.carId,
  'carTitle': instance.carTitle,
  'buyerId': instance.buyerId,
  'sellerId': instance.sellerId,
  'buyerName': instance.buyerName,
  'sellerName': instance.sellerName,
  'finalBidAmount': instance.finalBidAmount,
  'status': _$PreTransactionStatusEnumMap[instance.status]!,
  'messages': instance.messages,
  'buyerConfirmation': instance.buyerConfirmation,
  'sellerConfirmation': instance.sellerConfirmation,
  'createdAt': instance.createdAt.toIso8601String(),
  'discussionStartedAt': instance.discussionStartedAt?.toIso8601String(),
  'buyerConfirmedAt': instance.buyerConfirmedAt?.toIso8601String(),
  'sellerConfirmedAt': instance.sellerConfirmedAt?.toIso8601String(),
  'mutualConfirmationAt': instance.mutualConfirmationAt?.toIso8601String(),
  'adminReviewStartedAt': instance.adminReviewStartedAt?.toIso8601String(),
  'adminReviewCompletedAt': instance.adminReviewCompletedAt?.toIso8601String(),
  'adminReviewNotes': instance.adminReviewNotes,
  'readyForPaymentAt': instance.readyForPaymentAt?.toIso8601String(),
  'cancellationReason': instance.cancellationReason,
  'cancelledAt': instance.cancelledAt?.toIso8601String(),
};

const _$PreTransactionStatusEnumMap = {
  PreTransactionStatus.pendingDiscussion: 'pending_discussion',
  PreTransactionStatus.inDiscussion: 'in_discussion',
  PreTransactionStatus.pendingBuyerConfirmation: 'pending_buyer_confirmation',
  PreTransactionStatus.pendingSellerConfirmation: 'pending_seller_confirmation',
  PreTransactionStatus.pendingMutualConfirmation: 'pending_mutual_confirmation',
  PreTransactionStatus.confirmed: 'confirmed',
  PreTransactionStatus.pendingAdminReview: 'pending_admin_review',
  PreTransactionStatus.adminApproved: 'admin_approved',
  PreTransactionStatus.readyForPayment: 'ready_for_payment',
  PreTransactionStatus.cancelled: 'cancelled',
};
