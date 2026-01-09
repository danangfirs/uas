import 'package:flutter/material.dart';

import '../styles/text_styles.dart';
import 'homepage.dart';

class OrderReviewPage extends StatefulWidget {
  const OrderReviewPage({super.key});

  static const String routeName = '/order-review';

  @override
  State<OrderReviewPage> createState() => _OrderReviewPageState();
}

class _OrderReviewPageState extends State<OrderReviewPage> {
  double rating = 4;
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            } else {
              Navigator.of(context).pushReplacementNamed(HomePage.routeName);
            }
          },
        ),
        title: const Text('Write Reviews', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700)),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: Icon(Icons.more_vert, color: Colors.black54),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        children: [
          // Product summary
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
              child: Image.network(
                  'https://images.unsplash.com/photo-1498804103079-a6351b050096?q=80&w=400&auto=format&fit=crop',
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Brewed Coppuccino Latte with Creamy Milk',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.black87, height: 1.3),
                    ),
                    SizedBox(height: 8),
                    Text('Beverages', style: TextStyle(color: subtitleColor, fontSize: 18)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Title
          const Center(
            child: Text('What do you think?',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Colors.black87)),
          ),
          const SizedBox(height: 12),
          const Center(
            child: Text(
              'Lorem ipsum dolor sit amet, consectetur\nadipiscing elit, sed do eiusmod',
              textAlign: TextAlign.center,
              style: TextStyle(color: subtitleColor, height: 1.6, fontSize: 18),
            ),
          ),
          const SizedBox(height: 24),
          // Rating number
          Center(
            child: Text(
              rating.toStringAsFixed(1),
              style: const TextStyle(fontSize: 64, fontWeight: FontWeight.w800, color: Colors.black87),
            ),
          ),
          const SizedBox(height: 8),
          // Stars (responsive, avoid pixel overflow)
          LayoutBuilder(
            builder: (context, constraints) {
              const double spacing = 12;
              // Compute a responsive size to fit 5 circles + spacing
              final double maxWidth = constraints.maxWidth;
              final double itemSize = ((maxWidth - (spacing * 4)) / 5).clamp(44.0, 72.0);
              return Wrap(
                alignment: WrapAlignment.center,
                spacing: spacing,
                runSpacing: spacing,
                children: List.generate(5, (index) {
                  final isFilled = index < rating.round();
                  final color = isFilled ? const Color(0xFFFF8A34) : const Color(0xFFCFD2D4);
                  return InkWell(
                    onTap: () => setState(() => rating = index + 1.0),
                    child: Container(
                      width: itemSize,
                      height: itemSize,
                      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                      child: Icon(Icons.star, color: Colors.white, size: itemSize * 0.5),
                    ),
                  );
                }),
              );
            },
          ),
          const SizedBox(height: 24),
          // Text area
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE9EBEC)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: controller,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'Write your review here',
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Send button
          SizedBox(
            width: double.infinity,
            height: 68,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Review sent')));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryGreen,
                foregroundColor: Colors.white,
                shape: const StadiumBorder(),
              ),
              child: const Text('SEND', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }
}


