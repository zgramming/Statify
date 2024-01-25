import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../injection.dart';
import '../../../router.dart';
import '../../../utils/constant.dart';
import '../../../utils/functions.dart';
import '../../../view_model/custom_notifier/get_application_config_by_key.notifier.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/listtile_setting_menu.dart';

class SettingPage extends ConsumerStatefulWidget {
  const SettingPage({super.key});

  @override
  ConsumerState<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends ConsumerState<SettingPage> {
  Future<void> onLogout() async {
    final notifier = ref.read(authenticationNotifier.notifier);
    final result = await notifier.logout();
    result.onLogout.when(
      data: (data) {
        if (data == null) return;
        showSnackbar(
          context: context,
          message: "Logout Success",
          backgroundColor: Colors.green,
        );

        context.goNamed(routeLogin);
      },
      error: (error, stackTrace) => showSnackbar(
        context: context,
        message: error.toString(),
        backgroundColor: Colors.red,
      ),
      loading: () => showSnackbar(
        context: context,
        message: "Loading...",
        backgroundColor: Colors.blue,
      ),
    );
  }

  Future<void> onChangeAutoRespondServer(bool value) async {
    final notifier = ref.read(applicationConfigNotifier.notifier);
    await notifier.upsert(
      key: kAutoRespondServer,
      value: value ? "true" : "false",
    );

    ref.invalidate(getApplicationConfigByKeyFutureProvider(kAutoRespondServer));

    // Restart Application then navigate to splash screen
    if (context.mounted) {
      context.goNamed(routeSplash);
    }
  }

  @override
  Widget build(BuildContext context) {
    final futureAutoResponseServer =
        ref.watch(getApplicationConfigByKeyFutureProvider(kAutoRespondServer));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const CustomAppbar(title: "Admin Setting"),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ListTileSettingMenu(
                    onTap: () {
                      context.pushNamed(routeMyAccountPage);
                    },
                    title: "My Account",
                    subtitle: "Manage your account",
                    leadingIcon: Icons.person,
                    leadingBackgroundColor: Colors.blue,
                  ),
                  const SizedBox(height: 16),
                  ListTileSettingMenu(
                    onTap: () {
                      context.pushNamed(routeMachineGroup);
                    },
                    title: "Machine Group",
                    subtitle: "Manage machine group",
                    leadingIcon: Icons.group,
                    leadingBackgroundColor: Colors.purple,
                  ),
                  const SizedBox(height: 16),
                  ListTileSettingMenu(
                    onTap: () {
                      context.pushNamed(routeWifiControlFormPage);
                    },
                    title: "Wifi Control IP",
                    subtitle: "Manage wifi control ip",
                    leadingIcon: Icons.wifi,
                    leadingBackgroundColor: Colors.green,
                  ),
                  const SizedBox(height: 16),
                  ListTileSettingMenu(
                    onTap: () {},
                    title: "Auto Respond Server",
                    subtitle: "Toggle auto respond server",
                    leadingIcon: Icons.send_to_mobile_outlined,
                    leadingBackgroundColor: Colors.orange,
                    trailing: Builder(builder: (context) {
                      return futureAutoResponseServer.when(
                        data: (data) {
                          final isActive = (data?.value ?? "true") == "true";
                          return Switch(
                            value: isActive,
                            onChanged: (value) {
                              onChangeAutoRespondServer(value);
                            },
                          );
                        },
                        error: (error, stackTrace) => const SizedBox(),
                        loading: () => const CircularProgressIndicator(),
                      );
                    }),
                  ),
                  const SizedBox(height: 16),
                  ListTileSettingMenu(
                    onTap: () {
                      context.pushNamed(
                        routeLogPage,
                      );
                    },
                    title: "Log",
                    subtitle: "Manage log",
                    leadingIcon: Icons.logo_dev,
                    leadingBackgroundColor: Colors.black,
                  ),
                ],
              ),
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
