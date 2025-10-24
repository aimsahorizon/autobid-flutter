import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../data/models/auction_model.dart';
import '../../../../core/constants/bid_increments.dart';
import '../../../../core/constants/color_constants.dart';
import '../../../../core/utils/bid_validator.dart';
import '../../../providers/token_provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/deposit_provider.dart';
import '../../../widgets/token_top_up_sheet.dart';

class BidInputWidget extends ConsumerStatefulWidget {
  final Auction auction;
  final Function(double) onBidPlaced;

  const BidInputWidget({
    super.key,
    required this.auction,
    required this.onBidPlaced,
  });

  @override
  ConsumerState<BidInputWidget> createState() => _BidInputWidgetState();
}

class _BidInputWidgetState extends ConsumerState<BidInputWidget> {
  final _controller = TextEditingController();
  String? _error;
  double? _bidAmount;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _showDepositRequiredDialog() async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.lock_outline,
            size: 48,
            color: Colors.orange.shade700,
          ),
        ),
        title: const Text('Deposit Required'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'You need to pay a ₱10,000 refundable deposit before placing bids.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle, size: 16, color: Colors.green),
                  const SizedBox(width: 8),
                  Text(
                    '100% Refundable',
                    style: TextStyle(
                      color: Colors.green.shade900,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton.icon(
            onPressed: () {
              Navigator.pop(context);
              context.push('/deposit/payment');
            },
            icon: const Icon(Icons.payment),
            label: const Text('Pay Deposit'),
            style: FilledButton.styleFrom(
              backgroundColor: Colors.orange,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showInsufficientTokensDialog(int currentBalance) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.orange),
            SizedBox(width: 12),
            Text('Insufficient Tokens'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('You need at least 1 token to place a bid.'),
            const SizedBox(height: 12),
            Text(
              'Current balance: $currentBalance tokens',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: currentBalance == 0 ? Colors.red : Colors.orange,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Purchase tokens to continue bidding.',
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context);
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => const TokenTopUpSheet(),
              );
            },
            icon: const Icon(Icons.add),
            label: const Text('Buy Tokens'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void _updateBidAmount(String value) {
    setState(() {
      _bidAmount = double.tryParse(value.replaceAll(',', ''));
      if (_bidAmount != null) {
        _error = BidValidator.validateBid(_bidAmount!, widget.auction);
      } else {
        _error = null;
      }
    });
  }

  void _setQuickBid(double increment) {
    final amount = widget.auction.currentBid + increment;
    _controller.text = _formatCurrency(amount);
    _updateBidAmount(amount.toString());
  }

  Future<void> _placeBid() async {
    if (_bidAmount == null || _error != null) return;

    // Check deposit first
    final currentUser = ref.read(currentUserProvider);
    if (currentUser == null) return;

    final hasDeposit = await ref.read(hasDepositProvider(currentUser.id).future);
    if (!hasDeposit) {
      _showDepositRequiredDialog();
      return;
    }

    // Check token balance (REVISED Revenue Model)
    final tokenBalanceAsync = ref.read(currentUserTokenBalanceProvider);
    final balance = tokenBalanceAsync.value ?? 0;

    if (balance < 1) {
      _showInsufficientTokensDialog(balance);
      return;
    }

    // Proceed with bid
    widget.onBidPlaced(_bidAmount!);
    _controller.clear();
    setState(() {
      _bidAmount = null;
      _error = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final minBid = BidValidator.getMinimumBid(widget.auction);
    final tokenBalanceAsync = ref.watch(currentUserTokenBalanceProvider);

    // Bidding interface (REVISED - Token-based)
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Place Your Bid',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: ColorConstants.primaryGreen.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_circle, size: 14, color: ColorConstants.primaryGreen),
                      const SizedBox(width: 4),
                      Text(
                        'Verified',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: ColorConstants.primaryGreen,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Minimum bid: ₱${_formatCurrency(minBid)}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: InputDecoration(
                labelText: 'Bid Amount',
                prefixText: '₱ ',
                errorText: _error,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                suffixIcon: _bidAmount != null && _error == null
                    ? Icon(Icons.check_circle, color: Colors.green)
                    : null,
              ),
              onChanged: _updateBidAmount,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: BidIncrements.quickBidIncrements.map((increment) {
                return OutlinedButton(
                  onPressed: () => _setQuickBid(increment),
                  child: Text('+₱${_formatCurrency(increment)}'),
                );
              }).toList(),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _bidAmount != null && _error == null ? _placeBid : null,
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Place Bid',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatCurrency(double amount) {
    return amount.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }
}
