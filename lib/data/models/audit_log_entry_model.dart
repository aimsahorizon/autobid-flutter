import 'package:freezed_annotation/freezed_annotation.dart';

part 'audit_log_entry_model.freezed.dart';
part 'audit_log_entry_model.g.dart';

/// Audit log entry model for immutable transaction tracking
/// Protected under RA 8792 Sections 6-13 for legal compliance
@freezed
abstract class AuditLogEntry with _$AuditLogEntry {
  const factory AuditLogEntry({
    required String id,
    required String preTransactionId,

    // ===== ACTION DETAILS =====
    /// Action performed (e.g., "Buyer Verified", "Agreement Signed", "Payment Confirmed")
    required String action,

    /// Actor who performed the action ('buyer' or 'seller')
    required String actor,

    /// Name of the actor
    required String actorName,

    /// Timestamp when action occurred
    required DateTime timestamp,

    /// Optional detailed description of the action
    String? details,

    // ===== RA 8792 PROTECTION =====
    /// Flag indicating this record is protected under RA 8792
    /// "This digital record is protected under the Electronic Commerce Act
    /// of 2000 (RA 8792), Sections 6-13, and serves as admissible evidence
    /// in legal proceedings."
    @Default(true) bool ra8792Protected,
  }) = _AuditLogEntry;

  factory AuditLogEntry.fromJson(Map<String, dynamic> json) =>
      _$AuditLogEntryFromJson(json);
}
