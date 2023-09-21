import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../injection.dart';
import '../../../model/model/machine_whatsapp/machine_whatsapp_model.dart';
import '../../../router.dart';
import '../../../utils/enum.dart';
import '../../../utils/fonts.dart';
import '../../../utils/functions.dart';
import '../../../utils/styles.dart';
import '../../../view_model/custom_notifier/get_all_machine.notifier.dart';
import '../../../view_model/custom_provider/custom_provider.dart';
import '../../widgets/circle_index_number.dart';
import '../../widgets/custom_appbar.dart';
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
    final machineWhatsApps = ref.watch(CustomProvider.getOnlyWhatsAppMachine);
    return Stack(
      children: [
        Column(
          children: [
            const CustomAppbar(title: 'WhatsApp'),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  // Reload data
                  ref.invalidate(getAllMachineFutureProvider);
                },
                child: Builder(
                  builder: (context) {
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
                  },
                ),
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

  Future<void> onSelected(String value, MachineWhatsappModel item) async {
    final notifier = ref.read(machineWhatsappNotifier.notifier);
    switch (value) {
      case "delete":
        await notifier.delete(
          item.id,
          onLoading: () {
            showSnackbar(
              context: context,
              message: "Deleting...",
              backgroundColor: Colors.blue,
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
              message: "Success Deleting WhatsApp Machine",
              backgroundColor: Colors.green,
            );

            // reload data
            ref.invalidate(getAllMachineFutureProvider);
          },
        );
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    final machine = ref.watch(
      CustomProvider.getMachineByIdProvider(widget.item.machineId),
    );

    return Stack(
      children: [
        Card(
          margin: const EdgeInsets.only(),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                RowBody(
                  title: "Machine",
                  content: machine?.name ?? "",
                  titleFlex: 1,
                  contentFlex: 1,
                ),
                const SizedBox(height: 8.0),
                RowBody(
                  title: "WhatsApp Number",
                  content: widget.item.number,
                  titleFlex: 1,
                  contentFlex: 1,
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleIndexNumber(radius: 30.0, index: widget.index),
                          const SizedBox(height: 8.0),
                          ElevatedButton(
                            onPressed: () => onClickQRCode(widget.item.qrCode!),
                            style: elevatedButtonStyle(
                              padding: const EdgeInsets.all(
                                8.0,
                              ),
                            ),
                            child: const Text("QR CODE"),
                          ),
                          Text(
                            widget.item.status.valueStringReadable,
                            style: bodyFont.copyWith(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Expanded(
                      flex: 8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RowBody(
                            title: "Total WA Sent",
                            content: '-',
                            titleFlex: 1,
                            contentFlex: 1,
                          ),
                          SizedBox(height: 8.0),
                          RowBody(
                            title: "Total Replied",
                            content: '-',
                            titleFlex: 1,
                            contentFlex: 1,
                          ),
                          SizedBox(height: 8.0),
                          RowBody(
                            title: "Total Finished",
                            content: '-',
                            titleFlex: 1,
                            contentFlex: 1,
                          ),
                          SizedBox(height: 8.0),
                          RowBody(
                            title: "Total Voted",
                            content: '-',
                            titleFlex: 1,
                            contentFlex: 1,
                          ),
                          SizedBox(height: 8.0),
                          RowBody(
                            title: "Total Choose 1",
                            content: '-',
                            titleFlex: 1,
                            contentFlex: 1,
                          ),
                          SizedBox(height: 8.0),
                          RowBody(
                            title: "Total Choose 2",
                            content: '-',
                            titleFlex: 1,
                            contentFlex: 1,
                          ),
                          SizedBox(height: 8.0),
                          RowBody(
                            title: "Total Choose 3",
                            content: '-',
                            titleFlex: 1,
                            contentFlex: 1,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: PopupMenuButton<String>(
            onSelected: (value) => onSelected(value, widget.item),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: "delete",
                child: Text(
                  "Delete",
                  style: bodyFont.copyWith(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
