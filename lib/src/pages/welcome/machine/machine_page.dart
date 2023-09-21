import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../injection.dart';
import '../../../model/model/machine/machine_model.dart';
import '../../../router.dart';
import '../../../utils/fonts.dart';
import '../../../utils/functions.dart';
import '../../../view_model/custom_provider/custom_provider.dart';
import '../../widgets/circle_index_number.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/row_body.dart';

class _MachinePageItem extends ConsumerStatefulWidget {
  const _MachinePageItem({
    required this.item,
    required this.index,
  });
  final MachineModel item;
  final int index;

  @override
  ConsumerState<_MachinePageItem> createState() => _MachinePageItemState();
}

class _MachinePageItemState extends ConsumerState<_MachinePageItem> {
  Future<void> onSelected(String value) async {
    final item = widget.item;
    if (value == "survey") {
      context.pushNamed(
        routeSurveyPage,
        pathParameters: {
          "idMachine": item.id,
        },
      );
    }

    if (value == "delete") {
      final isDelete = await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Delete Machine"),
            content: const Text(
              "Are you sure want to delete this machine?",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text("Delete"),
              ),
            ],
          );
        },
      );

      if (isDelete == true) {
        final result = await ref.read(machineNotifier.notifier).delete(
              machineId: item.id,
            );
        result.onDelete.when(
          data: (data) {
            if (data == null) {
              return;
            }
            showSnackbar(
              context: context,
              message: "Success delete machine ${item.name}",
              backgroundColor: Colors.green,
            );
          },
          error: (error, stackTrace) {
            showSnackbar(
              context: context,
              message: error.toString(),
              backgroundColor: Colors.red,
            );
          },
          loading: () {},
        );
      }
    }
  }

  Future<void> onTapMachine(MachineModel item) async {
    context.pushNamed(
      routeMachineForm,
      pathParameters: {
        "id": item.id,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final textStyle = bodyFont.copyWith(
      color: Colors.grey[700],
      fontSize: 10.0,
    );
    final sim1ORsim2 = ref.watch(getSIM1orSIM2Provider(item.number));
    const radius = 30.0;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Stack(
        children: [
          ListTile(
            onTap: () => onTapMachine(item),
            contentPadding: const EdgeInsets.all(16.0),
            leading: CircleIndexNumber(
              radius: radius,
              index: widget.index,
            ),
            title: Text(
              item.name,
              style: headerFont.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 8.0),
                RowBody(
                  title: "No Serial Machine",
                  content: item.serialNumber,
                  titleFlex: 7,
                  contentFlex: 5,
                  contentStyle: textStyle,
                  titleStyle: textStyle,
                ),
                const SizedBox(height: 4.0),
                RowBody(
                  title: "Activation License",
                  content: item.license,
                  titleFlex: 7,
                  contentFlex: 5,
                  contentStyle: textStyle,
                  titleStyle: textStyle,
                ),
                const SizedBox(height: 4.0),
                RowBody(
                  title: "Machine Phone Number",
                  content: "$sim1ORsim2 (${item.number})",
                  titleFlex: 7,
                  contentFlex: 5,
                  contentStyle: textStyle,
                  titleStyle: textStyle,
                ),
                const SizedBox(height: 4.0),
              ],
            ),
          ),
          Positioned(
            top: 0.0,
            right: 0.0,
            child: PopupMenuButton(
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(
                    value: 'survey',
                    child: Text(
                      "Survey",
                    ),
                  ),
                  PopupMenuItem(
                    value: "delete",
                    child: Text(
                      "Delete",
                      style: bodyFont.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ];
              },
              onSelected: onSelected,
              child: const Icon(Icons.more_vert),
            ),
          ),
        ],
      ),
    );
  }
}

class MachinePage extends ConsumerStatefulWidget {
  const MachinePage({super.key});

  @override
  ConsumerState<MachinePage> createState() => _MachinePageState();
}

class _MachinePageState extends ConsumerState<MachinePage> {
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

  @override
  Widget build(BuildContext context) {
    final machines = ref.watch(machineNotifier).items;
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
                if (machines.isEmpty) {
                  return const Center(
                    child: Text("Empty Machine"),
                  );
                }

                return ListView.separated(
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: machines.length,
                  itemBuilder: (context, index) {
                    final item = machines[index];
                    return _MachinePageItem(
                      item: item,
                      index: index + 1,
                    );
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
