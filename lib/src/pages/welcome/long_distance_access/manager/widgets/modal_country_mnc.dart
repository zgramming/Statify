import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../utils/sizes.dart';
import '../../../../../view_model/custom_provider/custom_form_provider.dart';
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
      builder: (context) => ModalAddCountryMNC(label: label),
    );
  }

  static void delete({
    required WidgetRef ref,
    required String labelCountry,
    required String labelMnc,
  }) {
    final form = ref.read(
      CustomFormProvider.machineConfigCountriesForm.notifier,
    );
    form.update((state) {
      final country = state.firstWhere(
        (element) => element.label == labelCountry,
      );
      final mncs =
          country.mncs.where((element) => element.label != labelMnc).toList();
      return state.map((e) {
        if (e.label == labelCountry) {
          return e.copyWith(mncs: mncs);
        }
        return e;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final country = ref.watch(CustomFormProvider.machineConfigCountriesForm
        .select(
            (value) => value.firstWhere((element) => element.label == label)));
    return AlertDialog(
      insetPadding: const EdgeInsets.all(16.0),
      title: const Text("Country MNC"),
      content: SizedBox(
        width: w(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            DataTable(
              columnSpacing: 28,
              columns: const [
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
                    return DataRow(cells: [
                      DataCell(Text(item.name)),
                      DataCell(Text(item.mcc)),
                      DataCell(Text(item.mnc)),
                      DataCell(
                        InkWell(
                          onTap: () => delete(
                            ref: ref,
                            labelCountry: label,
                            labelMnc: item.label,
                          ),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ]);
                  },
                ).toList()
              ],
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
