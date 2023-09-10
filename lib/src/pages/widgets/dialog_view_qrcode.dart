import 'package:flutter/material.dart';

import '../../utils/functions.dart';

class DialogViewQRCode extends StatelessWidget {
  const DialogViewQRCode({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("QR Code"),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          AspectRatio(
            aspectRatio: 1.0,
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              loadingBuilder: imageNetworkLoadingBuilder(),
              errorBuilder: (context, error, stackTrace) {
                return Center(
                  child: Text(
                      "Error loading image from network url ${error.toString()}"),
                );
              },
            ),
          )
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
