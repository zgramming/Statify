import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../injection.dart';
import '../../../router.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/row_body.dart';

class MachinePage extends ConsumerStatefulWidget {
  const MachinePage({super.key});

  @override
  ConsumerState<MachinePage> createState() => _MachinePageState();
}

class _MachinePageState extends ConsumerState<MachinePage> {
  @override
  void initState() {
    super.initState();
    final user = ref.read(authenticationNotifier).user;
    Future.microtask(() {
      ref.read(machineNotifier.notifier).getAll(user?.id ?? "");
    });
  }

  @override
  Widget build(BuildContext context) {
    final machine = ref.watch(machineNotifier).onGetAll;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const CustomAppbar(title: "Mesin"),
          Expanded(
            child: Builder(
              builder: (context) {
                return machine.when(
                  data: (data) {
                    return ListView.separated(
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final item = data[index];
                        return ListTile(
                          title: Text(item.license),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              RowBody(title: "Number", content: item.number),
                              RowBody(title: "Action", content: item.action),
                              RowBody(
                                title: "SMS Setting",
                                content: item.smsSetting,
                              ),
                              RowBody(
                                title: "Send",
                                content: item.send.toString(),
                              ),
                              RowBody(
                                title: "Replied",
                                content: item.replied.toString(),
                              ),
                              RowBody(
                                title: "Total Whatsapp",
                                content: item.whatsapps.length.toString(),
                              ),
                            ],
                          ),
                          trailing: PopupMenuButton(
                            itemBuilder: (context) {
                              return [
                                const PopupMenuItem(
                                  value: "edit",
                                  child: Text("Edit"),
                                ),
                              ];
                            },
                            onSelected: (value) async {
                              switch (value) {
                                case "edit":
                                  break;
                                default:
                              }
                            },
                          ),
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
        onPressed: () {
          context.pushNamed(routeMachineForm, pathParameters: {
            "id": "-1",
          });
        },
        icon: const Icon(Icons.add),
        label: const Text("Tambah Mesin"),
      ),
    );
  }
}
