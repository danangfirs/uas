import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/// API Service untuk koneksi ke backend Laravel
class ApiService {
  // Ganti dengan URL backend kamu
  // Local: http://10.0.2.2:8000/api (Android Emulator)
  // Local: http://localhost:8000/api (iOS Simulator / Web)
  // Production: https://your-railway-app.railway.app/api
  static const String baseUrl = 'https://ombes.up.railway.app/api';
  
  static String? _authToken;
  
  // ==================== AUTH ====================
  
  /// Get stored auth token
  static Future<String?> getToken() async {
    if (_authToken != null) return _authToken;
    final prefs = await SharedPreferences.getInstance();
    _authToken = prefs.getString('auth_token');
    return _authToken;
  }
  
  /// Save auth token
  static Future<void> saveToken(String token) async {
    _authToken = token;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }
  
  /// Clear auth token (logout)
  static Future<void> clearToken() async {
    _authToken = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }
  
  /// Get headers with auth token
  static Future<Map<String, String>> _getHeaders({bool withAuth = true}) async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    
    if (withAuth) {
      final token = await getToken();
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }
    }
    
    return headers;
  }
  
  // ==================== AUTH ENDPOINTS ====================
  
  /// Register new user
  static Future<ApiResponse> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    String? phone,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/register'),
        headers: await _getHeaders(withAuth: false),
        body: jsonEncode({
          'name': name,
          'email': email,
          'phone': phone,
          'password': password,
          'password_confirmation': passwordConfirmation,
        }),
      );
      
      final data = jsonDecode(response.body);
      
      if (response.statusCode == 201 && data['success'] == true) {
        // Save token
        await saveToken(data['data']['token']);
        return ApiResponse.success(data);
      }
      
      return ApiResponse.error(data['message'] ?? 'Registration failed');
    } catch (e) {
      return ApiResponse.error('Network error: $e');
    }
  }
  
  /// Login user
  static Future<ApiResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: await _getHeaders(withAuth: false),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );
      
      final data = jsonDecode(response.body);
      
      if (response.statusCode == 200 && data['success'] == true) {
        // Save token
        await saveToken(data['data']['token']);
        return ApiResponse.success(data);
      }
      
      return ApiResponse.error(data['message'] ?? 'Login failed');
    } catch (e) {
      return ApiResponse.error('Network error: $e');
    }
  }
  
  /// Logout user
  static Future<ApiResponse> logout() async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/logout'),
        headers: await _getHeaders(),
      );
      
      await clearToken();
      
      if (response.statusCode == 200) {
        return ApiResponse.success({'message': 'Logout successful'});
      }
      
      return ApiResponse.success({'message': 'Logged out'});
    } catch (e) {
      await clearToken();
      return ApiResponse.success({'message': 'Logged out'});
    }
  }
  
  /// Get current user
  static Future<ApiResponse> getMe() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/auth/me'),
        headers: await _getHeaders(),
      );
      
      final data = jsonDecode(response.body);
      
      if (response.statusCode == 200 && data['success'] == true) {
        return ApiResponse.success(data);
      }
      
      return ApiResponse.error(data['message'] ?? 'Failed to get user');
    } catch (e) {
      return ApiResponse.error('Network error: $e');
    }
  }
  
  // ==================== PRODUCTS ====================
  
  /// Get all products
  static Future<ApiResponse> getProducts({int? categoryId}) async {
    try {
      String url = '$baseUrl/products';
      if (categoryId != null) {
        url += '?category_id=$categoryId';
      }
      
      final response = await http.get(
        Uri.parse(url),
        headers: await _getHeaders(withAuth: false),
      );
      
      final data = jsonDecode(response.body);
      
      if (response.statusCode == 200) {
        return ApiResponse.success(data);
      }
      
      return ApiResponse.error('Failed to load products');
    } catch (e) {
      return ApiResponse.error('Network error: $e');
    }
  }
  
  /// Get featured products
  static Future<ApiResponse> getFeaturedProducts() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/products/featured'),
        headers: await _getHeaders(withAuth: false),
      );
      
      final data = jsonDecode(response.body);
      
      if (response.statusCode == 200) {
        return ApiResponse.success(data);
      }
      
      return ApiResponse.error('Failed to load featured products');
    } catch (e) {
      return ApiResponse.error('Network error: $e');
    }
  }
  
  /// Get categories
  static Future<ApiResponse> getCategories() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/categories'),
        headers: await _getHeaders(withAuth: false),
      );
      
      final data = jsonDecode(response.body);
      
      if (response.statusCode == 200) {
        return ApiResponse.success(data);
      }
      
      return ApiResponse.error('Failed to load categories');
    } catch (e) {
      return ApiResponse.error('Network error: $e');
    }
  }
  
  // ==================== CART ====================
  
  /// Get cart
  static Future<ApiResponse> getCart() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/cart'),
        headers: await _getHeaders(),
      );
      
      final data = jsonDecode(response.body);
      
      if (response.statusCode == 200) {
        return ApiResponse.success(data);
      }
      
      return ApiResponse.error('Failed to load cart');
    } catch (e) {
      return ApiResponse.error('Network error: $e');
    }
  }
  
  /// Add item to cart
  static Future<ApiResponse> addToCart({
    required int productId,
    required int quantity,
    String? size,
    List<String>? extras,
    String? notes,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/cart/items'),
        headers: await _getHeaders(),
        body: jsonEncode({
          'product_id': productId,
          'quantity': quantity,
          'size': size,
          'extras': extras,
          'notes': notes,
        }),
      );
      
      final data = jsonDecode(response.body);
      
      if (response.statusCode == 201 && data['success'] == true) {
        return ApiResponse.success(data);
      }
      
      return ApiResponse.error(data['message'] ?? 'Failed to add to cart');
    } catch (e) {
      return ApiResponse.error('Network error: $e');
    }
  }
  
  /// Clear cart
  static Future<ApiResponse> clearCart() async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/cart/clear'),
        headers: await _getHeaders(),
      );
      
      if (response.statusCode == 200) {
        return ApiResponse.success({'message': 'Cart cleared'});
      }
      
      return ApiResponse.error('Failed to clear cart');
    } catch (e) {
      return ApiResponse.error('Network error: $e');
    }
  }
  
  // ==================== ORDERS ====================
  
  /// Create order and get Midtrans Snap Token
  static Future<ApiResponse> createOrder({
    required String orderType, // 'pickup' or 'delivery'
    int? storeId,
    String? deliveryAddress,
    String? notes,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/orders'),
        headers: await _getHeaders(),
        body: jsonEncode({
          'order_type': orderType,
          'store_id': storeId,
          'delivery_address': deliveryAddress,
          'notes': notes,
        }),
      );
      
      final data = jsonDecode(response.body);
      
      if (response.statusCode == 201 && data['success'] == true) {
        return ApiResponse.success(data);
      }
      
      return ApiResponse.error(data['message'] ?? 'Failed to create order');
    } catch (e) {
      return ApiResponse.error('Network error: $e');
    }
  }
  
  /// Get user's orders
  static Future<ApiResponse> getOrders() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/orders'),
        headers: await _getHeaders(),
      );
      
      final data = jsonDecode(response.body);
      
      if (response.statusCode == 200) {
        return ApiResponse.success(data);
      }
      
      return ApiResponse.error('Failed to load orders');
    } catch (e) {
      return ApiResponse.error('Network error: $e');
    }
  }
  
  /// Get order detail
  static Future<ApiResponse> getOrderDetail(String orderId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/orders/$orderId'),
        headers: await _getHeaders(),
      );
      
      final data = jsonDecode(response.body);
      
      if (response.statusCode == 200) {
        return ApiResponse.success(data);
      }
      
      return ApiResponse.error('Failed to load order');
    } catch (e) {
      return ApiResponse.error('Network error: $e');
    }
  }
  
  /// Check order payment status
  static Future<ApiResponse> checkOrderStatus(String orderId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/orders/$orderId/status'),
        headers: await _getHeaders(),
      );
      
      final data = jsonDecode(response.body);
      
      if (response.statusCode == 200) {
        return ApiResponse.success(data);
      }
      
      return ApiResponse.error('Failed to check status');
    } catch (e) {
      return ApiResponse.error('Network error: $e');
    }
  }
  
  // ==================== STORES ====================
  
  /// Get all stores
  static Future<ApiResponse> getStores() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/stores'),
        headers: await _getHeaders(withAuth: false),
      );
      
      final data = jsonDecode(response.body);
      
      if (response.statusCode == 200) {
        return ApiResponse.success(data);
      }
      
      return ApiResponse.error('Failed to load stores');
    } catch (e) {
      return ApiResponse.error('Network error: $e');
    }
  }
  
  // ==================== NOTIFICATIONS ====================
  
  /// Get notifications
  static Future<ApiResponse> getNotifications() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/notifications'),
        headers: await _getHeaders(),
      );
      
      final data = jsonDecode(response.body);
      
      if (response.statusCode == 200) {
        return ApiResponse.success(data);
      }
      
      return ApiResponse.error('Failed to load notifications');
    } catch (e) {
      return ApiResponse.error('Network error: $e');
    }
  }
}

/// API Response wrapper
class ApiResponse {
  final bool success;
  final dynamic data;
  final String? error;
  
  ApiResponse._({
    required this.success,
    this.data,
    this.error,
  });
  
  factory ApiResponse.success(dynamic data) {
    return ApiResponse._(success: true, data: data);
  }
  
  factory ApiResponse.error(String message) {
    return ApiResponse._(success: false, error: message);
  }
}
