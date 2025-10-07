/// Defines all required images for a complete car listing
class RequiredCarImages {
  // EXTERIOR IMAGES (15 required)
  static const List<String> exteriorImages = [
    'front_view',
    'front_3/4_driver',
    'front_3/4_passenger',
    'side_driver',
    'side_passenger',
    'rear_3/4_driver',
    'rear_3/4_passenger',
    'rear_view',
    'front_bumper',
    'rear_bumper',
    'wheels_front_left',
    'wheels_front_right',
    'wheels_rear_left',
    'wheels_rear_right',
    'roof_view',
  ];

  // INTERIOR IMAGES (12 required)
  static const List<String> interiorImages = [
    'dashboard_full',
    'steering_wheel',
    'instrument_cluster',
    'center_console',
    'front_seat_driver',
    'front_seat_passenger',
    'rear_seats',
    'cargo_trunk',
    'headliner',
    'door_panel_driver',
    'door_panel_passenger',
    'gear_shifter',
  ];

  // ENGINE & MECHANICAL (6 required)
  static const List<String> engineImages = [
    'engine_bay_full',
    'engine_closeup',
    'vin_plate',
    'odometer',
    'undercarriage',
    'suspension',
  ];

  // DETAILS & CONDITION (13 required)
  static const List<String> detailImages = [
    'paint_condition',
    'tire_tread_front_left',
    'tire_tread_front_right',
    'tire_tread_rear_left',
    'tire_tread_rear_right',
    'headlights',
    'tail_lights',
    'interior_wear',
    'carpet_condition',
    'infotainment',
    'service_stickers',
    'registration_papers',
    'service_history',
  ];

  static const int totalRequiredImages = 46;

  static Map<String, int> getRequiredCountByCategory() {
    return {
      'exterior': exteriorImages.length,
      'interior': interiorImages.length,
      'engine': engineImages.length,
      'details': detailImages.length,
    };
  }

  static Map<String, List<String>> getAllRequiredImagesByCategory() {
    return {
      'exterior': exteriorImages,
      'interior': interiorImages,
      'engine': engineImages,
      'details': detailImages,
    };
  }

  static String getImageDisplayName(String imageKey) {
    return imageKey.split('_').map((word) {
      return word[0].toUpperCase() + word.substring(1);
    }).join(' ');
  }

  static List<String> getAllRequiredImageKeys() {
    return [
      ...exteriorImages,
      ...interiorImages,
      ...engineImages,
      ...detailImages,
    ];
  }
}
