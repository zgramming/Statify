import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../injection.dart';
import '../../view_model/custom_notifier/get_all_machine.notifier.dart';
import '../../view_model/custom_notifier/request_permission_notifier.dart';
import '../widgets/async_error_builder.dart';
import 'home/home_page.dart';
import 'long_distance_access/long_distance_access_page.dart';
import 'setting/setting_page.dart';
import 'main_survey/main_survey.page.dart';
import 'whatsapp/main_whatsapp.page.dart';

class WelcomePage extends ConsumerStatefulWidget {
  const WelcomePage({super.key});

  @override
  createState() => _WelcomePageState();
}

class _WelcomePageState extends ConsumerState<WelcomePage> {
  int _selectedIndex = 0;

  final _destinations = <NavigationDestination>[
    NavigationDestination(
      icon: Icon(Icons.home_outlined, color: Colors.grey.withOpacity(.5)),
      selectedIcon: const Icon(Icons.home, color: Colors.white),
      label: "Home",
    ),
    NavigationDestination(
      icon: Icon(Icons.phone_outlined, color: Colors.grey.withOpacity(.5)),
      selectedIcon: const Icon(Icons.phone, color: Colors.white),
      label: "Whatsapp",
    ),
    NavigationDestination(
      icon: Icon(Icons.assignment_ind_outlined,
          color: Colors.grey.withOpacity(.5)),
      selectedIcon: const Icon(Icons.assignment_ind, color: Colors.white),
      label: "Survey",
    ),
    NavigationDestination(
      icon: Icon(
        Icons.accessibility_new_outlined,
        color: Colors.grey.withOpacity(.5),
      ),
      selectedIcon: const Icon(Icons.accessibility_new, color: Colors.white),
      label: "L.D.A",
    ),
    NavigationDestination(
      icon: Icon(
        Icons.settings_outlined,
        color: Colors.grey.withOpacity(.5),
      ),
      selectedIcon: const Icon(Icons.settings, color: Colors.white),
      label: "Setting",
    ),
  ];

  final _pages = [
    const HomePage(),
    const MainWhatsAppPage(),
    const MainSurveyPage(),
    const LongDistanceAccessPage(),
    const SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (_) {
        final permissionFuture = ref.watch(checkPermissionNotifier);
        return permissionFuture.when(
          data: (_) => IndexedStack(
            index: _selectedIndex,
            children: _pages,
          ),
          error: (error, stackTrace) => AsyncErrorBuilder(
            error: error.toString(),
            onRetry: () => ref.invalidate(checkPermissionNotifier),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
        );
      }),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        destinations: _destinations,
        onDestinationSelected: (value) {
          setState(() => _selectedIndex = value);
        },
      ),
    );
  }
}
