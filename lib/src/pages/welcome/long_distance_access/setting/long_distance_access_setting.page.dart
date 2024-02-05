import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../injection.dart';
import '../../../../model/model/helper/form/form_machine_update_config.model.dart';
import '../../../../model/model/machine/machine_config.model.dart';
import '../../../../model/model/machine/machine_config_operator.model.dart';
import '../../../../router.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constant.dart';
import '../../../../utils/fonts.dart';
import '../../../../utils/functions.dart';
import '../../../../utils/styles.dart';
import '../../../../view_model/custom_notifier/get_all_machine.notifier.dart';
import '../../../../view_model/custom_notifier/machine_config_common_setting.notifier.dart';
import '../../../../view_model/custom_notifier/machine_config_operators_setting.notifier.dart';
import '../../../../view_model/custom_provider/custom_provider.dart';
import 'widgets/lda_setting_config_operator_item.dart';
import 'widgets/lda_setting_modal_syncronize.dart';
import 'widgets/lda_setting_network_items.dart';
import 'widgets/modal_lda_setting_warning.dart';

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
    const _PowerDropdownItem(value: "3", label: "LOW"),
    const _PowerDropdownItem(value: "5", label: "MEDIUM"),
    const _PowerDropdownItem(value: "8", label: "HIGH"),
    const _PowerDropdownItem(value: "10", label: "VERY HIGH"),
  ];

  MachineConfigModel? machineConfig;
  bool wifiHidden = false;
  bool flashSms = false;
  bool saveSentList = false;
  bool autoArfcn = false;
  bool autoReset = false;
  bool hiddenManager = false;
  bool isShowPassword = false;
  bool isEnableSyncronize = false;

  String? selectedPower;

  String mappedRegisteredMccMnc(List<MachineConfigOperatorsModel> operators) {
    final selectedOperators =
        operators.where((element) => element.isPlay == 1).toList();

    if (selectedOperators.isEmpty) return "";

    return selectedOperators
        .map((e) {
          return "${e.mcc}_${e.mnc}_${kTimeout}_${kArfcn}_${kLteArfcn}_${kLtePci}_${kLtePci}_${kLteTac}_${kLteCellId}_${kLteDowngrade}_${kLteRotationTime}_$kLtePlmn";
        })
        .toList()
        .join(",");
  }

  void onSelectedMenu(String value) {
    switch (value) {
      case "admin":
        context.pushNamed(
          routeLoginLDAAdminPage,
          pathParameters: {
            "idMachine": widget.idMachine,
          },
        );
        break;
      case "manager":
        context.pushNamed(
          routeLoginLDAManagerPage,
          pathParameters: {
            "idMachine": widget.idMachine,
          },
        );
        break;
      default:
        showSnackbar(
          context: context,
          message: "Menu Not Valid",
          backgroundColor: Colors.red,
        );
        break;
    }
  }

  void onTapExclamationMark() {
    showDialog(
      context: context,
      builder: (context) {
        return const ModalLDASettingWarning();
      },
    );
  }

  void onTapTogglePassword() {
    setState(() {
      isShowPassword = !isShowPassword;
    });
  }

  void onTapWifiHidden(bool? value) {
    if (value == null) return;
    setState(() {
      wifiHidden = !wifiHidden;
    });

    onTapExclamationMark();
  }

  void onTapSyncronize() async {
    await showDialog(
      context: context,
      builder: (context) => LDASettingModalSyncronize(
        machineId: widget.idMachine,
      ),
    );
  }

  Future<void> onSubmit(bool isReboot) async {
    final operators = ref.read(machineConfigOperatorsSettingNotifier).items;

    MachineConfigModel commonConfig =
        ref.read(machineConfigCommonSettingNotifier).item;

    var form = FormMachineUpdateConfigModel.fromMachineConfigModel(
      widget.idMachine,
      commonConfig,
    );

    form = form.copyWith(
      wifiName: nameController.text,
      wifiPassword: passwordController.text,
      wifiHidden: wifiHidden ? '1' : '0',
      flashSms: flashSms ? '1' : '0',
      saveSentList: saveSentList ? '1' : '0',
      autoArfcn: autoArfcn ? '3' : '0',
      autoReset: autoReset ? '1' : '0',
      power: selectedPower ?? "1",
      operators: operators,
      registeredMccMnc: mappedRegisteredMccMnc(operators),
    );

    if (isReboot) {
      form = form.copyWith(reboot: "1");
    }

    final notifier = ref.read(machineNotifier.notifier);
    await notifier.updateConfig(form);
  }

  void init() {
    final machine =
        ref.read(CustomProvider.getMachineByIdProvider(widget.idMachine));
    final config = machine?.config;
    final boardIps = config?.boardIps ?? [];
    final board =
        boardIps.firstWhereOrNull((element) => element.ip == machine?.ip);

    // Init selected operators state
    ref
        .read(machineConfigOperatorsSettingNotifier.notifier)
        .init(config?.operators ?? []);

    // Init machine config common setting state
    ref
        .read(machineConfigCommonSettingNotifier.notifier)
        .init(config ?? const MachineConfigModel());

    if (board?.status == "on") {
      isEnableSyncronize = true;
    }

    nameController.text = config?.wifiName ?? "";
    passwordController.text = config?.wifiPassword ?? "";

    setState(() {
      wifiHidden = config?.wifiHidden == "1";
      flashSms = config?.flashSms == "1";
      saveSentList = config?.saveSentList == "1";
      autoArfcn = config?.autoArfcn == "3";
      autoReset = config?.autoReset == "1";
      selectedPower = config?.power;
      machineConfig = config;
      hiddenManager = config?.hiddenManager == "1";
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
    final machine =
        ref.watch(CustomProvider.getMachineByIdProvider(widget.idMachine));
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppBar(
            title: const Text('Setting'),
            centerTitle: true,
            automaticallyImplyLeading: false,
            actions: [
              PopupMenuButton(
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'admin',
                    child: Text("Admin"),
                  ),
                  if (!hiddenManager)
                    const PopupMenuItem(
                      value: 'manager',
                      child: Text("Manager"),
                    ),
                ],
                onSelected: (value) => onSelectedMenu(value),
                child: const Icon(Icons.more_vert),
              ),
              const SizedBox(width: 10.0),
            ],
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async =>
                  ref.invalidate(getAllMachineFutureProvider),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
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
                                    IntrinsicHeight(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Expanded(
                                            child: TextFormField(
                                              controller: nameController,
                                              style: bodyFont.copyWith(
                                                fontSize: 14.0,
                                              ),
                                              decoration:
                                                  inputDecorationRounded()
                                                      .copyWith(
                                                hintText: "Wifi Name",
                                                border:
                                                    const OutlineInputBorder(),
                                                fillColor: Colors.transparent,
                                                contentPadding:
                                                    const EdgeInsets.all(8.0),
                                              ),
                                            ),
                                          ),
                                          _InputIconButton(
                                              onTap: onTapExclamationMark,
                                              icon:
                                                  Icons.warning_amber_rounded),
                                          const SizedBox(width: 16.0),
                                        ],
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
                                      "Wifi Password",
                                      style: headerFontBold.copyWith(
                                        fontSize: 16.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    IntrinsicHeight(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Expanded(
                                            child: TextFormField(
                                              controller: passwordController,
                                              style: bodyFont.copyWith(
                                                  fontSize: 14.0),
                                              decoration:
                                                  inputDecorationRounded()
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
                                          _InputIconButton(
                                            onTap: onTapTogglePassword,
                                            icon: isShowPassword
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            borderRadius:
                                                const BorderRadius.only(),
                                          ),
                                          _InputIconButton(
                                            onTap: onTapExclamationMark,
                                            icon: Icons.warning_amber_rounded,
                                          ),
                                        ],
                                      ),
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
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 2,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Wifi Hidden",
                                      overflow: TextOverflow.ellipsis,
                                      style: bodyFont.copyWith(fontSize: 12.0),
                                    ),
                                    SizedBox(
                                      height: 32,
                                      child: Switch.adaptive(
                                        value: wifiHidden,
                                        onChanged: onTapWifiHidden,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Flash SMS",
                                      overflow: TextOverflow.ellipsis,
                                      style: bodyFont.copyWith(fontSize: 12.0),
                                    ),
                                    SizedBox(
                                      height: 32,
                                      child: Switch.adaptive(
                                        value: flashSms,
                                        onChanged: (value) {
                                          setState(() => flashSms = value);
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Save Sentlist",
                                      overflow: TextOverflow.ellipsis,
                                      style: bodyFont.copyWith(fontSize: 12.0),
                                    ),
                                    SizedBox(
                                      height: 32,
                                      child: Switch.adaptive(
                                        value: saveSentList,
                                        onChanged: (value) {
                                          setState(() => saveSentList = value);
                                        },
                                      ),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Auto ARFCN",
                                      overflow: TextOverflow.ellipsis,
                                      style: bodyFont.copyWith(fontSize: 12.0),
                                    ),
                                    SizedBox(
                                      height: 32,
                                      child: Switch.adaptive(
                                        value: autoArfcn,
                                        onChanged: (value) {
                                          setState(() => autoArfcn = value);
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Auto Reset",
                                      overflow: TextOverflow.ellipsis,
                                      style: bodyFont.copyWith(fontSize: 12.0),
                                    ),
                                    SizedBox(
                                      height: 32,
                                      child: Switch.adaptive(
                                        value: autoReset,
                                        onChanged: (value) {
                                          setState(() => autoReset = value);
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Power",
                                      overflow: TextOverflow.ellipsis,
                                      style: bodyFont.copyWith(fontSize: 12.0),
                                    ),
                                    const SizedBox(height: 8),
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
                                    onPressed: !isEnableSyncronize
                                        ? null
                                        : onTapSyncronize,
                                    style: elevatedButtonStyle(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                      ),
                                      minimumSize: const Size(0, 40),
                                      backgroundColor: darkPrimaryColor,
                                    ).copyWith(),
                                    icon: const Icon(
                                      Icons.sync,
                                      size: 16.0,
                                    ),
                                    label: Text(
                                      "Syncronize",
                                      style: bodyFont.copyWith(fontSize: 7.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          ...machineConfig?.operators
                                  .map(
                                    (e) => LDASettingConfigOperatorItem(
                                      cfgOperator: e,
                                      machine: machine,
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
    );
  }
}

class _InputIconButton extends StatelessWidget {
  const _InputIconButton({
    Key? key,
    required this.icon,
    // ignore: unused_element
    this.onTap,
    // ignore: unused_element
    this.borderRadius,
  }) : super(key: key);

  final IconData icon;
  final void Function()? onTap;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          border: Border.all(
            color: Colors.grey.withOpacity(0.5),
          ),
          borderRadius: borderRadius ??
              const BorderRadius.only(
                topRight: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0),
              ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 4.0,
        ),
        child: Icon(
          icon,
          size: 20.0,
          color: Colors.black,
        ),
      ),
    );
  }
}
