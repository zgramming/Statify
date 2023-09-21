import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../injection.dart';
import '../../model/model/machine_whatsapp/machine_whatsapp_model.dart';
import '../../utils/enum.dart';
import '../../utils/functions.dart';
import '../../view_model/custom_notifier/get_all_machine.notifier.dart';

class DialogConnectDisconnectWhatsapp extends ConsumerWidget {
  const DialogConnectDisconnectWhatsapp({
    super.key,
    required this.item,
  });

  final MachineWhatsappModel item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isConnected = item.status == MachineWhatsappStatusEnum.connected;
    return AlertDialog(
      title: Text(
        isConnected ? "Disconnect WhatsApp" : "Connect WhatsApp",
      ),
      content: Text(
        isConnected
            ? "Are you sure you want to disconnect WhatsApp?"
            : "Are you sure you want to connect WhatsApp?",
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(context),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () async {
            final notifier = ref.read(machineWhatsappNotifier.notifier);

            void reload() {
              if (context.mounted) {
                // reload data
                ref.invalidate(getAllMachineFutureProvider);
                context.pop(context);
              }
            }

            if (isConnected) {
              await notifier.disconnect(
                machineWhatsappId: item.id,
                onLoading: () {
                  showSnackbar(
                    context: context,
                    message: "Disconnecting...",
                    backgroundColor: Colors.orange,
                  );
                },
                onError: (message) {
                  showSnackbar(
                    context: context,
                    message: message,
                    backgroundColor: Colors.red,
                  );
                },
                onSuccess: (data) {
                  showSnackbar(
                    context: context,
                    message: "Success Disconnecting WhatsApp",
                    backgroundColor: Colors.green,
                  );

                  reload();
                },
              );
            } else {
              await notifier.connect(
                machineWhatsappId: item.id,
                onLoading: () {
                  showSnackbar(
                    context: context,
                    message: "Connecting...",
                    backgroundColor: Colors.orange,
                  );
                },
                onError: (message) {
                  showSnackbar(
                    context: context,
                    message: message,
                    backgroundColor: Colors.red,
                  );
                },
                onSuccess: (data) {
                  showSnackbar(
                    context: context,
                    message: "Success Connecting WhatsApp",
                    backgroundColor: Colors.green,
                  );

                  reload();
                },
              );
            }
          },
          child: const Text("Yes"),
        ),
      ],
    );
  }
}
