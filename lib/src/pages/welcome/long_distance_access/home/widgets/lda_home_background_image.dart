import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../utils/colors.dart';
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
  });
  final String? logo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: kGradientColor,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
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
