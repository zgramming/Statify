import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../injection.dart';
import '../../../utils/constant.dart';
import '../../../utils/functions.dart';
import '../../../view_model/custom_notifier/get_all_machine.notifier.dart';
import '../../widgets/async_error_builder.dart';
import '../../widgets/navigation_destination_item.dart';
import 'home/long_distance_access_home.page.dart';
import 'report/long_distance_access_report.page.dart';
import 'setting/long_distance_access_setting.page.dart';
import 'sms/long_distance_access_sms.page.dart';
import 'widgets/dialog_success_reset_machine.dart';

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
  int _selectedIndex = 0;

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
    // const NavigationDestinationItem(
    //   prefixAsset: "another_menu_outline.png",
    //   selectedPrefixAsset: "another_menu.png",
    //   label: "Menu",
    // ),
  ];

  void onTapMenu(int index) {
    setState(() => _selectedIndex = index);
  }

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
          data: (message) {
            if (message == null) return;

            if (message.contains(kSuccessMessageResetMachine)) {
              showDialog(
                context: context,
                builder: (context) => const DialogSuccessResetMachine(),
              );
            } else {
              showSnackbar(
                context: context,
                message: message,
                backgroundColor: Colors.green,
              );
            }

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

    final machineAsync =
        ref.watch(getAllMachineFutureProvider).unwrapPrevious();

    return machineAsync.when(
      data: (machine) {
        return Scaffold(
          body: IndexedStack(
            index: _selectedIndex,
            children: [
              LongDistanceAccessHomePage(idMachine: widget.idMachine),
              LongDistanceAccessSMSPage(idMachine: widget.idMachine),
              LongDistanceAccessReportPage(idMachine: widget.idMachine),
              LongDistanceAccessSettingPage(idMachine: widget.idMachine),
              // LongDistanceAccessAnotherMenuPage(idMachine: widget.idMachine),
            ],
          ),
          bottomNavigationBar: NavigationBar(
            destinations: _destinations,
            selectedIndex: _selectedIndex,
            onDestinationSelected: onTapMenu,
          ),
        );
      },
      error: (error, stackTrace) => Scaffold(
        body: AsyncErrorBuilder(
          error: error.toString(),
          onRetry: () {
            ref.invalidate(getAllMachineFutureProvider);
          },
        ),
      ),
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
