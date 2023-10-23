import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../injection.dart';
import '../../../utils/functions.dart';
import '../../../view_model/custom_notifier/get_all_machine.notifier.dart';
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

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      machineNotifier.select((value) => value.onUpdateConfig),
      (previous, next) {
        next.when(
          data: (data) {
            if (data == null) return;
            showSnackbar(
              context: context,
              message: "Update config success",
              backgroundColor: Colors.green,
            );

            // Reload Machine Data
            ref.invalidate(getAllMachineFutureProvider);
          },
          error: (error, stackTrace) => showSnackbar(
            context: context,
            message: error.toString(),
            backgroundColor: Colors.red,
          ),
          loading: () => showSnackbar(
            context: context,
            message: "Loading Update Machine Config ...",
            backgroundColor: Colors.blue,
          ),
        );
      },
    );
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          LongDistanceAccessHomePage(idMachine: widget.idMachine),
          LongDistanceAccessSMSPage(idMachine: widget.idMachine),
          const LongDistanceAccessReportPage(),
          LongDistanceAccessSettingPage(idMachine: widget.idMachine),
        ],
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
