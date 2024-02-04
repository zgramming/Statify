import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../model/model/machine/machine_config_countries.model.dart';
import '../../../../../utils/sizes.dart';
import '../../../../../view_model/custom_notifier/machine_config_countries.notifier.dart';
import 'modal_add_country_mnc.dart';

class ModalCountryMNC extends ConsumerWidget {
  const ModalCountryMNC({
    Key? key,
    required this.label,
  }) : super(key: key);
  final String label;

  static void showModalAddCountryMNC(BuildContext context, String label) {
    showDialog(
      context: context,
      builder: (context) => ModalAddCountryMNC(countryName: label),
    );
  }

  static void delete({
    required WidgetRef ref,
    required MachineConfigCountriesMNCModel item,
  }) {
    final countriesNotifier = ref.read(machineConfigCountriesNotifier.notifier);
    countriesNotifier.removeMnc(item);
  }

  static void onChanged({
    required bool? value,
    required WidgetRef ref,
    required MachineConfigCountriesMNCModel item,
  }) {
    final countriesNotifier = ref.read(machineConfigCountriesNotifier.notifier);
    countriesNotifier.updateChecklistMnc(item);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final country = ref.watch(machineConfigCountriesByLabel(label));
    return AlertDialog(
      insetPadding: const EdgeInsets.all(16.0),
      title: const Text("Country MNC"),
      content: SizedBox(
        width: w(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 10,
                columns: const [
                  DataColumn(label: Text("#")),
                  DataColumn(label: Text("Name")),
                  DataColumn(label: Text("MCC")),
                  DataColumn(label: Text("MNC")),
                  DataColumn(label: Text("")),
                ],
                rows: [
                  ...List.generate(
                    country.mncs.length,
                    (index) {
                      final item = country.mncs[index];
                      return DataRow(
                        cells: [
                          DataCell(
                            Checkbox.adaptive(
                              value: item.status == 1,
                              onChanged: (val) => onChanged(
                                value: val,
                                ref: ref,
                                item: item,
                              ),
                              visualDensity: VisualDensity.compact,
                            ),
                          ),
                          DataCell(Text(item.name)),
                          DataCell(Text(item.mcc)),
                          DataCell(
                            Text(item.mnc),
                          ),
                          DataCell(
                            IconButton(
                              onPressed: () => delete(
                                ref: ref,
                                item: item,
                              ),
                              icon: const Icon(Icons.delete, color: Colors.red),
                            ),
                          ),
                        ],
                      );
                    },
                  ).toList()
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => showModalAddCountryMNC(context, label),
          child: const Text("Add"),
        ),
        TextButton(
          onPressed: () => context.pop(),
          child: const Text("Cancel"),
        ),
      ],
    );
  }
}
