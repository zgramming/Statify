import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../model/model/helper/props_provider/props_is_machine_config_operators_selected.model.dart';
import '../../../../../model/model/machine/machine_config_operator.model.dart';
import '../../../../../model/model/machine/machine_model.dart';
import '../../../../../utils/fonts.dart';
import '../../../../../utils/styles.dart';
import '../../../../../view_model/custom_notifier/machine_config_operators_setting.notifier.dart';
import 'modal_operator_item.dart';

class LDASettingConfigOperatorItem extends ConsumerStatefulWidget {
  const LDASettingConfigOperatorItem({
    Key? key,
    required this.cfgOperator,
    required this.machine,
  }) : super(key: key);

  final MachineConfigOperatorsModel cfgOperator;
  final MachineModel? machine;

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
  final arfcn5gController = TextEditingController();

  void onTap4g() async {
    final idMachine = widget.machine?.id ?? "";
    final result = await showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      builder: (context) => ModalOperatorItem(
        item: widget.cfgOperator,
        idMachine: idMachine,
      ),
    );

    if (result == null) return;
  }

  void onChangeAutoSwitch(String value) {
    final notifier = ref.read(machineConfigOperatorsSettingNotifier.notifier);
    notifier.updateAutoSwitch(item: widget.cfgOperator, value: value);
  }

  void onChange2gArfcn(String value) {
    final notifier = ref.read(machineConfigOperatorsSettingNotifier.notifier);
    notifier.update2GArfcn(item: widget.cfgOperator, value: value);
  }

  void onChange3gArfcn(String value) {
    final notifier = ref.read(machineConfigOperatorsSettingNotifier.notifier);
    notifier.update3GArfcn(item: widget.cfgOperator, value: value);
  }

  void onChange4gArfcn(String value) {
    final notifier = ref.read(machineConfigOperatorsSettingNotifier.notifier);
    notifier.update4GArfcn(item: widget.cfgOperator, value: value);
  }

  void onChange5gArfcn(String value) {
    final notifier = ref.read(machineConfigOperatorsSettingNotifier.notifier);
    notifier.update5GArfcn(item: widget.cfgOperator, value: value);
  }

  void onChecklistOperator(bool? value) {
    final notifier = ref.read(machineConfigOperatorsSettingNotifier.notifier);
    notifier.updateChecklist(widget.cfgOperator, value ?? false);
  }

  void init() {
    autoSwitchController.text = widget.cfgOperator.timeout ?? "";
    arfcn2gController.text = widget.cfgOperator.arfcn ?? "";
    arfcn3gController.text = widget.cfgOperator.threeGArfcn ?? "";
    arfcn4gController.text = widget.cfgOperator.lteArfcn ?? "";
    arfcn5gController.text = widget.cfgOperator.fiveGArfcn ?? "";
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
    arfcn5gController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final machine = widget.machine;
    final config = machine?.config;
    final is2GArfcnHidden = config?.arfcnHidden2g == "1";
    final is3GArfcnHidden = config?.arfcnHidden3g == "1";
    final is4GArfcnHidden = config?.arfcnHidden4g == "1";
    final is5GArfcnHidden = config?.arfcnHidden5g == "1";
    final textStyleInput = bodyFont.copyWith(fontSize: 10.0);

    final isSelectedOperators = ref.watch(
      isMachineConfigOperatorsSelectedProvider(
        PropsIsMachineConfigOperatorsSelectedModel(
          mcc: widget.cfgOperator.mcc ?? "",
          mnc: widget.cfgOperator.mnc ?? "",
        ),
      ),
    );
    const widthInput = 80.0;
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
        border: Border.all(color: Colors.grey.withOpacity(0.5)),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 2.0,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Checkbox.adaptive(
                  value: isSelectedOperators,
                  onChanged: onChecklistOperator,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  "${widget.cfgOperator.name} - ${widget.cfgOperator.mcc}${widget.cfgOperator.mnc} ",
                  style: bodyFont.copyWith(
                    fontSize: 14.0,
                  ),
                ),
              ),
            ],
          ),
          const Divider(),
          SizedBox(
            height: 60,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Wrap(
                spacing: 8,
                children: [
                  SizedBox(
                    width: widthInput,
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
                  if (!is2GArfcnHidden) ...[
                    SizedBox(
                      width: widthInput,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FittedBox(
                            child: Text(
                              config?.arfcnLabel2g ?? "2G ARFCN",
                              style: textStyleInput,
                            ),
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
                  ],
                  if (!is3GArfcnHidden) ...[
                    SizedBox(
                      width: widthInput,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FittedBox(
                            child: Text(
                              config?.arfcnLabel3g ?? "3G ARFCN",
                              style: textStyleInput,
                            ),
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
                  ],
                  if (!is4GArfcnHidden) ...[
                    SizedBox(
                      width: widthInput,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FittedBox(
                            child: Text(config?.arfcnLabel4g ?? "4G ARFCN",
                                style: textStyleInput),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            onTap: onTap4g,
                            readOnly: true,
                            controller: arfcn4gController,
                            style: bodyFont.copyWith(fontSize: 14.0),
                            decoration: inputDecorationRounded().copyWith(
                              hintText: "Enter 4G ARFCN",
                              border: const OutlineInputBorder(),
                              fillColor: Colors.grey.withOpacity(0.2),
                              contentPadding: const EdgeInsets.all(8),
                            ),
                            onChanged: onChange4gArfcn,
                          ),
                        ],
                      ),
                    ),
                  ],
                  if (!is5GArfcnHidden) ...[
                    SizedBox(
                      width: widthInput,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FittedBox(
                            child: Text(
                              config?.arfcnLabel5g ?? "5G ARFCN",
                              style: textStyleInput,
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: arfcn5gController,
                            style: bodyFont.copyWith(fontSize: 14.0),
                            decoration: inputDecorationRounded().copyWith(
                              hintText: "Enter 5G ARFCN",
                              border: const OutlineInputBorder(),
                              fillColor: Colors.transparent,
                              contentPadding: const EdgeInsets.all(8),
                            ),
                            onChanged: onChange5gArfcn,
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
