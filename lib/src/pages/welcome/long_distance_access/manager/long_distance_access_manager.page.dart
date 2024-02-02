import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection.dart';
import '../../../../model/model/helper/form/form_machine_update_config.model.dart';
import '../../../../model/model/machine/machine_config_boardips.model.dart';
import '../../../../model/model/machine/machine_config_countries.model.dart';
import '../../../../model/model/machine/machine_config_operator.model.dart';
import '../../../../utils/fonts.dart';
import '../../../../utils/functions.dart';
import '../../../../utils/styles.dart';
import '../../../../view_model/custom_provider/custom_form_provider.dart';
import '../../../../view_model/custom_provider/custom_provider.dart';
import '../../../widgets/form_body_row.dart';
import 'widgets/modal_add_country.dart';
import 'widgets/modal_country_mnc.dart';

class LongDistanceAccessManagerPage extends ConsumerStatefulWidget {
  const LongDistanceAccessManagerPage({
    Key? key,
    required this.idMachine,
  }) : super(key: key);
  final String idMachine;

  @override
  ConsumerState<LongDistanceAccessManagerPage> createState() =>
      _LongDistanceAccessManagerPageState();
}

class _LongDistanceAccessManagerPageState
    extends ConsumerState<LongDistanceAccessManagerPage> {
  final _formKey = GlobalKey<FormState>();

  final senderUnallowedController = TextEditingController();
  final arfcn2GLabelController = TextEditingController();
  final arfcn3GLabelController = TextEditingController();
  final arfcn4GLabelController = TextEditingController();
  final arfcn5GLabelController = TextEditingController();
  final newPasswordController = TextEditingController();
  final boardIPController = TextEditingController();
  final powerVeryLowController = TextEditingController();
  final powerLowController = TextEditingController();
  final powerMediumController = TextEditingController();
  final powerHighController = TextEditingController();
  final powerVeryHighController = TextEditingController();

  MachineConfigCountriesModel? selectedCountry;

  bool isHiddenArfcn2G = false;
  bool isHiddenArfcn3G = false;
  bool isHiddenArfcn4G = false;
  bool isHiddenArfcn5G = false;

  bool isRemoveManagerPage = false;

  void showModalCountry(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const ModalAddCountryLDAManager(),
    );
  }

  List<MachineBoardIpsModel> mappedBoardIps() {
    try {
      final joinBoardIps = boardIPController.text.split(",");
      final mappingJoinBoardIps = joinBoardIps.map((e) {
        final [ip, name, status] = e.split("-");
        return MachineBoardIpsModel(ip: ip, name: name, status: status);
      }).toList();
      return mappingJoinBoardIps;
    } catch (e) {
      throw Exception(e);
    }
  }

  String mappedPowerConfig() {
    try {
      final joinPowerConfig = [
        powerVeryLowController.text,
        powerLowController.text,
        powerMediumController.text,
        powerHighController.text,
        powerVeryHighController.text,
      ].join("_");
      return joinPowerConfig;
    } catch (e) {
      throw Exception(e);
    }
  }

  String? mappedRegisteredMccMnc(List<MachineConfigCountriesModel> countries) {
    const kTimeout = "15";
    const kArfcn = "5";

    if (selectedCountry == null) return null;

    final country = countries.firstWhereOrNull(
      (element) => element.label == selectedCountry?.label,
    );

    if (country == null) {
      return null;
    }

    final mapping = country.mncs.map((e) {
      return "${e.mcc}${e.mnc}_${kTimeout}_$kArfcn";
    }).toList();

    final joinByComma = mapping.join(",");

    return joinByComma;
  }

  List<MachineConfigOperatorsModel>? mappedOperators(
      List<MachineConfigCountriesModel> countries) {
    if (selectedCountry == null) return null;

    final country = countries.firstWhereOrNull(
      (element) => element.label == selectedCountry?.label,
    );

    if (country == null) {
      return null;
    }

    const kArfcn = "5";
    const kTimeout = "15";
    const isPlay = 1;
    const curr = 1;
    const lteArfcn = "1850";
    const ltePci = "111";
    const lteTac = "1111";
    const lteCellId = "11111";
    const lteDowngrade = "5";
    const lteRotationTime = "70";
    const ltePlmn = "46010";
    const kDefault = "true";
    const k3GArfcn = "10638";
    const k5GArfcn = "1333";
    const kStatus = 1;

    final mapping = country.mncs.map((e) {
      return MachineConfigOperatorsModel(
        mcc: e.mcc,
        mnc: e.mnc,
        label: e.label,
        name: e.name,
        country: e.country,
        arfcn: kArfcn,
        timeout: kTimeout,
        isPlay: isPlay,
        curr: curr,
        lteArfcn: lteArfcn,
        ltePci: ltePci,
        lteTac: lteTac,
        lteCellId: lteCellId,
        lteDowngrade: lteDowngrade,
        lteRotationTime: lteRotationTime,
        fiveGArfcn: k5GArfcn,
        ltePlmn: ltePlmn,
        threeGArfcn: k3GArfcn,
        operatorDefault: kDefault,
        status: kStatus,
      );
    }).toList();

    return mapping;
  }

  Future<void> onSubmit() async {
    try {
      final validate = _formKey.currentState?.validate() ?? false;

      if (!validate) {
        return;
      }

      final machine = ref.read(
        CustomProvider.getMachineByIdProvider(widget.idMachine),
      );
      final config = machine?.config;

      if (config == null) {
        return;
      }

      final countries = ref.read(CustomFormProvider.machineConfigCountriesForm);

      FormMachineUpdateConfigModel form =
          FormMachineUpdateConfigModel.fromMachineConfigModel(
        widget.idMachine,
        config,
      ).copyWith(
        countries: countries,
        unallowed: senderUnallowedController.text,
        arfcnLabel2g: arfcn2GLabelController.text,
        arfcnLabel3g: arfcn3GLabelController.text,
        arfcnLabel4g: arfcn4GLabelController.text,
        arfcnLabel5g: arfcn5GLabelController.text,
        arfcnHidden2g: isHiddenArfcn2G ? "1" : "0",
        arfcnHidden3g: isHiddenArfcn3G ? "1" : "0",
        arfcnHidden4g: isHiddenArfcn4G ? "1" : "0",
        arfcnHidden5g: isHiddenArfcn5G ? "1" : "0",
        removeManager: isRemoveManagerPage ? "1" : "0",
        managerPassword: newPasswordController.text,
        boardIps: mappedBoardIps(),
        powerConfig: mappedPowerConfig(),
      );

      if (selectedCountry != null) {
        final registeredMccMnc = mappedRegisteredMccMnc(countries);
        final operators = mappedOperators(countries);

        form = form.copyWith(
          registeredMccMnc: registeredMccMnc,
          operators: operators,
        );
      }

      final notifier = ref.read(machineNotifier.notifier);
      await notifier.updateConfig(form);
    } catch (e) {
      if (!context.mounted) return;

      showSnackbar(
        context: context,
        message: e.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  void init() {
    // Initialize initial data machine config countries
    final formMachineConfigCountries = ref.read(
      CustomFormProvider.machineConfigCountriesForm.notifier,
    );
    final machine = ref.read(
      CustomProvider.getMachineByIdProvider(widget.idMachine),
    );

    if (machine == null) return;
    final config = machine.config;

    if (config == null) return;

    final countries = config.countries;

    formMachineConfigCountries.update((state) => countries
        .map(
          (e) => MachineConfigCountriesModel(
            label: e.label,
            name: e.name,
            isActive: e.isActive,
            mncs: e.mncs,
          ),
        )
        .toList());

    // Fill data
    final listPower = config.powerConfig?.split("_") ?? [];
    senderUnallowedController.text = "${config.unallowed}";
    arfcn2GLabelController.text = "${config.arfcnLabel2g}";
    arfcn3GLabelController.text = "${config.arfcnLabel3g}";
    arfcn4GLabelController.text = "${config.arfcnLabel4g}";
    arfcn5GLabelController.text = "${config.arfcnLabel5g}";
    isHiddenArfcn2G = config.arfcnHidden2g == "1";
    isHiddenArfcn3G = config.arfcnHidden3g == "1";
    isHiddenArfcn4G = config.arfcnHidden4g == "1";
    isHiddenArfcn5G = config.arfcnHidden5g == "1";
    isRemoveManagerPage = config.removeManager == "1";
    newPasswordController.text = "${config.managerPassword}";
    boardIPController.text =
        config.boardIps.map((e) => "${e.ip}-${e.name}-${e.status}").join(",");
    List.generate(listPower.length, (index) {
      switch (index) {
        case 0:
          powerVeryLowController.text = listPower[index];
          break;
        case 1:
          powerLowController.text = listPower[index];
          break;
        case 2:
          powerMediumController.text = listPower[index];
          break;
        case 3:
          powerHighController.text = listPower[index];
          break;
        case 4:
          powerVeryHighController.text = listPower[index];
          break;
        default:
      }
    });

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => init());
  }

  @override
  void dispose() {
    senderUnallowedController.dispose();
    arfcn2GLabelController.dispose();
    arfcn3GLabelController.dispose();
    arfcn4GLabelController.dispose();
    arfcn5GLabelController.dispose();
    newPasswordController.dispose();
    boardIPController.dispose();
    powerVeryLowController.dispose();
    powerLowController.dispose();
    powerMediumController.dispose();
    powerHighController.dispose();
    powerVeryHighController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("LDC Manager")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        physics: const AlwaysScrollableScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16.0),
              Text(
                "DEVICE SETUP",
                style: bodyFontBold.copyWith(fontSize: 16.0),
              ),
              const SizedBox(height: 8.0),
              Wrap(
                children: [
                  ElevatedButton(
                    onPressed: () => showModalCountry(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text("Add"),
                  ),
                  const SizedBox(width: 8.0),
                  ElevatedButton(
                    onPressed: () => onSubmit(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text("Save"),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              _DeviceSetup(
                onSelectedCountry: (value) {
                  selectedCountry = value;
                  setState(() {});
                },
              ),
              const SizedBox(height: 16.0),
              FormBodyRow(
                title: "Sender Unallowed",
                child: TextFormField(
                  controller: senderUnallowedController,
                  style: bodyFont.copyWith(fontSize: 14.0),
                  decoration: inputDecorationRounded().copyWith(
                    hintText: "Sender Unallowed",
                    border: const OutlineInputBorder(),
                    fillColor: Colors.transparent,
                    contentPadding: const EdgeInsets.all(8),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Sender Unallowed is required";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),
              FormBodyRow(
                titleWidget: _ArfcnTitle(
                  title: "2G Arfcn",
                  value: isHiddenArfcn2G,
                  onChanged: (val) => setState(
                    () => isHiddenArfcn2G = val ?? false,
                  ),
                ),
                child: TextFormField(
                  controller: arfcn2GLabelController,
                  style: bodyFont.copyWith(fontSize: 14.0),
                  decoration: inputDecorationRounded().copyWith(
                    hintText: "2G Arfcn Label",
                    border: const OutlineInputBorder(),
                    fillColor: Colors.transparent,
                    contentPadding: const EdgeInsets.all(8),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "2G Arfcn Label is required";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),
              FormBodyRow(
                titleWidget: _ArfcnTitle(
                  title: "3G Arfcn",
                  value: isHiddenArfcn3G,
                  onChanged: (val) => setState(
                    () => isHiddenArfcn3G = val ?? false,
                  ),
                ),
                child: TextFormField(
                  controller: arfcn3GLabelController,
                  style: bodyFont.copyWith(fontSize: 14.0),
                  decoration: inputDecorationRounded().copyWith(
                    hintText: "3G Arfcn Label",
                    border: const OutlineInputBorder(),
                    fillColor: Colors.transparent,
                    contentPadding: const EdgeInsets.all(8),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "3G Arfcn Label is required";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),
              FormBodyRow(
                titleWidget: _ArfcnTitle(
                  title: "4G Arfcn",
                  value: isHiddenArfcn4G,
                  onChanged: (val) => setState(
                    () => isHiddenArfcn4G = val ?? false,
                  ),
                ),
                child: TextFormField(
                  controller: arfcn4GLabelController,
                  style: bodyFont.copyWith(fontSize: 14.0),
                  decoration: inputDecorationRounded().copyWith(
                    hintText: "4G Arfcn Label",
                    border: const OutlineInputBorder(),
                    fillColor: Colors.transparent,
                    contentPadding: const EdgeInsets.all(8),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "4G Arfcn Label is required";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),
              FormBodyRow(
                titleWidget: _ArfcnTitle(
                  title: "5G Arfcn",
                  value: isHiddenArfcn5G,
                  onChanged: (val) => setState(
                    () => isHiddenArfcn5G = val ?? false,
                  ),
                ),
                child: TextFormField(
                  controller: arfcn5GLabelController,
                  style: bodyFont.copyWith(fontSize: 14.0),
                  decoration: inputDecorationRounded().copyWith(
                    hintText: "5G Arfcn Label",
                    border: const OutlineInputBorder(),
                    fillColor: Colors.transparent,
                    contentPadding: const EdgeInsets.all(8),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "5G Arfcn Label is required";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),
              FormBodyRow(
                title: "Remove Manager Page",
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Checkbox(
                    value: isRemoveManagerPage,
                    onChanged: (value) {
                      if (value == null) return;

                      setState(() => isRemoveManagerPage = value);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              FormBodyRow(
                title: "New Password",
                child: TextFormField(
                  controller: newPasswordController,
                  style: bodyFont.copyWith(fontSize: 14.0),
                  obscureText: true,
                  decoration: inputDecorationRounded().copyWith(
                    hintText: "New Password",
                    border: const OutlineInputBorder(),
                    fillColor: Colors.transparent,
                    contentPadding: const EdgeInsets.all(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              FormBodyRow(
                title: "Board IP",
                child: TextFormField(
                  controller: boardIPController,
                  style: bodyFont.copyWith(fontSize: 14.0),
                  decoration: inputDecorationRounded().copyWith(
                      hintText: "Board IP",
                      border: const OutlineInputBorder(),
                      fillColor: Colors.transparent,
                      contentPadding: const EdgeInsets.all(8),
                      helperText: "IP-Name-Status,IP-Name-Status,...",
                      helperStyle: bodyFont.copyWith(fontSize: 10.0)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Board IP is required";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Power",
                style: headerFontBold.copyWith(
                  fontSize: 20.0,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FormBodyRow(
                    title: "Very Low",
                    child: TextFormField(
                      controller: powerVeryLowController,
                      style: bodyFont.copyWith(fontSize: 14.0),
                      decoration: inputDecorationRounded().copyWith(
                        hintText: "Very Low",
                        border: const OutlineInputBorder(),
                        fillColor: Colors.transparent,
                        contentPadding: const EdgeInsets.all(8),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Very Low is required";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  FormBodyRow(
                    title: "Low",
                    child: TextFormField(
                      controller: powerLowController,
                      style: bodyFont.copyWith(fontSize: 14.0),
                      decoration: inputDecorationRounded().copyWith(
                        hintText: "Low",
                        border: const OutlineInputBorder(),
                        fillColor: Colors.transparent,
                        contentPadding: const EdgeInsets.all(8),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Low is required";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  FormBodyRow(
                    title: "Medium",
                    child: TextFormField(
                      controller: powerMediumController,
                      style: bodyFont.copyWith(fontSize: 14.0),
                      decoration: inputDecorationRounded().copyWith(
                        hintText: "Medium",
                        border: const OutlineInputBorder(),
                        fillColor: Colors.transparent,
                        contentPadding: const EdgeInsets.all(8),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Medium is required";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  FormBodyRow(
                    title: "High",
                    child: TextFormField(
                      controller: powerHighController,
                      style: bodyFont.copyWith(fontSize: 14.0),
                      decoration: inputDecorationRounded().copyWith(
                        hintText: "High",
                        border: const OutlineInputBorder(),
                        fillColor: Colors.transparent,
                        contentPadding: const EdgeInsets.all(8),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "High is required";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  FormBodyRow(
                    title: "Very High",
                    child: TextFormField(
                      controller: powerVeryHighController,
                      style: bodyFont.copyWith(fontSize: 14.0),
                      decoration: inputDecorationRounded().copyWith(
                        hintText: "Very High",
                        border: const OutlineInputBorder(),
                        fillColor: Colors.transparent,
                        contentPadding: const EdgeInsets.all(8),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Very High is required";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _DeviceSetup extends ConsumerStatefulWidget {
  final void Function(MachineConfigCountriesModel? value)? onSelectedCountry;
  const _DeviceSetup({
    Key? key,
    // ignore: unused_element
    this.onSelectedCountry,
  }) : super(key: key);

  @override
  ConsumerState<_DeviceSetup> createState() => _DeviceSetupState();
}

class _DeviceSetupState extends ConsumerState<_DeviceSetup> {
  MachineConfigCountriesModel? selectedCountry;

  void removeCountry(WidgetRef ref, String label) {
    final form =
        ref.read(CustomFormProvider.machineConfigCountriesForm.notifier);
    form.update((state) {
      final newState =
          state.where((element) => element.label != label).toList();
      return newState;
    });
  }

  void showModalCountryMNC(
    BuildContext context,
    String label,
  ) {
    showDialog(
      context: context,
      builder: (context) => ModalCountryMNC(label: label),
    );
  }

  void onSelectedCountry({
    required bool value,
    required MachineConfigCountriesModel country,
  }) {
    if (value) {
      selectedCountry = country;
    } else {
      selectedCountry = null;
    }

    widget.onSelectedCountry?.call(selectedCountry);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final formMachineConfigCountryMnc = ref.watch(
      CustomFormProvider.machineConfigCountriesForm,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (formMachineConfigCountryMnc.isNotEmpty) ...[
          DataTable(
            columns: const [
              DataColumn(label: Text("#")),
              DataColumn(label: Text("Country")),
              DataColumn(label: Text("")),
            ],
            rows: [
              ...formMachineConfigCountryMnc
                  .map(
                    (e) => DataRow(
                      cells: [
                        DataCell(
                          Checkbox(
                            value: selectedCountry?.label == e.label,
                            onChanged: (value) {
                              onSelectedCountry(
                                country: e,
                                value: value ?? false,
                              );
                            },
                          ),
                        ),
                        DataCell(
                          TextButton(
                            child: Text(e.name),
                            onPressed: () => showModalCountryMNC(
                              context,
                              e.label,
                            ),
                          ),
                        ),
                        DataCell(
                          IconButton(
                            onPressed: () => removeCountry(ref, e.label),
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ],
          ),
        ],
        const SizedBox(height: 16.0),
      ],
    );
  }
}

class _ArfcnTitle extends StatelessWidget {
  const _ArfcnTitle({
    Key? key,
    required this.title,
    required this.value,
    // ignore: unused_element
    this.onChanged,
  }) : super(key: key);

  final String title;
  final bool value;
  final void Function(bool? val)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: bodyFont.copyWith(fontSize: 14.0),
        ),
        const SizedBox(width: 8),
        Row(
          children: [
            Checkbox(
              value: value,
              onChanged: onChanged,
            ),
            Text(
              "Hidden",
              style: bodyFont.copyWith(fontSize: 12.0),
            ),
          ],
        )
      ],
    );
  }
}
