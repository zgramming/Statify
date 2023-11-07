import 'dart:io';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection.dart';
import '../../../../utils/fonts.dart';
import '../../../../utils/functions.dart';
import '../../../../utils/styles.dart';
import '../../../../view_model/custom_provider/custom_form_provider.dart';
import '../../../../view_model/custom_provider/custom_provider.dart';
import '../../../widgets/form_body_row.dart';

class _BandDropdown {
  final String label;
  final String value;
  const _BandDropdown({
    required this.label,
    required this.value,
  });
}

class _MachineKeyTypeDropdown {
  final String label;
  final String value;
  const _MachineKeyTypeDropdown({
    required this.label,
    required this.value,
  });
}

const bands = [
  _BandDropdown(
    label: "850",
    value: "192",
  ),
  _BandDropdown(
    label: "900",
    value: "65",
  ),
  _BandDropdown(
    label: "1800",
    value: "97",
  ),
  _BandDropdown(
    label: "1900",
    value: "224",
  ),
  _BandDropdown(
    label: "900/1800",
    value: "1",
  ),
  _BandDropdown(
    label: "850/1900",
    value: "128",
  ),
];

const machineKeyTypes = [
  _MachineKeyTypeDropdown(
    label: "IMSI",
    value: "1",
  ),
  _MachineKeyTypeDropdown(
    label: "IMEI",
    value: "2",
  ),
];

class LongDistanceAccessAdminPage extends ConsumerStatefulWidget {
  const LongDistanceAccessAdminPage({
    Key? key,
    required this.idMachine,
  }) : super(key: key);

  final String idMachine;

  @override
  ConsumerState<LongDistanceAccessAdminPage> createState() =>
      _LongDistanceAccessAdminPageState();
}

