import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../../../injection.dart';
import '../../../utils/enum.dart';
import '../../../utils/functions.dart';
import '../../../view_model/custom_notifier/get_all_machine.notifier.dart';
import '../../../view_model/custom_provider/custom_state_provider.dart';

import '../../widgets/async_error_builder.dart';
import 'admin/long_distance_access_admin.page.dart';
import 'home/long_distance_access_home.page.dart';
import 'manager/long_distance_access_manager.page.dart';
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
  void onTapMenu(MenuLDAEnum menu) {
    ref
        .read(CustomStateProvider.currentMenuLDA.notifier)
        .update((state) => menu);
  }

  Widget choosenMenu(MenuLDAEnum menu) {
    switch (menu) {
      case MenuLDAEnum.home:
        return LongDistanceAccessHomePage(idMachine: widget.idMachine);
      case MenuLDAEnum.sms:
        return LongDistanceAccessSMSPage(idMachine: widget.idMachine);
      case MenuLDAEnum.report:
        return const LongDistanceAccessReportPage();
      case MenuLDAEnum.setting:
        return LongDistanceAccessSettingPage(idMachine: widget.idMachine);
      case MenuLDAEnum.admin:
        return const LongDistanceAccessAdminPage();
      case MenuLDAEnum.manager:
        return const LongDistanceAccessManagerPage();
      default:
        return const Center(child: Text("No menu selected"));
    }
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

    final menu = ref.watch(CustomStateProvider.currentMenuLDA);
    final machineAsync =
        ref.watch(getAllMachineFutureProvider).unwrapPrevious();

    return Scaffold(
      body: Builder(
        builder: (context) {
          return machineAsync.when(
            data: (data) => choosenMenu(menu),
            error: (error, stackTrace) => AsyncErrorBuilder(
              error: error.toString(),
              onRetry: () {
                ref.invalidate(getAllMachineFutureProvider);
              },
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: const IconThemeData(size: 22.0),
        children: [
          SpeedDialChild(
            label: "Home",
            onTap: () => onTapMenu(MenuLDAEnum.home),
          ),
          SpeedDialChild(
            label: "SMS",
            onTap: () => onTapMenu(MenuLDAEnum.sms),
          ),
          SpeedDialChild(
            label: "Report",
            onTap: () => onTapMenu(MenuLDAEnum.report),
          ),
          SpeedDialChild(
            label: "Setting",
            onTap: () => onTapMenu(MenuLDAEnum.setting),
          ),
          SpeedDialChild(
            label: "Admin",
            onTap: () => onTapMenu(MenuLDAEnum.admin),
          ),
          SpeedDialChild(
            label: "Manager",
            onTap: () => onTapMenu(MenuLDAEnum.manager),
          ),
        ],
      ),
    );
  }
}
