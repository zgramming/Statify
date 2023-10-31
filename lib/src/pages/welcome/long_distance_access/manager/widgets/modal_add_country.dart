import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../model/model/helper/form/form_machine_config_country_mnc.model.dart';
import '../../../../../utils/fonts.dart';
import '../../../../../utils/styles.dart';
import '../../../../../view_model/custom_provider/custom_form_provider.dart';
import '../../../../widgets/form_row_body.dart';

class ModalAddCountryLDAManager extends ConsumerStatefulWidget {
  const ModalAddCountryLDAManager({
    super.key,
  });

  @override
  ConsumerState<ModalAddCountryLDAManager> createState() =>
      _ModalAddCountryLDAManagerState();
}

class _ModalAddCountryLDAManagerState
    extends ConsumerState<ModalAddCountryLDAManager> {
  final _formKey = GlobalKey<FormState>();
  final labelController = TextEditingController();

  Future<void> onSubmit() async {
    final validate = _formKey.currentState?.validate() ?? false;
    if (!validate) {
      return;
    }

    final form = ref.read(CustomFormProvider.machineConfigCountries.notifier);
    final label = labelController.text;
    form.update((state) {
      final isExists = state.any((element) => element.label == label);
      if (isExists) {
        return state;
      }
      final newState = [
        ...state,
        FormMachineConfigCountryMnc(label: label, name: label)
      ];

      return newState;
    });

    // Close modal
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add Country"),
      content: Form(
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
          ],
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
