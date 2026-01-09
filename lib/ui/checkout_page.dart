import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../styles/text_styles.dart';
import '../services/api_service.dart';
import '../providers/cart_provider.dart';
import 'payment_webview_page.dart';
import 'payment_success_page.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  static const String routeName = '/checkout';

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  bool _isLoading = false;
  String _orderType = 'pickup'; // 'pickup' or 'delivery'
  int? _selectedStoreId;
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  // Sample stores
  final List<Map<String, dynamic>> _stores = [
    {'id': 1, 'name': 'Ombe Coffee - Jakarta Pusat', 'address': 'Jl. Thamrin No. 123'},
    {'id': 2, 'name': 'Ombe Coffee - Bandung', 'address': 'Jl. Braga No. 45'},
    {'id': 3, 'name': 'Ombe Coffee - Surabaya', 'address': 'Jl. Darmo No. 78'},
  ];

  double get _subtotal => cart.subtotal;
  double get _tax => cart.tax;
  double get _total => cart.total;

  @override
  void dispose() {
    _addressController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _processCheckout() async {
    // Validate
    if (_orderType == 'pickup' && _selectedStoreId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih lokasi toko untuk pickup')),
      );
      return;
    }

    if (_orderType == 'delivery' && _addressController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Masukkan alamat pengiriman')),
      );
      return;
    }

    if (cart.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Keranjang kosong')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Step 1: Clear existing backend cart
      await ApiService.clearCart();

      // Step 2: Sync local cart items to backend
      for (final item in cart.items) {
        // Extract product ID from local cart item ID (e.g., 'prod_1' -> 1)
        final productIdStr = item.id.replaceAll('prod_', '');
        final productId = int.tryParse(productIdStr) ?? 1;

        await ApiService.addToCart(
          productId: productId,
          quantity: item.quantity,
        );
      }

      // Step 3: Create order
      final response = await ApiService.createOrder(
        orderType: _orderType,
        storeId: _orderType == 'pickup' ? _selectedStoreId : null,
        deliveryAddress: _orderType == 'delivery' ? _addressController.text : null,
        notes: _notesController.text.isNotEmpty ? _notesController.text : null,
      );

      setState(() => _isLoading = false);

      if (response.success) {
        final snapToken = response.data['data']['snap_token'];
        final orderId = response.data['data']['order']['order_id'];

        // Clear local cart after successful order
        cart.clear();

        if (!mounted) return;

        // If we got a snap token, use Midtrans
        if (snapToken != null && snapToken.toString().isNotEmpty) {
          // FORCE USE VTWEB URL for redirection (Correct Link)
          final snapUrl = 'https://app.sandbox.midtrans.com/snap/v2/vtweb/$snapToken';
          
          // Check platform using multiple checks for safety
          // kIsWeb is standard, but Platform checks can throw on web 
          bool isWeb = true; 
          try {
             // Basic check if dart:io Platform is available (it's not on web)
             // But to be safe on flutter web we just default to true if we catch error
             // Actually, simplest way:
             if (Theme.of(context).platform == TargetPlatform.android || 
                 Theme.of(context).platform == TargetPlatform.iOS) {
               isWeb = false;
             }
          } catch (e) {
             isWeb = true;
          }

          if (isWeb) {
             // Web / Desktop -> Launch in Browser
             if (await canLaunchUrl(Uri.parse(snapUrl))) {
               await launchUrl(Uri.parse(snapUrl), mode: LaunchMode.externalApplication);
               
               // Show dialog to confirm manually after they return
               if (!mounted) return;
               showDialog(
                 context: context,
                 barrierDismissible: false,
                 builder: (context) => AlertDialog(
                   title: const Text('Menunggu Pembayaran'),
                   content: const Text('Selesaikan pembayaran di browser Anda. Setelah selesai, klik tombol di bawah.'),
                   actions: [
                     TextButton(
                       onPressed: () {
                         Navigator.pop(context); // Close dialog
                         Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PaymentSuccessPage(
                                orderId: orderId,
                                isPending: true, // Let them check status
                              ),
                            ),
                          );
                       },
                       child: const Text('Saya Sudah Bayar'),
                     ),
                   ],
                 ),
               );
             } else {
               ScaffoldMessenger.of(context).showSnackBar(
                 const SnackBar(content: Text('Tidak dapat membuka link pembayaran')),
               );
             }
          } else {
             // Mobile App -> Use WebView
             Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PaymentWebViewPage(
                  snapToken: snapToken,
                  orderId: orderId,
                ),
              ),
            );
          }
        } else {
          // No snap token? Treats as "Bayar Tunai / Pay Later"
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('✅ Pesanan Dibuat! Silakan bayar di kasir.'),
              backgroundColor: Colors.green,
            ),
          );

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => PaymentSuccessPage(
                orderId: orderId,
                isPending: true, // Show as pending instructions
              ),
            ),
          );
        }
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.error ?? 'Gagal membuat pesanan')),
        );
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
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
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Checkout',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Type Selection
            const Text(
              'Tipe Pesanan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _OrderTypeCard(
                    title: 'Pickup',
                    icon: Icons.store,
                    isSelected: _orderType == 'pickup',
                    onTap: () => setState(() => _orderType = 'pickup'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _OrderTypeCard(
                    title: 'Delivery',
                    icon: Icons.delivery_dining,
                    isSelected: _orderType == 'delivery',
                    onTap: () => setState(() => _orderType = 'delivery'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Pickup: Store Selection
            if (_orderType == 'pickup') ...[
              const Text(
                'Pilih Lokasi Toko',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              ...(_stores.map((store) => _StoreCard(
                    name: store['name'],
                    address: store['address'],
                    isSelected: _selectedStoreId == store['id'],
                    onTap: () => setState(() => _selectedStoreId = store['id']),
                  ))),
            ],

            // Delivery: Address Input
            if (_orderType == 'delivery') ...[
              const Text(
                'Alamat Pengiriman',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _addressController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Masukkan alamat lengkap...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: lightGray),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: lightGray),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: primaryGreen, width: 2),
                  ),
                ),
              ),
            ],

            const SizedBox(height: 24),

            // Notes
            const Text(
              'Catatan (Opsional)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _notesController,
              maxLines: 2,
              decoration: InputDecoration(
                hintText: 'Contoh: Extra gula, tanpa es...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: lightGray),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: lightGray),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: primaryGreen, width: 2),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Order Summary
            const Text(
              'Ringkasan Pesanan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: lightGray),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  ...cart.items.map((item) => _OrderItemTile(item: item)),
                  const Divider(height: 1),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _SummaryRow('Subtotal', _subtotal),
                        const SizedBox(height: 8),
                        _SummaryRow('Pajak (11%)', _tax),
                        const Divider(height: 20),
                        _SummaryRow('Total', _total, isBold: true),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            height: 60,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _processCheckout,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryGreen,
                foregroundColor: Colors.white,
                shape: const StadiumBorder(),
                disabledBackgroundColor: Colors.grey[300],
              ),
              child: _isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      'BAYAR - Rp ${_formatCurrency(_total)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
            ),
          ),
        ),
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

