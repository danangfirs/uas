import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../styles/text_styles.dart';
import 'payment_success_page.dart';
import 'payment_failed_page.dart';

/// Halaman WebView untuk menampilkan Midtrans Snap payment
class PaymentWebViewPage extends StatefulWidget {
  final String snapToken;
  final String orderId;

  const PaymentWebViewPage({
    super.key,
    required this.snapToken,
    required this.orderId,
  });

  @override
  State<PaymentWebViewPage> createState() => _PaymentWebViewPageState();
}

class _PaymentWebViewPageState extends State<PaymentWebViewPage> {
  late final WebViewController _controller;
  bool _isLoading = true;
  double _loadingProgress = 0;

  // Midtrans Snap URL
  // Sandbox: https://app.sandbox.midtrans.com/snap/v2/vtweb/
  // Production: https://app.midtrans.com/snap/v2/vtweb/
  static const String _snapBaseUrl = 'https://app.sandbox.midtrans.com/snap/v2/vtweb/';

  @override
  void initState() {
    super.initState();
    _initWebView();
  }

  void _initWebView() {
    final snapUrl = '$_snapBaseUrl${widget.snapToken}';

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            setState(() {
              _loadingProgress = progress / 100;
              if (progress == 100) {
                _isLoading = false;
              }
            });
          },
          onPageStarted: (String url) {
            setState(() => _isLoading = true);
          },
          onPageFinished: (String url) {
            setState(() => _isLoading = false);
            _handleUrlChange(url);
          },
          onNavigationRequest: (NavigationRequest request) {
            // Handle deep links or custom schemes
            final url = request.url;
            
            if (_isPaymentCallback(url)) {
              _handlePaymentCallback(url);
              return NavigationDecision.prevent;
            }
            
            return NavigationDecision.navigate;
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('WebView error: ${error.description}');
          },
        ),
      )
      ..loadRequest(Uri.parse(snapUrl));
  }

  bool _isPaymentCallback(String url) {
    // Check for common callback patterns
    return url.contains('transaction_status=') ||
           url.contains('status_code=') ||
           url.contains('/finish') ||
           url.contains('/error') ||
           url.contains('/pending');
  }

  void _handleUrlChange(String url) {
    debugPrint('URL changed: $url');
    
    // Check if URL contains payment result
    if (url.contains('transaction_status=')) {
      _handlePaymentCallback(url);
    }
  }

  void _handlePaymentCallback(String url) {
    final uri = Uri.parse(url);
    final status = uri.queryParameters['transaction_status'] ?? 
                   uri.queryParameters['status'];
    
    debugPrint('Payment status: $status');
    
    if (!mounted) return;
    
    // Navigate based on status
    if (status == 'capture' || status == 'settlement' || status == 'success') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentSuccessPage(orderId: widget.orderId),
        ),
      );
    } else if (status == 'pending') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentSuccessPage(
            orderId: widget.orderId,
            isPending: true,
          ),
        ),
      );
    } else if (status == 'deny' || status == 'cancel' || status == 'expire' || status == 'failure') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentFailedPage(
            orderId: widget.orderId,
            status: status ?? 'failed',
          ),
        ),
      );
    }
  }

  Future<bool> _onWillPop() async {
    // Show confirmation dialog
    final shouldPop = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Batalkan Pembayaran?'),
        content: const Text(
          'Apakah Anda yakin ingin membatalkan pembayaran? '
          'Pesanan Anda akan tetap tersimpan dan bisa dibayar nanti.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Tidak'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Ya, Batalkan'),
          ),
        ],
      ),
    );

    return shouldPop ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.close, color: Colors.black87),
            onPressed: () async {
              if (await _onWillPop()) {
                if (mounted) Navigator.pop(context);
              }
            },
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Pembayaran',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              Text(
                'Order: ${widget.orderId}',
                style: const TextStyle(
                  color: subtitleColor,
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh, color: Colors.black87),
              onPressed: () => _controller.reload(),
            ),
          ],
          bottom: _isLoading
              ? PreferredSize(
                  preferredSize: const Size.fromHeight(3),
                  child: LinearProgressIndicator(
                    value: _loadingProgress,
                    backgroundColor: Colors.grey[200],
                    valueColor: const AlwaysStoppedAnimation<Color>(primaryGreen),
                  ),
                )
              : null,
        ),
        body: Stack(
          children: [
            WebViewWidget(controller: _controller),
            if (_isLoading && _loadingProgress < 0.3)
              Container(
                color: Colors.white,
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(color: primaryGreen),
                      SizedBox(height: 16),
                      Text(
                        'Memuat halaman pembayaran...',
                        style: TextStyle(color: subtitleColor),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
