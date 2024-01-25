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
        // ignore: deprecated_member_use
        useMaterial3: false,
        textTheme: bodyFontTheme(theme.textTheme),
        scaffoldBackgroundColor: Colors.white,
        primaryColor: darkPrimaryColor,
        tabBarTheme: const TabBarTheme(indicator: BoxDecoration()),
        navigationBarTheme: const NavigationBarThemeData(
          backgroundColor: Colors.white,
          elevation: 10,
          indicatorColor: darkPrimaryColor,
          labelTextStyle: MaterialStatePropertyAll(TextStyle(fontSize: 9)),
          iconTheme:
              MaterialStatePropertyAll(IconThemeData(color: Colors.black)),
        ),
        cardTheme: CardTheme(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: Colors.white,
        ),
        colorScheme: theme.colorScheme.copyWith(
          primary: darkPrimaryColor,
          secondary: secondary,
        ),
      ),
    );
  }
}
