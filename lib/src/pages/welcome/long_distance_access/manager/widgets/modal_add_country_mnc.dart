import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../model/model/machine/machine_config_countries.model.dart';
import '../../../../../utils/fonts.dart';
import '../../../../../utils/sizes.dart';
import '../../../../../utils/styles.dart';
import '../../../../../view_model/custom_provider/custom_form_provider.dart';
import '../../../../widgets/form_body_row.dart';

class ModalAddCountryMNC extends ConsumerStatefulWidget {
  const ModalAddCountryMNC({
    Key? key,
    required this.label,
  }) : super(key: key);
  final String label;

  @override
  ConsumerState<ModalAddCountryMNC> createState() => _ModalAddCountryMNCState();
}

class _ModalAddCountryMNCState extends ConsumerState<ModalAddCountryMNC> {
  final _formKey = GlobalKey<FormState>();
  final labelController = TextEditingController();
  final mccController = TextEditingController();
  final mncController = TextEditingController();

  Future<void> onSubmit() async {
    final validate = _formKey.currentState?.validate() ?? false;
    if (!validate) return;

    final form =
        ref.read(CustomFormProvider.machineConfigCountriesForm.notifier);
    final label = labelController.text;
    final mcc = mccController.text;
    final mnc = mncController.text;

    form.update((state) {
      final country =
          state.firstWhere((element) => element.label == widget.label);
      final model = MachineConfigCountriesMNCModel(
        status: 1,
        label: label,
        mcc: mcc,
        mnc: mnc,
        name: label,
      );
      final mncs = [...country.mncs, model];
      return state.map((e) {
        if (e.label == widget.label) {
          return e.copyWith(mncs: mncs);
        }
        return e;
      }).toList();
    });

    // Close Modal
    context.pop();
  }

  void init() {}

  @override
  void initState() {
    super.initState();

    Future.microtask(() => init());
  }

  @override
  void dispose() {
    labelController.dispose();
    mccController.dispose();
    mncController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(16.0),
      title: const Text("Add MNC"),
      content: SizedBox(
        width: w(context),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              FormBodyRow(
                title: "Label",
                child: TextFormField(
                  controller: labelController,
                  style: bodyFont.copyWith(fontSize: 14.0),
                  decoration: inputDecorationRounded().copyWith(
                    hintText: "Label",
                    border: const OutlineInputBorder(),
                    fillColor: Colors.transparent,
                    contentPadding: const EdgeInsets.all(8),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              FormBodyRow(
                title: "MCC",
                child: TextFormField(
                  controller: mccController,
                  style: bodyFont.copyWith(fontSize: 14.0),
                  decoration: inputDecorationRounded().copyWith(
                    hintText: "MCC",
                    border: const OutlineInputBorder(),
                    fillColor: Colors.transparent,
                    contentPadding: const EdgeInsets.all(8),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              FormBodyRow(
                title: "MNC",
                child: TextFormField(
                  controller: mncController,
                  style: bodyFont.copyWith(fontSize: 14.0),
                  decoration: inputDecorationRounded().copyWith(
                    hintText: "MNC",
                    border: const OutlineInputBorder(),
                    fillColor: Colors.transparent,
                    contentPadding: const EdgeInsets.all(8),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: onSubmit,
          child: const Text("Save"),
        ),
        TextButton(
          onPressed: () => context.pop(),
          child: const Text("Cancel"),
        ),
      ],
    );
  }
}
