# RA 8792 Integration Plan - Implementation Guide

## Overview
Integration of RA 8792 legal compliance features into existing pre-transaction discussion flow.

## Status: KYC Modal Already Exists ✓
- File: `lib/presentation/screens/home/tabs/my_listings_tab_kyc_modal.dart`
- Already implemented with RA 8792 compliance
- Called in my_listings_tab.dart at line 196

---

## Required Changes

### 1. Add Missing _showKycModalAndNavigate Method in my_listings_tab.dart

**Location:** After `_buildPreTransactionCard` method
**Add this method:**

```dart
void _showKycModalAndNavigate({
  required String auctionId,
  required String carTitle,
  required double winningBid,
}) {
  // RA 8792 Compliance: KYC verification required before pre-transaction access
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => KycVerificationModal(
      isSeller: true,
      onSuccess: () {
        // Navigate to pre-transaction screen after KYC success
        Navigator.pushNamed(
          context,
          '/pre-transaction-discussion',
          arguments: {
            'auctionId': auctionId,
            'carTitle': carTitle,
            'winningBid': winningBid,
            'isSeller': true,
          },
        );
      },
    ),
  );
}
```

---

### 2. Add KYC Trigger in my_bids_tab.dart

**Location:** In the `_AuctionResultCard` onTap handler (around line 203-204)

**Replace:**
```dart
onTap: () {
  context.push('/auction/${auction.id}');
},
```

**With:**
```dart
onTap: () {
  // RA 8792 Compliance: KYC verification before pre-transaction
  if (transaction != null &&
      transaction.status == TransactionStatus.pendingBuyerAction) {
    _showKycModalAndNavigate(
      context: context,
      auction: auction,
      transaction: transaction,
    );
  } else {
    context.push('/auction/${auction.id}');
  }
},
```

**Add helper method in _WonTabState class:**
```dart
void _showKycModalAndNavigate({
  required BuildContext context,
  required Auction auction,
  required Transaction transaction,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => KycVerificationModal(
      isSeller: false,
      onSuccess: () {
        // Navigate to pre-transaction screen after KYC
        Navigator.pushNamed(
          context,
          '/pre-transaction-discussion',
          arguments: {
            'auctionId': auction.id,
            'carTitle': auction.carTitle,
            'winningBid': auction.currentBid,
            'isSeller': false,
          },
        );
      },
    ),
  );
}
```

**Add import at top:**
```dart
import '../../../screens/home/tabs/my_listings_tab_kyc_modal.dart';
```

---

### 3. Add Legal Acknowledgment Section in pre_transaction_discussion_screen.dart

**Location:** In `_buildFormTab` method, between line 371-372 (after form, before submit button)

**Insert:**
```dart
        ),
        // RA 8792 Legal Acknowledgment Section
        _buildLegalAcknowledgmentSection(preTransaction),
        _buildFormSubmitButton(preTransaction),
```

**Add state variables at top of _PreTransactionDiscussionScreenState class (after line 63):**
```dart
// RA 8792 Legal acknowledgment tracking
bool _legalAcknowledgmentBuyer = false;
bool _legalAcknowledgmentSeller = false;
```

**Add new method after `_buildFormSubmitButton` method (around line 1188):**
```dart
/// RA 8792 Legal Acknowledgment Section
/// Both parties must independently acknowledge that agreements are legally binding
Widget _buildLegalAcknowledgmentSection(PreTransaction preTransaction) {
  final isMyAcknowledgment = widget.isSeller
      ? _legalAcknowledgmentSeller
      : _legalAcknowledgmentBuyer;

  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: ColorConstants.info.withOpacity(0.05),
      border: Border(
        top: BorderSide(color: Colors.grey[300]!),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.gavel, color: ColorConstants.primaryGreen, size: 20),
            const SizedBox(width: 8),
            const Text(
              'Legal Acknowledgment (RA 8792)',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // RA 8792 Section 8: Electronic signatures are legally binding
        // RA 8792 Section 11: Electronic agreements are admissible as evidence
        CheckboxListTile(
          value: isMyAcknowledgment,
          onChanged: _isFormDeactivated ? null : (value) {
            setState(() {
              if (widget.isSeller) {
                _legalAcknowledgmentSeller = value ?? false;
              } else {
                _legalAcknowledgmentBuyer = value ?? false;
              }
            });
          },
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
          dense: true,
          title: const Text(
            'I acknowledge that this pre-transaction process and any signed agreements are legally binding and admissible under Republic Act No. 8792 (Electronic Commerce Act of 2000).',
            style: TextStyle(fontSize: 13),
          ),
        ),
        if (!isMyAcknowledgment)
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 40),
            child: Text(
              'You must acknowledge the legal terms before submitting',
              style: TextStyle(
                fontSize: 11,
                color: Colors.orange[700],
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
      ],
    ),
  );
}
```

**Update `_buildFormSubmitButton` method - modify canSubmit logic (around line 1156-1158):**

**Replace:**
```dart
final canSubmit = widget.isSeller
    ? (_sellerFormKey.currentState?.canSubmit() ?? false)
    : (_buyerFormKey.currentState?.canSubmit() ?? false);
```

**With:**
```dart
// RA 8792: Require legal acknowledgment before submission
final formCanSubmit = widget.isSeller
    ? (_sellerFormKey.currentState?.canSubmit() ?? false)
    : (_buyerFormKey.currentState?.canSubmit() ?? false);

final acknowledgmentGiven = widget.isSeller
    ? _legalAcknowledgmentSeller
    : _legalAcknowledgmentBuyer;

final canSubmit = formCanSubmit && acknowledgmentGiven;
```

