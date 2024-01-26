import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../injection.dart';
import '../../../utils/functions.dart';

class MainWifiControlPage extends ConsumerStatefulWidget {
  const MainWifiControlPage({super.key});

  @override
  ConsumerState<MainWifiControlPage> createState() =>
      _MainWifiControlPageState();
}

class _MainWifiControlPageState extends ConsumerState<MainWifiControlPage> {
  WebViewController _controller = WebViewController();

  void init() async {
    final navigationDelegate = NavigationDelegate(
      onProgress: (progress) {},
      onPageStarted: (url) {},
      onPageFinished: (url) {},
      onWebResourceError: (error) {
        log("Error: ${error.description} ${error.errorCode} ${error.errorType} ${error.url}");
        showSnackbar(
          context: context,
          message: error.description,
        );
      },
      onNavigationRequest: (request) {
        return NavigationDecision.navigate;
      },
    );

    final defaultUrl = Uri.parse("http://192.168.88.100");
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.black)
      ..setNavigationDelegate(navigationDelegate)
      ..loadRequest(defaultUrl);
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      wifiControlNotifier.select((value) => value.item?.url),
      (previous, urlAddress) {
        log("trigger wifiControlNotifier");
        if (urlAddress != null) {
          _controller.loadRequest(Uri.parse(urlAddress));
        }
      },
    );

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: WebViewWidget(
              controller: _controller,
            ),
          ),
        ],
      ),
    );
  }
}
