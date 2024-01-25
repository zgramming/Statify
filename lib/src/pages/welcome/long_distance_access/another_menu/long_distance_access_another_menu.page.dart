import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../router.dart';
import '../../../widgets/listtile_setting_menu.dart';

class LongDistanceAccessAnotherMenuPage extends StatelessWidget {
  const LongDistanceAccessAnotherMenuPage({
    Key? key,
    required this.idMachine,
  }) : super(key: key);
  final String idMachine;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListTileSettingMenu(
              onTap: () => context.pushNamed(
                routeLDAAdminPage,
                pathParameters: {
                  "idMachine": idMachine,
                },
              ),
              title: "LDC Admin",
              subtitle: "Manage LDC Admin",
              leadingIcon: Icons.person,
              leadingBackgroundColor: Colors.blue,
            ),
            const SizedBox(height: 16),
            ListTileSettingMenu(
              onTap: () => context.pushNamed(
                routeLDAManagerPage,
                pathParameters: {
                  "idMachine": idMachine,
                },
              ),
              title: "LDC Manager",
              subtitle: "Manage LDC Manager",
              leadingIcon: Icons.group,
              leadingBackgroundColor: Colors.purple,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