---

### 4. Update Progress Tracker (pre_transaction_progress_tracker.dart)

**Update `_getProgressSteps()` method (around line 175-203):**

**Replace entire method with:**
```dart
List<Map<String, String>> _getProgressSteps() {
  // RA 8792 Compliant Progress: Simplified no-escrow flow
  // Check if we're in the legacy checkpoint flow (for backward compatibility)
  final isInCheckpointFlow = currentStatus == PreTransactionStatus.preparing ||
      currentStatus == PreTransactionStatus.shipping ||
      currentStatus == PreTransactionStatus.delivered ||
      currentStatus == PreTransactionStatus.paymentSuccess ||
      currentStatus == PreTransactionStatus.transactionComplete;

  if (isInCheckpointFlow) {
    // Legacy checkpoint flow (maintain for existing transactions)
    return [
      {'label': 'Preparing'},
      {'label': 'Shipping'},
      {'label': 'Delivered'},
      {'label': 'Payment Success'},
      {'label': 'Complete'},
    ];
  }

  // NEW: RA 8792 Compliant Flow - 3 Simple Steps
  return [
    {'label': 'KYC Verification'},
    {'label': 'Agreement & Acknowledgment'},
    {'label': 'Completed'},
  ];
}
```

**Update `_getCurrentStepIndex()` method (around line 205-236):**

**Replace with:**
```dart
int _getCurrentStepIndex() {
  switch (currentStatus) {
    // RA 8792 Compliant Flow
    case PreTransactionStatus.inDiscussion:
    case PreTransactionStatus.pendingVerification:
      return 0; // KYC Verification
    case PreTransactionStatus.verificationComplete:
    case PreTransactionStatus.pendingBuyerConfirmation:
    case PreTransactionStatus.pendingSellerConfirmation:
    case PreTransactionStatus.agreementDraft:
      return 1; // Agreement & Acknowledgment
    case PreTransactionStatus.agreementSigned:
    case PreTransactionStatus.pendingMutualConfirmation:
    case PreTransactionStatus.pendingAdminReview:
    case PreTransactionStatus.adminApproved:
    case PreTransactionStatus.readyForPayment:
      return 2; // Completed

    // Legacy checkpoint flow (backward compatibility)
    case PreTransactionStatus.preparing:
      return 0;
    case PreTransactionStatus.shipping:
      return 1;
    case PreTransactionStatus.delivered:
      return 2;
    case PreTransactionStatus.paymentSuccess:
      return 3;
    case PreTransactionStatus.transactionComplete:
      return 4;

    default:
      return 0;
  }
}
```

**Update `_getStatusDescription()` method (add RA 8792 references around line 330-376):**

**Add these cases at the beginning of the switch statement:**
```dart
String _getStatusDescription() {
  switch (currentStatus) {
    // RA 8792 Compliant Flow Descriptions
    case PreTransactionStatus.pendingVerification:
      return 'Identity verification required under RA 8792 before proceeding';
    case PreTransactionStatus.verificationComplete:
      return 'KYC verified. Proceed to fill out and acknowledge the agreement';
    case PreTransactionStatus.agreementDraft:
      return 'Review agreement and provide legal acknowledgment under RA 8792';
    case PreTransactionStatus.agreementSigned:
      return 'Agreement signed and legally binding under RA 8792 Section 8';

    // ... rest of existing cases
```

---

## Testing Checklist

- [ ] Seller clicks listing card → KYC modal appears
- [ ] KYC modal validates all fields (ID type, number, photos, consent)
- [ ] After KYC success, navigate to pre-transaction screen
- [ ] Buyer clicks won auction card → KYC modal appears (same validation)
- [ ] In "My Form" tab, legal acknowledgment section visible above submit button
- [ ] Submit button disabled until acknowledgment checkbox checked
- [ ] Progress tracker shows 3 steps: KYC → Agreement → Completed
- [ ] Progress tracker descriptions reference RA 8792
- [ ] No payment/handover sections visible (deprecated)

---

## Files to Modify

1. `lib/presentation/screens/home/tabs/my_listings_tab.dart` - Add _showKycModalAndNavigate method
2. `lib/presentation/screens/home/tabs/my_bids_tab.dart` - Add KYC trigger + import
3. `lib/presentation/screens/pre_transaction/pre_transaction_discussion_screen.dart` - Add legal acknowledgment
4. `lib/presentation/widgets/pre_transaction_progress_tracker.dart` - Simplify to 3 steps

---

## Backend Integration Notes (Future)

```dart
// TODO: Connect to actual KYC verification API (eKYC service)
// Example: await KycService.verifyIdentity(idType, idNumber, idPhoto, selfie)

// TODO: Store legal acknowledgment in database
// Example: await PreTransactionService.recordAcknowledgment(userId, timestamp)

// TODO: Generate RA 8792 compliant digital signature
// Example: await DigitalSignatureService.signDocument(agreementHash, userId)
```

---

## Legal Compliance References

- **RA 8792 Section 7**: Authentication of electronic data messages
- **RA 8792 Section 8**: Legal recognition of electronic signatures
- **RA 8792 Section 11**: Admissibility of electronic evidence
- **RA 8792 Section 27**: Penalties for fraudulent misrepresentation

---

**Generated:** 2025-10-22
**Status:** Ready for Implementation
