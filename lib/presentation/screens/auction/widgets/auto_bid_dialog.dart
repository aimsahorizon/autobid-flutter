import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../../../../data/models/auto_bid_config.dart';
import '../../../../data/models/auction_model.dart';
import '../../../../core/constants/bid_increments.dart';
import '../../../../core/utils/bid_validator.dart';

class AutoBidDialog extends StatefulWidget {
  final Auction auction;
  final AutoBidConfig? existingConfig;

  const AutoBidDialog({
    super.key,
    required this.auction,
    this.existingConfig,
  });

  @override
  State<AutoBidDialog> createState() => _AutoBidDialogState();
}

class _AutoBidDialogState extends State<AutoBidDialog> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  final _currencyFormat = NumberFormat.currency(symbol: '₱', locale: 'en_PH', decimalDigits: 0);

  double _increment = BidIncrements.twoThousand;
  bool _isActive = true;
  bool _isSubmitting = false;
  String? _error;
  String? _inlineError;

  @override
  void initState() {
    super.initState();
    if (widget.existingConfig != null) {
      _controller.text = widget.existingConfig!.maxBidAmount.toStringAsFixed(0);
      _increment = widget.existingConfig!.incrementAmount;
      _isActive = widget.existingConfig!.isActive;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _validateMaxBid(String value) {
    final maxBid = double.tryParse(value.replaceAll(',', ''));
    setState(() {
      if (maxBid != null) {
        _error = BidValidator.validateAutoBid(
          maxBid,
          widget.auction.currentBid,
          widget.auction.buyNowPrice,
        );
      } else {
        _error = null;
      }
    });
  }

  /// Submit proxy bid with backend-ready payload
  ///
  /// Builds a backend-ready payload and simulates API call.
  /// Payload structure:
  /// ```json
  /// {
  ///   "auction_id": "string",
  ///   "max_amount": number,
  ///   "increment_amount": number,
  ///   "is_active": boolean,
  ///   "idempotency_key": "uuid"
  /// }
  /// ```
  Future<void> _submitProxyBid() async {
    // Validate form
    if (!_formKey.currentState!.validate()) return;

    final maxBid = double.tryParse(_controller.text.replaceAll(',', ''));
    if (maxBid == null || _error != null) return;

    // Clear any previous inline errors
    setState(() {
      _inlineError = null;
      _isSubmitting = true;
    });

    try {
      // Build backend-ready payload
      final payload = {
        'auction_id': widget.auction.id,
        'max_amount': maxBid,
        'increment_amount': _increment,
        'is_active': _isActive,
        'idempotency_key': const Uuid().v4(), // Generate unique idempotency key
        'timestamp': DateTime.now().toIso8601String(),
      };

      // In production, this would be: await apiService.submitAutoBid(payload);
      // For demo, we simulate the API call with a delay
      debugPrint('Auto-bid payload: $payload'); // Log payload for debugging

      // Simulate API call (1-2 seconds delay)
      await Future.delayed(const Duration(milliseconds: 1500));

      // Simulate potential API errors (5% failure rate for testing)
      // if (DateTime.now().millisecond % 20 == 0) {
      //   throw Exception('Network error: Unable to connect to server');
      // }

      // Create config object for local state management
      final config = AutoBidConfig(
        maxBidAmount: maxBid,
        incrementAmount: _increment,
        isActive: _isActive,
      );

      // Success - close dialog and return config
      if (mounted) {
        Navigator.of(context).pop(config);
      }
    } catch (e) {
      // Handle errors
      if (mounted) {
        setState(() {
          _inlineError = e.toString().replaceAll('Exception: ', '');
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final nextMinimumBid = widget.auction.currentBid + BidIncrements.minimumIncrement;

    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with icon
              Row(
                children: [
                  Icon(Icons.auto_mode, color: theme.colorScheme.primary),
                  const SizedBox(width: 8),
                  Text(
                    'Auto-Bid Setup',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Auction Summary Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: theme.colorScheme.outline.withOpacity(0.2),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Auction Summary',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildInfoRow(
                      'Vehicle',
                      widget.auction.car != null
                          ? '${widget.auction.car!.year} ${widget.auction.car!.brand} ${widget.auction.car!.model}'
                          : 'Car Auction',
                      theme,
                    ),
                    const SizedBox(height: 8),
                    _buildInfoRow(
                      'Current Bid',
                      _currencyFormat.format(widget.auction.currentBid),
                      theme,
                    ),
                    const SizedBox(height: 8),
                    _buildInfoRow(
                      'Next Minimum Bid',
                      _currencyFormat.format(nextMinimumBid),
                      theme,
                      highlight: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Info banner
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, size: 20, color: Colors.blue[700]),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Auto-bid will automatically place bids up to your maximum amount when you\'re outbid.',
                        style: TextStyle(fontSize: 12, color: Colors.blue[700]),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Error banner (if any)
              if (_inlineError != null) ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error_outline, size: 20, color: Colors.red[700]),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _inlineError!,
                          style: TextStyle(fontSize: 12, color: Colors.red[700]),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],

              // Maximum Bid Amount
              Text(
                'Enter your maximum bid',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _controller,
                enabled: !_isSubmitting,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: InputDecoration(
                  labelText: 'Maximum bid amount',
                  prefixText: '₱ ',
                  errorText: _error,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  helperText: 'Must be ≥ ${_currencyFormat.format(nextMinimumBid)}',
                  filled: _isSubmitting,
                  fillColor: _isSubmitting
                      ? theme.disabledColor.withOpacity(0.05)
                      : null,
                ),
                onChanged: _validateMaxBid,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a maximum bid amount';
                  }
                  final amount = double.tryParse(value.replaceAll(',', ''));
                  if (amount == null) {
                    return 'Invalid amount';
                  }
                  if (amount < nextMinimumBid) {
                    return 'Must be at least ${_currencyFormat.format(nextMinimumBid)}';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Bid Increment
              Text(
                'Bid Increment',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: BidIncrements.autoBidIncrements.map((amount) {
                  final isSelected = _increment == amount;
                  return ChoiceChip(
                    label: Text(_currencyFormat.format(amount)),
                    selected: isSelected,
                    onSelected: _isSubmitting
                        ? null
                        : (selected) {
                            setState(() {
                              _increment = amount;
                            });
                          },
                    selectedColor: theme.colorScheme.primary.withOpacity(0.2),
                    backgroundColor: theme.colorScheme.surfaceContainerHighest,
                    labelStyle: TextStyle(
                      color: isSelected
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onSurfaceVariant,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                    side: BorderSide(
                      color: isSelected
                          ? theme.colorScheme.primary
                          : theme.colorScheme.outline.withOpacity(0.5),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              // Enable/Disable Auto-Bid
              SwitchListTile(
                title: Text(
                  'Enable Auto-Bid',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  _isActive ? 'Auto-bid is active' : 'Auto-bid is paused',
                  style: const TextStyle(fontSize: 12),
                ),
                value: _isActive,
                onChanged: _isSubmitting
                    ? null
                    : (value) {
                        setState(() {
                          _isActive = value;
                        });
                      },
                contentPadding: EdgeInsets.zero,
              ),
              const SizedBox(height: 24),

              // Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _isSubmitting
                        ? null
                        : () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    onPressed: _isSubmitting ||
                            _error != null ||
                            _controller.text.isEmpty
                        ? null
                        : _submitProxyBid,
                    child: _isSubmitting
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : const Text('Confirm Auto Bid'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, ThemeData theme, {bool highlight = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        Text(
          value,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: highlight ? FontWeight.w600 : FontWeight.normal,
            color: highlight ? theme.colorScheme.primary : null,
          ),
        ),
      ],
    );
  }
}
