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
import '../../../view_model/custom_notifier/get_all_whatsapp_by_user.notifier.dart';
import '../../../view_model/custom_provider/custom_provider.dart';
import '../../widgets/async_error_builder.dart';
import '../../widgets/circle_index_number.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/dialog_confirmation_delete.dart';
import '../../widgets/dialog_view_qrcode.dart';
import '../../widgets/row_body.dart';

class MainWhatsAppPage extends ConsumerStatefulWidget {
  const MainWhatsAppPage({super.key});

  @override
  ConsumerState<MainWhatsAppPage> createState() => _MainWhatsAppPageState();
}

class _MainWhatsAppPageState extends ConsumerState<MainWhatsAppPage> {
  Future<void> onAdd() async {
    context.pushNamed(
      routeMachineWhatsAppForm,
      pathParameters: {
        "id": "-1",
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final whatsappsAsync =
        ref.watch(getAllWhatsAppByUserFutureProvider).unwrapPrevious();
    return Stack(
      children: [
        Column(
          children: [
            const CustomAppbar(title: 'WhatsApp Business'),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  ref.invalidate(getAllWhatsAppByUserFutureProvider);

                  showSnackbar(
                    context: context,
                    message: "Refreshing...",
                    backgroundColor: Colors.blue,
                  );
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Builder(
                    builder: (context) {
                      return whatsappsAsync.when(
                        data: (map) {
                          final isEmpty = map.values.every(
                            (element) => element.isEmpty,
                          );

                          if (isEmpty) {
                            return Center(
                              child: Text(
                                "No Machine WhatsApp Found",
                                style: bodyFont.copyWith(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: map.entries.map((e) {
                              final machine = e.key;
                              final whatsapps = e.value;

                              if (whatsapps.isEmpty) {
                                return const SizedBox();
                              }

                              return Card(
                                margin: const EdgeInsets.only(
                                    bottom: 16.0, left: 16.0, right: 16.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  side: const BorderSide(
                                    color: Colors.grey,
                                    width: 1.0,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0,
                                        ),
                                        child: Text(
                                          machine.name,
                                          style: headerFont.copyWith(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 16.0),
                                      ListView.separated(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: whatsapps.length,
                                        shrinkWrap: true,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0,
                                        ),
                                        separatorBuilder: (context, index) =>
                                            const Divider(),
                                        itemBuilder: (context, index) {
                                          final item = whatsapps[index];
                                          return _WhatsappItem(
                                            item: item,
                                            index: index,
                                          );
                                        },
                                      ),
                                      const SizedBox(height: 16.0),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                        },
                        error: (error, stack) {
                          return AsyncErrorBuilder(
                            error: error.toString(),
                            onRetry: () {
                              ref.invalidate(
                                  getAllWhatsAppByUserFutureProvider);
                            },
                          );
                        },
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: FloatingActionButton(
            heroTag: "addWhatsapp",
            onPressed: onAdd,
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
      builder: (context) => DialogViewQRCode(
        id: widget.item.id,
      ),
    );
  }

  void onClickEdit() {
    context.pushNamed(
      routeMachineWhatsAppForm,
      pathParameters: {
        "id": widget.item.id,
      },
    );
  }

  Future<void> onSelected(String value, MachineWhatsappModel item) async {
    final notifier = ref.read(machineWhatsappNotifier.notifier);
    switch (value) {
      case "delete":
        await showDialog(
          context: context,
          builder: (context) => DialogDeleteConfirmation(
            onConfirm: () async {
              final result = await notifier.delete(item.id);
              result.onDelete.whenOrNull(
                data: (data) {
                  if (data == null) return;

                  // Close Modal
                  context.pop();

                  showSnackbar(
                    context: context,
                    message:
                        "Success delete whatsapp with number ${item.number}",
                    backgroundColor: Colors.green,
                  );

                  ref.invalidate(getAllWhatsAppByUserFutureProvider);
                },
                error: (error, stack) {
                  showSnackbar(
                    context: context,
                    message: error.toString(),
                    backgroundColor: Colors.red,
                  );
                },
              );
            },
          ),
        );
        break;
      case "edit":
        onClickEdit();
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    final machine = ref.watch(
      CustomProvider.getMachineByIdProvider(item.machineId),
    );

    return Stack(
      children: [
        Card(
          margin: const EdgeInsets.only(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: const BorderSide(color: Colors.grey, width: 1.0),
          ),
          child: InkWell(
            onTap: onClickEdit,
            child: Padding(
              padding: const EdgeInsets.all(16),
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
                    content: item.number,
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
                            CircleIndexNumber(
                                radius: 30.0, index: widget.index),
                            const SizedBox(height: 8.0),
                            ElevatedButton(
                              onPressed: () => onClickQRCode(item.qrCode!),
                              style: elevatedButtonStyle(
                                padding: const EdgeInsets.all(
                                  8.0,
                                ),
                              ),
                              child: const Text("QR CODE"),
                            ),
                            Text(
                              item.status.valueStringReadable,
                              style: bodyFont.copyWith(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RowBody(
                              title: "Total Responden",
                              content: "${item.totalReplied}",
                              titleFlex: 1,
                              contentFlex: 1,
                              titleTrailing: const [
                                Icon(
                                  Icons.download,
                                  color: Colors.green,
                                  size: 16.0,
                                ),
                              ],
                            ),
                            const SizedBox(height: 8.0),
                            RowBody(
                              title: "Total WA Sent",
                              content: "${item.totalSent}",
                              titleFlex: 1,
                              contentFlex: 1,
                              titleTrailing: const [
                                Icon(
                                  Icons.download,
                                  color: Colors.green,
                                  size: 16.0,
                                ),
                              ],
                            ),
                            const SizedBox(height: 8.0),
                            RowBody(
                              title: "Total Voted",
                              content: "${item.totalVoted}",
                              titleFlex: 1,
                              contentFlex: 1,
                              titleTrailing: const [
                                Icon(
                                  Icons.download,
                                  color: Colors.green,
                                  size: 16.0,
                                ),
                              ],
                            ),
                            const SizedBox(height: 8.0),
                            RowBody(
                              title: "Total Finished",
                              content: "${item.totalFinished}",
                              titleFlex: 1,
                              contentFlex: 1,
                              titleTrailing: const [
                                Icon(
                                  Icons.download,
                                  color: Colors.green,
                                  size: 16.0,
                                ),
                              ],
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
        ),
        Positioned(
          top: 0,
          right: 0,
          child: PopupMenuButton<String>(
            onSelected: (value) => onSelected(value, widget.item),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: "edit",
                child: Text(
                  "Edit",
                  style: bodyFont.copyWith(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
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
