import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../view_model/custom_notifier/request_permission_notifier.dart';
import '../widgets/async_error_builder.dart';
import '../widgets/navigation_destination_item.dart';
import 'main_long_distance_access/main_long_distance_access.page.dart';
import 'main_machine_group/main_machine_group.page.dart';
import 'main_survey/main_survey.page.dart';
import 'main_wifi_control/main_wifi_control.page.dart';
import 'setting/setting_page.dart';
import 'whatsapp/main_whatsapp.page.dart';

class WelcomePage extends ConsumerStatefulWidget {
  const WelcomePage({super.key});

  @override
  createState() => _WelcomePageState();
}

class _WelcomePageState extends ConsumerState<WelcomePage> {
  int _selectedIndex = 0;

  final _destinations = <NavigationDestinationItem>[
    const NavigationDestinationItem(
      prefixAsset: "tower_outline.png",
      selectedPrefixAsset: "tower.png",
      label: "Machine",
    ),
    const NavigationDestinationItem(
      prefixAsset: "wa_business_outline.png",
      selectedPrefixAsset: "wa_business.png",
      label: "Whatsapp",
    ),
    const NavigationDestinationItem(
      prefixAsset: "survey_outline.png",
      selectedPrefixAsset: "survey.png",
      label: "Survey",
    ),
    const NavigationDestinationItem(
      prefixAsset: "distance_outline.png",
      selectedPrefixAsset: "distance.png",
      label: "LDC",
    ),
    const NavigationDestinationItem(
      prefixAsset: "wifi-control-outline.png",
      selectedPrefixAsset: "wifi-control.png",
      label: "Wifi Control",
    ),
    const NavigationDestinationItem(
      prefixAsset: "setting_outline.png",
      selectedPrefixAsset: "setting.png",
      label: "Admin",
    ),
  ];

  final _pages = [
    const MainMachineGroupPage(),
    const MainWhatsAppPage(),
    const MainSurveyPage(),
    const MainLongDistanceAccessPage(),
    const MainWifiControlPage(),
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
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        onDestinationSelected: (value) {
          setState(() => _selectedIndex = value);
        },
      ),
    );
  }
}
