import 'dart:math';

class DistanceCalculator {
  // Mock distance calculator for Philippine cities
  // In production, this would use actual geolocation data or a maps API

  static const Map<String, Map<String, double>> _cityCoordinates = {
    'Manila': {'lat': 14.5995, 'lng': 120.9842},
    'Quezon City': {'lat': 14.6760, 'lng': 121.0437},
    'Makati': {'lat': 14.5547, 'lng': 121.0244},
    'Pasig': {'lat': 14.5764, 'lng': 121.0851},
    'Taguig': {'lat': 14.5176, 'lng': 121.0509},
    'Mandaluyong': {'lat': 14.5794, 'lng': 121.0359},
    'Pasay': {'lat': 14.5378, 'lng': 120.9896},
    'Caloocan': {'lat': 14.6492, 'lng': 120.9833},
    'Parañaque': {'lat': 14.4793, 'lng': 121.0198},
    'Las Piñas': {'lat': 14.4453, 'lng': 120.9823},
    'Muntinlupa': {'lat': 14.4081, 'lng': 121.0421},
    'Cebu City': {'lat': 10.3157, 'lng': 123.8854},
    'Davao City': {'lat': 7.1907, 'lng': 125.4553},
    'Baguio': {'lat': 16.4023, 'lng': 120.5960},
    'Iloilo City': {'lat': 10.7202, 'lng': 122.5621},
    'Cagayan de Oro': {'lat': 8.4542, 'lng': 124.6319},
    'Bacolod': {'lat': 10.6770, 'lng': 122.9500},
    'General Santos': {'lat': 6.1164, 'lng': 125.1716},
    'Zamboanga City': {'lat': 6.9214, 'lng': 122.0790},
    'Antipolo': {'lat': 14.5863, 'lng': 121.1758},
  };

  /// Calculate approximate distance between two cities in kilometers
  /// Returns null if either city is not in the database
  static double? calculateDistance(String city1, String city2) {
    final coords1 = _cityCoordinates[city1];
    final coords2 = _cityCoordinates[city2];

    if (coords1 == null || coords2 == null) {
      return null;
    }

    return _haversineDistance(
      coords1['lat']!,
      coords1['lng']!,
      coords2['lat']!,
      coords2['lng']!,
    );
  }

  /// Haversine formula to calculate distance between two points on Earth
  static double _haversineDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const double earthRadius = 6371; // Radius of the Earth in kilometers

    final dLat = _degreesToRadians(lat2 - lat1);
    final dLon = _degreesToRadians(lon2 - lon1);

    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(lat1)) *
            cos(_degreesToRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadius * c;
  }

  static double _degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }

  /// Format distance for display
  static String formatDistance(double distanceKm) {
    if (distanceKm < 1) {
      return '${(distanceKm * 1000).round()} m';
    } else if (distanceKm < 10) {
      return '${distanceKm.toStringAsFixed(1)} km';
    } else {
      return '${distanceKm.round()} km';
    }
  }

  /// Get distance text between two cities
  static String? getDistanceText(String city1, String city2) {
    final distance = calculateDistance(city1, city2);
    if (distance == null) return null;
    return formatDistance(distance);
  }
}
