import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/routes/app_route_args.dart';

class ExternalWebViewScreen extends StatefulWidget {
  final Object? arguments;
  const ExternalWebViewScreen({super.key, this.arguments});

  @override
  State<ExternalWebViewScreen> createState() => _ExternalWebViewScreenState();
}

class _ExternalWebViewScreenState extends State<ExternalWebViewScreen> {
  late ExternalBookViewScreenArgs _screenArgs;
  late final WebViewController _controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _screenArgs = widget.arguments as ExternalBookViewScreenArgs;
    _controller = WebViewController() // Initialize the WebViewController here
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onUrlChange: (UrlChange urlChange) {},
          onProgress: (int progress) {
            if (progress == 100) {
              print(progress);
              if (mounted) {
                setState(() {
                  isLoading = false;
                });
              }
            }
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(Uri.parse(_screenArgs.url));
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: _screenArgs.title,
      child: isLoading == false
          ? WebViewWidget(controller: _controller)
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
