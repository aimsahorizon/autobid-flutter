// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pre_transaction_confirmation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PreTransactionConfirmation _$PreTransactionConfirmationFromJson(
  Map<String, dynamic> json,
) => _PreTransactionConfirmation(
  id: json['id'] as String,
  userId: json['userId'] as String,
  userName: json['userName'] as String,
  vehicleIdentityConfirmed: json['vehicleIdentityConfirmed'] as bool,
  vinNumber: json['vinNumber'] as String?,
  licensePlate: json['licensePlate'] as String?,
  conditionAccuratelyRepresented:
      json['conditionAccuratelyRepresented'] as bool,
  knownIssues:
      (json['knownIssues'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  finalBidPrice: (json['finalBidPrice'] as num).toDouble(),
  additionalFees: (json['additionalFees'] as num?)?.toDouble() ?? 0.0,
  paymentTimelineDays: (json['paymentTimelineDays'] as num?)?.toInt() ?? 3,
  latePaymentPenaltyAcknowledged:
      json['latePaymentPenaltyAcknowledged'] as bool? ?? false,
  shippingMethod: $enumDecodeNullable(
    _$ShippingMethodEnumMap,
    json['shippingMethod'],
  ),
  shippingCostResponsibility: $enumDecodeNullable(
    _$ShippingCostResponsibilityEnumMap,
    json['shippingCostResponsibility'],
  ),
  insuranceResponsibility: $enumDecodeNullable(
    _$InsuranceResponsibilityEnumMap,
    json['insuranceResponsibility'],
  ),
  estimatedDeliveryDays: (json['estimatedDeliveryDays'] as num?)?.toInt() ?? 3,
  requiredShippingEvidence:
      (json['requiredShippingEvidence'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const ['VIN Photo', '360° Video', 'Shipping Receipt', 'GPS Check-in'],
  shippingEvidenceCommitment:
      json['shippingEvidenceCommitment'] as bool? ?? false,
  transitInsuranceAcknowledged:
      json['transitInsuranceAcknowledged'] as bool? ?? false,
  vehicleInspectionPeriodHours:
      (json['vehicleInspectionPeriodHours'] as num?)?.toInt() ?? 48,
  inspectionMethod: $enumDecodeNullable(
    _$InspectionMethodEnumMap,
    json['inspectionMethod'],
  ),
  acceptanceCriteria: json['acceptanceCriteria'] as String?,
  discrepancyProcedure: json['discrepancyProcedure'] as String?,
  buyerConfirmationLimitHours:
      (json['buyerConfirmationLimitHours'] as num?)?.toInt() ?? 24,
  sellerInspectionReviewCommitment:
      json['sellerInspectionReviewCommitment'] as bool? ?? false,
  inspectionNotes: json['inspectionNotes'] as String?,
  sellerOwnershipConfirmed: json['sellerOwnershipConfirmed'] as bool? ?? false,
  titleTransferAcknowledged:
      json['titleTransferAcknowledged'] as bool? ?? false,
  noOutstandingLiensAcknowledged:
      json['noOutstandingLiensAcknowledged'] as bool? ?? false,
  ownershipTransferProcessAcknowledged:
      json['ownershipTransferProcessAcknowledged'] as bool? ?? false,
  specialTransferInstructions: json['specialTransferInstructions'] as String?,
  allIssuesDisclosedAccurately:
      json['allIssuesDisclosedAccurately'] as bool? ?? false,
  conditionAsRepresented: json['conditionAsRepresented'] as bool? ?? false,
  supportingDocumentsUrls:
      (json['supportingDocumentsUrls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  discussionsLoggedAcknowledged:
      json['discussionsLoggedAcknowledged'] as bool? ?? false,
  disputeResolutionProcessAgreed:
      json['disputeResolutionProcessAgreed'] as bool? ?? false,
  fraudPoliciesAcknowledged:
      json['fraudPoliciesAcknowledged'] as bool? ?? false,
  additionalProtections: json['additionalProtections'] as String?,
  sellerProtectionMeasures: json['sellerProtectionMeasures'] as String?,
  informationAccuracyConfirmed:
      json['informationAccuracyConfirmed'] as bool? ?? false,
  termsAgreed: json['termsAgreed'] as bool,
  deliveryDate: json['deliveryDate'] as String?,
  deliveryLocation: json['deliveryLocation'] as String?,
  uploadedDocuments:
      (json['uploadedDocuments'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  confirmedAt: DateTime.parse(json['confirmedAt'] as String),
  notes: json['notes'] as String?,
);

Map<String, dynamic> _$PreTransactionConfirmationToJson(
  _PreTransactionConfirmation instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'userName': instance.userName,
  'vehicleIdentityConfirmed': instance.vehicleIdentityConfirmed,
  'vinNumber': instance.vinNumber,
  'licensePlate': instance.licensePlate,
  'conditionAccuratelyRepresented': instance.conditionAccuratelyRepresented,
  'knownIssues': instance.knownIssues,
  'finalBidPrice': instance.finalBidPrice,
  'additionalFees': instance.additionalFees,
  'paymentTimelineDays': instance.paymentTimelineDays,
  'latePaymentPenaltyAcknowledged': instance.latePaymentPenaltyAcknowledged,
  'shippingMethod': _$ShippingMethodEnumMap[instance.shippingMethod],
  'shippingCostResponsibility':
      _$ShippingCostResponsibilityEnumMap[instance.shippingCostResponsibility],
  'insuranceResponsibility':
      _$InsuranceResponsibilityEnumMap[instance.insuranceResponsibility],
  'estimatedDeliveryDays': instance.estimatedDeliveryDays,
  'requiredShippingEvidence': instance.requiredShippingEvidence,
  'shippingEvidenceCommitment': instance.shippingEvidenceCommitment,
  'transitInsuranceAcknowledged': instance.transitInsuranceAcknowledged,
  'vehicleInspectionPeriodHours': instance.vehicleInspectionPeriodHours,
  'inspectionMethod': _$InspectionMethodEnumMap[instance.inspectionMethod],
  'acceptanceCriteria': instance.acceptanceCriteria,
  'discrepancyProcedure': instance.discrepancyProcedure,
  'buyerConfirmationLimitHours': instance.buyerConfirmationLimitHours,
  'sellerInspectionReviewCommitment': instance.sellerInspectionReviewCommitment,
  'inspectionNotes': instance.inspectionNotes,
  'sellerOwnershipConfirmed': instance.sellerOwnershipConfirmed,
  'titleTransferAcknowledged': instance.titleTransferAcknowledged,
  'noOutstandingLiensAcknowledged': instance.noOutstandingLiensAcknowledged,
  'ownershipTransferProcessAcknowledged':
      instance.ownershipTransferProcessAcknowledged,
  'specialTransferInstructions': instance.specialTransferInstructions,
  'allIssuesDisclosedAccurately': instance.allIssuesDisclosedAccurately,
  'conditionAsRepresented': instance.conditionAsRepresented,
  'supportingDocumentsUrls': instance.supportingDocumentsUrls,
  'discussionsLoggedAcknowledged': instance.discussionsLoggedAcknowledged,
  'disputeResolutionProcessAgreed': instance.disputeResolutionProcessAgreed,
  'fraudPoliciesAcknowledged': instance.fraudPoliciesAcknowledged,
  'additionalProtections': instance.additionalProtections,
  'sellerProtectionMeasures': instance.sellerProtectionMeasures,
  'informationAccuracyConfirmed': instance.informationAccuracyConfirmed,
  'termsAgreed': instance.termsAgreed,
  'deliveryDate': instance.deliveryDate,
  'deliveryLocation': instance.deliveryLocation,
  'uploadedDocuments': instance.uploadedDocuments,
  'confirmedAt': instance.confirmedAt.toIso8601String(),
  'notes': instance.notes,
};

const _$ShippingMethodEnumMap = {
  ShippingMethod.pickup: 'pickup',
  ShippingMethod.transporter: 'transporter',
  ShippingMethod.sellerArranged: 'seller_arranged',
};

const _$ShippingCostResponsibilityEnumMap = {
  ShippingCostResponsibility.buyer: 'buyer',
  ShippingCostResponsibility.seller: 'seller',
  ShippingCostResponsibility.shared: 'shared',
};

const _$InsuranceResponsibilityEnumMap = {
  InsuranceResponsibility.buyer: 'buyer',
  InsuranceResponsibility.seller: 'seller',
  InsuranceResponsibility.both: 'both',
};

const _$InspectionMethodEnumMap = {
  InspectionMethod.inPerson: 'in_person',
  InspectionMethod.videoWalkthrough: 'video_walkthrough',
  InspectionMethod.thirdParty: 'third_party',
};
