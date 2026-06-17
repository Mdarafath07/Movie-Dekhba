import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:go_router/go_router.dart';

// Conditionally import the web builder
import 'play_webview_stub.dart' if (dart.library.html) 'play_webview_web.dart' as web_view;

class PlayWebViewScreen extends StatefulWidget {
  final String url;

  const PlayWebViewScreen({super.key, required this.url});

  @override
  State<PlayWebViewScreen> createState() => _PlayWebViewScreenState();
}

class _PlayWebViewScreenState extends State<PlayWebViewScreen> {
  WebViewController? _controller;
  bool _isLoading = true;
  Widget? _webViewWidget;

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) {
      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setUserAgent(
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.36')
        ..setBackgroundColor(const Color(0x00000000))
        ..setNavigationDelegate(
          NavigationDelegate(
            onPageFinished: (String url) {
              if (mounted) {
                setState(() {
                  _isLoading = false;
                });
              }
            },
          ),
        )
        ..loadRequest(Uri.parse(widget.url));
    } else {
      _isLoading = false;
      _webViewWidget = web_view.buildWebView(widget.url);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Positioned.fill(
              child: _webViewWidget ?? const SizedBox.shrink(),
            ),

            // ── Back button ──────────────────────────────────────────
            Positioned(
              top: 8,
              left: 8,
              child: SafeArea(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () => context.pop(),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    // Native (Android / iOS)
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: Stack(
        children: [
          if (_controller != null) WebViewWidget(controller: _controller!),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(
                color: Color(0xFFE50914),
              ),
            ),
        ],
      ),
    );
  }
}
