import 'package:flutter/material.dart';

import 'router.dart';
import 'utils/colors.dart';
import 'utils/fonts.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MaterialApp.router(
      routerConfig: routerConfig,
      debugShowCheckedModeBanner: false,
      title: 'Statify',
      theme: theme.copyWith(
        textTheme: bodyFontTheme(theme.textTheme),
        scaffoldBackgroundColor: Colors.white,
        primaryColor: darkPrimaryColor,
        tabBarTheme: const TabBarTheme(indicator: BoxDecoration()),
        navigationBarTheme: const NavigationBarThemeData(
          backgroundColor: Colors.white,
          elevation: 10,
          indicatorColor: darkPrimaryColor,
          iconTheme:
              MaterialStatePropertyAll(IconThemeData(color: Colors.black)),
        ),
        colorScheme: theme.colorScheme.copyWith(
          primary: darkPrimaryColor,
          secondary: secondary,
        ),
      ),
    );
  }
}
