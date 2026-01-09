import 'package:flutter/material.dart';
import '../styles/text_styles.dart';
import 'homepage.dart';
import 'cart_page.dart';

/// Halaman gagal ketika pembayaran gagal/expired/cancelled
class PaymentFailedPage extends StatelessWidget {
  final String orderId;
  final String status;

  const PaymentFailedPage({
    super.key,
    required this.orderId,
    required this.status,
  });

  static const String routeName = '/payment-failed';

  String get _title {
    switch (status) {
      case 'expire':
        return 'Pembayaran Kedaluwarsa';
      case 'cancel':
        return 'Pembayaran Dibatalkan';
      case 'deny':
        return 'Pembayaran Ditolak';
      default:
        return 'Pembayaran Gagal';
    }
  }

  String get _description {
    switch (status) {
      case 'expire':
        return 'Waktu pembayaran telah habis. Silakan buat pesanan baru untuk melanjutkan.';
      case 'cancel':
        return 'Pembayaran telah dibatalkan. Anda dapat mencoba lagi atau membuat pesanan baru.';
      case 'deny':
        return 'Pembayaran ditolak oleh sistem. Silakan coba metode pembayaran lain.';
      default:
        return 'Terjadi kesalahan saat memproses pembayaran. Silakan coba lagi.';
    }
  }

  IconData get _icon {
    switch (status) {
      case 'expire':
        return Icons.timer_off;
      case 'cancel':
        return Icons.cancel;
      default:
        return Icons.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _goToHome(context);
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                
                // Error Icon
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _icon,
                    size: 64,
                    color: Colors.red,
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Title
                Text(
                  _title,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 16),
                
                // Description
                Text(
                  _description,
                  style: const TextStyle(
                    fontSize: 16,
                    color: subtitleColor,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 24),
                
                // Order ID Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.red.withOpacity(0.2)),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Nomor Pesanan',
                        style: TextStyle(color: subtitleColor),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        orderId,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          status.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const Spacer(),
                
                // Buttons
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, CartPage.routeName);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryGreen,
                      foregroundColor: Colors.white,
                      shape: const StadiumBorder(),
                    ),
                    child: const Text(
                      'COBA LAGI',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                
                const SizedBox(height: 12),
                
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: OutlinedButton(
                    onPressed: () => _goToHome(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: subtitleColor,
                      side: const BorderSide(color: lightGray),
                      shape: const StadiumBorder(),
                    ),
                    child: const Text(
                      'KEMBALI KE BERANDA',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Help text
                TextButton.icon(
                  onPressed: () {
                    // TODO: Open help/support
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Hubungi customer support')),
                    );
                  },
                  icon: const Icon(Icons.help_outline, size: 18),
                  label: const Text('Butuh bantuan?'),
                  style: TextButton.styleFrom(foregroundColor: subtitleColor),
                ),
                
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _goToHome(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      HomePage.routeName,
      (route) => false,
    );
  }
}
