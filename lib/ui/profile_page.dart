import 'package:flutter/material.dart';

import '../styles/text_styles.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static const String routeName = '/profile';

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
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Profile', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700)),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.black87),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Edit profile clicked')));
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        children: [
          const SizedBox(height: 12),
          // Avatar
          Center(
            child: CircleAvatar(
              radius: 56,
              backgroundImage: const NetworkImage('https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=400&auto=format&fit=crop'),
              backgroundColor: Colors.grey[200],
            ),
          ),
          const SizedBox(height: 24),
          // Name & location
          const Center(
            child: Text('William Smith', style: TextStyle(fontSize: 36, fontWeight: FontWeight.w700, color: Colors.black87, height: 1.2)),
          ),
          const SizedBox(height: 10),
          const Center(
            child: Text('London, England', style: TextStyle(fontSize: 20, color: primaryGreen)),
          ),
          const SizedBox(height: 28),
          // Info rows
          _InfoRow(
            icon: Icons.call,
            title: 'Mobile Phone',
            value: '+12 345 678 92',
          ),
          const SizedBox(height: 18),
          _InfoRow(
            icon: Icons.email_outlined,
            title: 'Email Address',
            value: 'example@gmail.com',
          ),
          const SizedBox(height: 18),
          _InfoRow(
            icon: Icons.location_on_outlined,
            title: 'Address',
            value: 'Franklin Avenue, Corner St.\nLondon, 24125151',
          ),
          const SizedBox(height: 28),
          const Text('Most Ordered', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Colors.black87)),
          const SizedBox(height: 14),
          SizedBox(
            height: 160,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                _MenuCard(
                  title: 'Creamy Latte\nCoffee',
                  subtitle: 'Beverages',
                  imageUrl: 'https://images.unsplash.com/photo-1509042239860-f550ce710b93?q=80&w=400&auto=format&fit=crop',
                ),
                SizedBox(width: 12),
                _MenuCard(
                  title: 'Choco Muffin',
                  subtitle: 'Dessert',
                  imageUrl: 'https://images.unsplash.com/photo-1542838132-92c53300491e?q=80&w=400&auto=format&fit=crop',
                ),
                SizedBox(width: 12),
                _MenuCard(
                  title: 'Cappuccino',
                  subtitle: 'Beverages',
                  imageUrl: 'https://images.unsplash.com/photo-1481391032119-d89fee407e44?q=80&w=400&auto=format&fit=crop',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.title, required this.value});
  final IconData icon;
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: const BoxDecoration(color: Color(0xFFE6F1EC), shape: BoxShape.circle),
          child: Icon(icon, color: primaryGreen, size: 28),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: subtitleColor, fontSize: 18)),
              const SizedBox(height: 8),
              Text(value, style: const TextStyle(color: Colors.black87, fontSize: 22, fontWeight: FontWeight.w600, height: 1.3)),
            ],
          ),
        )
      ],
    );
  }
}

class _MenuCard extends StatelessWidget {
  const _MenuCard({required this.title, required this.subtitle, required this.imageUrl});
  final String title;
  final String subtitle;
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Open: $title')));
      },
      child: Container(
        width: 300,
        decoration: BoxDecoration(
          color: primaryGreen,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(imageUrl, width: 92, height: 92, fit: BoxFit.cover),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20, height: 1.2)),
                  const SizedBox(height: 8),
                  Row(
                    children: const [
                      Text('Beverages', style: TextStyle(color: Colors.white70)),
                      SizedBox(width: 8),
                      Icon(Icons.open_in_new_rounded, color: Colors.white70, size: 18),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


