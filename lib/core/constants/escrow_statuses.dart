import 'package:flutter/material.dart';
import '../../data/models/transaction_model.dart';

class EscrowStatusInfo {
  final EscrowStatus status;
  final String displayName;
  final String description;
  final Color color;
  final IconData icon;

  const EscrowStatusInfo({
    required this.status,
    required this.displayName,
    required this.description,
    required this.color,
    required this.icon,
  });
}

class EscrowStatuses {
  static const pending = EscrowStatusInfo(
    status: EscrowStatus.pending,
    displayName: 'Payment Pending',
    description: 'Waiting for buyer to submit payment',
    color: Colors.orange,
    icon: Icons.pending_actions,
  );

  static const held = EscrowStatusInfo(
    status: EscrowStatus.held,
    displayName: 'Escrow Held',
    description: 'Payment secured in escrow, waiting for delivery',
    color: Colors.blue,
    icon: Icons.lock,
  );

  static const validating = EscrowStatusInfo(
    status: EscrowStatus.validating,
    displayName: 'Transfer Validation',
    description: 'Validating transfer evidence (1-3 business days)',
    color: Colors.amber,
    icon: Icons.verified_user,
  );

  static const released = EscrowStatusInfo(
    status: EscrowStatus.released,
    displayName: 'Payment Released',
    description: 'Payment released to seller',
    color: Colors.green,
    icon: Icons.check_circle,
  );

  static const refunded = EscrowStatusInfo(
    status: EscrowStatus.refunded,
    displayName: 'Refunded',
    description: 'Payment refunded to buyer',
    color: Colors.red,
    icon: Icons.money_off,
  );

  static const disputed = EscrowStatusInfo(
    status: EscrowStatus.disputed,
    displayName: 'Disputed',
    description: 'Transaction under review',
    color: Colors.red,
    icon: Icons.warning,
  );

  static const all = [pending, held, validating, released, refunded, disputed];

  static EscrowStatusInfo getInfo(EscrowStatus status) {
    return all.firstWhere((info) => info.status == status);
  }
}
