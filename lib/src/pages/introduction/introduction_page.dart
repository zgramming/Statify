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
        PageViewModel(
          title: 'Design Menarik',
          body:
              'Dengan design yang menarik, membuat aplikasi ini nyaman digunakan',
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
          title: 'Melacak Aktivitas',
          body:
              'Dengan aplikasi ini, kamu dapat melacak aktivitas yang user lakukan',
          image: Center(
            child: Image.asset(
              'assets/image/intro/2.intro.png',
            ),
          ),
        ),
        PageViewModel(
          title: 'Statistik',
          body:
              'Dengan aplikasi ini, kamu dapat melihat statistik dari aktivitas yang user lakukan',
          image: Center(
            child: Image.asset(
              'assets/image/intro/3.intro.png',
            ),
          ),
        ),
        PageViewModel(
          title: 'Selesai',
          body: 'Selamat menggunakan aplikasi ini',
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
          context.goNamed(routeHome);
        }
      },
      onChange: (value) {},
      onSkip: () {},
    );
  }
}
