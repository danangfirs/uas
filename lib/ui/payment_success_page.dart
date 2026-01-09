import 'package:flutter/material.dart';
import '../styles/text_styles.dart';
import '../services/api_service.dart';
import 'homepage.dart';

/// Halaman sukses setelah pembayaran berhasil
/// Halaman sukses setelah pembayaran berhasil
class PaymentSuccessPage extends StatefulWidget {
  final String orderId;
  final bool isPending;

  const PaymentSuccessPage({
    super.key,
    required this.orderId,
    this.isPending = false,
  });

  static const String routeName = '/payment-success';

  @override
  State<PaymentSuccessPage> createState() => _PaymentSuccessPageState();
}

class _PaymentSuccessPageState extends State<PaymentSuccessPage> {
  late bool _isPending;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _isPending = widget.isPending;
    if (_isPending) {
       _checkStatus();
    }
  }

  Future<void> _checkStatus() async {
    setState(() => _isLoading = true);
    
    // Simulate slight delay for UX
    await Future.delayed(const Duration(seconds: 1));

    try {
      final response = await ApiService.checkOrderStatus(widget.orderId);
      if (!mounted) return;

      if (response.success) {
        final status = response.data['data']['payment_status'];
        final midtransStatus = response.data['data']['midtrans_status'];
        
        // If paid or settlement or capture
        if (status == 'paid' || 
            midtransStatus?['transaction_status'] == 'settlement' || 
            midtransStatus?['transaction_status'] == 'capture') {
          setState(() {
            _isPending = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
             const SnackBar(content: Text('✅ Pembayaran terkonfirmasi!'), backgroundColor: primaryGreen),
          );
        } else {
           ScaffoldMessenger.of(context).showSnackBar(
             const SnackBar(content: Text('Status masih pending. Coba beberapa saat lagi.')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
         ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(content: Text('Gagal cek status: $e')),
         );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
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
                
                // Success/Pending Icon
                if (_isLoading)
                   const CircularProgressIndicator(color: primaryGreen)
                else
                   Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: _isPending 
                          ? Colors.orange.withOpacity(0.1)
                          : primaryGreen.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _isPending ? Icons.schedule : Icons.check_circle,
                      size: 64,
                      color: _isPending ? Colors.orange : primaryGreen,
                    ),
                  ),
                
                const SizedBox(height: 32),
                
                // Title
                Text(
                  _isPending ? 'Menunggu Pembayaran' : 'Pembayaran Berhasil!',
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
                  _isPending
                      ? 'Silakan selesaikan pembayaran Anda sesuai instruksi yang diberikan.'
                      : 'Terima kasih! Pesanan Anda sedang diproses.',
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
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: lightGray),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Nomor Pesanan',
                        style: TextStyle(color: subtitleColor),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.orderId,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Status info
                if (!_isPending) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _StatusStep(
                        icon: Icons.payment,
                        label: 'Dibayar',
                        isActive: true,
                      ),
                      _StatusLine(isActive: true),
                      _StatusStep(
                        icon: Icons.pending,
                        label: 'Diproses',
                        isActive: false,
                      ),
                      _StatusLine(isActive: false),
                      _StatusStep(
                        icon: Icons.coffee,
                        label: 'Siap',
                        isActive: false,
                      ),
                    ],
                  ),
                ],

                // Refresh Button for Pending
                if (_isPending && !_isLoading) ...[
                    const SizedBox(height: 20),
                    TextButton.icon(
                      onPressed: _checkStatus,
                      icon: const Icon(Icons.refresh, color: primaryGreen),
                      label: const Text('Cek Status Pembayaran', style: TextStyle(color: primaryGreen, fontWeight: FontWeight.bold)),
                    ),
                ],
                
                const Spacer(),
                
                // Buttons
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () => _goToHome(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryGreen,
                      foregroundColor: Colors.white,
                      shape: const StadiumBorder(),
                    ),
                    child: const Text(
                      'KEMBALI KE BERANDA',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                
                const SizedBox(height: 12),
                
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: OutlinedButton(
                    onPressed: () {
                      // Navigate to order detail (or history)
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Lihat detail pesanan')),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: primaryGreen,
                      side: const BorderSide(color: primaryGreen),
                      shape: const StadiumBorder(),
                    ),
                    child: const Text(
                      'LIHAT PESANAN',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
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

class _StatusStep extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;

  const _StatusStep({
    required this.icon,
    required this.label,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isActive ? primaryGreen : Colors.grey[200],
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 20,
            color: isActive ? Colors.white : Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: isActive ? primaryGreen : subtitleColor,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

class _StatusLine extends StatelessWidget {
  final bool isActive;

  const _StatusLine({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 2,
      margin: const EdgeInsets.only(bottom: 20),
      color: isActive ? primaryGreen : Colors.grey[300],
    );
  }
}
