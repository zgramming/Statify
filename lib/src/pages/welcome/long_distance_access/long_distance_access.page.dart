import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../view_model/custom_provider/custom_injection_provider.dart';
import '../../../view_model/custom_provider/custom_provider.dart';
import '../../widgets/navigation_destination_item.dart';
import 'home/long_distance_access_home.page.dart';
import 'report/long_distance_access_report.page.dart';
import 'setting/long_distance_access_setting.page.dart';
import 'sms/long_distance_access_sms.page.dart';

class LongDistanceAccessPage extends ConsumerStatefulWidget {
  const LongDistanceAccessPage({
    Key? key,
    required this.idMachine,
  }) : super(key: key);
  final String idMachine;

  @override
  ConsumerState<LongDistanceAccessPage> createState() =>
      _LongDistanceAccessPageState();
}

class _LongDistanceAccessPageState
    extends ConsumerState<LongDistanceAccessPage> {
  final _destinations = <NavigationDestinationItem>[
    const NavigationDestinationItem(
      prefixAsset: "home_outline.png",
      selectedPrefixAsset: "home.png",
      label: "Home",
    ),
    const NavigationDestinationItem(
      prefixAsset: "sms_outline.png",
      selectedPrefixAsset: "sms.png",
      label: "SMS",
    ),
    const NavigationDestinationItem(
      prefixAsset: "report_outline.png",
      selectedPrefixAsset: "report.png",
      label: "Report",
    ),
    const NavigationDestinationItem(
      prefixAsset: "setting_outline.png",
      selectedPrefixAsset: "setting.png",
      label: "Setting",
    ),
  ];

  final _pages = <Widget>[
    const LongDistanceAccessHomePage(),
    const LongDistanceAccessSMSPage(),
    const LongDistanceAccessReportPage(),
    const LongDistanceAccessSettingPage(),
  ];

  int _selectedIndex = 0;

  void init() {
    final machine =
        ref.read(CustomProvider.getMachineByIdProvider(widget.idMachine));
    ref
        .read(CustomInjectionProvider.machineById.notifier)
        .update((state) => machine);
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => init());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: NavigationBar(
        destinations: _destinations,
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
        },
      ),
    );
  }
}
