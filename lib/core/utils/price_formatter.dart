import 'package:intl/intl.dart';

class PriceFormatter {
  static String formatPrice(double price) {
    final formatter = NumberFormat.currency(
      locale: 'en_PH',
      symbol: '₱',
      decimalDigits: 0,
    );
    return formatter.format(price);
  }

  static String formatPriceCompact(double price) {
    if (price >= 1000000) {
      final millions = price / 1000000;
      return '₱${millions.toStringAsFixed(1)}M';
    } else if (price >= 1000) {
      final thousands = price / 1000;
      return '₱${thousands.toStringAsFixed(0)}K';
    } else {
      return '₱${price.toStringAsFixed(0)}';
    }
  }

  static String formatMileage(int mileage) {
    final formatter = NumberFormat('#,###', 'en_US');
    return '${formatter.format(mileage)} km';
  }

  static String formatNumber(int number) {
    final formatter = NumberFormat('#,###', 'en_US');
    return formatter.format(number);
  }
}
