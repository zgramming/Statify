import 'package:flutter/material.dart';

import '../../../../utils/constant.dart';
import '../../../../utils/fonts.dart';

class DialogSuccessResetMachine extends StatelessWidget {
  const DialogSuccessResetMachine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Information"),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Reseted no 0...", style: bodyFontBold.copyWith(fontSize: 14.0)),
          const SizedBox(height: 10),
          Text(kSuccessMessageResetMachine,
              style: bodyFontBold.copyWith(fontSize: 14.0)),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("OK"),
        ),
      ],
    );
  }
}
