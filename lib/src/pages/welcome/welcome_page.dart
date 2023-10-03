import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/constant.dart';
import '../../view_model/custom_notifier/request_permission_notifier.dart';
import '../widgets/async_error_builder.dart';
import 'main_machine_group/main_machine_group.page.dart';
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
      icon: Image.asset(
        "$kURLImageAsset/tower_outline.png",
        width: 24,
        height: 24,
      ),
      selectedIcon: Image.asset(
        "$kURLImageAsset/tower.png",
        width: 24,
        height: 24,
      ),
      label: "Machine",
    ),
    NavigationDestination(
      icon: Image.asset(
        "$kURLImageAsset/wa_business_outline.png",
        width: 24,
        height: 24,
      ),
      selectedIcon: Image.asset(
        "$kURLImageAsset/wa_business.png",
        width: 24,
        height: 24,
      ),
      label: "Whatsapp",
    ),
    NavigationDestination(
      icon: Image.asset(
        "$kURLImageAsset/survey_outline.png",
        width: 24,
        height: 24,
      ),
      selectedIcon: Image.asset(
        "$kURLImageAsset/survey.png",
        width: 24,
        height: 24,
      ),
      label: "Survey",
    ),
    NavigationDestination(
      icon: Image.asset(
        "$kURLImageAsset/distance_outline.png",
        width: 24,
        height: 24,
      ),
      selectedIcon: Image.asset(
        "$kURLImageAsset/distance.png",
        width: 24,
        height: 24,
      ),
      label: "L.D.A",
    ),
    NavigationDestination(
      icon: Image.asset(
        "$kURLImageAsset/setting_outline.png",
        width: 24,
        height: 24,
      ),
      selectedIcon: Image.asset(
        "$kURLImageAsset/setting.png",
        width: 24,
        height: 24,
      ),
      label: "Admin",
    ),
  ];

  final _pages = [
    const MainMachineGroupPage(),
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