class _LongDistanceAccessAdminPageState
    extends ConsumerState<LongDistanceAccessAdminPage> {
  final _formKey = GlobalKey<FormState>();

  final newPasswordController = TextEditingController();
  final senderAllowedController = TextEditingController();
  final clientAllowedController = TextEditingController();
  final fakeOperationEveryController = TextEditingController();
  final runningTextController = TextEditingController();
  final machineKeyLastController = TextEditingController();

  bool isRemoveAdminPage = false;
  bool isEnableAutoClear = false;
  _BandDropdown? _selectedBand;
  _MachineKeyTypeDropdown? _selectedMachineKeyType;
  Uint8List? _selectedLogo;

  Future<void> onUpload() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ["jpg", "png"],
      );

      if (result == null) {
        return;
      }

      final file = result.files.first;
      final path = file.path;
      if (path == null) {
        return;
      }

      final pickedFile = File(path);
      final pickedFileBytes = await pickedFile.readAsBytes();

      setState(() => _selectedLogo = pickedFileBytes);
    } catch (e) {
      if (!mounted) return;
      showSnackbar(
        context: context,
        message: e.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  Future<void> onSubmit() async {
    final validate = _formKey.currentState?.validate() ?? false;
    if (!validate) {
      return;
    }

    final form = ref.read(
      CustomFormProvider.ldaAdminForm(widget.idMachine).notifier,
    )..update(
        (state) => state.copyWith(
          adminPassword: newPasswordController.text,
          allowed: senderAllowedController.text,
          band: _selectedBand?.value,
          runningText: runningTextController.text,
          autoClear: isEnableAutoClear ? "1" : "0",
          machineKeyType: _selectedMachineKeyType?.value,
          machineKeyLast: machineKeyLastController.text,
          removeAdmin: isRemoveAdminPage ? "1" : "0",
        ),
      );

    final notifier = ref.read(machineNotifier.notifier);
    await notifier.updateConfig(form.state);
  }

  void init() {
    final machine =
        ref.read(CustomProvider.getMachineByIdProvider(widget.idMachine));
    final config = machine?.config;
    if (config == null) {
      return;
    }

    newPasswordController.text = config.adminPassword ?? "";
    senderAllowedController.text = config.allowed ?? "";
    clientAllowedController.text = config.clientAllowed ?? "";
    // fakeOperationEveryController.text = config.allowed ?? "";
    // isRemoveAdminPage = config.removeManager == "1";
    _selectedBand =
        bands.firstWhereOrNull((element) => element.value == config.band);
    runningTextController.text = config.runningText ?? "";
    // _selectedLogo = config.allowed ?? "";
    isEnableAutoClear = config.autoClear == "1";
    _selectedMachineKeyType = machineKeyTypes.firstWhereOrNull(
      (element) => element.value == config.machineKeyType,
    );
    machineKeyLastController.text = config.machineKeyLast ?? "";
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => init());
  }

  @override
  void dispose() {
    newPasswordController.dispose();
    senderAllowedController.dispose();
    clientAllowedController.dispose();
    fakeOperationEveryController.dispose();
    runningTextController.dispose();
    machineKeyLastController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("LDA Admin")),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FormBodyRow(
                title: "New Password",
                child: TextFormField(
                  controller: newPasswordController,
                  style: bodyFont.copyWith(fontSize: 14.0),
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
                title: "Sender Allowed",
                child: TextFormField(
                  controller: senderAllowedController,
                  style: bodyFont.copyWith(fontSize: 14.0),
                  decoration: inputDecorationRounded().copyWith(
                    hintText: "Sender Allowed",
                    border: const OutlineInputBorder(),
                    fillColor: Colors.transparent,
                    contentPadding: const EdgeInsets.all(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              FormBodyRow(
                title: "Client Allowed",
                child: TextFormField(
                  controller: clientAllowedController,
                  style: bodyFont.copyWith(fontSize: 14.0),
                  decoration: inputDecorationRounded().copyWith(
                    hintText: "Client Allowed",
                    border: const OutlineInputBorder(),
                    fillColor: Colors.transparent,
                    contentPadding: const EdgeInsets.all(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              FormBodyRow(
                title: "Fake Operation Every",
                child: TextFormField(
                  controller: fakeOperationEveryController,
                  style: bodyFont.copyWith(fontSize: 14.0),
                  decoration: inputDecorationRounded().copyWith(
                    hintText: "Fake Operation Every",
                    border: const OutlineInputBorder(),
                    fillColor: Colors.transparent,
                    contentPadding: const EdgeInsets.all(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              FormBodyRow(
                title: "Remove Admin Page",
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Checkbox(
                    value: isRemoveAdminPage,
                    onChanged: (value) {
                      if (value == null) return;

                      setState(() {
                        isRemoveAdminPage = value;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              FormBodyRow(
                title: "Choose Band",
                child: DropdownButtonFormField<_BandDropdown>(
                  value: _selectedBand,
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() => _selectedBand = value);
                  },
                  decoration: inputDecorationRounded().copyWith(
                    hintText: "Choose Band",
                    border: const OutlineInputBorder(),
                    fillColor: Colors.transparent,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                  ),
                  items: bands
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.label),
                        ),
                      )
                      .toList(),
                  validator: (value) {
                    if (value == null) {
                      return "Please select band";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),
              FormBodyRow(
                title: "Running Text",
                child: TextFormField(
                  controller: runningTextController,
                  style: bodyFont.copyWith(fontSize: 14.0),
                  decoration: inputDecorationRounded().copyWith(
                    hintText: "Running Text",
                    border: const OutlineInputBorder(),
                    fillColor: Colors.transparent,
                    contentPadding: const EdgeInsets.all(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              FormBodyRow(
                title: "Logo",
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (_selectedLogo != null) ...[
                      Image.memory(
                        _selectedLogo!,
                        width: 100,
                        height: 100,
                      ),
                      const SizedBox(height: 16.0),
                    ],
                    OutlinedButton.icon(
                      onPressed: onUpload,
                      icon: const Icon(Icons.file_upload),
                      label: const Text("Pick Image from Gallery"),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              FormBodyRow(
                title: "Enable Auto Clear",
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Checkbox(
                    value: isEnableAutoClear,
                    onChanged: (value) {
                      if (value == null) return;

                      setState(() => isEnableAutoClear = value);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              FormBodyRow(
                title: "Choose Machine Key Type",
                child: DropdownButtonFormField<_MachineKeyTypeDropdown>(
                  value: _selectedMachineKeyType,
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() => _selectedMachineKeyType = value);
                  },
                  decoration: inputDecorationRounded().copyWith(
                    hintText: "Choose Machine Key Type",
                    border: const OutlineInputBorder(),
                    fillColor: Colors.transparent,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                  ),
                  items: machineKeyTypes
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.label),
                        ),
                      )
                      .toList(),
                  validator: (value) {
                    if (value == null) {
                      return "Please select machine key type";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),
              FormBodyRow(
                title: "Machine Key Last",
                child: TextFormField(
                  controller: machineKeyLastController,
                  style: bodyFont.copyWith(fontSize: 14.0),
                  decoration: inputDecorationRounded().copyWith(
                    hintText: "Machine Key Last",
                    border: const OutlineInputBorder(),
                    fillColor: Colors.transparent,
                    contentPadding: const EdgeInsets.all(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: onSubmit,
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
