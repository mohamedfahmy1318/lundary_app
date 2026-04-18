import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:laundry/core/constants/app_colors.dart';
import 'package:laundry/core/widgets/app_bar_factory.dart';

enum PaymentWebViewResult { success, failed, cancelled, unknown }

class PaymentWebViewPage extends StatefulWidget {
  final String paymentUrl;
  final String title;

  const PaymentWebViewPage({
    super.key,
    required this.paymentUrl,
    this.title = 'Secure Payment',
  });

  @override
  State<PaymentWebViewPage> createState() => _PaymentWebViewPageState();
}

class _PaymentWebViewPageState extends State<PaymentWebViewPage> {
  late final WebViewController _controller;
  bool _loading = true;
  bool _isHandlingBackendCallback = false;

  @override
  void initState() {
    super.initState();
    _controller =
        WebViewController()
          ..setOnConsoleMessage(_onConsoleMessage)
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageFinished: (_) {
                if (mounted) {
                  setState(() => _loading = false);
                }
              },
              onHttpError: _onHttpError,
              onNavigationRequest: (request) async {
                if (request.url.contains('/payment/callback')) {
                  if (_isHandlingBackendCallback) {
                    return NavigationDecision.prevent;
                  }

                  _isHandlingBackendCallback = true;

                  try {
                    await Dio().get(
                      request.url,
                      options: Options(
                        validateStatus: (_) => true,
                        responseType: ResponseType.plain,
                        followRedirects: true,
                      ),
                    );
                  } catch (error, stackTrace) {
                    debugPrint(
                      'Background callback GET failed for ${request.url}: $error',
                    );
                    debugPrint('$stackTrace');
                  }

                  if (mounted) {
                    _finishWith(PaymentWebViewResult.success);
                  }

                  return NavigationDecision.prevent;
                }

                final result = _resolveResultFromUrl(request.url);
                if (result != null) {
                  _finishWith(result);
                  return NavigationDecision.prevent;
                }
                return NavigationDecision.navigate;
              },
              onWebResourceError: (error) {
                if (mounted) {
                  setState(() => _loading = false);
                }

                final description = error.description.toLowerCase();
                if (description.contains('http error') ||
                    description.contains('request failed') ||
                    description.contains('status code 4') ||
                    description.contains('status code 5')) {
                  _finishWith(PaymentWebViewResult.failed);
                }
              },
            ),
          )
          ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  void _onHttpError(HttpResponseError error) {
    final url = error.request?.uri.toString().toLowerCase() ?? '';
    final isGatewayUrl = url.contains('ngenius-payments.com');
    if (isGatewayUrl && error.response?.statusCode != null) {
      final statusCode = error.response!.statusCode;
      if (statusCode >= 400) {
        _finishWith(PaymentWebViewResult.failed);
      }
    }
  }

  void _onConsoleMessage(JavaScriptConsoleMessage message) {
    final lowerMessage = message.message.toLowerCase();
    final isGatewaySource =
        lowerMessage.contains('ngenius-payments.com') ||
        lowerMessage.contains('paypage.sandbox.ngenius-payments.com');
    final isHttpFailure =
        lowerMessage.contains('request failed with status code 400') ||
        lowerMessage.contains('request failed with status code 401') ||
        lowerMessage.contains('request failed with status code 403') ||
        lowerMessage.contains('request failed with status code 404') ||
        lowerMessage.contains('request failed with status code 422') ||
        lowerMessage.contains('request failed with status code 500');

    if (isHttpFailure && (isGatewaySource || lowerMessage.contains('axios'))) {
      _finishWith(PaymentWebViewResult.failed);
    }
  }

  PaymentWebViewResult? _resolveResultFromUrl(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) {
      return null;
    }

    final normalizedUrl = url.toLowerCase();
    final scheme = uri.scheme.toLowerCase();
    final path = uri.path.toLowerCase();
    final host = uri.host.toLowerCase();
    final status = uri.queryParameters['status']?.toLowerCase().trim();

    final isAppDeepLink = scheme == 'laundryapp';

    if (isAppDeepLink || normalizedUrl.contains('/payment/')) {
      if (_looksSuccess(path, host, status, normalizedUrl)) {
        return PaymentWebViewResult.success;
      }
      if (_looksFailure(path, host, status, normalizedUrl)) {
        return PaymentWebViewResult.failed;
      }
      return PaymentWebViewResult.unknown;
    }

    return null;
  }

  bool _looksSuccess(
    String path,
    String host,
    String? status,
    String normalizedUrl,
  ) {
    if (status == 'success' || status == 'paid' || status == 'completed') {
      return true;
    }

    final merged = '$host$path';
    return merged.contains('success') ||
        merged.contains('paid') ||
        normalizedUrl.contains('payment/success');
  }

  bool _looksFailure(
    String path,
    String host,
    String? status,
    String normalizedUrl,
  ) {
    if (status == 'failed' || status == 'failure' || status == 'cancelled') {
      return true;
    }

    final merged = '$host$path';
    return merged.contains('fail') ||
        merged.contains('cancel') ||
        normalizedUrl.contains('payment/failed');
  }

  void _finishWith(PaymentWebViewResult result) {
    if (!mounted) {
      return;
    }
    Navigator.of(context).pop(result);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) {
          _finishWith(PaymentWebViewResult.cancelled);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.cardBackground,
        appBar: AppBarFactory.build(
          context,
          title: widget.title,
          backgroundColor: AppColors.cardBackground,
          onBack: () => _finishWith(PaymentWebViewResult.cancelled),
        ),
        body: Stack(
          children: [
            WebViewWidget(controller: _controller),
            if (_loading)
              const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
          ],
        ),
      ),
    );
  }
}
