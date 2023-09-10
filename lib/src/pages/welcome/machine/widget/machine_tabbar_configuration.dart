import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection.dart';
import '../../../../utils/enum.dart';
import '../../../../utils/fonts.dart';
import 'machine_tabbarview_smsbotorwhatsapp.dart';

class MachineTabBarConfiguration extends ConsumerStatefulWidget {
  const MachineTabBarConfiguration({
    super.key,
    required this.idMachine,
  });
  final String idMachine;

  @override
  ConsumerState<MachineTabBarConfiguration> createState() =>
      MachineTabBarConfigurationState();
}

class MachineTabBarConfigurationState
    extends ConsumerState<MachineTabBarConfiguration>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: 0,
    );

    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settingAsync =
        ref.watch(machineSettingNotifier(widget.idMachine)).onGetAll;
    final responseAsync =
        ref.watch(machineResponseNotifier(widget.idMachine)).onGetAll;

    /// Load response and setting machine before show tabbar
    return responseAsync.when(
      data: (_) {
        return settingAsync.when(
          data: (settings) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TabBar(
                      controller: _tabController,
                      labelStyle: bodyFont.copyWith(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      unselectedLabelColor: Colors.blue,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(60.0),
                        color: Colors.blue,
                      ),
                      tabs: settings
                          .map((e) => Tab(
                                text: e.platform.valueStringReadable,
                              ))
                          .toList()),
                ),

                IndexedStack(
                  index: _selectedIndex,
                  children: settings
                      .map(
                        (e) => Builder(
                          builder: (context) {
                            if (e.platform == MachineResponsePlatformEnum.sms) {
                              return MachineTabBarViewSMSBotOrWhatsapp(
                                idMachine: widget.idMachine,
                                idSetting: e.id,
                                isSMSBot: true,
                              );
                            } else {
                              return MachineTabBarViewSMSBotOrWhatsapp(
                                idMachine: widget.idMachine,
                                idSetting: e.id,
                                isSMSBot: false,
                              );
                            }
                          },
                        ),
                      )
                      .toList(),
                ),
                // Builder(
                //   builder: (context) {
                //     final selectedSetting = settings[_selectedIndex];
                //     if (selectedSetting.platform ==
                //         MachineResponsePlatformEnum.sms) {
                //       return MachineTabBarViewSMSBotOrWhatsapp(
                //         idMachine: widget.idMachine,
                //         idSetting: selectedSetting.id,
                //         isSMSBot: true,
                //       );
                //     } else {
                //       return MachineTabBarViewSMSBotOrWhatsapp(
                //         idMachine: widget.idMachine,
                //         idSetting: selectedSetting.id,
                //         isSMSBot: false,
                //       );
                //     }
                //   },
                // ),
                const SizedBox(height: 100),
              ],
            );
          },
          error: (error, stackTrace) {
            return Center(
              child: Text(error.toString()),
            );
          },
          loading: () {
            return const Center(child: CircularProgressIndicator());
          },
        );
      },
      error: (error, stackTrace) {
        return Center(
          child: Text(error.toString()),
        );
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
