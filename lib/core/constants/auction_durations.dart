class AuctionDurations {
  static const int oneDay = 1;
  static const int threeDays = 3;
  static const int sevenDays = 7;

  static const List<int> availableDurations = [
    oneDay,
    threeDays,
    sevenDays,
  ];

  static String getDurationLabel(int days) {
    return '$days ${days == 1 ? 'Day' : 'Days'}';
  }
}
