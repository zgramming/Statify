import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../injection.dart';
import '../../../router.dart';
import '../../widgets/custom_appbar.dart';

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
    // final survey = ref.read(surveyNotifier.notifier);
    // final surveyResponse = ref.read(surveyResponseNotifier.notifier);

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
    //   key: "welcome",
    //   type: "welcome",
    //   value: "Selamat datang pemirsa",
    //   // key: "3",
    //   // type: "regular",
    //   // value: "ini value",
    // );

    // await survey.create(
    //   number: "111222333111",
    //   machineId: "0f273631-d24f-444d-a9e7-3be786e70648",
    // );

    // await surveyResponse.getResponse(
    //     machineId: "0f273631-d24f-444d-a9e7-3be786e70648");

    // await surveyResponse.create(
    //   surveyId: "94320477-c45e-428e-ba77-f0f9eefa75d5",
    //   key: "2",
    //   type: "whatsapp",
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const CustomAppbar(title: "Setting"),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey)),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Machine'),
                    subtitle: const Text('Manage machine'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      context.pushNamed(routeMachine);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: onLogout,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Logout'),
          ),
        ),
      ],
    );
  }
}
