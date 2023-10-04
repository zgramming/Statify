import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../injection.dart';
import '../../../router.dart';
import '../../../utils/functions.dart';
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const CustomAppbar(title: "Admin Setting"),
        Expanded(
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
