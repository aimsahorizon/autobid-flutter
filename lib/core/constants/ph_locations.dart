class PhilippineLocations {
  static const Map<String, List<String>> provincesCities = {
    'Metro Manila': [
      'Manila',
      'Quezon City',
      'Makati',
      'Pasig',
      'Taguig',
      'Mandaluyong',
      'Pasay',
      'Caloocan',
      'Parañaque',
      'Las Piñas',
      'Muntinlupa',
      'Valenzuela',
      'Malabon',
      'Navotas',
      'San Juan',
      'Marikina',
      'Pateros',
    ],
    'Cebu': [
      'Cebu City',
      'Lapu-Lapu City',
      'Mandaue City',
      'Talisay City',
      'Toledo City',
      'Naga City',
      'Carcar City',
    ],
    'Davao del Sur': [
      'Davao City',
      'Digos City',
    ],
    'Benguet': [
      'Baguio',
      'La Trinidad',
    ],
    'Iloilo': [
      'Iloilo City',
      'Passi City',
    ],
    'Misamis Oriental': [
      'Cagayan de Oro',
      'Gingoog City',
    ],
    'Negros Occidental': [
      'Bacolod',
      'Silay City',
      'Talisay City',
      'Victorias City',
    ],
    'South Cotabato': [
      'General Santos',
      'Koronadal City',
    ],
    'Zamboanga del Sur': [
      'Zamboanga City',
      'Pagadian City',
    ],
    'Rizal': [
      'Antipolo',
      'Cainta',
      'Taytay',
      'Binangonan',
    ],
    'Cavite': [
      'Bacoor',
      'Dasmariñas',
      'Imus',
      'Cavite City',
      'Tagaytay',
    ],
    'Laguna': [
      'Calamba',
      'San Pedro',
      'Biñan',
      'Santa Rosa',
      'Cabuyao',
    ],
    'Bulacan': [
      'Malolos',
      'Meycauayan',
      'San Jose del Monte',
    ],
    'Pampanga': [
      'Angeles City',
      'San Fernando',
      'Mabalacat',
    ],
    'Batangas': [
      'Batangas City',
      'Lipa City',
      'Tanauan City',
    ],
  };

  static List<String> get provinces => provincesCities.keys.toList()..sort();

  static List<String> getCitiesForProvince(String province) {
    return provincesCities[province] ?? [];
  }

  static List<String> get allCities {
    final cities = <String>[];
    for (final cityList in provincesCities.values) {
      cities.addAll(cityList);
    }
    return cities..sort();
  }

  static String? getProvinceForCity(String city) {
    for (final entry in provincesCities.entries) {
      if (entry.value.contains(city)) {
        return entry.key;
      }
    }
    return null;
  }
}
