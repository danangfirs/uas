import 'package:flutter/material.dart';

import '../styles/text_styles.dart';
import '../providers/cart_provider.dart';
import 'cart_page.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  static const String routeName = '/products';

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    final String initialTab = (ModalRoute.of(context)?.settings.arguments as String?) ?? 'Beverages';
    final tabs = const ['Beverages', 'Brewed Coffee', 'Blends'];
    int initialIndex = tabs.indexOf(initialTab);
    if (initialIndex < 0) initialIndex = 0;

    return DefaultTabController(
      length: tabs.length,
      initialIndex: initialIndex,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black87),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text('Products', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700)),
          actions: [
            // Cart icon with badge
            Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black87),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CartPage()),
                    );
                  },
                ),
                if (cart.itemCount > 0)
                  Positioned(
                    right: 6,
                    top: 6,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                      child: Text(
                        '${cart.itemCount}',
                        style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          ],
          bottom: TabBar(
            labelColor: primaryGreen,
            unselectedLabelColor: Colors.black54,
            indicatorColor: primaryGreen,
            isScrollable: true,
            tabs: tabs.map((t) => Tab(text: t)).toList(),
          ),
        ),
        body: Column(
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search beverages or foods',
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  filled: true,
                  fillColor: const Color(0xFFF6F7F7),
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(28),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: tabs.map((t) => _ProductList(
                  category: t,
                  onAddToCart: () => setState(() {}), // Refresh UI
                )).toList(),
              ),
            ),
          ],
        ),
        // Floating cart button when cart has items
        floatingActionButton: cart.itemCount > 0
            ? FloatingActionButton.extended(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartPage()),
                  );
                },
                backgroundColor: primaryGreen,
                icon: const Icon(Icons.shopping_cart),
                label: Text(
                  '${cart.itemCount} items • Rp ${_formatCurrency(cart.subtotal)}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              )
            : null,
      ),
    );
  }

  String _formatCurrency(double amount) {
    return amount.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        );
  }
}

class _ProductList extends StatelessWidget {
  const _ProductList({required this.category, required this.onAddToCart});
  final String category;
  final VoidCallback onAddToCart;

  @override
  Widget build(BuildContext context) {
    // Sample products - dalam real app, fetch dari API
    final items = [
      _Item(
        id: 'prod_1',
        title: 'Sweet Lemon Indonesian Tea',
        subtitle: 'Tea, Lemon',
        price: 25000,
        imageUrl: 'https://images.unsplash.com/photo-1556679343-c7306c1976bc?q=80&w=400&auto=format&fit=crop',
      ),
      _Item(
        id: 'prod_2',
        title: 'Hot Cappuccino Latte with Mocha',
        subtitle: 'Coffee',
        price: 35000,
        imageUrl: 'https://images.unsplash.com/photo-1509042239860-f550ce710b93?q=80&w=400&auto=format&fit=crop',
      ),
      _Item(
        id: 'prod_3',
        title: 'Arabica Latte Ombe Coffee',
        subtitle: 'Coffee',
        price: 42000,
        imageUrl: 'https://images.unsplash.com/photo-1470337458703-46ad1756a187?q=80&w=400&auto=format&fit=crop',
      ),
      _Item(
        id: 'prod_4',
        title: 'Matcha Green Tea Latte',
        subtitle: 'Tea, Matcha',
        price: 38000,
        imageUrl: 'https://images.unsplash.com/photo-1515823064-d6e0c04616a7?q=80&w=400&auto=format&fit=crop',
      ),
      _Item(
        id: 'prod_5',
        title: 'Iced Americano',
        subtitle: 'Coffee',
        price: 28000,
        imageUrl: 'https://images.unsplash.com/photo-1461023058943-07fcbe16d735?q=80&w=400&auto=format&fit=crop',
      ),
    ];

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
      itemBuilder: (context, index) {
        final it = items[index];
        return _ProductTile(item: it, onAddToCart: onAddToCart);
      },
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemCount: items.length,
    );
  }
}

class _Item {
  final String id;
  final String title;
  final String subtitle;
  final double price;
  final String imageUrl;
  
  const _Item({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.imageUrl,
  });
}

class _ProductTile extends StatelessWidget {
  const _ProductTile({required this.item, required this.onAddToCart});
  final _Item item;
  final VoidCallback onAddToCart;

  @override
  Widget build(BuildContext context) {
    final isInCart = cart.containsItem(item.id);
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 6))],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                item.imageUrl,
                width: 96,
                height: 96,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 96,
                  height: 96,
                  color: Colors.grey[200],
                  child: const Icon(Icons.coffee, size: 40, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black87),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(item.subtitle, style: const TextStyle(color: subtitleColor, fontSize: 14)),
                  const SizedBox(height: 6),
                  Text(
                    'Rp ${item.price.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black87),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            isInCart
                ? Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: primaryGreen),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove, size: 18),
                          color: primaryGreen,
                          constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            cart.decrementQuantity(item.id);
                            onAddToCart();
                          },
                        ),
                        Text(
                          '${cart.getQuantity(item.id)}',
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add, size: 18),
                          color: primaryGreen,
                          constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            cart.incrementQuantity(item.id);
                            onAddToCart();
                          },
                        ),
                      ],
                    ),
                  )
                : ElevatedButton(
                    onPressed: () {
                      cart.addItem(
                        id: item.id,
                        name: item.title,
                        subtitle: item.subtitle,
                        price: item.price,
                        imageUrl: item.imageUrl,
                      );
                      onAddToCart();
                      
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${item.title} ditambahkan ke keranjang'),
                          duration: const Duration(seconds: 1),
                          behavior: SnackBarBehavior.floating,
                          action: SnackBarAction(
                            label: 'LIHAT',
                            textColor: Colors.white,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const CartPage()),
                              );
                            },
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryGreen,
                      foregroundColor: Colors.white,
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    child: const Text('Buy'),
                  ),
          ],
        ),
      ),
    );
  }
}
