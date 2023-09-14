import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../injection.dart';
import '../../../model/model/machine/machine_model.dart';
import '../../../router.dart';
import '../../../utils/enum.dart';
import '../../../utils/fonts.dart';
import '../../../utils/functions.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/row_body.dart';

class MachinePage extends ConsumerStatefulWidget {
  const MachinePage({super.key});

  @override
  ConsumerState<MachinePage> createState() => _MachinePageState();
}

class _MachinePageState extends ConsumerState<MachinePage> {
  Future<void> onEditButton(MachineModel item) async {
    context.pushNamed(
      routeMachineForm,
      pathParameters: {
        "id": item.id,
      },
    );
  }

  Future<void> onAddMachine() async {
    final isEmpty = ref.read(isEmptyAvailableSIM);

    if (isEmpty) {
      showSnackbar(
        context: context,
        message: "Please update SIM 1 / SIM 2 first in User Profile",
        backgroundColor: Colors.red,
      );
      return;
    }

    context.pushNamed(routeMachineForm, pathParameters: {
      "id": "-1",
    });
  }

  Future<void> onSelected(
    String value, {
    required MachineModel item,
  }) async {
    final notifier = ref.read(machineNotifier.notifier);
    switch (value) {
      case "edit":
        context.pushNamed(
          routeMachineForm,
          pathParameters: {
            "id": item.id,
          },
        );
        break;
      case "delete":
        await notifier.delete(machineId: item.id);
        ref.invalidate(machineNotifier);
        break;

      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    final machine = ref.watch(machineNotifier).onGetAll;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const CustomAppbar(
            title: "Machine",
            withBackButton: true,
          ),
          Expanded(
            child: Builder(
              builder: (context) {
                return machine.when(
                  data: (items) {
                    if (items.isEmpty) {
                      return const Center(
                        child: Text("Empty Machine"),
                      );
                    }

                    return ListView.separated(
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return Stack(
                          children: [
                            Card(
                              margin: const EdgeInsets.all(8),
                              child: ListTile(
                                onTap: () => onEditButton(item),
                                leading: const Column(
                                  children: [
                                    CircleAvatar(child: Icon(Icons.star)),
                                    SizedBox(height: 10.0),
                                  ],
                                ),
                                title: Text(
                                  item.name,
                                  style: headerFont.copyWith(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    const SizedBox(height: 10.0),
                                    RowBody(
                                      title: "No Serial Machine",
                                      content: item.serialNumber,
                                      titleFlex: 6,
                                      contentFlex: 6,
                                    ),
                                    const SizedBox(height: 4.0),
                                    RowBody(
                                      title: "Activation License",
                                      content: item.license,
                                      titleFlex: 6,
                                      contentFlex: 6,
                                    ),
                                    const SizedBox(height: 4.0),
                                    RowBody(
                                      title: "Action",
                                      content: item.action.valueStringReadable,
                                      titleFlex: 6,
                                      contentFlex: 6,
                                    ),
                                    if (item.settingsPlatformSMS != null) ...[
                                      const SizedBox(height: 10.0),
                                      Text("SMS Setting",
                                          style: bodyFont.copyWith(
                                              fontWeight: FontWeight.bold)),
                                      const SizedBox(height: 4.0),
                                      Text(item.settingByPlatformReadable(
                                              item.settingsPlatformSMS!) ??
                                          ""),
                                    ],
                                    if (item.settingsPlatformWhatsapp !=
                                        null) ...[
                                      const SizedBox(height: 10.0),
                                      Text("Whatsapp Setting",
                                          style: bodyFont.copyWith(
                                              fontWeight: FontWeight.bold)),
                                      const SizedBox(height: 4.0),
                                      Text(item.settingByPlatformReadable(
                                              item.settingsPlatformWhatsapp!) ??
                                          ""),
                                    ],
                                    const SizedBox(height: 10.0),
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
                                    const PopupMenuItem(
                                      value: "edit",
                                      child: Text("Edit"),
                                    ),
                                    PopupMenuItem(
                                      value: "delete",
                                      child: Text(
                                        "Delete Machine",
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
                    return Text(error.toString());
                  },
                  loading: () {
                    return const Center(child: CircularProgressIndicator());
                  },
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: onAddMachine,
        icon: const Icon(Icons.add),
        label: const Text("Add Machine"),
      ),
    );
  }
}
