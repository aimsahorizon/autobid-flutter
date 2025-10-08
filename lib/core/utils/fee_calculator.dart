class FeeCalculator {
  static const double platformFeePercentage = 0.03; // 3%
  static const double platformFeeFixed = 50.0; // ₱50

  static double calculatePlatformFee(double amount) {
    return (amount * platformFeePercentage) + platformFeeFixed;
  }

  static double calculateTotal(double amount) {
    return amount + calculatePlatformFee(amount);
  }

  static String formatCurrency(double amount) {
    return '₱${amount.toStringAsFixed(2).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        )}';
  }

  static Map<String, double> getBreakdown(double amount) {
    final fee = calculatePlatformFee(amount);
    final total = amount + fee;
    return {
      'amount': amount,
      'platformFee': fee,
      'total': total,
    };
  }
}
