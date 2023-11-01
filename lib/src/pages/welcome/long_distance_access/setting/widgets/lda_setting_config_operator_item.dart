import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../model/model/machine/machine_config_operator.model.dart';
import '../../../../../utils/fonts.dart';
import '../../../../../utils/styles.dart';
import '../../../../../view_model/custom_provider/custom_form_provider.dart';
import 'modal_operator_item.dart';

class LDASettingConfigOperatorItem extends ConsumerStatefulWidget {
  const LDASettingConfigOperatorItem({
    Key? key,
    required this.idMachine,
    required this.e,
  }) : super(key: key);

  final String idMachine;
  final MachineConfigOperatorsModel e;

  @override
  ConsumerState<LDASettingConfigOperatorItem> createState() =>
      LDASettingConfigOperatorItemState();
}

class LDASettingConfigOperatorItemState
    extends ConsumerState<LDASettingConfigOperatorItem> {
  final autoSwitchController = TextEditingController();
  final arfcn2gController = TextEditingController();
  final arfcn3gController = TextEditingController();
  final arfcn4gController = TextEditingController();

  void onTap4g() async {
    final result = await showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      builder: (context) => ModalOperatorItem(
        item: widget.e,
        idMachine: widget.idMachine,
      ),
    );

    if (result == null) return;
  }

  void onChangeAutoSwitch(String value) {
    final form =
        ref.read(CustomFormProvider.ldaSettingForm(widget.idMachine).notifier);
    form.update(
      (state) {
        final prevOperators = state.operators.map((e) {
          if (e.mcc == widget.e.mcc && e.mnc == widget.e.mnc) {
            return e.copyWith(timeout: value);
          }
          return e;
        }).toList();
        return state.copyWith(operators: prevOperators);
      },
    );
  }

  void onChange2gArfcn(String value) {
    final form =
        ref.read(CustomFormProvider.ldaSettingForm(widget.idMachine).notifier);
    form.update(
      (state) {
        final prevOperators = state.operators.map((e) {
          if (e.mcc == widget.e.mcc && e.mnc == widget.e.mnc) {
            return e.copyWith(arfcn: value);
          }
          return e;
        }).toList();
        return state.copyWith(operators: prevOperators);
      },
    );
  }

  void onChange3gArfcn(String value) {
    final form =
        ref.read(CustomFormProvider.ldaSettingForm(widget.idMachine).notifier);
    form.update(
      (state) {
        final prevOperators = state.operators.map((e) {
          if (e.mcc == widget.e.mcc && e.mnc == widget.e.mnc) {
            return e.copyWith(threeGArfcn: value);
          }
          return e;
        }).toList();
        return state.copyWith(operators: prevOperators);
      },
    );
  }

  void onChange4gArfcn(String value) {
    final form =
        ref.read(CustomFormProvider.ldaSettingForm(widget.idMachine).notifier);
    form.update(
      (state) {
        final prevOperators = state.operators.map((e) {
          if (e.mcc == widget.e.mcc && e.mnc == widget.e.mnc) {
            return e.copyWith(lteArfcn: value);
          }
          return e;
        }).toList();
        return state.copyWith(operators: prevOperators);
      },
    );
  }

  void init() {
    autoSwitchController.text = widget.e.timeout ?? "";
    arfcn2gController.text = widget.e.arfcn ?? "";
    arfcn3gController.text = widget.e.threeGArfcn ?? "";
    arfcn4gController.text = widget.e.lteArfcn ?? "";
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => init());
  }

  @override
  void dispose() {
    autoSwitchController.dispose();
    arfcn2gController.dispose();
    arfcn3gController.dispose();
    arfcn4gController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyleInput = bodyFont.copyWith(fontSize: 10.0);
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "${widget.e.name} - ${widget.e.ltePlmn} ",
              style: bodyFont.copyWith(
                fontSize: 14.0,
              ),
            ),
            const Divider(),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Auto Switch",
                        style: textStyleInput,
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: autoSwitchController,
                        style: bodyFont.copyWith(fontSize: 14.0),
                        decoration: inputDecorationRounded().copyWith(
                          hintText: "Enter auto switch",
                          border: const OutlineInputBorder(),
                          fillColor: Colors.transparent,
                          contentPadding: const EdgeInsets.all(8),
                        ),
                        onChanged: onChangeAutoSwitch,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "2G ARFCN",
                        style: textStyleInput,
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: arfcn2gController,
                        style: bodyFont.copyWith(fontSize: 14.0),
                        decoration: inputDecorationRounded().copyWith(
                          hintText: "Enter 2G ARFCN",
                          border: const OutlineInputBorder(),
                          fillColor: Colors.transparent,
                          contentPadding: const EdgeInsets.all(8),
                        ),
                        onChanged: onChange2gArfcn,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "3G ARFCN",
                        style: textStyleInput,
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: arfcn3gController,
                        style: bodyFont.copyWith(fontSize: 14.0),
                        decoration: inputDecorationRounded().copyWith(
                          hintText: "Enter 3G ARFCN",
                          border: const OutlineInputBorder(),
                          fillColor: Colors.transparent,
                          contentPadding: const EdgeInsets.all(8),
                        ),
                        onChanged: onChange3gArfcn,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "4G ARFCN",
                        style: textStyleInput,
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        onTap: onTap4g,
                        readOnly: true,
                        controller: arfcn4gController,
                        style: bodyFont.copyWith(fontSize: 14.0),
                        decoration: inputDecorationRounded().copyWith(
                          hintText: "Enter 4G ARFCN",
                          border: const OutlineInputBorder(),
                          fillColor: Colors.transparent,
                          contentPadding: const EdgeInsets.all(8),
                        ),
                        onChanged: onChange4gArfcn,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
