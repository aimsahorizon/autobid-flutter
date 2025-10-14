import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/constants/color_constants.dart';
import '../../../../core/utils/validators.dart';
import '../../../providers/signup_provider.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/signup_stepper.dart';

class SignupStep4PrimaryId extends StatefulWidget {
  const SignupStep4PrimaryId({super.key});

  @override
  State<SignupStep4PrimaryId> createState() => _SignupStep4PrimaryIdState();
}

class _SignupStep4PrimaryIdState extends State<SignupStep4PrimaryId> {
  final _formKey = GlobalKey<FormState>();
  final _idNumberController = TextEditingController();
  final _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    final provider = context.read<SignupProvider>();
    _idNumberController.text = provider.nationalIdNumber;
  }

  @override
  void dispose() {
    _idNumberController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(bool isFront) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
      );

      if (image != null) {
        final bytes = await image.readAsBytes();
        if (!mounted) return;
        final provider = context.read<SignupProvider>();

        if (isFront) {
          provider.setPrimaryIdFront(bytes);
        } else {
          provider.setPrimaryIdBack(bytes);
        }
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

  Future<void> _pickImageFromGallery(bool isFront) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (image != null) {
        final bytes = await image.readAsBytes();
        if (!mounted) return;
        final provider = context.read<SignupProvider>();

        if (isFront) {
          provider.setPrimaryIdFront(bytes);
        } else {
          provider.setPrimaryIdBack(bytes);
        }
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

  void _showImageSourceDialog(bool isFront) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take Photo'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(isFront);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImageFromGallery(isFront);
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
    if (!_formKey.currentState!.validate()) return;

    final provider = context.read<SignupProvider>();

    if (provider.primaryIdFront == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please upload front of National ID'),
          backgroundColor: ColorConstants.error,
        ),
      );
      return;
    }

    if (provider.primaryIdBack == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please upload back of National ID'),
          backgroundColor: ColorConstants.error,
        ),
      );
      return;
    }

    provider.setNationalIdNumber(_idNumberController.text.trim());

    context.go('/signup/step6');
  }

  void _handleBack() {
    context.go('/signup/step4');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Primary ID'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () async {
            final shouldProceed = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                icon: Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.orange,
                  size: 48,
                ),
                title: Text('Discard Changes?'),
                content: Text(
                  'Your changes would be lost if you go back. Are you sure you want to continue?',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstants.error,
                      foregroundColor: Colors.white,
                    ),
                    child: Text('Discard'),
                  ),
                ],
              ),
            );

            if (shouldProceed == true && mounted) {
              _handleBack();
            }
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SignupStepper(currentStep: 5, totalSteps: 9),
                const SizedBox(height: 32),
                Text(
                  'National ID',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.primaryGreen,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Upload your Philippine National ID',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
                const SizedBox(height: 24),
                CustomTextField(
                  controller: _idNumberController,
                  label: 'National ID Number',
                  hint: 'XXXX-XXXX-XXXX',
                  keyboardType: TextInputType.text,
                  prefixIcon: const Icon(Icons.badge_outlined),
                  validator: Validators.validateNationalId,
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 24),
                Consumer<SignupProvider>(
                  builder: (context, provider, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Front of ID',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        const SizedBox(height: 8),
                        _buildImageUploadCard(
                          imageBytes: provider.primaryIdFront,
                          onTap: () => _showImageSourceDialog(true),
                          onPreview: provider.primaryIdFront != null
                              ? () => _showImagePreview(provider.primaryIdFront!)
                              : null,
                          label: 'Upload Front',
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Back of ID',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        const SizedBox(height: 8),
                        _buildImageUploadCard(
                          imageBytes: provider.primaryIdBack,
                          onTap: () => _showImageSourceDialog(false),
                          onPreview: provider.primaryIdBack != null
                              ? () => _showImagePreview(provider.primaryIdBack!)
                              : null,
                          label: 'Upload Back',
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blue[200]!),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.blue[700]),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Ensure your ID is clear and all details are visible',
                          style: TextStyle(
                            color: Colors.blue[900],
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: 'Back',
                        onPressed: _handleBack,
                        isOutlined: true,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 2,
                      child: CustomButton(
                        text: 'Next',
                        onPressed: _handleNext,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageUploadCard({
    required Uint8List? imageBytes,
    required VoidCallback onTap,
    VoidCallback? onPreview,
    required String label,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 180,
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
                    size: 48,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    label,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Tap to take photo or choose from gallery',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
