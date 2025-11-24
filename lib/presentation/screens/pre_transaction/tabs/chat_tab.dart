import 'package:flutter/material.dart';

/// Chat Tab
/// Placeholder for discussion functionality (can reuse existing chat screen)
class ChatTab extends StatelessWidget {
  final String preTransactionId;

  const ChatTab({
    Key? key,
    required this.preTransactionId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_bubble_outline,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'Chat Functionality',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'This tab will integrate with the existing pre-transaction discussion screen.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 16),
            Text(
              'For now, use the standalone discussion screen to communicate with the other party.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),
            OutlinedButton.icon(
              onPressed: () {
                // Navigate to existing discussion screen
                Navigator.of(context).pop(); // Temporary - would navigate properly
              },
              icon: const Icon(Icons.arrow_back),
              label: const Text('Go to Discussion Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
