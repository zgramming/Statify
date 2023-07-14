import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../injection.dart';
import '../../router.dart';
import '../../utils/colors.dart';

class SplashPage extends ConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(applicationConfigNotifier.select((value) => value.item),
        (previous, config) async {
      config.when(
        data: (data) async {
          if (data.isIntroductionDone) {
            context.goNamed(routeLogin);
          } else {
            context.goNamed(routeIntroduction);
          }
        },
        error: (error, stackTrace) => log(error.toString()),
        loading: () => log("Loading"),
      );
    });

    return const Scaffold(
      backgroundColor: darkPrimaryColor,
      body: Center(
        child: CircularProgressIndicator(color: Colors.white),
      ),
    );
  }
}
