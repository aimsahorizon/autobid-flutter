import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/constants/color_constants.dart';
import '../../../../core/constants/id_types.dart';
import '../../../../core/utils/validators.dart';
import '../../../providers/signup_provider.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/signup_stepper.dart';

class SignupStep5SecondaryId extends StatefulWidget {
  const SignupStep5SecondaryId({super.key});

  @override
  State<SignupStep5SecondaryId> createState() => _SignupStep5SecondaryIdState();
}

class _SignupStep5SecondaryIdState extends State<SignupStep5SecondaryId> {
  final _formKey = GlobalKey<FormState>();
  final _idNumberController = TextEditingController();
  final _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    final provider = context.read<SignupProvider>();
    _idNumberController.text = provider.secondaryIdNumber;
  }

  @override
  void dispose() {
    _idNumberController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
      );

      if (image != null) {
        final bytes = await image.readAsBytes();
        if (!mounted) return;
        final provider = context.read<SignupProvider>();
        provider.setSecondaryIdImage(bytes);
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
        provider.setSecondaryIdImage(bytes);
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
              title: const Text('Take Photo'),
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
    if (!_formKey.currentState!.validate()) return;

    final provider = context.read<SignupProvider>();

    if (provider.secondaryIdType.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select an ID type'),
          backgroundColor: ColorConstants.error,
        ),
      );
      return;
    }

    if (provider.secondaryIdImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please upload your secondary ID'),
          backgroundColor: ColorConstants.error,
        ),
      );
      return;
    }

    provider.setSecondaryIdNumber(_idNumberController.text.trim());

    context.go('/signup/step6');
  }

  void _handleBack() {
    context.go('/signup/step4');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Secondary ID'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _handleBack,
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
                const SignupStepper(currentStep: 5),
                const SizedBox(height: 32),
                Text(
                  'Secondary ID',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.primaryGreen,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Upload a valid government ID',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
                const SizedBox(height: 24),
                Consumer<SignupProvider>(
                  builder: (context, provider, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ID Type',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButtonFormField<String>(
                            initialValue: provider.secondaryIdType.isEmpty
                                ? null
                                : provider.secondaryIdType,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.badge_outlined),
                              hintText: 'Select ID type',
                            ),
                            items: SecondaryIdTypes.allTypes.map((idType) {
                              return DropdownMenuItem(
                                value: idType,
                                child: Text(idType),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                provider.setSecondaryIdType(value);
                              }
                            },
                            isExpanded: true,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: _idNumberController,
                  label: 'ID Number',
                  hint: 'Enter ID number',
                  keyboardType: TextInputType.text,
                  prefixIcon: const Icon(Icons.numbers_outlined),
                  validator: Validators.validateSecondaryIdNumber,
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 24),
                Consumer<SignupProvider>(
                  builder: (context, provider, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ID Photo',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        const SizedBox(height: 8),
                        _buildImageUploadCard(
                          imageBytes: provider.secondaryIdImage,
                          onTap: _showImageSourceDialog,
                          onPreview: provider.secondaryIdImage != null
                              ? () =>
                                  _showImagePreview(provider.secondaryIdImage!)
                              : null,
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
                          'Make sure all details on your ID are clearly visible',
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
                CustomButton(
                  text: 'Next',
                  onPressed: _handleNext,
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
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 200,
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
                    'Upload ID Photo',
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
