import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/functions.dart';
import '../../view_model/custom_notifier/get_all_whatsapp_by_user.notifier.dart';

class DialogViewQRCode extends ConsumerStatefulWidget {
  const DialogViewQRCode({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);
  final String imageUrl;

  @override
  ConsumerState<DialogViewQRCode> createState() => _DialogViewQRCodeState();
}

class _DialogViewQRCodeState extends ConsumerState<DialogViewQRCode> {
  Timer? _timer;
  int _counter = 10;

  Future<void> onRefresh() async {
    ref.invalidate(getAllWhatsAppByUserFutureProvider);
    setState(() {
      _counter = 10;
    });
  }

  Future<void> init() async {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (!mounted) return;
      log("timer tick ${timer.tick}");
      _counter--;

// If counter is less than 0, invalidate the getAllWhatsAppByUserFutureProvider
      if (_counter < 0) {
        _counter = 10;
        ref.invalidate(getAllWhatsAppByUserFutureProvider);
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => init());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            children: [
              Icon(Icons.qr_code),
              SizedBox(width: 10),
              Text("QR Code"),
            ],
          ),
          IconButton(
            onPressed: onRefresh,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          AspectRatio(
            aspectRatio: 1.0,
            child: Image.network(
              widget.imageUrl,
              fit: BoxFit.cover,
              loadingBuilder: imageNetworkLoadingBuilder(),
              errorBuilder: (context, error, stackTrace) {
                return Center(
                  child: Text(
                    "Error loading image from network url ${error.toString()}",
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "This QR Code will be expired in $_counter seconds",
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Close"),
        )
      ],
    );
  }
}
