/// Mapping of car brands to their models and variants
/// This provides a more accurate vehicle selection experience with cascading dropdowns
class CarBrandModels {
  static const Map<String, Map<String, List<String>>> brandModelVariantMap = {
    'Toyota': {
      'Vios': [
        '1.3 E MT',
        '1.3 E CVT',
        '1.5 G MT',
        '1.5 G CVT',
        '1.5 XLE CVT',
        'GR-S CVT',
      ],
      'Wigo': [
        '1.0 E MT',
        '1.0 G MT',
        '1.0 G AT',
      ],
      'Rush': [
        '1.5 E MT',
        '1.5 G AT',
      ],
      'Raize': [
        '1.0 XLE Turbo CVT',
        '1.0 LTD Turbo CVT',
      ],
      'Fortuner': [
        '2.4 G 4X2 MT',
        '2.4 G 4X2 AT',
        '2.7 G 4X2 AT',
        '2.8 V 4X4 AT',
        'GR-S 4X2 AT',
      ],
      'Innova': [
        '2.8 E MT',
        '2.8 G AT',
        '2.8 V AT',
      ],
      'Hilux': [
        '2.4 J MT 4X2',
        '2.4 E MT 4X2',
        '2.4 G MT 4X2',
        '2.4 G AT 4X2',
        '2.8 G AT 4X4',
        '2.8 Conquest 4X4 AT',
      ],
      'Corolla Altis': [
        '1.6 E MT',
        '1.6 G CVT',
        '1.8 V CVT',
        'Hybrid V CVT',
      ],
      'Camry': [
        '2.5 V AT',
        '3.5 Q AT',
      ],
      'RAV4': [
        '2.0 LTD CVT',
        '2.5 LTD AWD CVT',
        'Hybrid LTD AWD CVT',
      ],
      'Land Cruiser': [
        '3.5 Twin Turbo V6 GR Sport',
        '3.5 Twin Turbo V6 ZX',
      ],
      'Avanza': [
        '1.3 E MT',
        '1.3 J MT',
        '1.5 G AT',
        '1.5 Veloz AT',
      ],
    },
    'Honda': {
      'City': [
        '1.5 S CVT',
        '1.5 V CVT',
        '1.5 VX CVT',
        '1.5 RS CVT',
      ],
      'Civic': [
        '1.5 S CVT',
        '1.5 V CVT',
        '1.5 VX Turbo CVT',
        '1.5 RS Turbo CVT',
        'Type R MT',
      ],
      'Accord': [
        '1.5 Turbo CVT',
        '2.0 Turbo CVT',
      ],
      'CR-V': [
        '1.5 S CVT',
        '1.5 V CVT',
        '2.0 S CVT AWD',
      ],
      'HR-V': [
        '1.8 E CVT',
        '1.8 V CVT',
        '1.8 RS CVT',
      ],
      'BR-V': [
        '1.5 S CVT',
        '1.5 V CVT',
      ],
      'Brio': [
        '1.2 S MT',
        '1.2 V CVT',
      ],
      'Jazz': [
        '1.5 S CVT',
        '1.5 V CVT',
        '1.5 VX CVT',
      ],
    },
    'Mitsubishi': {
      'Mirage': [
        '1.2 G MT',
        '1.2 G CVT',
        '1.2 GLS CVT',
      ],
      'Mirage G4': [
        '1.2 GLX MT',
        '1.2 GLX CVT',
        '1.2 GLS CVT',
      ],
      'Xpander': [
        '1.5 GLX MT',
        '1.5 GLS Sport AT',
        '1.5 GLS Premium AT',
      ],
      'Xpander Cross': [
        '1.5 Premium AT',
      ],
      'Montero Sport': [
        '2.4 GLX MT 4X2',
        '2.4 GLS AT 4X2',
        '2.4 GT AT 4X4',
      ],
      'Strada': [
        '2.4 GL MT 4X2',
        '2.4 GLS AT 4X2',
        '2.4 Athlete AT 4X4',
      ],
      'L300': [
        'FB Exceed',
        'Versa Van',
      ],
      'Pajero': [
        '3.2 GLS AT 4X4',
      ],
    },
    'Nissan': {
      'Almera': [
        '1.0 E MT',
        '1.0 VL Turbo CVT',
        '1.0 VE Turbo CVT',
      ],
      'Terra': [
        '2.5 E MT 4X2',
        '2.5 VL AT 4X2',
        '2.5 VL AT 4X4',
      ],
      'Navara': [
        '2.5 EL Calibre MT 4X2',
        '2.5 EL Calibre AT 4X2',
        '2.5 VL Sport Edition AT 4X4',
        '2.5 PRO-4X AT 4X4',
      ],
      'X-Trail': [
        '2.0 CVT 2WD',
        '2.5 CVT 4WD',
      ],
      'Patrol': [
        '5.6 V8 Platinum',
      ],
      'Urvan': [
        'Premium',
        'Estate',
      ],
    },
    'Ford': {
      'Ranger': [
        '2.2 XL MT 4X2',
        '2.2 XLT AT 4X2',
        '2.0 Biturbo Wildtrak AT 4X4',
        '2.0 Biturbo Raptor AT 4X4',
      ],
      'Everest': [
        '2.0 Trend AT 4X2',
        '2.0 Titanium+ AT 4X2',
        '2.0 Sport AT 4X4',
      ],
      'Territory': [
        '1.5 Trend AT',
        '1.5 Titanium AT',
      ],
      'Explorer': [
        '3.0 EcoBoost Hybrid ST-Line',
      ],
      'Expedition': [
        '3.5 EcoBoost Platinum',
      ],
      'Mustang': [
        '2.3 EcoBoost',
        '5.0 GT',
      ],
    },
    'Hyundai': {
      'Accent': [
        '1.4 GL MT',
        '1.4 GL AT',
        '1.6 CRDi GL AT',
      ],
      'Reina': [
        '1.4 GL MT',
        '1.4 GL AT',
      ],
      'Elantra': [
        '1.6 GL MT',
        '1.6 Premium AT',
      ],
      'Tucson': [
        '2.0 GL AT',
        '2.0 CRDi GL AT',
      ],
      'Santa Fe': [
        '2.2 CRDi GL AT',
        '2.2 CRDi Premium AT',
      ],
      'Palisade': [
        '2.2 CRDi GL AWD AT',
        '2.2 CRDi Premium AWD AT',
      ],
      'Stargazer': [
        '1.5 GL IVT',
        '1.5 Premium IVT',
      ],
      'Creta': [
        '1.5 GL IVT',
        '1.5 Premium IVT',
      ],
    },
    'Suzuki': {
      'Celerio': [
        '1.0 GL MT',
        '1.0 GL AGS',
      ],
      'Swift': [
        '1.2 GL MT',
        '1.2 GL AGS',
        '1.2 GLX AGS',
      ],
      'Dzire': [
        '1.2 GL MT',
        '1.2 GL AT',
        '1.2 GLX AT',
      ],
      'Ertiga': [
        '1.5 GL MT',
        '1.5 GL AT',
        '1.5 GLX AT',
      ],
      'XL7': [
        '1.5 GL AT',
        '1.5 GLX AT',
      ],
      'Jimny': [
        '1.5 GLX MT 4X4',
        '1.5 GLX AT 4X4',
      ],
      'S-Presso': [
        '1.0 GL MT',
        '1.0 GL AT',
      ],
      'Vitara': [
        '1.6 GL+ AT',
        '1.6 GLX AT',
      ],
    },
    'Mazda': {
      'Mazda2': [
        '1.5 V Sedan AT',
        '1.5 R Sedan AT',
      ],
      'Mazda3': [
        '1.5 V Sedan AT',
        '2.0 Premium Sedan AT',
        '2.0 Premium Hatchback AT',
      ],
      'CX-3': [
        '2.0 Pro AT',
        '2.0 Sport AT',
      ],
      'CX-5': [
        '2.0 Pro AT',
        '2.5 AWD Sport Turbo AT',
      ],
      'CX-9': [
        '2.5 AWD Sport Turbo AT',
      ],
      'BT-50': [
        '3.0 4X2 MT',
        '3.0 4X4 AT',
      ],
    },
    'Kia': {
      'Soluto': [
        '1.4 EX MT',
        '1.4 EX AT',
      ],
      'Picanto': [
        '1.0 EX MT',
        '1.2 GT-Line AT',
      ],
      'Stonic': [
        '1.4 EX AT',
        '1.4 GT-Line AT',
      ],
      'Seltos': [
        '1.5 EX AT',
        '1.5 GT-Line AT',
      ],
      'Sportage': [
        '2.0 EX AT',
        '2.0 GT-Line AT',
      ],
      'Sorento': [
        '2.2 EX 7-Seater AT',
        '2.2 SX 7-Seater AT',
      ],
      'Carnival': [
        '2.2 EX 7-Seater AT',
        '2.2 SX 11-Seater AT',
      ],
      'Stinger': [
        '3.3 GT AWD AT',
      ],
    },
    'Chevrolet': {
      'Spark': [
        '1.4 LS MT',
        '1.4 LT AT',
      ],
      'Sail': [
        '1.5 LS MT',
        '1.5 LT AT',
      ],
      'Trailblazer': [
        '2.8 LT 4X2 AT',
        '2.8 LTX 4X4 AT',
      ],
      'Colorado': [
        '2.5 LT 4X2 MT',
        '2.8 High Country 4X4 AT',
      ],
      'Tracker': [
        '1.0 LT Turbo AT',
        '1.0 Premier Turbo AT',
      ],
    },
    'Isuzu': {
      'D-Max': [
        '1.9 LS 4X2 MT',
        '1.9 LS 4X2 AT',
        '3.0 LS-E 4X4 AT',
        '3.0 X-Series 4X4 AT',
      ],
      'mu-X': [
        '1.9 LS-A 4X2 AT',
        '3.0 LS-E 4X4 AT',
      ],
      'Traviz': [
        '2.5 Standard',
        '2.5 Premium',
      ],
    },
    'Subaru': {
      'Forester': [
        '2.0i-L EyeSight CVT',
        '2.0i-S EyeSight CVT',
      ],
      'XV': [
        '2.0i-S EyeSight CVT',
      ],
      'Outback': [
        '2.5i-S EyeSight CVT',
      ],
      'WRX': [
        '2.0 Premium MT',
        '2.0 Sport CVT',
      ],
    },
    'BMW': {
      '3 Series': [
        '318i Sport',
        '320i M Sport',
        '330i M Sport',
      ],
      '5 Series': [
        '520i Luxury',
        '530i M Sport',
      ],
      'X1': [
        'sDrive18i',
        'xDrive20d M Sport',
      ],
      'X3': [
        'xDrive20d M Sport',
        'xDrive30i M Sport',
      ],
      'X5': [
        'xDrive40i M Sport',
      ],
    },
    'Mercedes-Benz': {
      'A-Class': [
        'A 200 Progressive',
        'A 200 AMG Dynamic',
      ],
      'C-Class': [
        'C 200 Avantgarde',
        'C 300 AMG Dynamic',
      ],
      'E-Class': [
        'E 200 Avantgarde',
        'E 300 AMG Dynamic',
      ],
      'GLA': [
        'GLA 200 Progressive',
        'GLA 200 AMG Dynamic',
      ],
      'GLC': [
        'GLC 200 Progressive',
        'GLC 300 AMG Dynamic',
      ],
    },
    'Audi': {
      'A4': [
        'A4 35 TFSI',
        'A4 40 TFSI',
      ],
      'Q2': [
        'Q2 35 TFSI',
      ],
      'Q5': [
        'Q5 40 TFSI quattro',
      ],
    },
    'Volkswagen': {
      'Santana': [
        '180 MPI',
      ],
      'Lamando': [
        '230 TSI',
      ],
      'Tiguan': [
        '280 TSI',
        '380 TSI 4Motion',
      ],
    },
    'Lexus': {
      'IS': [
        'IS 300',
      ],
      'RX': [
        'RX 350',
      ],
      'NX': [
        'NX 300',
      ],
    },
    'Tesla': {
      'Model 3': [
        'Standard Range Plus',
        'Long Range AWD',
        'Performance',
      ],
      'Model Y': [
        'Long Range AWD',
        'Performance',
      ],
      'Model S': [
        'Long Range',
        'Plaid',
      ],
      'Model X': [
        'Long Range',
        'Plaid',
      ],
    },
    'MG': {
      'MG5': [
        '1.5 Style MT',
        '1.5 Style CVT',
      ],
      'MG ZS': [
        '1.5 Style AT',
        '1.5 Alpha AT',
      ],
      'MG RX5': [
        '1.5 Style AT',
      ],
    },
    'Geely': {
      'Coolray': [
        'Comfort',
        'Sport',
        'Premium',
      ],
      'Okavango': [
        'Comfort',
        'Premium',
        'Urban Plus',
      ],
      'Azkarra': [
        'Comfort',
        'Premium',
      ],
    },
    'Chery': {
      'Tiggo 7 Pro': [
        'Comfort',
        'Premium',
      ],
      'Tiggo 8 Pro': [
        'Luxury',
        'Excellence',
      ],
    },
    'BYD': {
      'Atto 3': [
        'Standard Range',
        'Extended Range',
      ],
      'Dolphin': [
        'Premium',
        'Superior',
      ],
    },
  };

  /// Get models for a specific brand
  static List<String> getModelsForBrand(String? brand) {
    if (brand == null) return [];
    final models = brandModelVariantMap[brand];
    if (models == null) return [];
    return models.keys.toList()..sort();
  }

  /// Get variants for a specific brand and model
  static List<String> getVariantsForModel(String? brand, String? model) {
    if (brand == null || model == null) return [];
    final models = brandModelVariantMap[brand];
    if (models == null) return [];
    return models[model] ?? [];
  }

  /// Get all brands
  static List<String> get brands {
    return brandModelVariantMap.keys.toList();
  }

  /// Check if a model belongs to a brand
  static bool isModelInBrand(String model, String brand) {
    final models = brandModelVariantMap[brand];
    return models?.containsKey(model) ?? false;
  }

  /// Check if a variant belongs to a model in a brand
  static bool isVariantInModel(String variant, String brand, String model) {
    final models = brandModelVariantMap[brand];
    if (models == null) return false;
    final variants = models[model];
    return variants?.contains(variant) ?? false;
  }
}
