import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection.dart';
import '../../../../model/model/machine/machine_config.model.dart';
import '../../../../utils/fonts.dart';
import '../../../../utils/styles.dart';
import '../../../../view_model/custom_provider/custom_form_provider.dart';
import '../../../../view_model/custom_provider/custom_provider.dart';
import 'widgets/lda_setting_config_operator_item.dart';
import 'widgets/lda_setting_network_items.dart';

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
          wifiHidden: wifiHidden ? '1' : '0',
          flashSms: flashSms ? '1' : '0',
          saveSentList: saveSentList ? '1' : '0',
          autoArfcn: autoArfcn ? '1' : '0',
          autoReset: autoReset ? '1' : '0',
          power: selectedPower ?? "1",
        ),
      );

    if (isReboot) {
      form.update((state) => state.copyWith(reboot: '1'));
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
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      "Wifi Name",
                                      style: headerFontBold.copyWith(
                                        fontSize: 16.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    TextFormField(
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
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      "Wifi Name",
                                      style: headerFontBold.copyWith(
                                        fontSize: 16.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                            controller: passwordController,
                                            style: bodyFont.copyWith(
                                                fontSize: 14.0),
                                            decoration: inputDecorationRounded()
                                                .copyWith(
                                              hintText: "Wifi Password",
                                              border:
                                                  const OutlineInputBorder(),
                                              fillColor: Colors.transparent,
                                              contentPadding:
                                                  const EdgeInsets.all(8),
                                            ),
                                            obscureText: !isShowPassword,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              isShowPassword = !isShowPassword;
                                            });
                                          },
                                          icon: Icon(
                                            isShowPassword
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            size: 20.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Wifi Hidden",
                                      overflow: TextOverflow.ellipsis,
                                      style: bodyFont.copyWith(fontSize: 12.0),
                                    ),
                                    Switch.adaptive(
                                      value: wifiHidden,
                                      onChanged: (value) {
                                        setState(() => wifiHidden = value);
                                      },
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Flash SMS",
                                      overflow: TextOverflow.ellipsis,
                                      style: bodyFont.copyWith(fontSize: 12.0),
                                    ),
                                    Switch.adaptive(
                                      value: flashSms,
                                      onChanged: (value) {
                                        setState(() => flashSms = value);
                                      },
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Save Sentlist",
                                      overflow: TextOverflow.ellipsis,
                                      style: bodyFont.copyWith(fontSize: 12.0),
                                    ),
                                    Switch.adaptive(
                                      value: saveSentList,
                                      onChanged: (value) {
                                        setState(() => saveSentList = value);
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Auto ARFCN",
                                      overflow: TextOverflow.ellipsis,
                                      style: bodyFont.copyWith(fontSize: 12.0),
                                    ),
                                    Switch.adaptive(
                                      value: autoArfcn,
                                      onChanged: (value) {
                                        setState(() => autoArfcn = value);
                                      },
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Auto Reset",
                                      overflow: TextOverflow.ellipsis,
                                      style: bodyFont.copyWith(fontSize: 12.0),
                                    ),
                                    Switch.adaptive(
                                      value: autoReset,
                                      onChanged: (value) {
                                        setState(() => autoReset = value);
                                      },
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Power",
                                      overflow: TextOverflow.ellipsis,
                                      style: bodyFont.copyWith(fontSize: 12.0),
                                    ),
                                    const SizedBox(height: 16),
                                    DropdownButtonFormField<_PowerDropdownItem>(
                                      isExpanded: true,
                                      value: powers.firstWhereOrNull(
                                          (element) =>
                                              element.value == selectedPower),
                                      onChanged: (value) {
                                        if (value == null) return;
                                        setState(
                                            () => selectedPower = value.value);
                                      },
                                      decoration:
                                          inputDecorationRounded().copyWith(
                                        hintText: "Choose Power",
                                        border: const OutlineInputBorder(),
                                        fillColor: Colors.transparent,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                      ),
                                      style: bodyFont.copyWith(
                                        fontSize: 12.0,
                                        color: Colors.grey,
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
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
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
                          Row(
                            children: [
                              LDASettingNetworkItems(
                                idMachine: widget.idMachine,
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: ElevatedButton.icon(
                                    onPressed: null,
                                    style: elevatedButtonStyle(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                      ),
                                      minimumSize: const Size(0, 40),
                                      backgroundColor: Colors.blueGrey,
                                    ).copyWith(),
                                    icon: const Icon(
                                      Icons.sync,
                                      size: 16.0,
                                    ),
                                    label: Text(
                                      "Syncronize",
                                      style: bodyFont.copyWith(fontSize: 10.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
                                    (e) => LDASettingConfigOperatorItem(
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
