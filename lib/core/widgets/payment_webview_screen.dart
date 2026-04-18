import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// A secure checkout screen for N-Genius payment pages.
///
/// Returns `true` to the previous screen when a callback URL is detected.
class PaymentWebViewScreen extends StatefulWidget {
  final String paymentUrl;

  const PaymentWebViewScreen({super.key, required this.paymentUrl});

  @override
  State<PaymentWebViewScreen> createState() => _PaymentWebViewScreenState();
}

class _PaymentWebViewScreenState extends State<PaymentWebViewScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    _controller =
        WebViewController()
          // N-Genius pages require JavaScript to render and process payment steps.
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setBackgroundColor(Colors.transparent)
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageStarted: (_) {
                if (!mounted) {
                  return;
                }
                setState(() => _isLoading = true);
              },
              onPageFinished: (_) {
                if (!mounted) {
                  return;
                }
                setState(() => _isLoading = false);
              },
              onWebResourceError: (_) {
                if (!mounted) {
                  return;
                }
                setState(() => _isLoading = false);
              },
              onNavigationRequest: (request) {
                // Intercept payment callback redirect and return success to caller.
                if (request.url.contains('/payment/callback')) {
                  Navigator.pop(context, true);
                  return NavigationDecision.prevent;
                }
                return NavigationDecision.navigate;
              },
            ),
          )
          ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Secure Checkout')),
      body: SafeArea(
        child: Stack(
          children: [
            WebViewWidget(controller: _controller),
            if (_isLoading) const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
