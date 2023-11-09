import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:go_router/go_router.dart';

import '../../../../router.dart';
import '../../../../view_model/custom_provider/custom_provider.dart';

class CustomFloatingActionButtonLDA extends ConsumerWidget {
  const CustomFloatingActionButtonLDA({
    Key? key,
    required this.idMachine,
  }) : super(key: key);
  final String idMachine;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final machine = ref.watch(CustomProvider.getMachineByIdProvider(idMachine));
    final config = machine?.config;
    final isHiddenManager = config?.hiddenManager == "1";
    return SpeedDial(
      buttonSize: const Size.square(56),
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: const IconThemeData(size: 22.0),
      children: [
        // SpeedDialChild(
        //   label: "Home",
        //   onTap: () => onTapMenu(MenuLDAEnum.home),
        // ),
        // SpeedDialChild(
        //   label: "SMS",
        //   onTap: () => onTapMenu(MenuLDAEnum.sms),
        // ),
        // SpeedDialChild(
        //   label: "Report",
        //   onTap: () => onTapMenu(MenuLDAEnum.report),
        // ),
        // SpeedDialChild(
        //   label: "Setting",
        //   onTap: () => onTapMenu(MenuLDAEnum.setting),
        // ),
        SpeedDialChild(
          label: "Admin",
          onTap: () => context.pushNamed(
            routeLDAAdminPage,
            pathParameters: {
              "idMachine": idMachine,
            },
          ),
        ),
        if (!isHiddenManager) ...[
          SpeedDialChild(
            label: "Manager",
            onTap: () => context.pushNamed(
              routeLDAManagerPage,
              pathParameters: {
                "idMachine": idMachine,
              },
            ),
          ),
        ],
      ],
    );
  }
}
