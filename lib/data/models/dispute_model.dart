import 'package:freezed_annotation/freezed_annotation.dart';

part 'dispute_model.freezed.dart';
part 'dispute_model.g.dart';

enum RefundReason {
  conditionMismatch,
  wrongVehicle,
  missingDocuments,
  sellerMisrepresentation,
  other,
}

@freezed
abstract class DisputeModel with _$DisputeModel {
  const factory DisputeModel({
    required String id,
    required String transactionId,
    required String initiatorId,
    required RefundReason reason,
    required String description,
    required List<String> evidencePhotos,
    String? evidenceVideo,
    required DateTime createdAt,
    String? sellerResponse,
    List<String>? sellerCounterEvidence,
    DateTime? sellerRespondedAt,
    String? adminDecision, // 'approved' or 'rejected'
    String? adminNotes,
    DateTime? resolvedAt,
  }) = _DisputeModel;

  factory DisputeModel.fromJson(Map<String, dynamic> json) =>
      _$DisputeModelFromJson(json);
}
