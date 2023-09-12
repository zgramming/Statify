import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../router.dart';
import '../../utils/colors.dart';
import '../../view_model/custom_notifier/initialize_application.notifier.dart';

class SplashPage extends ConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      initializeApplicationNotifier,
      (previous, next) {
        next.when(
          data: (data) {
            if (data.isAlreadyIntroduction) {
              if (data.user != null) {
                context.goNamed(routeWelcome);
              } else {
                context.goNamed(routeLogin);
              }
            } else {
              context.goNamed(routeIntroduction);
            }
          },
          error: (error, stackTrace) {
            log("Error initialize application: $error");
          },
          loading: () {
            log("Loading initialize application");
          },
        );
      },
    );

    final initAppAsync =
        ref.watch(initializeApplicationNotifier).unwrapPrevious();

    return Scaffold(
      backgroundColor: darkPrimaryColor,
      body: Builder(builder: (context) {
        return initAppAsync.when(
          data: (data) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.white));
          },
          error: (error, stackTrace) => Center(
            child: Text(
              error.toString(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(color: Colors.white),
          ),
        );
      }),
    );
  }
}
