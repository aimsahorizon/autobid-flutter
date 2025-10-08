import 'package:freezed_annotation/freezed_annotation.dart';

part 'transfer_evidence_model.freezed.dart';
part 'transfer_evidence_model.g.dart';

enum ValidationStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('under_review')
  underReview,
  @JsonValue('approved')
  approved,
  @JsonValue('rejected')
  rejected,
  @JsonValue('more_info_needed')
  moreInfoNeeded,
}

@freezed
abstract class TransferEvidence with _$TransferEvidence {
  const factory TransferEvidence({
    required String id,
    required String transactionId,
    required String buyerId,
    required DateTime submittedAt,

    // Documents
    String? deedOfSaleUrl,
    String? crOrTransferUrl,
    String? officialReceiptUrl,

    // Vehicle photos
    required List<String> vehiclePhotoUrls,
    String? odometerPhotoUrl,
    String? vinPhotoUrl,
    int? odometerReading,

    // Condition photos
    required List<String> conditionPhotoUrls,
    List<String>? damagePhotoUrls,

    // Delivery receipt
    String? deliveryReceiptUrl,
    String? buyerNotes,
    @Default(false) bool buyerSignature,

    // Validation
    required ValidationStatus status,
    DateTime? validatedAt,
    String? validatedBy,
    String? rejectionReason,

  }) = _TransferEvidence;

  factory TransferEvidence.fromJson(Map<String, dynamic> json) =>
      _$TransferEvidenceFromJson(json);
}
