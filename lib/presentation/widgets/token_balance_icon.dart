import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:autobid/presentation/providers/token_provider.dart';
import 'package:autobid/presentation/widgets/token_top_up_sheet.dart';

/// Token balance icon widget for AppBar
///
/// Shows current token balance with coin icon.
/// Tapping opens token top-up sheet.
class TokenBalanceIcon extends ConsumerWidget {
  const TokenBalanceIcon({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tokenBalanceAsync = ref.watch(currentUserTokenBalanceProvider);

    return tokenBalanceAsync.when(
      data: (balance) => _buildTokenButton(context, balance),
      loading: () => _buildTokenButton(context, 0, isLoading: true),
      error: (_, __) => _buildTokenButton(context, 0, hasError: true),
    );
  }

  Widget _buildTokenButton(
    BuildContext context,
    int balance, {
    bool isLoading = false,
    bool hasError = false,
  }) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => const TokenTopUpSheet(),
        );
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.generating_tokens_rounded,
              size: 18,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
            const SizedBox(width: 6),
            if (isLoading)
              SizedBox(
                width: 30,
                height: 14,
                child: Center(
                  child: SizedBox(
                    width: 12,
                    height: 12,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
              )
            else if (hasError)
              Text(
                '--',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              )
            else
              Text(
                balance.toString(),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
