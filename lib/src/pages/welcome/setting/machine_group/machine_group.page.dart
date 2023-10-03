import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../injection.dart';
import '../../../../model/model/machine/machine_model.dart';
import '../../../../model/model/machine_group/machine_group.model.dart';
import '../../../../router.dart';
import '../../../../utils/fonts.dart';
import '../../../../utils/functions.dart';
import '../../../../view_model/custom_notifier/get_alll_machine_group.notifier.dart';
import '../../../widgets/async_error_builder.dart';
import '../../../widgets/custom_appbar.dart';

class MachineGroupPage extends ConsumerStatefulWidget {
  const MachineGroupPage({super.key});

  @override
  ConsumerState<MachineGroupPage> createState() => _MachineGroupPageState();
}

class _MachineGroupPageState extends ConsumerState<MachineGroupPage> {
  void onAdd() {
    context.pushNamed(
      routeMachineGroupForm,
      pathParameters: {"id": "-1"},
    );
  }

  @override
  Widget build(BuildContext context) {
    final machineGroupAsync =
        ref.watch(getAllMachineGroupFutureProvider).unwrapPrevious();

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const CustomAppbar(
            title: "Machine Group",
            withBackButton: true,
          ),
          Expanded(
            child: Builder(
              builder: (context) {
                return machineGroupAsync.when(
                  data: (data) {
                    final items = data.$1;
                    if (items.isEmpty) {
                      return Center(
                        child: Text(
                          "No Data",
                          style: bodyFont.copyWith(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }

                    return ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => const Divider(),
                      physics: const BouncingScrollPhysics(),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];

                        return _MachineGroupItem(item: item, index: index);
                      },
                    );
                  },
                  error: (error, stackTrace) => AsyncErrorBuilder(
                    error: error.toString(),
                    onRetry: () =>
                        ref.refresh(getAllMachineGroupFutureProvider),
                  ),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onAdd,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _MachineGroupItem extends ConsumerStatefulWidget {
  const _MachineGroupItem({
    Key? key,
    required this.item,
    required this.index,
  }) : super(key: key);

  final MachineGroupModel item;
  final int index;

  @override
  ConsumerState<_MachineGroupItem> createState() => _MachineGroupItemState();
}

class _MachineGroupItemState extends ConsumerState<_MachineGroupItem> {
  void onEdit() {
    context.pushNamed(
      routeMachineGroupForm,
      pathParameters: {"id": widget.item.id.toString()},
    );
  }

  Future<void> onDelete() async {
    final notifier = ref.read(machineGroupNotifier.notifier);
    final result = await notifier.delete(machineGroupId: widget.item.id);
    result.onDelete.when(
      data: (data) {
        if (data == null) return;

        showSnackbar(
          context: context,
          message: "Delete Success ${data.name}",
          backgroundColor: Colors.green,
        );

        // Reload machine group
        ref.invalidate(getAllMachineGroupFutureProvider);
      },
      error: (error, stackTrace) => showSnackbar(
        context: context,
        message: error.toString(),
        backgroundColor: Colors.red,
      ),
      loading: () => showSnackbar(
        context: context,
        message: "Loading...",
        backgroundColor: Colors.blue,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final machines = widget.item.machines ?? <MachineModel>[];
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ListTile(
        onTap: onEdit,
        leading: CircleAvatar(
          radius: 15.0,
          child: Text("${widget.index + 1}"),
        ),
        title: Text(widget.item.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8.0),
            for (final machine in machines) ...[
              Text(
                machine.name,
                style: bodyFont.copyWith(
                  fontSize: 12.0,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8.0),
            ],
          ],
        ),
        trailing: Wrap(
          children: [
            IconButton(
              onPressed: onDelete,
              icon: const Icon(Icons.delete, color: Colors.red),
            ),
            IconButton(
              onPressed: onEdit,
              icon: const Icon(
                Icons.edit,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
