import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../injection.dart';
import '../../../../router.dart';
import '../../../../utils/functions.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/listtile_setting_menu.dart';

class MyAccountPage extends ConsumerWidget {
  const MyAccountPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userNotifier).user;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const CustomAppbar(
            title: "My Account",
            withBackButton: true,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ListTileSettingMenu(
                    onTap: () {
                      context.pushNamed(
                        routeMyAccountFormPage,
                        pathParameters: {
                          "id": user?.id ?? "",
                        },
                      );
                    },
                    title: "Edit Profile",
                    subtitle: "Change your profile",
                    leadingIcon: Icons.person,
                    leadingBackgroundColor: Colors.blue,
                  ),
                  const SizedBox(height: 16.0),
                  ListTileSettingMenu(
                    onTap: () {
                      showSnackbar(
                        context: context,
                        message: "Coming soon",
                        backgroundColor: Colors.blue,
                      );
                    },
                    title: "Change Password",
                    subtitle: "Change your password",
                    leadingIcon: Icons.lock,
                    leadingBackgroundColor: Colors.green,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
