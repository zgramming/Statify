import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../injection.dart';
import '../../router.dart';
import '../../utils/colors.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  Future<void> init() async {
    final config = ref.read(applicationConfigNotifier.notifier);
    final auth = ref.read(authenticationNotifier.notifier);

    final configResult = await config.getApplicationConfig();
    final authResult = await auth.getUserLocalStorage();

    // Check if introduction is done
    // when it is done, check again if user is logged in
    // if user is logged in, go to home page
    // if user is not logged in, go to login page

    final isIntroductionDone = configResult.isIntroductionDone;
    final isUserLoggedIn = authResult != null;

    // Check if mounted
    if (!mounted) return;

    if (isIntroductionDone) {
      if (isUserLoggedIn) {
        context.goNamed(routeWelcome);
      } else {
        context.goNamed(routeLogin);
      }
    } else {
      context.goNamed(routeIntroduction);
    }
  }

  @override
  void initState() {
    super.initState();

    Future.microtask(() => init());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: darkPrimaryColor,
      body: Center(child: CircularProgressIndicator(color: Colors.white)),
    );
  }
}
