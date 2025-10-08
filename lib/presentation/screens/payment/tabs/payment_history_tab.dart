import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../data/models/transaction_model.dart';
import '../../../providers/payment_provider.dart';
import '../widgets/transaction_item.dart';

class PaymentHistoryTab extends StatefulWidget {
  const PaymentHistoryTab({super.key});

  @override
  State<PaymentHistoryTab> createState() => _PaymentHistoryTabState();
}

class _PaymentHistoryTabState extends State<PaymentHistoryTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  EscrowStatus? _selectedFilter;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadTransactions();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadTransactions() async {
    final provider = context.read<PaymentProvider>();
    await provider.loadUserTransactions('user123');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'As Buyer'),
            Tab(text: 'As Seller'),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Text(
                'Filter:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildFilterChip('All', null),
                      _buildFilterChip('Pending', EscrowStatus.pending),
                      _buildFilterChip('In Escrow', EscrowStatus.held),
                      _buildFilterChip('Completed', EscrowStatus.released),
                      _buildFilterChip('Refunded', EscrowStatus.refunded),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildTransactionList(true),
              _buildTransactionList(false),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(String label, EscrowStatus? status) {
    final isSelected = _selectedFilter == status;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            _selectedFilter = selected ? status : null;
          });
        },
      ),
    );
  }

  Widget _buildTransactionList(bool asBuyer) {
    return Consumer<PaymentProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final transactions = asBuyer
            ? provider.buyerTransactions
            : provider.sellerTransactions;

        final filteredTransactions = _selectedFilter == null
            ? transactions
            : transactions
                .where((t) => t.escrowStatus == _selectedFilter)
                .toList();

        if (filteredTransactions.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.receipt_long_outlined,
                  size: 64,
                  color: Colors.grey[300],
                ),
                const SizedBox(height: 16),
                Text(
                  'No transactions yet',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: _loadTransactions,
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: filteredTransactions.length,
            itemBuilder: (context, index) {
              final transaction = filteredTransactions[index];
              return TransactionItem(
                transaction: transaction,
                onTap: () {
                  context.push('/transaction/${transaction.id}');
                },
              );
            },
          ),
        );
      },
    );
  }
}
