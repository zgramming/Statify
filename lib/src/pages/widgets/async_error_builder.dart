import 'package:flutter/material.dart';

class AsyncErrorBuilder extends StatelessWidget {
  const AsyncErrorBuilder({
    super.key,
    required this.error,
    required this.onRetry,
  });

  final String error;
  final void Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(error.toString()),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text("Retry again"),
          ),
        ],
      ),
    );
  }
}
