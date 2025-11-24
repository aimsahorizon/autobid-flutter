import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import '../../data/models/user_model.dart';

/// Demo data helper for auto-filling signup forms in demo/testing mode
///
/// Architecture:
/// - Centralized demo data management
/// - Realistic Philippine-specific data
/// - Easy to disable for production via [kEnableDemoMode]
/// - Provides both data and image generation utilities
class DemoDataHelper {
  DemoDataHelper._();

  /// Feature flag to enable/disable demo mode
  /// Set to false in production builds
  static const bool kEnableDemoMode = true;

  /// Step 1: Account Information
  static const String demoEmail = 'juan.delacruz@gmail.com';
  static const String demoPassword = 'SecurePass123!';
  static const String demoPhoneNumber = '+639171234567';

  /// Step 2: Personal Information
  static const String demoFirstName = 'Juan';
  static const String demoMiddleName = 'Santos';
  static const String demoLastName = 'Dela Cruz';
  static final DateTime demoDOB = DateTime(1990, 5, 15);
  static const String demoGender = 'Male';

  /// Step 3: Address Information
  static const String demoRegion = 'National Capital Region (NCR)';
  static const String demoProvince = 'Metro Manila';
  static const String demoCity = 'Quezon City';
  static const String demoBarangay = 'Commonwealth';
  static const String demoStreet = '123 Maharlika Street, Villa Cristina Subdivision';
  static const String demoZipCode = '1121';
  static const String demoNationality = 'Filipino';

  /// Step 4: Primary ID (National ID)
  static const String demoNationalIdNumber = '1234-5678-9012-3456';

  /// Step 5: Secondary ID
  static const String demoSecondaryIdType = 'Driver\'s License';
  static const String demoSecondaryIdNumber = 'N01-23-456789';

  /// Step 7: Proof of Address
  static final ProofOfAddressType demoProofOfAddressType =
      ProofOfAddressType.utilityBill;

  /// OTP for verification
  static const String demoOTP = '123456';

  /// Generates a demo image with text overlay
  /// Used for ID photos, selfies, and proof of address
  static Future<Uint8List> generateDemoImage({
    required String label,
    int width = 800,
    int height = 600,
    Color backgroundColor = const Color(0xFFE8F5E9),
    Color textColor = const Color(0xFF2E7D32),
  }) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(
      recorder,
      Rect.fromLTWH(0, 0, width.toDouble(), height.toDouble()),
    );

    // Draw background
    final backgroundPaint = Paint()..color = backgroundColor;
    canvas.drawRect(
      Rect.fromLTWH(0, 0, width.toDouble(), height.toDouble()),
      backgroundPaint,
    );

    // Draw border
    final borderPaint = Paint()
      ..color = textColor.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;
    canvas.drawRect(
      Rect.fromLTWH(10, 10, width - 20.0, height - 20.0),
      borderPaint,
    );

    // Draw text
    final textPainter = TextPainter(
      text: TextSpan(
        text: label,
        style: TextStyle(
          color: textColor,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        (width - textPainter.width) / 2,
        (height - textPainter.height) / 2,
      ),
    );

    // Draw "DEMO" watermark
    final watermarkPainter = TextPainter(
      text: TextSpan(
        text: 'DEMO',
        style: TextStyle(
          color: textColor.withValues(alpha: 0.2),
          fontSize: 80,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    watermarkPainter.layout();
    watermarkPainter.paint(
      canvas,
      Offset(
        (width - watermarkPainter.width) / 2,
        height - 120.0,
      ),
    );

    // Convert to image
    final picture = recorder.endRecording();
    final image = await picture.toImage(width, height);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    return byteData!.buffer.asUint8List();
  }

  /// Generates demo image for National ID Front
  static Future<Uint8List> generateNationalIdFront() {
    return generateDemoImage(
      label: 'National ID - Front\n$demoNationalIdNumber',
      backgroundColor: const Color(0xFFE3F2FD),
      textColor: const Color(0xFF1565C0),
    );
  }

  /// Generates demo image for National ID Back
  static Future<Uint8List> generateNationalIdBack() {
    return generateDemoImage(
      label: 'National ID - Back\n$demoFirstName $demoLastName',
      backgroundColor: const Color(0xFFE3F2FD),
      textColor: const Color(0xFF1565C0),
    );
  }

  /// Generates demo image for Secondary ID
  static Future<Uint8List> generateSecondaryId() {
    return generateDemoImage(
      label: '$demoSecondaryIdType\n$demoSecondaryIdNumber',
      backgroundColor: const Color(0xFFFFF3E0),
      textColor: const Color(0xFFE65100),
    );
  }

  /// Generates demo selfie image
  static Future<Uint8List> generateSelfie() {
    return generateDemoImage(
      label: 'Selfie Photo\n$demoFirstName $demoLastName',
      backgroundColor: const Color(0xFFFCE4EC),
      textColor: const Color(0xFFC2185B),
    );
  }

  /// Generates demo proof of address image
  static Future<Uint8List> generateProofOfAddress() {
    return generateDemoImage(
      label: 'Utility Bill\n$demoStreet',
      backgroundColor: const Color(0xFFF3E5F5),
      textColor: const Color(0xFF7B1FA2),
    );
  }

  /// Validates if demo mode is enabled before executing demo operations
  static bool get isDemoModeEnabled => kEnableDemoMode;

  /// Shows a snackbar indicating demo data was filled
  static void showDemoFilledMessage(BuildContext context) {
    if (!isDemoModeEnabled) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('✨ Demo data auto-filled'),
        duration: Duration(seconds: 2),
        backgroundColor: Color(0xFF4CAF50),
      ),
    );
  }
}
