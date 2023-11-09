import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../utils/fonts.dart';

class ModalLDASettingWarning extends StatelessWidget {
  const ModalLDASettingWarning({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Important Warning !!!",
            style: bodyFont.copyWith(fontSize: 12.0),
          ),
          const SizedBox(height: 10),
          Text(
            "Change Wifi Name, Wifi Password or Hide Wifi, you have to make sure that you remember your settings. If you forget, maybe you need to send unit back to factory to reset the hardware.",
            style: bodyFont.copyWith(
              fontSize: 12.0,
            ),
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: const Text("Close"),
        ),
      ],
    );
  }
}
