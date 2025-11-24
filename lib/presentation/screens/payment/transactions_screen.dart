import 'package:flutter/material.dart';
import 'tabs/payment_history_tab.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Transactions'),
        centerTitle: true,
      ),
      body: const PaymentHistoryTab(),
    );
  }
}
