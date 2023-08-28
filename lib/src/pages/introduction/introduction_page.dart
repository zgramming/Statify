import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../injection.dart';
import '../../router.dart';

class IntroductionPage extends ConsumerWidget {
  const IntroductionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IntroductionScreen(
      pages: [
        // Convert text to english
        PageViewModel(
          title: 'Minimalist design',
          body:
              'With an attractive design, this application is comfortable to use.',
          image: Image.asset(
            'assets/image/intro/1.intro.png',
          ),
          decoration: const PageDecoration(
            bodyTextStyle: TextStyle(
              fontSize: 16,
            ),
            titleTextStyle: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        PageViewModel(
          title: 'Tracking Activity',
          body: 'With this application, you can track user activity.',
          image: Center(
            child: Image.asset(
              'assets/image/intro/2.intro.png',
            ),
          ),
        ),
        PageViewModel(
          title: 'Statistics',
          body:
              'With this application, you can view statistics from user activity.',
          image: Center(
            child: Image.asset(
              'assets/image/intro/3.intro.png',
            ),
          ),
        ),
        PageViewModel(
          title: 'Done',
          body: 'Enjoy using this application',
          image: Center(
            child: Image.asset(
              'assets/image/intro/4.intro.png',
            ),
          ),
        ),
      ],
      back: const Icon(Icons.arrow_back),
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      onDone: () async {
        final notifier = ref.read(applicationConfigNotifier.notifier);
        await notifier.saveIntroduction(true);
        if (context.mounted) {
          context.goNamed(routeLogin);
        }
      },
      onChange: (value) {},
      onSkip: () {},
    );
  }
}
