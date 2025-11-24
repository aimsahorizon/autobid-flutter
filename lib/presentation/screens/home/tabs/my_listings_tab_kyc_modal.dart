import 'package:flutter/material.dart';
import '../../../../core/constants/color_constants.dart';

/// KYC Verification Modal (RA 8792 Compliance)
/// Collects government ID verification before pre-transaction access
class KycVerificationModal extends StatefulWidget {
  final bool isSeller;
  final VoidCallback onSuccess;

  const KycVerificationModal({
    super.key,
    required this.isSeller,
    required this.onSuccess,
  });

  @override
  State<KycVerificationModal> createState() => _KycVerificationModalState();
}

class _KycVerificationModalState extends State<KycVerificationModal> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedIdType;
  final _idNumberController = TextEditingController();
  bool _hasUploadedId = false;
  bool _hasUploadedSelfie = false;
  bool _ra8792Consent = false;
  bool _isSubmitting = false;

  final List<String> _idTypes = [
    'Driver\'s License',
    'Passport',
    'National ID (PhilSys)',
    'SSS ID',
    'UMID',
    'Voter\'s ID',
    'PRC ID',
  ];

  @override
  void dispose() {
    _idNumberController.dispose();
    super.dispose();
  }

  Future<void> _mockUploadIdPhoto() async {
    // TODO: Connect to actual image picker and upload service
    setState(() {
      _hasUploadedId = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('ID photo uploaded (mock)')),
    );
  }

  Future<void> _mockUploadSelfie() async {
    // TODO: Connect to actual image picker and upload service
    setState(() {
      _hasUploadedSelfie = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Selfie uploaded (mock)')),
    );
  }

  Future<void> _submitKycVerification() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_ra8792Consent) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You must agree to the RA 8792 legal consent'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (!_hasUploadedId || !_hasUploadedSelfie) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please upload both ID photo and selfie'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    // TODO: Connect to actual KYC verification API (eKYC service)
    // Simulate backend verification delay
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() {
      _isSubmitting = false;
    });

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('KYC verification successful!'),
        backgroundColor: ColorConstants.primaryGreen,
      ),
    );

    // Close modal and call success callback
    Navigator.pop(context);
    widget.onSuccess();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500, maxHeight: 650),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(Icons.verified_user, color: ColorConstants.primaryGreen, size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'KYC Verification Required',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'RA 8792 Legal Compliance',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Divider(color: Colors.grey[300]),
            const SizedBox(height: 16),
            // Form
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ID Type Dropdown
                      const Text(
                        'Government ID Type',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: _selectedIdType,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Select ID type',
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                        ),
                        items: _idTypes.map((type) {
                          return DropdownMenuItem(value: type, child: Text(type));
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedIdType = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select an ID type';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      // ID Number
                      const Text(
                        'ID Number',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _idNumberController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter ID number',
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your ID number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      // ID Photo Upload
                      const Text(
                        'ID Photo',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      OutlinedButton.icon(
                        onPressed: _isSubmitting ? null : _mockUploadIdPhoto,
                        icon: Icon(_hasUploadedId ? Icons.check_circle : Icons.upload_file),
                        label: Text(_hasUploadedId ? 'ID Photo Uploaded' : 'Upload ID Photo'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: _hasUploadedId ? ColorConstants.primaryGreen : null,
                          side: BorderSide(
                            color: _hasUploadedId ? ColorConstants.primaryGreen : Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Selfie Upload
                      const Text(
                        'Selfie with ID',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      OutlinedButton.icon(
                        onPressed: _isSubmitting ? null : _mockUploadSelfie,
                        icon: Icon(_hasUploadedSelfie ? Icons.check_circle : Icons.camera_alt),
                        label: Text(_hasUploadedSelfie ? 'Selfie Uploaded' : 'Upload Selfie'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: _hasUploadedSelfie ? ColorConstants.primaryGreen : null,
                          side: BorderSide(
                            color: _hasUploadedSelfie ? ColorConstants.primaryGreen : Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // RA 8792 Consent
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: ColorConstants.info.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: ColorConstants.info.withOpacity(0.3)),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.info_outline, size: 18, color: ColorConstants.info),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'Legal Consent (RA 8792)',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: ColorConstants.info,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            // RA 8792 Section 8: Electronic signatures are legally binding
                            CheckboxListTile(
                              value: _ra8792Consent,
                              onChanged: _isSubmitting ? null : (value) {
                                setState(() {
                                  _ra8792Consent = value ?? false;
                                });
                              },
                              contentPadding: EdgeInsets.zero,
                              controlAffinity: ListTileControlAffinity.leading,
                              dense: true,
                              title: const Text(
                                'I agree that this identity verification is legally binding under Republic Act No. 8792 (Electronic Commerce Act of 2000).',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Submit Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _submitKycVerification,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstants.primaryGreen,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: _isSubmitting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        'Verify Identity',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
