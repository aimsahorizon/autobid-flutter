import 'package:flutter/material.dart';

class WatchlistProvider extends ChangeNotifier {
  // In-memory storage (would be replaced with actual persistence)
  final Set<String> _watchlistedCarIds = {};

  Set<String> get watchlistedCarIds => {..._watchlistedCarIds};

  bool isWatchlisted(String carId) {
    return _watchlistedCarIds.contains(carId);
  }

  void addToWatchlist(String carId) {
    _watchlistedCarIds.add(carId);
    notifyListeners();
  }

  void removeFromWatchlist(String carId) {
    _watchlistedCarIds.remove(carId);
    notifyListeners();
  }

  void toggleWatchlist(String carId) {
    if (isWatchlisted(carId)) {
      removeFromWatchlist(carId);
    } else {
      addToWatchlist(carId);
    }
  }

  int get watchlistCount => _watchlistedCarIds.length;
}
