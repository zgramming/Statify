import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../router.dart';
import '../../../../utils/fonts.dart';

class ModalAddMachineGroupOrMachine extends ConsumerWidget {
  const ModalAddMachineGroupOrMachine({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Add New",
            style: headerFont.copyWith(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              context.pop();
              context.pushNamed(routeMachineGroupForm, pathParameters: {
                "id": "-1",
              });
            },
            child: const Text("Machine Group"),
          ),
          const SizedBox(height: 8.0),
          ElevatedButton.icon(
            onPressed: () {
              context.pop();
              context.pushNamed(routeMachineForm, pathParameters: {
                "id": "-1",
              });
            },
            icon: const Icon(Icons.qr_code_scanner_rounded),
            label: const Text("Machine"),
          ),
        ],
      ),
    );
  }
}
