// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'digital_agreement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DigitalAgreement _$DigitalAgreementFromJson(
  Map<String, dynamic> json,
) => _DigitalAgreement(
  id: json['id'] as String,
  auctionId: json['auctionId'] as String,
  preTransactionId: json['preTransactionId'] as String,
  buyerId: json['buyerId'] as String,
  buyerName: json['buyerName'] as String,
  buyerSignature: json['buyerSignature'] as String?,
  buyerSignedAt: json['buyerSignedAt'] == null
      ? null
      : DateTime.parse(json['buyerSignedAt'] as String),
  sellerId: json['sellerId'] as String,
  sellerName: json['sellerName'] as String,
  sellerSignature: json['sellerSignature'] as String?,
  sellerSignedAt: json['sellerSignedAt'] == null
      ? null
      : DateTime.parse(json['sellerSignedAt'] as String),
  vehicleMake: json['vehicleMake'] as String,
  vehicleModel: json['vehicleModel'] as String,
  vehicleYear: json['vehicleYear'] as String,
  vinNumber: json['vinNumber'] as String,
  licensePlate: json['licensePlate'] as String,
  vehicleColor: json['vehicleColor'] as String?,
  finalBidPrice: (json['finalBidPrice'] as num).toDouble(),
  additionalFees: (json['additionalFees'] as num?)?.toDouble() ?? 0.0,
  totalAmount: (json['totalAmount'] as num?)?.toDouble() ?? 0.0,
  paymentTerms: json['paymentTerms'] as String,
  deliveryMethod: json['deliveryMethod'] as String,
  transferAcknowledgment: json['transferAcknowledgment'] as bool? ?? true,
  legalConsentText: json['legalConsentText'] as String,
  disputeClause: json['disputeClause'] as String,
  documentHash: json['documentHash'] as String,
  agreementGeneratedAt: DateTime.parse(json['agreementGeneratedAt'] as String),
  status:
      $enumDecodeNullable(_$DigitalAgreementStatusEnumMap, json['status']) ??
      DigitalAgreementStatus.draft,
);

Map<String, dynamic> _$DigitalAgreementToJson(_DigitalAgreement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'auctionId': instance.auctionId,
      'preTransactionId': instance.preTransactionId,
      'buyerId': instance.buyerId,
      'buyerName': instance.buyerName,
      'buyerSignature': instance.buyerSignature,
      'buyerSignedAt': instance.buyerSignedAt?.toIso8601String(),
      'sellerId': instance.sellerId,
      'sellerName': instance.sellerName,
      'sellerSignature': instance.sellerSignature,
      'sellerSignedAt': instance.sellerSignedAt?.toIso8601String(),
      'vehicleMake': instance.vehicleMake,
      'vehicleModel': instance.vehicleModel,
      'vehicleYear': instance.vehicleYear,
      'vinNumber': instance.vinNumber,
      'licensePlate': instance.licensePlate,
      'vehicleColor': instance.vehicleColor,
      'finalBidPrice': instance.finalBidPrice,
      'additionalFees': instance.additionalFees,
      'totalAmount': instance.totalAmount,
      'paymentTerms': instance.paymentTerms,
      'deliveryMethod': instance.deliveryMethod,
      'transferAcknowledgment': instance.transferAcknowledgment,
      'legalConsentText': instance.legalConsentText,
      'disputeClause': instance.disputeClause,
      'documentHash': instance.documentHash,
      'agreementGeneratedAt': instance.agreementGeneratedAt.toIso8601String(),
      'status': _$DigitalAgreementStatusEnumMap[instance.status]!,
    };

const _$DigitalAgreementStatusEnumMap = {
  DigitalAgreementStatus.draft: 'draft',
  DigitalAgreementStatus.partialSigned: 'partial_signed',
  DigitalAgreementStatus.fullySigned: 'fully_signed',
};
