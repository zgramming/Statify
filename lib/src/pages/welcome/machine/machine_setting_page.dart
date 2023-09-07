// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../injection.dart';
import '../../../model/model/machine_setting/machine_setting_model.dart';
import '../../../router.dart';
import '../../../utils/enum.dart';
import '../../widgets/custom_appbar.dart';

class MachineSettingPage extends ConsumerStatefulWidget {
  const MachineSettingPage({
    Key? key,
    required this.idMachine,
  }) : super(key: key);
  final String idMachine;

  @override
  ConsumerState<MachineSettingPage> createState() => _MachineSettingPageState();
}

class _MachineSettingPageState extends ConsumerState<MachineSettingPage> {
  Future<void> onSelected(
    String value, {
    required MachineSettingModel item,
  }) async {
    switch (value) {
      case "edit":
        final idMachine = widget.idMachine;
        final id = item.id;
        context.pushNamed(routeMachineSettingForm, pathParameters: {
          "idMachine": idMachine,
          "id": id,
        });
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
            title: "Machine Setting",
            withBackButton: true,
          ),
          Expanded(
            child: Builder(
              builder: (context) {
                final settingAsync = ref
                    .watch(machineSettingNotifier(widget.idMachine))
                    .onGetAll;
                return settingAsync.when(
                  data: (items) {
                    return ListView.separated(
                      padding: const EdgeInsets.all(16.0),
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        final order = index + 1;
                        return Stack(
                          children: [
                            Card(
                              margin: EdgeInsets.zero,
                              child: ListTile(
                                leading: Text("$order"),
                                title: Text(
                                  item.platform.valueStringReadable,
                                ),
                                subtitle: Text(
                                  item.settingByPlatformReadable ?? "",
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
                                      value: "edit",
                                      child: Text("Edit"),
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
                        style: const TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    );
                  },
                  loading: () {
                    return const Center(child: CircularProgressIndicator());
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
