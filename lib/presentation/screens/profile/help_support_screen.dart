import 'package:flutter/material.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  String? _selectedCategory;
  final List<String> _categories = [
    'Account Issues',
    'Bidding & Auctions',
    'Payments & Transactions',
    'KYC Verification',
    'Listings',
    'Technical Issues',
    'Other',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submitSupport() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Simulate sending support request
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Support request submitted successfully. We\'ll respond within 24 hours.'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 3),
      ),
    );

    // Clear form
    _nameController.clear();
    _emailController.clear();
    _subjectController.clear();
    _messageController.clear();
    setState(() {
      _selectedCategory = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // FAQs Section
          Text(
            'Frequently Asked Questions',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),

          _buildFAQItem(
            question: 'How do I verify my account?',
            answer:
                'Complete the 8-step KYC registration process including uploading your government IDs, selfie, and proof of address. Verification typically takes 1-2 business days.',
          ),
          _buildFAQItem(
            question: 'How does bidding work?',
            answer:
                'Place bids on live auctions. You can set up auto-bid to automatically bid up to your maximum amount. The highest bidder when the auction ends wins the vehicle.',
          ),
          _buildFAQItem(
            question: 'What payment methods are accepted?',
            answer:
                'We accept GCash, PayMaya, bank transfer, and cash on pickup. All payments are held in escrow until the buyer confirms receipt of the vehicle.',
          ),
          _buildFAQItem(
            question: 'How do I sell my car?',
            answer:
                'Create a listing with your vehicle details, upload photos, and submit vehicle documents (OR/CR, emission test). Once approved, your car will be listed for auction.',
          ),
          // _buildFAQItem(
          //   question: 'What are verification levels?',
          //   answer:
          //       'Verification levels determine your buying/selling limits. Level 1 (default) allows up to ₱500k, Level 2 up to ₱2M, and Level 3 has no limits. Upgrade by submitting additional documents.',
          // ),
          // _buildFAQItem(
          //   question: 'How long does delivery take?',
          //   answer:
          //       'Delivery time depends on the seller and location. Typically, vehicles are transferred within 7-14 days after payment. You can also arrange self-pickup.',
          // ),

          const SizedBox(height: 32),
          const Divider(),
          const SizedBox(height: 16),

          // Contact Support Section
          Text(
            'Contact Support',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Can\'t find what you\'re looking for? Send us a message.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 16),

          // Support Form
          Form(
            key: _formKey,
            child: Column(
              children: [
                // Name
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    hintText: 'Enter your name',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Email
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email Address',
                    hintText: 'Enter your email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Email is required';
                    }
                    final emailRegex = RegExp(
                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                    );
                    if (!emailRegex.hasMatch(value)) {
                      return 'Invalid email format';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Category
                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  decoration: const InputDecoration(
                    labelText: 'Category',
                    prefixIcon: Icon(Icons.category),
                    border: OutlineInputBorder(),
                  ),
                  items: _categories.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a category';
                    }
                    return null;
                  },
                  hint: const Text('Select category'),
                ),
                const SizedBox(height: 16),

                // Subject
                TextFormField(
                  controller: _subjectController,
                  decoration: const InputDecoration(
                    labelText: 'Subject',
                    hintText: 'Brief description of your issue',
                    prefixIcon: Icon(Icons.subject),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Subject is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Message
                TextFormField(
                  controller: _messageController,
                  decoration: const InputDecoration(
                    labelText: 'Message',
                    hintText: 'Describe your issue in detail',
                    prefixIcon: Icon(Icons.message),
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Message is required';
                    }
                    if (value.trim().length < 20) {
                      return 'Please provide more details (at least 20 characters)';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: _submitSupport,
                    icon: const Icon(Icons.send),
                    label: const Text('Submit Request'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Additional Support Channels
          // Text(
          //   'Other Ways to Reach Us',
          //   style: Theme.of(context).textTheme.titleLarge?.copyWith(
          //         fontWeight: FontWeight.bold,
          //       ),
          // ),
          // const SizedBox(height: 16),

          // _buildSupportChannel(
          //   icon: Icons.email,
          //   title: 'Email',
          //   subtitle: 'support@autobid.ph',
          //   color: Colors.blue,
          // ),
          // const SizedBox(height: 12),
          // _buildSupportChannel(
          //   icon: Icons.phone,
          //   title: 'Phone',
          //   subtitle: '+63 (02) 8123-4567',
          //   color: Colors.green,
          // ),
          // const SizedBox(height: 12),
          // _buildSupportChannel(
          //   icon: Icons.chat,
          //   title: 'Live Chat',
          //   subtitle: 'Available Mon-Fri, 9AM-6PM',
          //   color: Colors.orange,
          // ),
          // const SizedBox(height: 12),
          // _buildSupportChannel(
          //   icon: Icons.facebook,
          //   title: 'Facebook',
          //   subtitle: 'fb.com/AutoBIDPH',
          //   color: Colors.indigo,
          // ),
        ],
      ),
    );
  }

  Widget _buildFAQItem({required String question, required String answer}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        title: Text(
          question,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              answer,
              style: TextStyle(color: Colors.grey[700], height: 1.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSupportChannel({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
