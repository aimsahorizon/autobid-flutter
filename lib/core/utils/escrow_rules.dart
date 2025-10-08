class EscrowRules {
  static const int autoReleaseDays = 7;
  static const int refundWindowDays = 3;
  static const int disputeWindowDays = 14;

  static DateTime calculateAutoReleaseDate(DateTime paidAt) {
    return paidAt.add(const Duration(days: autoReleaseDays));
  }

  static DateTime calculateRefundDeadline(DateTime paidAt) {
    return paidAt.add(const Duration(days: refundWindowDays));
  }

  static bool canRequestRefund(DateTime paidAt) {
    final now = DateTime.now();
    final deadline = calculateRefundDeadline(paidAt);
    return now.isBefore(deadline);
  }

  static bool shouldAutoRelease(DateTime paidAt) {
    final now = DateTime.now();
    final releaseDate = calculateAutoReleaseDate(paidAt);
    return now.isAfter(releaseDate);
  }

  static int daysUntilAutoRelease(DateTime paidAt) {
    final now = DateTime.now();
    final releaseDate = calculateAutoReleaseDate(paidAt);
    final difference = releaseDate.difference(now).inDays;
    return difference < 0 ? 0 : difference;
  }

  static String getEscrowExplanation() {
    return '''
Escrow is a secure payment method that protects both buyers and sellers.

How it works:
1. Buyer pays for the vehicle
2. Payment is held securely in escrow
3. Seller ships the vehicle
4. Buyer confirms receipt
5. Payment is released to seller

Your payment is protected until you confirm you've received the vehicle in the expected condition.
''';
  }

  static List<String> getSafetyTips() {
    return [
      'Inspect the vehicle thoroughly before confirming receipt',
      'Take photos/videos of the vehicle condition upon delivery',
      'Confirm all documents are complete and valid',
      'Report any issues within $refundWindowDays days',
      'Payment auto-releases after $autoReleaseDays days if no issues',
    ];
  }
}
