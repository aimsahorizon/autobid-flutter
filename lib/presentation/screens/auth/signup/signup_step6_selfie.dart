import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/constants/color_constants.dart';
import '../../../providers/signup_provider.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/signup_stepper.dart';

class SignupStep6Selfie extends StatefulWidget {
  const SignupStep6Selfie({super.key});

  @override
  State<SignupStep6Selfie> createState() => _SignupStep6SelfieState();
}

class _SignupStep6SelfieState extends State<SignupStep6Selfie> {
  final _picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
        preferredCameraDevice: CameraDevice.front,
      );

      if (image != null) {
        final bytes = await image.readAsBytes();
        if (!mounted) return;
        final provider = context.read<SignupProvider>();
        provider.setSelfieImage(bytes);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error taking selfie: $e'),
            backgroundColor: ColorConstants.error,
          ),
        );
      }
    }
  }

  Future<void> _pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (image != null) {
        final bytes = await image.readAsBytes();
        if (!mounted) return;
        final provider = context.read<SignupProvider>();
        provider.setSelfieImage(bytes);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error picking image: $e'),
            backgroundColor: ColorConstants.error,
          ),
        );
      }
    }
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take Selfie'),
              onTap: () {
                Navigator.pop(context);
                _pickImage();
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImageFromGallery();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showImagePreview(Uint8List imageBytes) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InteractiveViewer(
              child: Image.memory(imageBytes),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }

  void _handleNext() {
    final provider = context.read<SignupProvider>();

    if (provider.selfieImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please take a selfie with your ID'),
          backgroundColor: ColorConstants.error,
        ),
      );
      return;
    }

    context.go('/signup/step8');
  }

  void _handleBack() {
    context.go('/signup/step6');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selfie Verification'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _handleBack,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SignupStepper(currentStep: 7, totalSteps: 9),
              const SizedBox(height: 32),
              Text(
                'Take a Selfie',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.primaryGreen,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Take a selfie holding your National ID',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue[200]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.blue[700]),
                        const SizedBox(width: 8),
                        Text(
                          'Instructions',
                          style: TextStyle(
                            color: Colors.blue[900],
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _buildInstruction('Hold your National ID next to your face'),
                    _buildInstruction('Make sure your face is clearly visible'),
                    _buildInstruction('Ensure the ID details are readable'),
                    _buildInstruction('Good lighting is important'),
                    _buildInstruction('Remove glasses if possible'),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Consumer<SignupProvider>(
                builder: (context, provider, child) {
                  return _buildSelfieCard(
                    imageBytes: provider.selfieImage,
                    onTap: _showImageSourceDialog,
                    onPreview: provider.selfieImage != null
                        ? () => _showImagePreview(provider.selfieImage!)
                        : null,
                  );
                },
              ),
              const SizedBox(height: 32),
              CustomButton(
                text: 'Next',
                onPressed: _handleNext,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInstruction(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle, size: 20, color: Colors.blue[700]),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.blue[900],
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelfieCard({
    required Uint8List? imageBytes,
    required VoidCallback onTap,
    VoidCallback? onPreview,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 300,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            color: imageBytes != null
                ? ColorConstants.primaryGreen
                : Colors.grey[300]!,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
          color: imageBytes != null ? null : Colors.grey[50],
        ),
        child: imageBytes != null
            ? Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.memory(
                      imageBytes,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Row(
                      children: [
                        if (onPreview != null)
                          CircleAvatar(
                            backgroundColor: Colors.black54,
                            child: IconButton(
                              icon: const Icon(Icons.zoom_in,
                                  color: Colors.white, size: 20),
                              onPressed: onPreview,
                            ),
                          ),
                        const SizedBox(width: 8),
                        CircleAvatar(
                          backgroundColor: Colors.black54,
                          child: IconButton(
                            icon: const Icon(Icons.edit,
                                color: Colors.white, size: 20),
                            onPressed: onTap,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.camera_alt_outlined,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Take Your Selfie',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap to open camera',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
