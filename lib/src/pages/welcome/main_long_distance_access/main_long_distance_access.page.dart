import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../model/model/machine/machine_model.dart';
import '../../../router.dart';
import '../../../utils/enum.dart';
import '../../../utils/fonts.dart';
import '../../../utils/functions.dart';
import '../../../view_model/custom_notifier/get_alll_machine_group.notifier.dart';
import '../../../view_model/custom_provider/custom_provider.dart';
import '../../widgets/async_error_builder.dart';
import '../../widgets/circle_index_number.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/row_body.dart';

class MainLongDistanceAccessPage extends ConsumerWidget {
  const MainLongDistanceAccessPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupsAsync =
        ref.watch(getAllMachineGroupFutureProvider).unwrapPrevious();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const CustomAppbar(title: "Long Distance Control"),
        Expanded(
          child: Builder(
            builder: (ctx) {
              return groupsAsync.when(
                data: (data) {
                  final groups = data.$1;
                  final machinesNotHaveGroup = data.$2;

                  return RefreshIndicator(
                    onRefresh: () async =>
                        ref.invalidate(getAllMachineGroupFutureProvider),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(
                        left: 16.0,
                        right: 16.0,
                        bottom: 80.0,
                      ),
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (groups.isEmpty &&
                              machinesNotHaveGroup.isEmpty) ...[
                            const SizedBox(height: 16.0),
                            Center(
                              child: Text(
                                "No Machine Found, Please Add Machine",
                                style: headerFont.copyWith(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                          if (groups.isNotEmpty) ...[
                            ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: groups.length,
                              shrinkWrap: true,
                              separatorBuilder: (context, index) =>
                                  const Divider(),
                              itemBuilder: (context, index) {
                                final item = groups[index];
                                final machines = item.machines ?? [];
                                return Card(
                                  margin: const EdgeInsets.only(),
                                  elevation: 5,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "Group : ${item.name}",
                                                style: bodyFontBold.copyWith(
                                                    fontSize: 16.0),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8.0),
                                        ListView.separated(
                                          itemCount: machines.length,
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          separatorBuilder: (context, index) =>
                                              const Divider(),
                                          itemBuilder: (context, index) {
                                            final item = machines[index];
                                            return _MachineItem(
                                              item: item,
                                              index: index,
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                          if (machinesNotHaveGroup.isNotEmpty) ...[
                            ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: machinesNotHaveGroup.length,
                              separatorBuilder: (context, index) =>
                                  const Divider(),
                              itemBuilder: (context, index) {
                                final item = machinesNotHaveGroup[index];
                                return _MachineItem(item: item, index: index);
                              },
                            ),
                          ]
                        ],
                      ),
                    ),
                  );
                },
                error: (error, stackTrace) => AsyncErrorBuilder(
                  error: error.toString(),
                  onRetry: () =>
                      ref.invalidate(getAllMachineGroupFutureProvider),
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _MachineItem extends ConsumerWidget {
  const _MachineItem({
    Key? key,
    required this.item,
    required this.index,
  }) : super(key: key);

  final MachineModel item;
  final int index;

  onMachineTap(BuildContext context, MachineModel item) {
    context.pushNamed(routeMachineLongDistanceAccess, pathParameters: {
      "idMachine": item.id,
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sim1ORsim2 =
        ref.watch(CustomProvider.getSIM1orSIM2Provider(item.number));
    final isOffline = item.status == MachineStatusEnum.offline;

    final config = item.config;
    final totalSent = config?.count ?? 0;
    final totalTask = config?.taskCount ?? 0;
    final isWorking = (config?.start ?? "0") == "1";

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: const BorderSide(color: Colors.grey, width: 1.0),
      ),
      margin: const EdgeInsets.only(),
      child: InkWell(
        onTap: () => onMachineTap(context, item),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Machine : ${item.name}",
                style: bodyFontBold.copyWith(fontSize: 14.0),
              ),
              const SizedBox(height: 8.0),
              RowBody(
                title: "Machine Phone Number",
                content: sim1ORsim2,
                titleFlex: 2,
                contentFlex: 1,
                titleStyle: bodyFont.copyWith(fontSize: 14.0),
                contentStyle: bodyFont.copyWith(fontSize: 14.0),
              ),
              const SizedBox(height: 16.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleIndexNumber(
                          radius: 24.0,
                          index: index,
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 6.0,
                              backgroundColor:
                                  isOffline ? Colors.grey : Colors.green,
                            ),
                            const SizedBox(width: 4.0),
                            Text(
                              item.status.valueStringReadable,
                              textAlign: TextAlign.center,
                              style: bodyFont.copyWith(
                                fontSize: 10.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    flex: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RowBody(
                          title: "Total Sent",
                          content: "$totalSent",
                          titleFlex: 2,
                          titleStyle: bodyFont.copyWith(fontSize: 12.0),
                          contentStyle: bodyFont.copyWith(fontSize: 12.0),
                        ),
                        const SizedBox(height: 8.0),
                        RowBody(
                          title: "Status",
                          content: isWorking ? "Working" : "Stopped",
                          titleFlex: 2,
                          titleStyle: bodyFont.copyWith(fontSize: 12.0),
                          contentStyle: bodyFont.copyWith(fontSize: 12.0),
                        ),
                        const SizedBox(height: 8.0),
                        RowBody(
                          title: "Task",
                          content: "$totalTask",
                          titleFlex: 2,
                          titleStyle: bodyFont.copyWith(fontSize: 12.0),
                          contentStyle: bodyFont.copyWith(fontSize: 12.0),
                        ),
                        const SizedBox(height: 8.0),
                        RowBody(
                          title: "Connected",
                          content: textMachineConnectOrDisconnected(config),
                          titleFlex: 2,
                          titleStyle: bodyFont.copyWith(fontSize: 12.0),
                          contentStyle: bodyFont.copyWith(fontSize: 12.0),
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
    );
  }
}
