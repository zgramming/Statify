// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../injection.dart';
import '../../../model/model/machine_whatsapp/machine_whatsapp_model.dart';
import '../../../utils/enum.dart';
import '../../../utils/fonts.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/dialog_view_qrcode.dart';
import '../../widgets/row_body.dart';

class WhatsAppPage extends ConsumerWidget {
  const WhatsAppPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final machineWhatsApps = ref.watch(getOnlyWhatsAppMachine);
    return Column(
      children: [
        const CustomAppbar(title: 'WhatsApp'),
        Expanded(
          child: ListView.separated(
            itemCount: machineWhatsApps.length,
            shrinkWrap: true,
            padding: const EdgeInsets.all(16.0),
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final item = machineWhatsApps[index];
              return _WhatsappItem(
                item: item,
                index: index,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _WhatsappItem extends ConsumerStatefulWidget {
  const _WhatsappItem({
    Key? key,
    required this.item,
    required this.index,
  }) : super(key: key);
  final MachineWhatsappModel item;
  final int index;

  @override
  ConsumerState<_WhatsappItem> createState() => _WhatsappItemState();
}

class _WhatsappItemState extends ConsumerState<_WhatsappItem> {
  void onClickQRCode(String imageUrl) {
    showDialog(
      context: context,
      builder: (context) => DialogViewQRCode(imageUrl: imageUrl),
    );
  }

  Future<void> connectOrDisconnectWhatsapp(MachineWhatsappModel item) async {
    final status = item.status;
    final id = item.id;

    final notifier = ref.read(machineWhatsappNotifier.notifier);
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          status == MachineWhatsappStatusEnum.connected
              ? "Disconnect WhatsApp"
              : "Connect WhatsApp",
        ),
        content: Text(
          status == MachineWhatsappStatusEnum.connected
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
              if (status == MachineWhatsappStatusEnum.connected) {
                await notifier.disconnect(machineWhatsappId: id);
              } else {
                await notifier.connect(machineWhatsappId: id);
              }

              if (context.mounted) {
                // reload data
                ref.invalidate(machineNotifier);

                context.pop(context);
              }
            },
            child: const Text("Yes"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isConnected =
        widget.item.status == MachineWhatsappStatusEnum.connected;
    return Card(
      margin: const EdgeInsets.only(),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 8.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "WhatsApp ${widget.index + 1}",
                        style: headerFont.copyWith(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      const CircleAvatar(
                        radius: 24.0,
                        backgroundColor: Colors.green,
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        widget.item.number,
                        textAlign: TextAlign.center,
                        style: bodyFont.copyWith(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      RowBody(
                        title: "Status",
                        content: widget.item.status.valueStringReadable,
                      ),
                      const SizedBox(height: 8.0),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => onClickQRCode(widget.item.qrCode!),
                    icon: const Icon(Icons.qr_code),
                    label: const Text("QR Code"),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isConnected
                          ? Colors.red
                          : Theme.of(context).primaryColor,
                    ),
                    onPressed: () => connectOrDisconnectWhatsapp(widget.item),
                    icon: Icon(
                      isConnected ? Icons.close : Icons.connect_without_contact,
                    ),
                    label: const Text("Connect"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
