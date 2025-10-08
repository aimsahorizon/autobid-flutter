import 'package:flutter/material.dart';
import '../../../../core/utils/escrow_rules.dart';

class EscrowInfoCard extends StatefulWidget {
  const EscrowInfoCard({super.key});

  @override
  State<EscrowInfoCard> createState() => _EscrowInfoCardState();
}

class _EscrowInfoCardState extends State<EscrowInfoCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(Icons.shield, color: Colors.blue[700], size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'What is escrow?',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900],
                      ),
                    ),
                  ),
                  Icon(
                    _isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.blue[700],
                  ),
                ],
              ),
            ),
          ),
          if (_isExpanded) ...[
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    EscrowRules.getEscrowExplanation(),
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blue[900],
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Safety Tips',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900],
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...EscrowRules.getSafetyTips().map((tip) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: Colors.blue[700],
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              tip,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.blue[900],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.support_agent, color: Colors.blue[700]),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Need Help?',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue[900],
                                ),
                              ),
                              Text(
                                'Contact support@autobid.ph',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.blue[700],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
