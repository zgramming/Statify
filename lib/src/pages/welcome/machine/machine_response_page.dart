// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../injection.dart';
import '../../../router.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/row_body.dart';

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
              final settingsAsync =
                  ref.watch(machineResponseNotifier(widget.idMachine)).onGetAll;

              return settingsAsync.when(
                data: (items) {
                  return ListView.separated(
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    padding: const EdgeInsets.all(16.0),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return ListTile(
                        title: Text(item.key),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RowBody(title: "Value", content: item.value),
                            RowBody(
                              title: "Type",
                              content: item.type,
                            ),
                          ],
                        ),
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
          context.pushNamed(routeMachineResponseSettingForm, pathParameters: {
            "idMachine": widget.idMachine,
            "id": "-1",
          });
        },
        label: const Text("Tambah Response"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
