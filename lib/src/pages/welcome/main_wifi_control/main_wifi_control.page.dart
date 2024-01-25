import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../injection.dart';
import '../../../utils/fonts.dart';
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

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.black)
      ..setNavigationDelegate(navigationDelegate);
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
    // Listen wifi control state here
    ref.listen(
      wifiControlNotifier.select((value) => value.item),
      (previous, next) {
        if (next != null) {
          _controller.loadRequest(Uri.parse(next.url));
        } else {
          const defaultURL = "http://192.168.88.100";
          _controller.loadRequest(Uri.parse(defaultURL));
        }
      },
    );

    final wifiControl =
        ref.watch(wifiControlNotifier.select((value) => value.item));
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (wifiControl == null) ...[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Please set wifi control first in setting > wifi control before using this feature",
                textAlign: TextAlign.center,
                style: bodyFont.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
          ] else ...[
            Expanded(
              child: WebViewWidget(
                controller: _controller,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
