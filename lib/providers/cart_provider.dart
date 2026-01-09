import 'package:flutter/foundation.dart';

/// Model untuk item di keranjang
class CartItem {
  final String id;
  final String name;
  final String subtitle;
  final double price;
  final String imageUrl;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.price,
    required this.imageUrl,
    this.quantity = 1,
  });

  double get totalPrice => price * quantity;

  CartItem copyWith({
    String? id,
    String? name,
    String? subtitle,
    double? price,
    String? imageUrl,
    int? quantity,
  }) {
    return CartItem(
      id: id ?? this.id,
      name: name ?? this.name,
      subtitle: subtitle ?? this.subtitle,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      quantity: quantity ?? this.quantity,
    );
  }
}

/// Cart Provider - Singleton untuk mengelola keranjang
class CartProvider extends ChangeNotifier {
  // Singleton instance
  static final CartProvider _instance = CartProvider._internal();
  factory CartProvider() => _instance;
  CartProvider._internal();

  // Cart items
  final List<CartItem> _items = [];

  // Getters
  List<CartItem> get items => List.unmodifiable(_items);
  
  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);
  
  double get subtotal => _items.fold(0, (sum, item) => sum + item.totalPrice);
  
  double get tax => subtotal * 0.11; // 11% PPN
  
  double get total => subtotal + tax;

  bool get isEmpty => _items.isEmpty;

  /// Tambah item ke keranjang
  void addItem({
    required String id,
    required String name,
    required String subtitle,
    required double price,
    required String imageUrl,
    int quantity = 1,
  }) {
    // Cek apakah item sudah ada
    final existingIndex = _items.indexWhere((item) => item.id == id);
    
    if (existingIndex >= 0) {
      // Tambah quantity
      _items[existingIndex].quantity += quantity;
    } else {
      // Tambah item baru
      _items.add(CartItem(
        id: id,
        name: name,
        subtitle: subtitle,
        price: price,
        imageUrl: imageUrl,
        quantity: quantity,
      ));
    }
    
    notifyListeners();
  }

  /// Update quantity item
  void updateQuantity(String id, int quantity) {
    final index = _items.indexWhere((item) => item.id == id);
    if (index >= 0) {
      if (quantity <= 0) {
        _items.removeAt(index);
      } else {
        _items[index].quantity = quantity;
      }
      notifyListeners();
    }
  }

  /// Increment quantity
  void incrementQuantity(String id) {
    final index = _items.indexWhere((item) => item.id == id);
    if (index >= 0) {
      _items[index].quantity++;
      notifyListeners();
    }
  }

  /// Decrement quantity
  void decrementQuantity(String id) {
    final index = _items.indexWhere((item) => item.id == id);
    if (index >= 0) {
      if (_items[index].quantity > 1) {
        _items[index].quantity--;
      } else {
        _items.removeAt(index);
      }
      notifyListeners();
    }
  }

  /// Hapus item dari keranjang
  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  /// Kosongkan keranjang
  void clear() {
    _items.clear();
    notifyListeners();
  }

  /// Cek apakah item ada di keranjang
  bool containsItem(String id) {
    return _items.any((item) => item.id == id);
  }

  /// Dapatkan quantity item
  int getQuantity(String id) {
    final item = _items.firstWhere(
      (item) => item.id == id,
      orElse: () => CartItem(id: '', name: '', subtitle: '', price: 0, imageUrl: ''),
    );
    return item.quantity;
  }
}

// Global cart instance
final cart = CartProvider();
