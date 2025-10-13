class CarFeatures {
  // Custom features category for user-added features
  static const String customCategory = 'Custom Features';

  // Categorized features for better organization
  static const Map<String, List<String>> categorizedFeatures = {
    'Safety & Security': [
      'Anti-lock Braking System (ABS)',
      'Airbags (Driver & Passenger)',
      'Side Airbags',
      'Curtain Airbags',
      'Knee Airbags',
      'Automatic Emergency Braking',
      'Blind Spot Monitoring',
      'Lane Departure Warning',
      'Lane Keep Assist',
      'Forward Collision Warning',
      'Rear Cross Traffic Alert',
      'Hill Start Assist',
      'Hill Descent Control',
      'Traction Control',
      'Stability Control',
      'Anti-theft Alarm',
      'Immobilizer',
      'Child Safety Locks',
      'ISOFIX Child Seat Anchors',
    ],
    'Comfort & Convenience': [
      'Air Conditioning',
      'Automatic Climate Control',
      'Dual-Zone Climate Control',
      'Tri-Zone Climate Control',
      'Rear AC Vents',
      'Cruise Control',
      'Adaptive Cruise Control',
      'Keyless Entry',
      'Keyless Start',
      'Push Start Button',
      'Power Windows',
      'Power Door Locks',
      'Auto-folding Mirrors',
      'Power Steering',
      'Adjustable Steering Wheel',
      'Tilt & Telescopic Steering',
      'Sunroof/Moonroof',
      'Panoramic Sunroof',
      'Rain Sensing Wipers',
      'Auto-dimming Mirrors',
      'Interior Ambient Lighting',
    ],
    'Seating & Interior': [
      'Leather Seats',
      'Fabric Seats',
      'Leatherette Seats',
      'Heated Seats (Front)',
      'Heated Seats (Rear)',
      'Ventilated Seats (Front)',
      'Ventilated Seats (Rear)',
      'Power Adjustable Seats (Driver)',
      'Power Adjustable Seats (Passenger)',
      'Memory Seats',
      'Lumbar Support',
      'Split-folding Rear Seats',
      'Reclining Rear Seats',
      'Armrest (Front)',
      'Armrest (Rear)',
      'Cup Holders',
      'Storage Compartments',
    ],
    'Technology & Infotainment': [
      'Touchscreen Infotainment',
      '7-inch Touchscreen',
      '8-inch Touchscreen',
      '10-inch Touchscreen',
      '12-inch+ Touchscreen',
      'Apple CarPlay',
      'Android Auto',
      'Bluetooth Connectivity',
      'USB Ports (Front)',
      'USB Ports (Rear)',
      'Wireless Charging',
      'Navigation System',
      'GPS',
      'Voice Commands',
      'Digital Instrument Cluster',
      'Head-Up Display',
      'Wireless Apple CarPlay',
      'Wireless Android Auto',
    ],
    'Audio & Entertainment': [
      'AM/FM Radio',
      'Premium Sound System',
      '6-Speaker System',
      '8-Speaker System',
      '10+ Speaker System',
      'Subwoofer',
      'Amplifier',
      'Rear Entertainment System',
      'DVD Player',
    ],
    'Camera & Parking': [
      'Reverse Camera',
      'Front Camera',
      '360-degree Camera',
      'Parking Sensors (Rear)',
      'Parking Sensors (Front)',
      'Parking Sensors (Side)',
      'Auto-parking Assist',
    ],
    'Lighting': [
      'Halogen Headlights',
      'LED Headlights',
      'Xenon/HID Headlights',
      'Adaptive Headlights',
      'Automatic Headlights',
      'Daytime Running Lights (DRL)',
      'LED DRL',
      'Fog Lights (Front)',
      'Fog Lights (Rear)',
      'LED Tail Lights',
    ],
    'Exterior & Wheels': [
      'Alloy Wheels',
      'Steel Wheels',
      'Spare Tire (Full Size)',
      'Spare Tire (Compact)',
      'Tire Repair Kit',
      'Roof Rails',
      'Roof Rack',
      'Running Boards',
      'Body Kit',
      'Spoiler',
      'Chrome Accents',
      'Tinted Windows',
      'Privacy Glass',
    ],
    'Performance & Drivetrain': [
      'All-Wheel Drive (AWD)',
      '4-Wheel Drive (4WD)',
      'Paddle Shifters',
      'Sport Mode',
      'Eco Mode',
      'Off-road Mode',
      'Snow Mode',
      'Drive Mode Selector',
      'Launch Control',
      'Limited Slip Differential',
      'Locking Differential',
    ],
  };

  // Legacy flat list for backwards compatibility
  static List<String> get standardFeatures {
    return categorizedFeatures.values
        .expand((features) => features)
        .toList();
  }

  // Get all categories
  static List<String> get categories {
    return categorizedFeatures.keys.toList();
  }

  // Get features by category
  static List<String> getFeaturesForCategory(String category) {
    return categorizedFeatures[category] ?? [];
  }
}
