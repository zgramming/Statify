import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../model/model/machine/machine_config_4g_data.model.dart';
import '../../../../../utils/fonts.dart';
import '../../../../../utils/sizes.dart';
import '../../../../../view_model/custom_provider/custom_provider.dart';

class LDASettingModalLTE extends ConsumerWidget {
  const LDASettingModalLTE({
    Key? key,
    required this.idMachine,
  }) : super(key: key);

  final String idMachine;

  static List<MachineConfig4GDataModel> mapping4GData(String? data) {
    if (data == null) return [];
    final splitted = data.split("-");
    final mappedSplitted = splitted.map((e) {
      // 192.168.1.91=60_510_10_1850_111_1111_11111*60_510_10_1852_222_2222_22222
      final [ip, combinationItems] = e.split("=");
      final splitted = combinationItems.split("*");
      MachineConfig4GDataModel model = MachineConfig4GDataModel(
        ip: ip,
        interval: "",
        mcc: "",
        mnc: "",
        arfcn: "",
        pci: "",
        lac: "",
        cellId: "",
      );

      for (final combination in splitted) {
        final split = combination.split("_");
        final interval = split[0];
        final mcc = split[1];
        final mnc = split[2];
        final arfcn = split[3];
        final pci = split[4];
        final lac = split[5];
        final cellId = split[6];

        model = model.copyWith(
          interval: interval,
          mcc: mcc,
          mnc: mnc,
          arfcn: arfcn,
          pci: pci,
          lac: lac,
          cellId: cellId,
        );
      }

      return model;
    }).toList();
    return mappedSplitted;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fourGData = ref.watch(
      CustomProvider.getMachineByIdProvider(idMachine).select(
        (value) => value?.config?.fourGData,
      ),
    );

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
                "GSM",
                style: bodyFont.copyWith(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(
                    label: Text("IP", style: dataColumnStyle),
                  ),
                  DataColumn(
                    label: Text("INTERVAL", style: dataColumnStyle),
                  ),
                  DataColumn(
                    label: Text("MCC", style: dataColumnStyle),
                  ),
                  DataColumn(
                    label: Text("MNC", style: dataColumnStyle),
                  ),
                  DataColumn(
                    label: Text("4G ARFCN", style: dataColumnStyle),
                  ),
                  DataColumn(
                    label: Text("PCI", style: dataColumnStyle),
                  ),
                  DataColumn(
                    label: Text("LAC", style: dataColumnStyle),
                  ),
                  DataColumn(
                    label: Text("CELL ID", style: dataColumnStyle),
                  ),
                ],
                rows: [
                  ...mapping4GData(fourGData)
                      .map(
                        (e) => DataRow(
                          cells: [
                            DataCell(Text(e.ip, style: dataRowStyle)),
                            DataCell(Text(e.interval, style: dataRowStyle)),
                            DataCell(Text(e.mcc, style: dataRowStyle)),
                            DataCell(Text(e.mnc, style: dataRowStyle)),
                            DataCell(Text(e.arfcn, style: dataRowStyle)),
                            DataCell(Text(e.pci, style: dataRowStyle)),
                            DataCell(Text(e.lac, style: dataRowStyle)),
                            DataCell(Text(e.cellId, style: dataRowStyle)),
                          ],
                        ),
                      )
                      .toList(),
                ],
              ),
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
