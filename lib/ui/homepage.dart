import 'package:flutter/material.dart';
import '../styles/text_styles.dart';
import '../widgets/coffee_logo.dart';
import '../widgets/app_drawer.dart';
import 'login_page.dart';

const double _contentMaxWidth = 420;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: AppDrawer(currentRoute: routeName),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: _contentMaxWidth),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  // Header: Welcome text + Icons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Welcome Text
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Good Morning',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Williams',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Icons: Shop + Menu
                      Row(
                        children: [
                          // Shopping Bag Icon with Badge
                          Stack(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.shopping_bag_outlined,
                                  color: Colors.black87,
                                  size: 24,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pushNamed('/cart');
                                },
                              ),
                              Positioned(
                                right: 8,
                                top: 8,
                                child: Container(
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(
                                    color: primaryGreen,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // Hamburger Menu Icon
                          Builder(
                            builder: (context) => IconButton(
                              icon: const Icon(
                                Icons.menu,
                                color: Colors.black87,
                                size: 24,
                              ),
                              onPressed: () {
                                Scaffold.of(context).openDrawer();
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Search Bar
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              hintText: 'Search beverages or foods',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.search,
                          color: Colors.grey,
                          size: 22,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Categories Section
                  const Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _CategoryCard(
                          icon: Icons.coffee_outlined,
                          title: 'Beverages',
                          menuCount: '67',
                          onTap: () {
                            Navigator.of(context).pushNamed('/products', arguments: 'Beverages');
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _CategoryCard(
                          icon: Icons.fastfood_outlined,
                          title: 'Foods',
                          menuCount: '23',
                          onTap: () {
                            Navigator.of(context).pushNamed('/products', arguments: 'Beverages');
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  // Stats Cards
                  Row(
                    children: [
                      Expanded(
                        child: _StatCard(
                          icon: Icons.coffee,
                          title: 'Orders',
                          value: '24',
                          color: primaryGreen,
                          imageUrl: 'https://images.unsplash.com/photo-1509042239860-f550ce710b93?q=80&w=200&auto=format&fit=crop',
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _StatCard(
                          icon: Icons.favorite,
                          title: 'Favorites',
                          value: '12',
                          color: Colors.red,
                          imageUrl: 'https://images.unsplash.com/photo-1511920170033-f8396924c348?q=80&w=200&auto=format&fit=crop',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Featured Section
                  const Text(
                    'Featured',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _FeaturedCard(
                    title: 'Special Coffee Blend',
                    description: 'A unique blend of premium coffee beans',
                    price: '\$12.99',
                    imageUrl: 'https://images.unsplash.com/photo-1445077100181-a33e9ac94db0?q=80&w=400&auto=format&fit=crop',
                  ),
                  const SizedBox(height: 16),
                  _FeaturedCard(
                    title: 'Fresh Espresso',
                    description: 'Rich and aromatic espresso shots',
                    price: '\$8.99',
                    imageUrl: 'https://images.unsplash.com/photo-1470337458703-46ad1756a187?q=80&w=400&auto=format&fit=crop',
                  ),
                  const SizedBox(height: 48),
                  // Action Button
                  SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryGreen,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                      ),
                      onPressed: () {
                        // Add navigation or action here
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Feature coming soon!'),
                            backgroundColor: primaryGreen,
                          ),
                        );
                      },
                      child: const Text(
                        'EXPLORE MENU',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;
  final String? imageUrl;

  const _StatCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: lightGray, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (imageUrl == null)
            Icon(icon, color: color, size: 32)
          else
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(imageUrl!, width: 40, height: 40, fit: BoxFit.cover),
            ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: subtitleColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _FeaturedCard extends StatelessWidget {
  final String title;
  final String description;
  final String price;
  final String imageUrl;

  const _FeaturedCard({
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: lightGray, width: 1),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(imageUrl, width: 80, height: 80, fit: BoxFit.cover),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: subtitleColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: primaryGreen,
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

class _CategoryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String menuCount;
  final VoidCallback? onTap;

  const _CategoryCard({
    required this.icon,
    required this.title,
    required this.menuCount,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: lightGray, width: 1),
        ),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: primaryGreen,
                size: 24,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            '$menuCount Menus',
            style: const TextStyle(
              fontSize: 14,
              color: subtitleColor,
            ),
          ),
        ],
        ),
      ),
    );
  }
}


