import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../injection.dart';
import '../../../model/model/machine_whatsapp/machine_whatsapp_model.dart';
import '../../../router.dart';
import '../../../utils/enum.dart';
import '../../../utils/fonts.dart';
import '../../../utils/functions.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/dialog_connect_disconnect_whatsapp.dart';
import '../../widgets/dialog_view_qrcode.dart';
import '../../widgets/row_body.dart';

class WhatsAppPage extends ConsumerStatefulWidget {
  const WhatsAppPage({super.key});

  @override
  ConsumerState<WhatsAppPage> createState() => _WhatsAppPageState();
}

class _WhatsAppPageState extends ConsumerState<WhatsAppPage> {
  Future<void> onAddWhatsapp() async {
    context.pushNamed(
      routeMachineWhatsAppForm,
      pathParameters: {
        "id": "-1",
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final machineWhatsApps = ref.watch(getOnlyWhatsAppMachine);
    return Stack(
      children: [
        Column(
          children: [
            const CustomAppbar(title: 'WhatsApp'),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  // Reload data
                  ref.invalidate(machineNotifier);
                },
                child: Builder(builder: (context) {
                  if (machineWhatsApps.isEmpty) {
                    return Center(
                      child: Text(
                        "No WhatsApp",
                        style: headerFont.copyWith(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }

                  return ListView.separated(
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
                  );
                }),
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: FloatingActionButton(
            onPressed: onAddWhatsapp,
            child: const Icon(Icons.add),
          ),
        )
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
    return showDialog(
      context: context,
      builder: (context) => DialogConnectDisconnectWhatsapp(item: item),
    );
  }

  Future<void> onSelected(String value, MachineWhatsappModel item) async {
    final notifier = ref.read(machineWhatsappNotifier.notifier);
    switch (value) {
      case "qr_code":
        final qrCode = item.qrCode;
        if (qrCode != null) {
          onClickQRCode(qrCode);
        }
        break;
      case "connect_disconnect":
        connectOrDisconnectWhatsapp(item);
        break;
      case "delete":
        await notifier.delete(
          item.id,
          onLoading: () {
            showSnackbar(
                context: context,
                message: "Deleting...",
                backgroundColor: Colors.orange);
          },
          onError: (message) {
            showSnackbar(
                context: context,
                message: message,
                backgroundColor: Colors.red);
          },
          onSuccess: (data) {
            showSnackbar(
              context: context,
              message: "Success Deleting WhatsApp Machine",
              backgroundColor: Colors.green,
            );

            // reload data
            ref.invalidate(machineNotifier);
          },
        );
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
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
              ],
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: PopupMenuButton(
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  value: "qr_code",
                  child: Text("QR Code"),
                ),
                const PopupMenuItem(
                  value: "connect_disconnect",
                  child: Text("Connect / Disconnect"),
                ),
                PopupMenuItem(
                  value: "delete",
                  child: Text(
                    "Delete WhatsApp Machine",
                    style: bodyFont.copyWith(
                      color: Colors.red,
                    ),
                  ),
                ),
              ];
            },
            onSelected: (value) => onSelected(value, widget.item),
          ),
        ),
      ],
    );
  }
}
