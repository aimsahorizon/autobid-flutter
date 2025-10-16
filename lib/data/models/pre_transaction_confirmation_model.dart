import 'package:freezed_annotation/freezed_annotation.dart';

part 'pre_transaction_confirmation_model.freezed.dart';
part 'pre_transaction_confirmation_model.g.dart';

@freezed
abstract class PreTransactionConfirmation with _$PreTransactionConfirmation {
  const factory PreTransactionConfirmation({
    required String id,
    required String userId,
    required String userName,
    required bool vehicleDetailsConfirmed,
    String? deliveryDate,
    String? deliveryLocation,
    @Default([]) List<String> uploadedDocuments,
    required bool termsAgreed,
    required DateTime confirmedAt,
    String? notes,
  }) = _PreTransactionConfirmation;

  factory PreTransactionConfirmation.fromJson(Map<String, dynamic> json) =>
      _$PreTransactionConfirmationFromJson(json);
}
