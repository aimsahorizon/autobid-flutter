class PriceRanges {
  static const List<PriceRange> quickFilters = [
    PriceRange(label: 'Under ₱300K', min: 0, max: 300000),
    PriceRange(label: '₱300K - ₱500K', min: 300000, max: 500000),
    PriceRange(label: '₱500K - ₱800K', min: 500000, max: 800000),
    PriceRange(label: '₱800K - ₱1M', min: 800000, max: 1000000),
    PriceRange(label: '₱1M - ₱1.5M', min: 1000000, max: 1500000),
    PriceRange(label: 'Above ₱1.5M', min: 1500000, max: 10000000),
  ];

  static const double minPrice = 100000;
  static const double maxPrice = 5000000;
  static const double defaultMinPrice = 100000;
  static const double defaultMaxPrice = 3000000;
}

class PriceRange {
  final String label;
  final double min;
  final double max;

  const PriceRange({
    required this.label,
    required this.min,
    required this.max,
  });
}
