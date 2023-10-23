import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection.dart';
import '../../../../model/model/machine/machine_config.model.dart';
import '../../../../model/model/machine/machine_config_operator.model.dart';
import '../../../../utils/fonts.dart';
import '../../../../utils/styles.dart';
import '../../../../view_model/custom_provider/custom_form_provider.dart';
import '../../../../view_model/custom_provider/custom_provider.dart';
import '../../../widgets/form_row_body.dart';
import 'widgets/modal_operator_item.dart';

class _PowerDropdownItem {
  const _PowerDropdownItem({
    required this.value,
    required this.label,
  });

  final String value;
  final String label;
}

class LongDistanceAccessSettingPage extends ConsumerStatefulWidget {
  const LongDistanceAccessSettingPage({
    Key? key,
    required this.idMachine,
  }) : super(key: key);

  final String idMachine;

  @override
  ConsumerState<LongDistanceAccessSettingPage> createState() =>
      _LongDistanceAccessSettingPageState();
}

class _LongDistanceAccessSettingPageState
    extends ConsumerState<LongDistanceAccessSettingPage> {
  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  final powers = <_PowerDropdownItem>[
    const _PowerDropdownItem(value: "1", label: "VERY LOW"),
    const _PowerDropdownItem(value: "2", label: "LOW"),
    const _PowerDropdownItem(value: "3", label: "MEDIUM"),
    const _PowerDropdownItem(value: "4", label: "HIGH"),
    const _PowerDropdownItem(value: "5", label: "VERY HIGH"),
  ];

  MachineConfigModel? machineConfig;
  bool wifiHidden = false;
  bool flashSms = false;
  bool saveSentList = false;
  bool autoArfcn = false;
  bool autoReset = false;
  String? selectedPower;

  bool isShowPassword = false;

  Future<void> onSubmit(bool isReboot) async {
    final form = ref.read(
      CustomFormProvider.ldaSettingForm(widget.idMachine).notifier,
    )..update(
        (state) => state.copyWith(
          wifiName: nameController.text,
          wifiPassword: passwordController.text,
          wifiHidden: wifiHidden ? 1 : 0,
          flashSms: flashSms ? 1 : 0,
          saveSentList: saveSentList ? 1 : 0,
          autoArfcn: autoArfcn ? 1 : 0,
          autoReset: autoReset ? 1 : 0,
          power: int.tryParse(selectedPower ?? "1"),
        ),
      );

    if (isReboot) {
      form.update((state) => state.copyWith(isReboot: true));
    }

    final formState = form.state;
    final notifier = ref.read(machineNotifier.notifier);
    await notifier.updateConfig(formState);
  }

  void init() {
    final machine =
        ref.read(CustomProvider.getMachineByIdProvider(widget.idMachine));
    final config = machine?.config;
    nameController.text = config?.wifiName ?? "";
    passwordController.text = config?.wifiPassword ?? "";

    setState(() {
      wifiHidden = config?.wifiHidden == "1";
      flashSms = config?.flashSms == "1";
      saveSentList = config?.saveSentList == "1";
      autoArfcn = config?.autoArfcn == "1";
      autoReset = config?.autoReset == "1";
      selectedPower = config?.power;
      machineConfig = config;
    });
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => init());
  }

  @override
  void dispose() {
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          FormBodyRow(
                            title: "Wifi Name",
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: nameController,
                                    style: bodyFont.copyWith(fontSize: 14.0),
                                    decoration:
                                        inputDecorationRounded().copyWith(
                                      hintText: "Wifi Name",
                                      border: const OutlineInputBorder(),
                                      fillColor: Colors.transparent,
                                      contentPadding: const EdgeInsets.all(8),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                InkWell(
                                  onTap: () {},
                                  child: const Icon(
                                    Icons.warning_amber_rounded,
                                    color: Colors.grey,
                                    size: 20.0,
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          FormBodyRow(
                            title: "Wifi Password",
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: passwordController,
                                    style: bodyFont.copyWith(fontSize: 14.0),
                                    decoration:
                                        inputDecorationRounded().copyWith(
                                      hintText: "Wifi Password",
                                      border: const OutlineInputBorder(),
                                      fillColor: Colors.transparent,
                                      contentPadding: const EdgeInsets.all(8),
                                    ),
                                    obscureText: !isShowPassword,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      isShowPassword = !isShowPassword;
                                    });
                                  },
                                  child: Icon(
                                    isShowPassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey,
                                    size: 20.0,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                InkWell(
                                  onTap: () {},
                                  child: const Icon(
                                    Icons.warning_amber_rounded,
                                    color: Colors.grey,
                                    size: 20.0,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Card(
                      margin: EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SwitchListTile.adaptive(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                "Wifi Hidden",
                                style: bodyFont.copyWith(fontSize: 14.0),
                              ),
                              value: wifiHidden,
                              onChanged: (value) {
                                setState(() => wifiHidden = value);
                              },
                            ),
                            SwitchListTile.adaptive(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                "Flash SMS",
                                style: bodyFont.copyWith(fontSize: 14.0),
                              ),
                              value: flashSms,
                              onChanged: (value) {
                                setState(() => flashSms = value);
                              },
                            ),
                            SwitchListTile.adaptive(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                "Save Sentlist",
                                style: bodyFont.copyWith(fontSize: 14.0),
                              ),
                              value: saveSentList,
                              onChanged: (value) {
                                setState(() => saveSentList = value);
                              },
                            ),
                            SwitchListTile.adaptive(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                "Auto ARFCN",
                                style: bodyFont.copyWith(fontSize: 14.0),
                              ),
                              value: autoArfcn,
                              onChanged: (value) {
                                setState(() => autoArfcn = value);
                              },
                            ),
                            SwitchListTile.adaptive(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                "Auto Reset",
                                style: bodyFont.copyWith(fontSize: 14.0),
                              ),
                              value: autoReset,
                              onChanged: (value) {
                                setState(() => autoReset = value);
                              },
                            ),
                            FormBodyRow(
                              title: "Choose Power",
                              child:
                                  DropdownButtonFormField<_PowerDropdownItem>(
                                value: powers.firstWhereOrNull((element) =>
                                    element.value == selectedPower),
                                onChanged: (value) {
                                  if (value == null) return;
                                  setState(() => selectedPower = value.value);
                                },
                                decoration: inputDecorationRounded().copyWith(
                                  hintText: "Choose Power",
                                  border: const OutlineInputBorder(),
                                  fillColor: Colors.transparent,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                ),
                                items: powers
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e.label),
                                      ),
                                    )
                                    .toList(),
                                validator: (value) {
                                  if (value == null) {
                                    return "Please select power";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "Network",
                            style: headerFontBold.copyWith(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton.icon(
                              onPressed: null,
                              style: elevatedButtonStyle(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                ),
                                backgroundColor: Colors.blueGrey,
                              ).copyWith(),
                              icon: const Icon(Icons.sync),
                              label: const Text("Syncronize"),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          CheckboxListTile.adaptive(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              "GSM",
                              style: bodyFont.copyWith(fontSize: 14.0),
                            ),
                            value: true,
                            onChanged: (value) {},
                          ),
                          CheckboxListTile.adaptive(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              "WCDMA",
                              style: bodyFont.copyWith(fontSize: 14.0),
                            ),
                            value: true,
                            onChanged: (value) {},
                          ),
                          CheckboxListTile.adaptive(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              "LTE",
                              style: bodyFont.copyWith(fontSize: 14.0),
                            ),
                            value: true,
                            onChanged: (value) {},
                          ),
                          Text(
                            "Operators",
                            style: headerFontBold.copyWith(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 10),
                          ...machineConfig?.operators
                                  .map(
                                    (e) => _ConfigOperatorItem(
                                      e: e,
                                      idMachine: widget.idMachine,
                                    ),
                                  )
                                  .toList() ??
                              [],
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => onSubmit(false),
                      style: elevatedButtonStyle(),
                      child: const Text("Save"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => onSubmit(true),
                      style: elevatedButtonStyle(),
                      child: const FittedBox(child: Text("Save & Reboot")),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => onSubmit(true),
                      style: elevatedButtonStyle(),
                      child: const Text("Reboot"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ConfigOperatorItem extends ConsumerStatefulWidget {
  const _ConfigOperatorItem({
    Key? key,
    required this.idMachine,
    required this.e,
  }) : super(key: key);

  final String idMachine;
  final MachineConfigOperatorsModel e;

  @override
  ConsumerState<_ConfigOperatorItem> createState() =>
      _ConfigOperatorItemState();
}

class _ConfigOperatorItemState extends ConsumerState<_ConfigOperatorItem> {
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
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      title: Text(
        "${widget.e.name} - ${widget.e.ltePlmn} ",
        style: bodyFont.copyWith(
          fontSize: 14.0,
        ),
      ),
      children: [
        FormBodyRow(
          title: "Auto Switch",
          child: TextFormField(
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
        ),
        const SizedBox(height: 10),
        FormBodyRow(
          title: "2G ARFCN",
          child: TextFormField(
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
        ),
        const SizedBox(height: 10),
        FormBodyRow(
          title: "3G ARFCN",
          child: TextFormField(
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
        ),
        const SizedBox(height: 10),
        FormBodyRow(
          title: "4G ARFCN",
          child: TextFormField(
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
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
