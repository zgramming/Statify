import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../model/model/machine/machine_config_operator.model.dart';
import '../../../../../utils/fonts.dart';
import '../../../../../utils/styles.dart';
import '../../../../../view_model/custom_provider/custom_form_provider.dart';
import '../../../../widgets/form_body_row.dart';

class ModalOperatorItem extends ConsumerStatefulWidget {
  const ModalOperatorItem({
    Key? key,
    required this.item,
    required this.idMachine,
  }) : super(key: key);

  final MachineConfigOperatorsModel item;
  final String idMachine;

  @override
  ConsumerState<ModalOperatorItem> createState() => _ModalOperatorItemState();
}

class _ModalOperatorItemState extends ConsumerState<ModalOperatorItem> {
  final _formKey = GlobalKey<FormState>();

  final arfcnController = TextEditingController();
  final pciController = TextEditingController();
  final tacController = TextEditingController();
  final cellIdController = TextEditingController();
  final plmnController = TextEditingController();
  final downgradeController = TextEditingController();
  final rotationTimeController = TextEditingController();

  bool isDefault = false;

  Future<void> onClose() async {
    final validate = _formKey.currentState?.validate() ?? false;

    if (!validate) {
      return;
    }

    final form =
        ref.read(CustomFormProvider.ldaSettingForm(widget.idMachine).notifier);
    form.update(
      (state) {
        final operators = state.operators.map((e) {
          if (e.mcc == widget.item.mcc && e.mnc == widget.item.mnc) {
            return e.copyWith(
              arfcn: arfcnController.text,
              ltePci: pciController.text,
              lteTac: tacController.text,
              lteCellId: cellIdController.text,
              ltePlmn: plmnController.text,
              lteDowngrade: downgradeController.text,
              lteRotationTime: rotationTimeController.text,
              operatorDefault: isDefault ? "true" : "false",
            );
          }

          return e;
        }).toList();

        return state.copyWith(operators: operators);
      },
    );

    context.pop();
  }

  void init() {
    arfcnController.text = widget.item.arfcn.toString();
    pciController.text = widget.item.ltePci.toString();
    tacController.text = widget.item.lteTac.toString();
    cellIdController.text = widget.item.lteCellId.toString();
    plmnController.text = widget.item.ltePlmn.toString();
    downgradeController.text = widget.item.lteDowngrade.toString();
    rotationTimeController.text = widget.item.lteRotationTime.toString();
    isDefault = (widget.item.operatorDefault ?? "false") == "true";

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => init());
  }

  @override
  void dispose() {
    arfcnController.dispose();
    pciController.dispose();
    tacController.dispose();
    cellIdController.dispose();
    plmnController.dispose();
    downgradeController.dispose();
    rotationTimeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "4G ${widget.item.name}",
              style: headerFontBold.copyWith(fontSize: 24.0),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            FormBodyRow(
              title: "ARFCN",
              child: TextFormField(
                controller: arfcnController,
                style: bodyFont.copyWith(fontSize: 14.0),
                decoration: inputDecorationRounded().copyWith(
                  hintText: "ARFCN",
                  border: const OutlineInputBorder(),
                  fillColor: Colors.transparent,
                  contentPadding: const EdgeInsets.all(8),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "ARFCN is required";
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 8),
            FormBodyRow(
              title: "PCI",
              child: TextFormField(
                controller: pciController,
                style: bodyFont.copyWith(fontSize: 14.0),
                decoration: inputDecorationRounded().copyWith(
                  hintText: "PCI",
                  border: const OutlineInputBorder(),
                  fillColor: Colors.transparent,
                  contentPadding: const EdgeInsets.all(8),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "PCI is required";
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 8),
            FormBodyRow(
              title: "TAC",
              child: TextFormField(
                controller: tacController,
                style: bodyFont.copyWith(fontSize: 14.0),
                decoration: inputDecorationRounded().copyWith(
                  hintText: "TAC",
                  border: const OutlineInputBorder(),
                  fillColor: Colors.transparent,
                  contentPadding: const EdgeInsets.all(8),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "TAC is required";
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 8),
            FormBodyRow(
              title: "Cell ID",
              child: TextFormField(
                controller: cellIdController,
                style: bodyFont.copyWith(fontSize: 14.0),
                decoration: inputDecorationRounded().copyWith(
                  hintText: "Cell ID",
                  border: const OutlineInputBorder(),
                  fillColor: Colors.transparent,
                  contentPadding: const EdgeInsets.all(8),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Cell ID is required";
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 8),
            FormBodyRow(
              title: "PLMN",
              child: TextFormField(
                controller: plmnController,
                style: bodyFont.copyWith(fontSize: 14.0),
                decoration: inputDecorationRounded().copyWith(
                  hintText: "PLMN",
                  border: const OutlineInputBorder(),
                  fillColor: Colors.transparent,
                  contentPadding: const EdgeInsets.all(8),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "PLMN is required";
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 8),
            FormBodyRow(
              title: "Downgrade",
              child: TextFormField(
                controller: downgradeController,
                style: bodyFont.copyWith(fontSize: 14.0),
                decoration: inputDecorationRounded().copyWith(
                  hintText: "Downgrade",
                  border: const OutlineInputBorder(),
                  fillColor: Colors.transparent,
                  contentPadding: const EdgeInsets.all(8),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Downgrade is required";
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 8),
            FormBodyRow(
              title: "Rotation Time",
              child: TextFormField(
                controller: rotationTimeController,
                style: bodyFont.copyWith(fontSize: 14.0),
                decoration: inputDecorationRounded().copyWith(
                  hintText: "Rotation Time",
                  border: const OutlineInputBorder(),
                  fillColor: Colors.transparent,
                  contentPadding: const EdgeInsets.all(8),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Rotation Time is required";
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Checkbox(
                  value: isDefault,
                  onChanged: (value) {
                    setState(() => isDefault = value ?? false);
                  },
                ),
                const Text("Default"),
              ],
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: onClose,
              child: const Text("Close"),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
