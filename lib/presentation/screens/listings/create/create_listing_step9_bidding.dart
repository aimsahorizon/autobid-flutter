import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart' as provider_pkg;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../data/models/car_model.dart';
import '../../../../data/services/mock/mock_ai_pricing_service.dart';
import '../../../providers/listing_provider.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/save_draft_button.dart';
import 'create_listing_step_mixin.dart';

class CreateListingStep9Bidding extends ConsumerStatefulWidget {
  const CreateListingStep9Bidding({super.key});

  @override
  ConsumerState<CreateListingStep9Bidding> createState() =>
      _CreateListingStep9BiddingState();
}

class _CreateListingStep9BiddingState
    extends ConsumerState<CreateListingStep9Bidding>
    with CreateListingMixin {
  final _formKey = GlobalKey<FormState>();
  final _aiPricingService = MockAIPricingService();

  // Controllers
  final _openingPriceController = TextEditingController();
  final _reservePriceController = TextEditingController();
  final _bidIncrementController = TextEditingController();

  // AI Predictions
  bool _isLoadingPredictions = false;
  Map<String, dynamic>? _aiPredictions;
  bool _hasAppliedAI = false;

  @override
  void initState() {
    super.initState();
    final provider = context.read<ListingProvider>();
    provider.setCurrentStep(9);

    // Load AI predictions
    _loadAIPredictions();
  }

  @override
  void dispose() {
    _openingPriceController.dispose();
    _reservePriceController.dispose();
    _bidIncrementController.dispose();
    super.dispose();
  }

  Future<void> _loadAIPredictions() async {
    setState(() => _isLoadingPredictions = true);

    try {
      final provider = provider_pkg.Provider.of<ListingProvider>(context, listen: false);

      // Build temporary car model for AI prediction
      final tempCar = await provider.createListing('temp-user', 'Temp User', isDraft: true);

      // Get predictions from AI service
      final predictions = await _aiPricingService.predictPricing(tempCar);

      if (mounted) {
        setState(() {
          _aiPredictions = predictions;
          _isLoadingPredictions = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoadingPredictions = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load AI predictions: $e'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    }
  }

  void _applyAIPricing() {
    if (_aiPredictions == null) return;

    setState(() {
      _openingPriceController.text = _formatNumber(_aiPredictions!['openingPrice']);
      _reservePriceController.text = _formatNumber(_aiPredictions!['reservePrice']);
      _bidIncrementController.text = _formatNumber(_aiPredictions!['bidIncrement']);
      _hasAppliedAI = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('AI pricing applied successfully'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  String _formatNumber(double value) {
    return value.toStringAsFixed(0);
  }

  String _formatCurrency(double value) {
    final formatter = NumberFormat.currency(locale: 'en_PH', symbol: '₱', decimalDigits: 0);
    return formatter.format(value);
  }

  bool _validateForm() {
    if (!_formKey.currentState!.validate()) {
      return false;
    }

    final openingPrice = double.tryParse(_openingPriceController.text.replaceAll(',', '')) ?? 0;
    final reservePrice = double.tryParse(_reservePriceController.text.replaceAll(',', '')) ?? 0;

    if (openingPrice >= reservePrice) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Reserve price must be higher than opening price'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    return true;
  }

  void _handleNext() {
    if (!_validateForm()) return;

    final provider = provider_pkg.Provider.of<ListingProvider>(context, listen: false);

    // Save bidding settings to provider
    provider.setAuctionSettings(
      startingPrice: double.parse(_openingPriceController.text.replaceAll(',', '')),
      reservePrice: double.parse(_reservePriceController.text.replaceAll(',', '')),
      bidIncrement: double.parse(_bidIncrementController.text.replaceAll(',', '')),
      durationDays: 7, // Default 7 days auction duration
    );

    context.push('/listing/create/step10');
  }

  @override
  Widget build(BuildContext context) {
    final provider = provider_pkg.Provider.of<ListingProvider>(context);
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => handleBackWithWarning(),
        ),
        title: const Text('Bidding Settings'),
        actions: [
          SaveDraftButton(
            stepNumber: 9,
            validateForm: _validateForm,
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Progress Indicator
            LinearProgressIndicator(
              value: 9 / 10,
              backgroundColor: isDarkMode ? Colors.grey[700] : Colors.grey[200],
            ),
            const SizedBox(height: 24),

            // Step indicator
            Text(
              'Step 9 of 10',
              style: theme.textTheme.bodySmall?.copyWith(
                color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),

            Text(
              'Configure Auction Settings',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            Text(
              'Set your auction prices and bidding rules. Our AI can suggest optimal pricing based on your vehicle details.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
            const SizedBox(height: 32),

            // AI Predictions Card
            if (_isLoadingPredictions)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      const CircularProgressIndicator(),
                      const SizedBox(height: 16),
                      Text(
                        'AI is analyzing your vehicle...',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              )
            else if (_aiPredictions != null) ...[
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.purple.shade50,
                      Colors.blue.shade50,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.purple.shade200,
                    width: 2,
                  ),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.purple.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.psychology,
                            color: Colors.purple.shade700,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'AI Price Predictions',
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.purple.shade900,
                                ),
                              ),
                              Text(
                                '${_aiPredictions!['confidence']}% Confidence',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: Colors.purple.shade700,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (!_hasAppliedAI)
                          FilledButton.icon(
                            onPressed: _applyAIPricing,
                            style: FilledButton.styleFrom(
                              backgroundColor: Colors.purple.shade700,
                            ),
                            icon: const Icon(Icons.auto_fix_high, size: 18),
                            label: const Text('Apply'),
                          ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Estimated Value
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Estimated Market Value',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: Colors.grey[700],
                                ),
                              ),
                              Text(
                                _formatCurrency(_aiPredictions!['estimatedValue']),
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green.shade700,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          const Divider(height: 1),
                          const SizedBox(height: 12),

                          // Suggested prices
                          _buildPriceSuggestion(
                            'Opening Price',
                            _aiPredictions!['openingPrice'],
                            Icons.gavel,
                            Colors.blue,
                          ),
                          const SizedBox(height: 8),
                          _buildPriceSuggestion(
                            'Reserve Price',
                            _aiPredictions!['reservePrice'],
                            Icons.shield,
                            Colors.orange,
                          ),
                          const SizedBox(height: 8),
                          _buildPriceSuggestion(
                            'Bid Increment',
                            _aiPredictions!['bidIncrement'],
                            Icons.trending_up,
                            Colors.purple,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Market insights
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.insights, size: 20, color: Colors.blue.shade700),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Market Trend: ${_aiPredictions!['marketTrend']} • '
                              'Demand: ${_aiPredictions!['demandLevel']}',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.blue.shade900,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // AI Insights
                    if (_aiPredictions!['insights'] != null) ...[
                      const SizedBox(height: 16),
                      Text(
                        'Key Insights',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.purple.shade900,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ...(_aiPredictions!['insights'] as List<String>).map(
                        (insight) => Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.check_circle,
                                size: 16,
                                color: Colors.green.shade600,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  insight,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey[800],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 32),
            ],

            // Manual Input Section
            Text(
              'Auction Configuration',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Opening Price
            TextFormField(
              controller: _openingPriceController,
              decoration: InputDecoration(
                labelText: 'Opening Price *',
                hintText: 'Starting bid amount',
                prefixText: '₱ ',
                helperText: 'The initial starting bid for your auction',
                border: const OutlineInputBorder(),
                suffixIcon: const Icon(Icons.attach_money),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter opening price';
                }
                final price = double.tryParse(value);
                if (price == null || price <= 0) {
                  return 'Please enter a valid price';
                }
                if (price < 10000) {
                  return 'Minimum opening price is ₱10,000';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Reserve Price
            TextFormField(
              controller: _reservePriceController,
              decoration: InputDecoration(
                labelText: 'Reserve Price *',
                hintText: 'Minimum acceptable price',
                prefixText: '₱ ',
                helperText: 'Your car won\'t sell below this price',
                border: const OutlineInputBorder(),
                suffixIcon: const Icon(Icons.shield_outlined),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter reserve price';
                }
                final price = double.tryParse(value);
                if (price == null || price <= 0) {
                  return 'Please enter a valid price';
                }
                if (price < 15000) {
                  return 'Minimum reserve price is ₱15,000';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Bid Increment
            TextFormField(
              controller: _bidIncrementController,
              decoration: InputDecoration(
                labelText: 'Bid Increment *',
                hintText: 'Minimum bid increase',
                prefixText: '₱ ',
                helperText: 'Each new bid must be at least this amount higher',
                border: const OutlineInputBorder(),
                suffixIcon: const Icon(Icons.trending_up),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter bid increment';
                }
                final increment = double.tryParse(value);
                if (increment == null || increment <= 0) {
                  return 'Please enter a valid increment';
                }
                if (increment < 100) {
                  return 'Minimum bid increment is ₱100';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),

            // Info Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.amber.shade200),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline, color: Colors.amber.shade700),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pricing Tips',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.amber.shade900,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '• Set opening price 10-20% below reserve\n'
                          '• Reserve price should reflect your minimum acceptable amount\n'
                          '• Bid increments of 1-2% of opening price work well\n'
                          '• Consider AI suggestions for optimal market positioning',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.amber.shade900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => context.push('/listing/create/step8'),
                  child: const Text('Back'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 2,
                child: CustomButton(
                  text: 'Next',
                  onPressed: () {
                    if (provider.validateStep8()) {
                      context.push('/listing/create/step10');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Please write at least 50 characters description'),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriceSuggestion(String label, double value, IconData icon, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
        Text(
          _formatCurrency(value),
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
