import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../injection.dart';
import '../../../../../model/model/helper/form/form_machine_update_config.model.dart';
import '../../../../../model/model/machine/machine_config_2g_data.model.dart';
import '../../../../../utils/fonts.dart';
import '../../../../../utils/sizes.dart';
import '../../../../../utils/styles.dart';
import '../../../../../view_model/custom_provider/custom_provider.dart';

class LDASettingModalGSM extends ConsumerStatefulWidget {
  const LDASettingModalGSM({
    Key? key,
    required this.idMachine,
  }) : super(key: key);

  final String idMachine;

  @override
  ConsumerState<LDASettingModalGSM> createState() => _LDASettingModalGSMState();
}

class _LDASettingModalGSMState extends ConsumerState<LDASettingModalGSM> {
  List<MachineConfig2GDataModel> mappingTwoGData(String? data) {
    if (data == null) return [];

    final splitted = data.split("-").where((e) => e.isNotEmpty).toList();

    if (splitted.isEmpty) return [];

    final mappedSplitted = splitted.map((e) {
      final split = e.split("_");
      final ip = split[0];
      final mcc = split[1];
      final mnc = split[2];
      final arfcn = split[3];
      return MachineConfig2GDataModel(
        ip: ip,
        mcc: mcc,
        mnc: mnc,
        arfcn: arfcn,
      );
    }).toList();
    return mappedSplitted;
  }

  void onDelete() async {
    final machine =
        ref.read(CustomProvider.getMachineByIdProvider(widget.idMachine));
    final config = machine?.config;
    if (config == null) return;

    final notifier = ref.read(machineNotifier.notifier);
    final form = FormMachineUpdateConfigModel.fromMachineConfigModel(
      widget.idMachine,
      config.copyWith(
        twoGData: "",
        twoGDataChanged: "1",
      ),
    );

    await notifier.updateConfig(form);

    if (context.mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final twoGData = ref.watch(
        CustomProvider.getMachineByIdProvider(widget.idMachine)
            .select((value) => value?.config?.twoGData));

    final dataColumnStyle = bodyFont.copyWith(
      fontSize: 12.0,
      fontWeight: FontWeight.bold,
    );
    final dataRowStyle = bodyFont.copyWith(fontSize: 10.0);
    return AlertDialog(
      insetPadding: const EdgeInsets.all(8),
      content: SizedBox(
        width: w(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                "2G Data",
                style: bodyFont.copyWith(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Container(
              constraints: BoxConstraints(
                maxHeight: h(context) / 1.5,
              ),
              child: SingleChildScrollView(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: [
                      DataColumn(
                        label: Text("IP", style: dataColumnStyle),
                      ),
                      DataColumn(
                        label: Text("MCC", style: dataColumnStyle),
                      ),
                      DataColumn(
                        label: Text("MNC", style: dataColumnStyle),
                      ),
                      DataColumn(
                        label: Text("2G ARFCN", style: dataColumnStyle),
                      ),
                    ],
                    rows: [
                      ...mappingTwoGData(twoGData)
                          .map(
                            (e) => DataRow(
                              cells: [
                                DataCell(Text(e.ip, style: dataRowStyle)),
                                DataCell(Text(e.mcc, style: dataRowStyle)),
                                DataCell(Text(e.mnc, style: dataRowStyle)),
                                DataCell(Text(e.arfcn, style: dataRowStyle)),
                              ],
                            ),
                          )
                          .toList(),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: onDelete,
              style: elevatedButtonStyle(backgroundColor: Colors.red),
              child: const Text("DELETE"),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: const Text("Cancel"),
        ),
      ],
    );
  }
}
