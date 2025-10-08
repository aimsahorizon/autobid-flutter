import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/color_constants.dart';
import '../../providers/payment_provider.dart';
import '../../widgets/custom_button.dart';

class SubmitTransferEvidenceScreen extends StatefulWidget {
  final String transactionId;
  final String carTitle;

  const SubmitTransferEvidenceScreen({
    super.key,
    required this.transactionId,
    required this.carTitle,
  });

  @override
  State<SubmitTransferEvidenceScreen> createState() =>
      _SubmitTransferEvidenceScreenState();
}

class _SubmitTransferEvidenceScreenState
    extends State<SubmitTransferEvidenceScreen> {
  int _currentStep = 0;
  final _notesController = TextEditingController();
  bool _agreedToTerms = false;

  // Track uploaded documents
  bool _deedOfSaleUploaded = false;
  bool _crOrTransferUploaded = false;
  bool _officialReceiptUploaded = false;
  bool _vehiclePhotoUploaded = false;
  bool _odometerPhotoUploaded = false;
  bool _vinPhotoUploaded = false;
  int _conditionPhotosUploaded = 0;

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  bool _canProceedToNext() {
    switch (_currentStep) {
      case 0: // Deed of Sale
        return _deedOfSaleUploaded;
      case 1: // CR/OR Transfer
        return _crOrTransferUploaded;
      case 2: // Official Receipt
        return _officialReceiptUploaded;
      case 3: // Vehicle Photos
        return _vehiclePhotoUploaded && _odometerPhotoUploaded;
      case 4: // VIN Verification
        return _vinPhotoUploaded;
      case 5: // Condition Photos
        return _conditionPhotosUploaded >= 4;
      case 6: // Review & Sign
        return _agreedToTerms;
      default:
        return false;
    }
  }

  void _handleNext() {
    if (_currentStep < 6) {
      setState(() {
        _currentStep++;
      });
    }
  }

  void _handleBack() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  Future<void> _handleSubmit() async {
    final provider = context.read<PaymentProvider>();

    // Show loading dialog
    if (!mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Submitting evidence...'),
              ],
            ),
          ),
        ),
      ),
    );

    // Submit evidence and trigger validation
    await provider.submitTransferEvidence(widget.transactionId);

    if (!mounted) return;
    Navigator.pop(context); // Close loading dialog

    // Show success and navigate back
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('✅ Transfer evidence submitted for validation'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );

    context.go('/home?tab=2&subTab=1');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Submit Transfer Evidence ${_currentStep + 1}/7'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Cancel Submission?'),
                content: const Text(
                  'Your progress will be lost. You can submit evidence later.',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Continue'),
                  ),
                  FilledButton(
                    onPressed: () {
                      Navigator.pop(context);
                      context.pop();
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text('Exit'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      body: Column(
        children: [
          // Progress indicator
          LinearProgressIndicator(
            value: (_currentStep + 1) / 7,
            backgroundColor: Colors.grey[200],
            valueColor: const AlwaysStoppedAnimation<Color>(
              ColorConstants.primaryGreen,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: _buildStepContent(),
            ),
          ),
          // Navigation buttons
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                if (_currentStep > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _handleBack,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Back'),
                    ),
                  ),
                if (_currentStep > 0) const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: _currentStep == 6
                      ? CustomButton(
                          text: 'Submit for Validation',
                          onPressed:
                              _canProceedToNext() ? _handleSubmit : null,
                        )
                      : CustomButton(
                          text: 'Continue',
                          onPressed:
                              _canProceedToNext() ? _handleNext : null,
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return _buildDeedOfSaleStep();
      case 1:
        return _buildCrOrTransferStep();
      case 2:
        return _buildOfficialReceiptStep();
      case 3:
        return _buildVehiclePhotosStep();
      case 4:
        return _buildVinVerificationStep();
      case 5:
        return _buildConditionPhotosStep();
      case 6:
        return _buildReviewStep();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildDeedOfSaleStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.description,
          size: 64,
          color: ColorConstants.primaryGreen,
        ),
        const SizedBox(height: 16),
        Text(
          'Deed of Sale',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Upload the signed deed of sale showing the transfer agreement.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.grey[700],
              ),
        ),
        const SizedBox(height: 24),
        _buildUploadCard(
          title: 'Deed of Sale Document',
          isUploaded: _deedOfSaleUploaded,
          onUpload: () {
            setState(() {
              _deedOfSaleUploaded = true;
            });
          },
        ),
        const SizedBox(height: 16),
        _buildRequirementsList([
          'Must be signed by both buyer and seller',
          'Must include sale price and date',
          'Must show complete vehicle details',
        ]),
      ],
    );
  }

  Widget _buildCrOrTransferStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.badge,
          size: 64,
          color: ColorConstants.primaryGreen,
        ),
        const SizedBox(height: 16),
        Text(
          'Certificate of Registration',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Upload the CR/OR showing ownership transfer.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.grey[700],
              ),
        ),
        const SizedBox(height: 24),
        _buildUploadCard(
          title: 'CR/OR Transfer Document',
          isUploaded: _crOrTransferUploaded,
          onUpload: () {
            setState(() {
              _crOrTransferUploaded = true;
            });
          },
        ),
        const SizedBox(height: 16),
        _buildRequirementsList([
          'Must be LTO-issued document',
          'Seller signature required',
          'Clear scan or photo required',
        ]),
      ],
    );
  }

  Widget _buildOfficialReceiptStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.receipt_long,
          size: 64,
          color: ColorConstants.primaryGreen,
        ),
        const SizedBox(height: 16),
        Text(
          'Official Receipt',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Upload proof of payment for transfer fees.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.grey[700],
              ),
        ),
        const SizedBox(height: 24),
        _buildUploadCard(
          title: 'LTO Official Receipt',
          isUploaded: _officialReceiptUploaded,
          onUpload: () {
            setState(() {
              _officialReceiptUploaded = true;
            });
          },
        ),
        const SizedBox(height: 16),
        _buildRequirementsList([
          'LTO-issued receipt required',
          'Must be dated within 7 days',
          'Clear and readable photo',
        ]),
      ],
    );
  }

  Widget _buildVehiclePhotosStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.directions_car,
          size: 64,
          color: ColorConstants.primaryGreen,
        ),
        const SizedBox(height: 16),
        Text(
          'Vehicle & Odometer Photos',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Take photos of the vehicle at your location and the current odometer reading.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.grey[700],
              ),
        ),
        const SizedBox(height: 24),
        _buildUploadCard(
          title: 'Vehicle at Your Location',
          subtitle: 'Must show recognizable landmark',
          isUploaded: _vehiclePhotoUploaded,
          onUpload: () {
            setState(() {
              _vehiclePhotoUploaded = true;
            });
          },
        ),
        const SizedBox(height: 12),
        _buildUploadCard(
          title: 'Current Odometer Reading',
          subtitle: 'Clear photo of mileage display',
          isUploaded: _odometerPhotoUploaded,
          onUpload: () {
            setState(() {
              _odometerPhotoUploaded = true;
            });
          },
        ),
      ],
    );
  }

  Widget _buildVinVerificationStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.qr_code_scanner,
          size: 64,
          color: ColorConstants.primaryGreen,
        ),
        const SizedBox(height: 16),
        Text(
          'VIN Verification',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Take a clear photo of the vehicle identification number (VIN) plate.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.grey[700],
              ),
        ),
        const SizedBox(height: 24),
        _buildUploadCard(
          title: 'VIN Plate Photo',
          subtitle: 'Chassis number must be clear and readable',
          isUploaded: _vinPhotoUploaded,
          onUpload: () {
            setState(() {
              _vinPhotoUploaded = true;
            });
          },
        ),
        const SizedBox(height: 16),
        _buildRequirementsList([
          'VIN must match auction listing',
          'Photo must be clear and readable',
          'Usually located on driver-side doorjamb or dashboard',
        ]),
      ],
    );
  }

  Widget _buildConditionPhotosStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.photo_camera,
          size: 64,
          color: ColorConstants.primaryGreen,
        ),
        const SizedBox(height: 16),
        Text(
          'Vehicle Condition Photos',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Take photos from all 4 angles to document the vehicle condition.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.grey[700],
              ),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: _buildAnglePhotoCard('Front', 0),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildAnglePhotoCard('Rear', 1),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildAnglePhotoCard('Driver Side', 2),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildAnglePhotoCard('Passenger Side', 3),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Photos taken: $_conditionPhotosUploaded/4',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: _conditionPhotosUploaded >= 4
                ? Colors.green
                : Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildAnglePhotoCard(String angle, int index) {
    final isUploaded = _conditionPhotosUploaded > index;
    return GestureDetector(
      onTap: isUploaded
          ? null
          : () {
              setState(() {
                _conditionPhotosUploaded++;
              });
            },
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: isUploaded ? Colors.green[50] : Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isUploaded ? Colors.green : Colors.grey[300]!,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isUploaded ? Icons.check_circle : Icons.camera_alt,
              size: 40,
              color: isUploaded ? Colors.green : Colors.grey[400],
            ),
            const SizedBox(height: 8),
            Text(
              angle,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isUploaded ? Colors.green[900] : Colors.grey[600],
              ),
            ),
            if (isUploaded)
              Text(
                'Uploaded',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.green[700],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.fact_check,
          size: 64,
          color: ColorConstants.primaryGreen,
        ),
        const SizedBox(height: 16),
        Text(
          'Review & Submit',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Review your submitted evidence and confirm the transfer.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.grey[700],
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
                  Icon(Icons.info_outline, color: Colors.blue[700], size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Vehicle Information',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _buildInfoRow('Vehicle', widget.carTitle),
              _buildInfoRow('Transaction', widget.transactionId.substring(0, 8)),
              _buildInfoRow('Date', 'Oct 8, 2025'),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.green[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.green[200]!),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Evidence Submitted',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green[900],
                ),
              ),
              const SizedBox(height: 12),
              _buildCheckItem('Deed of Sale', _deedOfSaleUploaded),
              _buildCheckItem('CR/OR Transfer', _crOrTransferUploaded),
              _buildCheckItem('Official Receipt', _officialReceiptUploaded),
              _buildCheckItem('Vehicle Photos', _vehiclePhotoUploaded),
              _buildCheckItem('Odometer Photo', _odometerPhotoUploaded),
              _buildCheckItem('VIN Verification', _vinPhotoUploaded),
              _buildCheckItem('Condition Photos (4)', _conditionPhotosUploaded >= 4),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Buyer Notes (Optional)',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _notesController,
          maxLines: 4,
          maxLength: 500,
          decoration: InputDecoration(
            hintText: 'Add any notes about the vehicle condition or transfer...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        const SizedBox(height: 16),
        CheckboxListTile(
          value: _agreedToTerms,
          onChanged: (value) {
            setState(() {
              _agreedToTerms = value ?? false;
            });
          },
          title: const Text(
            'I confirm that all information provided is accurate and complete',
            style: TextStyle(fontSize: 14),
          ),
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: EdgeInsets.zero,
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.amber[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.amber[200]!),
          ),
          child: Row(
            children: [
              Icon(Icons.schedule, color: Colors.amber[900], size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Validation typically takes 1-3 business days. You\'ll be notified once approved.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.amber[900],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUploadCard({
    required String title,
    String? subtitle,
    required bool isUploaded,
    required VoidCallback onUpload,
  }) {
    return GestureDetector(
      onTap: isUploaded ? null : onUpload,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isUploaded ? Colors.green[50] : Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isUploaded ? Colors.green : Colors.grey[300]!,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isUploaded ? Icons.check_circle : Icons.upload_file,
              size: 40,
              color: isUploaded ? Colors.green : ColorConstants.primaryGreen,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: isUploaded ? Colors.green[900] : Colors.grey[900],
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (!isUploaded)
              Text(
                'Tap to upload',
                style: TextStyle(
                  fontSize: 12,
                  color: ColorConstants.primaryGreen,
                  fontWeight: FontWeight.w600,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildRequirementsList(List<String> requirements) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Requirements:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue[900],
            ),
          ),
          const SizedBox(height: 8),
          ...requirements.map((req) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      size: 16,
                      color: Colors.blue[700],
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        req,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.blue[900],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[700],
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckItem(String label, bool isChecked) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(
            isChecked ? Icons.check_circle : Icons.radio_button_unchecked,
            size: 16,
            color: isChecked ? Colors.green : Colors.grey,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: isChecked ? Colors.green[900] : Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
