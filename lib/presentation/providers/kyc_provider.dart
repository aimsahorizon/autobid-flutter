import 'package:flutter/foundation.dart';
import '../../data/models/kyc_model.dart';
import '../../data/services/mock/mock_kyc_service.dart';

enum KycUploadStep {
  primaryId,
  secondaryId,
  selfie,
}

class KycProvider extends ChangeNotifier {
  final MockKycService _kycService;

  KycProvider(this._kycService);

  // State
  KycModel? _kycData;
  bool _isLoading = false;
  String? _error;
  double _uploadProgress = 0.0;

  // Form data
  KycUploadStep _currentStep = KycUploadStep.primaryId;
  IdType _selectedIdType = IdType.nationalId;
  String _idNumber = '';
  Uint8List? _primaryIdImage;
  Uint8List? _secondaryIdImage;
  Uint8List? _selfieImage;

  // Getters
  KycModel? get kycData => _kycData;
  bool get isLoading => _isLoading;
  String? get error => _error;
  double get uploadProgress => _uploadProgress;
  KycUploadStep get currentStep => _currentStep;
  IdType get selectedIdType => _selectedIdType;
  String get idNumber => _idNumber;
  Uint8List? get primaryIdImage => _primaryIdImage;
  Uint8List? get secondaryIdImage => _secondaryIdImage;
  Uint8List? get selfieImage => _selfieImage;

  bool get isFormValid {
    if (_idNumber.isEmpty || _primaryIdImage == null || _selfieImage == null) {
      return false;
    }
    return true;
  }

  bool get canProceedToNextStep {
    switch (_currentStep) {
      case KycUploadStep.primaryId:
        return _primaryIdImage != null;
      case KycUploadStep.secondaryId:
        return true; // Secondary ID is optional
      case KycUploadStep.selfie:
        return _selfieImage != null;
    }
  }

  // Setters
  void setIdType(IdType type) {
    _selectedIdType = type;
    notifyListeners();
  }

  void setIdNumber(String number) {
    _idNumber = number;
    notifyListeners();
  }

  void setPrimaryIdImage(Uint8List? image) {
    _primaryIdImage = image;
    notifyListeners();
  }

  void setSecondaryIdImage(Uint8List? image) {
    _secondaryIdImage = image;
    notifyListeners();
  }

  void setSelfieImage(Uint8List? image) {
    _selfieImage = image;
    notifyListeners();
  }

  void nextStep() {
    if (_currentStep == KycUploadStep.primaryId) {
      _currentStep = KycUploadStep.secondaryId;
    } else if (_currentStep == KycUploadStep.secondaryId) {
      _currentStep = KycUploadStep.selfie;
    }
    notifyListeners();
  }

  void previousStep() {
    if (_currentStep == KycUploadStep.selfie) {
      _currentStep = KycUploadStep.secondaryId;
    } else if (_currentStep == KycUploadStep.secondaryId) {
      _currentStep = KycUploadStep.primaryId;
    }
    notifyListeners();
  }

  void resetForm() {
    _currentStep = KycUploadStep.primaryId;
    _selectedIdType = IdType.nationalId;
    _idNumber = '';
    _primaryIdImage = null;
    _secondaryIdImage = null;
    _selfieImage = null;
    _uploadProgress = 0.0;
    _error = null;
    notifyListeners();
  }

  Future<void> loadKycStatus(String userId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _kycData = await _kycService.getKYCStatus(userId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> submitKyc(String userId) async {
    if (!isFormValid) {
      _error = 'Please complete all required fields';
      notifyListeners();
      return false;
    }

    _isLoading = true;
    _error = null;
    _uploadProgress = 0.0;
    notifyListeners();

    try {
      // Simulate upload progress
      for (var i = 1; i <= 5; i++) {
        await Future.delayed(const Duration(milliseconds: 400));
        _uploadProgress = i / 5;
        notifyListeners();
      }

      _kycData = await _kycService.submitKYC(
        userId: userId,
        idType: _selectedIdType,
        idNumber: _idNumber,
        primaryIdImage: _primaryIdImage!,
        secondaryIdImage: _secondaryIdImage,
        selfieImage: _selfieImage!,
      );

      _uploadProgress = 1.0;
      notifyListeners();

      // Start polling for status updates
      _startPolling(userId);

      return true;
    } catch (e) {
      _error = e.toString();
      _uploadProgress = 0.0;
      notifyListeners();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _startPolling(String userId) {
    // Poll every 2 seconds for status updates
    Future.delayed(const Duration(seconds: 2), () async {
      final kyc = await _kycService.getKYCStatus(userId);
      if (kyc != null && kyc.id == _kycData?.id) {
        _kycData = kyc;
        notifyListeners();

        // Continue polling if still pending
        if (kyc.verificationStatus == KycVerificationStatus.pending) {
          _startPolling(userId);
        }
      }
    });
  }

  @override
  void dispose() {
    _kycService.dispose();
    super.dispose();
  }
}
