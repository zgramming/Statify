import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../injection.dart';
import '../../../router.dart';
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
    await notifier.logout();

    if (context.mounted) {
      context.goNamed(routeLogin);
    }
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
                  onTap: () {},
                  title: "My Account",
                  subtitle: "Manage your account",
                  leadingIcon: Icons.person,
                  leadingBackgroundColor: Colors.blue,
                ),
                const SizedBox(height: 16),
                ListTileSettingMenu(
                  onTap: () {
                    context.pushNamed(routeMachine);
                  },
                  title: "Machine",
                  subtitle: "Manage machine",
                  leadingIcon: Icons.devices_rounded,
                  leadingBackgroundColor: Colors.green,
                ),
                const SizedBox(height: 16),
                ListTileSettingMenu(
                  onTap: () {
                    context.pushNamed(
                      routePhoneNumberSettingFormPage,
                    );
                  },
                  title: "Phone Number Setting",
                  subtitle: "Manage phone number setting",
                  leadingIcon: Icons.assignment,
                  leadingBackgroundColor: Colors.orange,
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
