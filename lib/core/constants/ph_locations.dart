class PhilippineLocations {
  // Region -> Province -> Cities/Municipalities mapping
  static const Map<String, Map<String, List<String>>> regionProvincesCities = {
    'National Capital Region (NCR)': {
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
    },
    'Region I (Ilocos Region)': {
      'Ilocos Norte': ['Laoag City', 'Batac City'],
      'Ilocos Sur': ['Vigan City', 'Candon City'],
      'La Union': ['San Fernando City'],
      'Pangasinan': ['Dagupan City', 'Alaminos City', 'San Carlos City', 'Urdaneta City'],
    },
    'Region II (Cagayan Valley)': {
      'Batanes': ['Basco'],
      'Cagayan': ['Tuguegarao City'],
      'Isabela': ['Ilagan City', 'Santiago City', 'Cauayan City'],
      'Nueva Vizcaya': ['Bayombong'],
      'Quirino': ['Cabarroguis'],
    },
    'Region III (Central Luzon)': {
      'Aurora': ['Baler'],
      'Bataan': ['Balanga City'],
      'Bulacan': ['Malolos', 'Meycauayan', 'San Jose del Monte'],
      'Nueva Ecija': ['Cabanatuan City', 'Gapan City', 'Palayan City', 'San Jose City'],
      'Pampanga': ['Angeles City', 'San Fernando', 'Mabalacat'],
      'Tarlac': ['Tarlac City'],
      'Zambales': ['Olongapo City', 'Subic'],
    },
    'Region IV-A (CALABARZON)': {
      'Batangas': ['Batangas City', 'Lipa City', 'Tanauan City'],
      'Cavite': ['Bacoor', 'Dasmariñas', 'Imus', 'Cavite City', 'Tagaytay'],
      'Laguna': ['Calamba', 'San Pedro', 'Biñan', 'Santa Rosa', 'Cabuyao'],
      'Quezon': ['Lucena City', 'Tayabas City'],
      'Rizal': ['Antipolo', 'Cainta', 'Taytay', 'Binangonan'],
    },
    'Region IV-B (MIMAROPA)': {
      'Marinduque': ['Boac'],
      'Occidental Mindoro': ['San Jose'],
      'Oriental Mindoro': ['Calapan City'],
      'Palawan': ['Puerto Princesa City'],
      'Romblon': ['Romblon'],
    },
    'Region V (Bicol Region)': {
      'Albay': ['Legazpi City', 'Ligao City', 'Tabaco City'],
      'Camarines Norte': ['Daet'],
      'Camarines Sur': ['Naga City', 'Iriga City'],
      'Catanduanes': ['Virac'],
      'Masbate': ['Masbate City'],
      'Sorsogon': ['Sorsogon City'],
    },
    'Region VI (Western Visayas)': {
      'Aklan': ['Kalibo'],
      'Antique': ['San Jose'],
      'Capiz': ['Roxas City'],
      'Guimaras': ['Jordan'],
      'Iloilo': ['Iloilo City', 'Passi City'],
      'Negros Occidental': ['Bacolod', 'Silay City', 'Talisay City', 'Victorias City'],
    },
    'Region VII (Central Visayas)': {
      'Bohol': ['Tagbilaran City'],
      'Cebu': ['Cebu City', 'Lapu-Lapu City', 'Mandaue City', 'Talisay City', 'Toledo City', 'Naga City', 'Carcar City'],
      'Negros Oriental': ['Dumaguete City', 'Bais City'],
      'Siquijor': ['Siquijor'],
    },
    'Region VIII (Eastern Visayas)': {
      'Biliran': ['Naval'],
      'Eastern Samar': ['Borongan City'],
      'Leyte': ['Tacloban City', 'Ormoc City', 'Baybay City'],
      'Northern Samar': ['Catarman'],
      'Samar': ['Calbayog City', 'Catbalogan City'],
      'Southern Leyte': ['Maasin City'],
    },
    'Region IX (Zamboanga Peninsula)': {
      'Zamboanga del Norte': ['Dipolog City', 'Dapitan City'],
      'Zamboanga del Sur': ['Zamboanga City', 'Pagadian City'],
      'Zamboanga Sibugay': ['Ipil'],
    },
    'Region X (Northern Mindanao)': {
      'Bukidnon': ['Malaybalay City', 'Valencia City'],
      'Camiguin': ['Mambajao'],
      'Lanao del Norte': ['Iligan City'],
      'Misamis Occidental': ['Oroquieta City', 'Ozamiz City'],
      'Misamis Oriental': ['Cagayan de Oro', 'Gingoog City'],
    },
    'Region XI (Davao Region)': {
      'Davao de Oro': ['Nabunturan'],
      'Davao del Norte': ['Tagum City', 'Panabo City'],
      'Davao del Sur': ['Davao City', 'Digos City'],
      'Davao Occidental': ['Malita'],
      'Davao Oriental': ['Mati City'],
    },
    'Region XII (SOCCSKSARGEN)': {
      'Cotabato': ['Kidapawan City'],
      'Sarangani': ['Alabel'],
      'South Cotabato': ['General Santos', 'Koronadal City'],
      'Sultan Kudarat': ['Isulan'],
    },
    'Region XIII (Caraga)': {
      'Agusan del Norte': ['Butuan City', 'Cabadbaran City'],
      'Agusan del Sur': ['Bayugan City'],
      'Dinagat Islands': ['San Jose'],
      'Surigao del Norte': ['Surigao City'],
      'Surigao del Sur': ['Tandag City', 'Bislig City'],
    },
    'CAR (Cordillera Administrative Region)': {
      'Abra': ['Bangued'],
      'Apayao': ['Kabugao'],
      'Benguet': ['Baguio', 'La Trinidad'],
      'Ifugao': ['Lagawe'],
      'Kalinga': ['Tabuk City'],
      'Mountain Province': ['Bontoc'],
    },
    'BARMM (Bangsamoro Autonomous Region in Muslim Mindanao)': {
      'Basilan': ['Isabela City'],
      'Lanao del Sur': ['Marawi City'],
      'Maguindanao': ['Cotabato City'],
      'Sulu': ['Jolo'],
      'Tawi-Tawi': ['Bongao'],
    },
  };

  // Sample barangays (can be expanded)
  static const Map<String, List<String>> cityBarangays = {
    'Quezon City': ['Bagong Pag-asa', 'Batasan Hills', 'Commonwealth', 'Cubao', 'Diliman', 'Fairview', 'Kamuning', 'Libis', 'Novaliches', 'Project 6', 'UP Campus'],
    'Manila': ['Binondo', 'Ermita', 'Intramuros', 'Malate', 'Paco', 'Pandacan', 'Port Area', 'Quiapo', 'Sampaloc', 'San Miguel', 'Santa Cruz', 'Tondo'],
    'Makati': ['Bel-Air', 'Dasmarinas', 'Forbes Park', 'Guadalupe Nuevo', 'Magallanes', 'Poblacion', 'Rockwell', 'Salcedo Village', 'San Antonio', 'San Lorenzo', 'Urdaneta'],
    'Pasig': ['Kapitolyo', 'Manggahan', 'Maybunga', 'Oranbo', 'Pineda', 'Rosario', 'San Antonio', 'San Joaquin', 'Santolan', 'Ugong'],
    'Taguig': ['Bagumbayan', 'Bambang', 'Fort Bonifacio', 'Hagonoy', 'Ibayo-Tipas', 'Katuparan', 'Ligid-Tipas', 'Lower Bicutan', 'Maharlika Village', 'Napindan', 'Pinagsama', 'Signal Village', 'Upper Bicutan', 'Western Bicutan'],
    'Cebu City': ['Apas', 'Banilad', 'Busay', 'Capitol Site', 'Guadalupe', 'Lahug', 'Mabolo', 'Talamban', 'Tisa'],
    'Davao City': ['Agdao', 'Buhangin', 'Calinan', 'Lanang', 'Matina', 'Panacan', 'Poblacion', 'Toril', 'Tugbok'],
  };

  // Get all regions
  static List<String> get regions => regionProvincesCities.keys.toList();

  // Get provinces for a specific region
  static List<String> getProvincesForRegion(String region) {
    final provincesMap = regionProvincesCities[region];
    return provincesMap?.keys.toList() ?? [];
  }

  // Get cities for a specific province
  static List<String> getCitiesForProvince(String province) {
    for (final regionData in regionProvincesCities.values) {
      if (regionData.containsKey(province)) {
        return regionData[province] ?? [];
      }
    }
    return [];
  }

  // Get barangays for a specific city
  static List<String> getBarangaysForCity(String city) {
    return cityBarangays[city] ?? [];
  }

  // Get region for a province
  static String? getRegionForProvince(String province) {
    for (final entry in regionProvincesCities.entries) {
      if (entry.value.containsKey(province)) {
        return entry.key;
      }
    }
    return null;
  }

  // Get province for a city
  static String? getProvinceForCity(String city) {
    for (final regionData in regionProvincesCities.values) {
      for (final entry in regionData.entries) {
        if (entry.value.contains(city)) {
          return entry.key;
        }
      }
    }
    return null;
  }

  // Legacy support - all provinces
  static List<String> get provinces {
    final allProvinces = <String>[];
    for (final regionData in regionProvincesCities.values) {
      allProvinces.addAll(regionData.keys);
    }
    return allProvinces..sort();
  }

  // Legacy support - all cities
  static List<String> get allCities {
    final cities = <String>[];
    for (final regionData in regionProvincesCities.values) {
      for (final cityList in regionData.values) {
        cities.addAll(cityList);
      }
    }
    return cities..sort();
  }

  // Legacy support - old provincesCities map
  static Map<String, List<String>> get provincesCities {
    final Map<String, List<String>> result = {};
    for (final regionData in regionProvincesCities.values) {
      result.addAll(regionData);
    }
    return result;
  }
}
