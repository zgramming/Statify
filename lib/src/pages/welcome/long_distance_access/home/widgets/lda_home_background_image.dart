import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../utils/constant.dart';

class _DefaultImage extends StatelessWidget {
  const _DefaultImage();

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      kURLLogoHitech,
      width: 100,
      height: 100,
      errorBuilder: (context, error, stackTrace) => const Center(
        child: Icon(
          Icons.error,
          size: 50.0,
          color: Colors.red,
        ),
      ),
    );
  }
}

class LDAHomeBackgroundImage extends ConsumerWidget {
  const LDAHomeBackgroundImage({
    super.key,
    required this.logo,
    required this.start,
  });
  final String? logo;
  final String? start;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isWorking = start == "1";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              gradient: LinearGradient(
                colors: [
                  if (isWorking) ...[
                    // White top and blue bottom
                    Colors.white,
                    Colors.blue.withOpacity(0.5),
                  ] else ...[
                    // White top and red bottom
                    Colors.white,
                    Colors.red.withOpacity(0.5),
                  ],
                ],
                begin: const Alignment(0, 0),
                end: const Alignment(0, 2),
              ),
            ),
            child: Builder(
              builder: (context) {
                return Image.network(
                  logo ?? "",
                  width: 100,
                  height: 100,
                  errorBuilder: (context, error, stackTrace) {
                    return const _DefaultImage();
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
