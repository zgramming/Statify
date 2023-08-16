import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../injection.dart';
import '../../../router.dart';

class SettingPage extends ConsumerStatefulWidget {
  const SettingPage({super.key});

  @override
  ConsumerState<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends ConsumerState<SettingPage> {
  Future<void> onLogout() async {
    final notifier = ref.read(authenticationNotifier.notifier);
    await notifier.logout();

    if (context.mounted) {
      context.goNamed(routeLogin);
    }
  }

  Future<void> init() async {
    // final machine = ref.read(machineNotifier.notifier);
    // final machineWhatsapp = ref.read(machineWhatsappNotifier.notifier);
    // final machineResponseSetting =
    //     ref.read(machineResponseSettingNotifier.notifier);
    // final user = ref.read(authenticationNotifier).user!;

    // await machine.getAll(user.id);
    // await machine.getById(
    //   userId: user.id,
    //   machineId: "0f273631-d24f-444d-a9e7-3be786e70648",
    // );

    // await machine.create(
    //   number: "123467889",
    //   license: 'License 123',
    //   action: 'whatsapp',
    //   smsSetting: 'both',
    //   userId: user.id,
    // );

    // await machineWhatsapp.create(
    //   number: "111222333",
    //   machineId: "0f273631-d24f-444d-a9e7-3be786e70648",
    // );

    // await machineResponseSetting.getAll("0f273631-d24f-444d-a9e7-3be786e70648");

    // await machineResponseSetting.create(
    //   idMachine: "0f273631-d24f-444d-a9e7-3be786e70648",
    //   key: "3",
    //   type: "regular",
    //   value: "ini value",
    // );
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: onLogout,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
