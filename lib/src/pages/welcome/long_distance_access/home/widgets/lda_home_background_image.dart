import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../injection.dart';
import '../../../../../utils/colors.dart';
import '../../../../../utils/constant.dart';
import '../../../../widgets/async_error_builder.dart';

class LDAHomeBackgroundImage extends ConsumerWidget {
  const LDAHomeBackgroundImage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logoAsync = ref.watch(logoNotifier).onGetFirstLogo;
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
                return logoAsync.when(
                  data: (data) {
                    if (data == null) {
                      return Image.asset(
                        kURLLogoHitech,
                        width: 100,
                        height: 100,
                      );
                    }

                    return Image.memory(
                      data.logo!,
                      fit: BoxFit.cover,
                      width: 100,
                      height: 100,
                    );
                  },
                  error: (error, stackTrace) => AsyncErrorBuilder(
                    error: error.toString(),
                    onRetry: () {
                      ref.invalidate(logoNotifier);
                    },
                  ),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
