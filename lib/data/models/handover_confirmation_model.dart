import 'package:freezed_annotation/freezed_annotation.dart';

part 'handover_confirmation_model.freezed.dart';
part 'handover_confirmation_model.g.dart';

/// Handover confirmation status
enum HandoverConfirmationStatus {
  @JsonValue('pending')
  pending, // Not yet released
  @JsonValue('released')
  released, // Seller released vehicle
  @JsonValue('received')
  received, // Buyer received vehicle
  @JsonValue('completed')
  completed, // Handover fully completed
}

/// Handover confirmation model for vehicle transfer tracking
/// Documents the physical transfer of vehicle from seller to buyer
@freezed
abstract class HandoverConfirmation with _$HandoverConfirmation {
  const factory HandoverConfirmation({
    required String id,
    required String preTransactionId,

    // ===== SELLER VEHICLE RELEASE =====
    /// Whether seller has released the vehicle
    @Default(false) bool sellerReleased,

    /// Timestamp when seller released vehicle
    DateTime? sellerReleasedAt,

    /// URLs to photos taken by seller at release (vehicle condition, etc.)
    @Default([]) List<String> sellerPhotoUrls,

    /// Location where vehicle was released (e.g., "Quezon City, Metro Manila")
    String? releaseLocation,

    /// Optional notes from seller about release
    String? sellerNotes,

    // ===== BUYER VEHICLE RECEIPT =====
    /// Whether buyer has received the vehicle
    @Default(false) bool buyerReceived,

    /// Timestamp when buyer received vehicle
    DateTime? buyerReceivedAt,

    /// Whether buyer accepted the vehicle condition
    @Default(false) bool buyerConditionAccepted,

    /// URLs to photos taken by buyer at receipt
    @Default([]) List<String> buyerPhotoUrls,

    /// Optional notes from buyer about vehicle condition
    String? buyerNotes,

    // ===== OWNERSHIP TRANSFER =====
    /// Whether ownership documents were transferred
    @Default(false) bool ownershipDocumentsTransferred,

    /// List of ownership documents transferred (e.g., "OR/CR", "Deed of Sale")
    @Default([]) List<String> ownershipDocuments,

    // ===== METADATA =====
    /// Current status of handover confirmation
    @Default(HandoverConfirmationStatus.pending) HandoverConfirmationStatus status,

    /// Timestamp when handover confirmation was created
    required DateTime createdAt,
  }) = _HandoverConfirmation;

  factory HandoverConfirmation.fromJson(Map<String, dynamic> json) =>
      _$HandoverConfirmationFromJson(json);
}