class _OrderTypeCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _OrderTypeCard({
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? primaryGreen.withOpacity(0.1) : Colors.white,
          border: Border.all(
            color: isSelected ? primaryGreen : lightGray,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32,
              color: isSelected ? primaryGreen : subtitleColor,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: isSelected ? primaryGreen : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StoreCard extends StatelessWidget {
  final String name;
  final String address;
  final bool isSelected;
  final VoidCallback onTap;

  const _StoreCard({
    required this.name,
    required this.address,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? primaryGreen.withOpacity(0.1) : Colors.white,
          border: Border.all(
            color: isSelected ? primaryGreen : lightGray,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? primaryGreen : subtitleColor,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    address,
                    style: const TextStyle(color: subtitleColor, fontSize: 13),
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

class _OrderItemTile extends StatelessWidget {
  final CartItem item;

  const _OrderItemTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              item.imageUrl,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 50,
                height: 50,
                color: Colors.grey[200],
                child: const Icon(Icons.coffee, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${item.quantity}x • ${item.subtitle}',
                  style: const TextStyle(color: subtitleColor, fontSize: 13),
                ),
              ],
            ),
          ),
          Text(
            'Rp ${item.totalPrice.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final double value;
  final bool isBold;

  const _SummaryRow(this.label, this.value, {this.isBold = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.w700 : FontWeight.normal,
            fontSize: isBold ? 16 : 14,
          ),
        ),
        Text(
          'Rp ${value.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: isBold ? 16 : 14,
            color: isBold ? primaryGreen : Colors.black87,
          ),
        ),
      ],
    );
  }
}
