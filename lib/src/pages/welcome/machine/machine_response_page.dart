// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../injection.dart';
import '../../../model/model/machine_response/machine_response_model.dart';
import '../../../router.dart';
import '../../../utils/fonts.dart';
import '../../widgets/custom_appbar.dart';

class MachineResponsePage extends ConsumerStatefulWidget {
  const MachineResponsePage({
    super.key,
    required this.idMachine,
  });

  final String idMachine;

  @override
  ConsumerState<MachineResponsePage> createState() =>
      _MachineResponsePageState();
}

class _MachineResponsePageState extends ConsumerState<MachineResponsePage> {
  @override
  void initState() {
    super.initState();
    final idMachine = widget.idMachine;
    final notifier = ref.read(machineResponseNotifier(idMachine).notifier);
    Future.microtask(() => notifier.getAll());
  }

  Future<void> onSelected(
    String value, {
    required MachineResponseModel item,
  }) async {
    final notifier =
        ref.read(machineResponseNotifier(widget.idMachine).notifier);
    switch (value) {
      case "delete":
        await notifier.delete(responseId: item.id);

        // Reload data
        ref.invalidate(machineResponseNotifier(widget.idMachine));

        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const CustomAppbar(
            title: "Machine Response Setting",
            withBackButton: true,
          ),
          Expanded(
            child: Builder(builder: (context) {
              final responseAsync =
                  ref.watch(machineResponseNotifier(widget.idMachine)).onGetAll;

              return responseAsync.when(
                data: (items) {
                  return ListView.separated(
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    padding: const EdgeInsets.all(16.0),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return Stack(
                        children: [
                          Card(
                            margin: EdgeInsets.zero,
                            child: ListTile(
                              title: Text(item.key),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ...[
                                    const SizedBox(height: 10.0),
                                    Text(
                                      "Type :",
                                      style: bodyFontBold,
                                    ),
                                    const SizedBox(
                                      height: 8.0,
                                    ),
                                    Text(item.type),
                                  ],
                                  ...[
                                    const SizedBox(height: 10.0),
                                    Text(
                                      "Value :",
                                      style: bodyFontBold,
                                    ),
                                    const SizedBox(
                                      height: 8.0,
                                    ),
                                    Text(item.value),
                                  ],
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: PopupMenuButton(
                              itemBuilder: (context) {
                                return [
                                  PopupMenuItem(
                                    value: "delete",
                                    child: Text(
                                      "Delete Response",
                                      style: bodyFont.copyWith(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ];
                              },
                              onSelected: (value) =>
                                  onSelected(value, item: item),
                            ),
                          )
                        ],
                      );
                    },
                  );
                },
                error: (error, stackTrace) {
                  return Center(
                    child: Text(
                      error.toString(),
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                },
                loading: () {
                  return const Center(child: CircularProgressIndicator());
                },
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.pushNamed(routeMachineResponseForm, pathParameters: {
            "idMachine": widget.idMachine,
            "id": "-1",
          });
        },
        label: const Text("Add Response"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
