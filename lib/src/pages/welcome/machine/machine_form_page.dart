// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../injection.dart';
import '../../../model/model/helper/dropdown/sim_choose_dropdown_model.dart';
import '../../../model/model/helper/form/form_machine_create_update.model.dart';
import '../../../model/model/route/scan-qrcode-serial-number.route-extra.model.dart';
import '../../../router.dart';
import '../../../utils/fonts.dart';
import '../../../utils/functions.dart';
import '../../../utils/styles.dart';
import '../../../view_model/custom_notifier/get_all_machine.notifier.dart';
import '../../../view_model/custom_provider/custom_provider.dart';
import '../../widgets/async_error_builder.dart';
import '../../widgets/form_body_row.dart';

class MachineFormPage extends ConsumerStatefulWidget {
  const MachineFormPage({
    super.key,
    required this.id,
    this.extraScannedQRCodeNewMachine,
  });

  final String id;
  final String? extraScannedQRCodeNewMachine;

  @override
  ConsumerState<MachineFormPage> createState() => _MachineFormPageState();
}

class _MachineFormPageState extends ConsumerState<MachineFormPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _licenseController = TextEditingController();
  final TextEditingController _serialNumberController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _ipController = TextEditingController();

  bool _needReload = false;

  List<SimChooseDropdownModel> availableSim = [];
  SimChooseDropdownModel? selectedSim;

  void onScanQRCode() async {
    final result = await context.pushNamed<String?>(
      routeScanQRCodeSerialNumberPage,
      extra: ScanQRCodeSerialNumberRouteExtraModel(
        isNewMachine: widget.id == "-1",
      ),
    );
    if (result == null) return;
    _serialNumberController.text = result;
    setState(() {});
  }

  void resetForm() {
    _nameController.clear();
    _licenseController.clear();
    _serialNumberController.clear();
    _formKey.currentState?.reset();
    _codeController.clear();
    _ipController.clear();
    _needReload = true;

    setState(() {});
  }

  Future<void> onSubmit() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    final id = widget.id;
    final isCreate = id == "-1";

    final notifier = ref.read(machineNotifier.notifier);

    final name = _nameController.text;
    final license = _licenseController.text;
    final serialNumber = _serialNumberController.text;
    final code = _codeController.text;
    final ip = _ipController.text;

    final form = FormMachineCreateUpdateModel(
      serialNumber: serialNumber,
      name: name,
      number: selectedSim?.value ?? "",
      license: license,
      code: code,
      ip: ip,
    );

    if (isCreate) {
      await notifier.create(form);
    } else {
      await notifier.update(machineId: id, form: form);
    }
  }

  void autoFilledScanQRCodeNewMachine() {
    final isCreate = widget.id == "-1";
    if (!isCreate) return;
    final extraScannedQRCodeNewMachine = widget.extraScannedQRCodeNewMachine;
    if (extraScannedQRCodeNewMachine == null) return;

    final splitted = extraScannedQRCodeNewMachine.split(",");
    if (splitted.length != 3) return;

    final [serialNumber, code, ip] = splitted;
    _serialNumberController.text = serialNumber;
    _codeController.text = code;
    _ipController.text = ip;
  }

  void init() {
    final id = widget.id;

    final resultAvailableSim = ref.read(CustomProvider.getAvailableSIM);
    availableSim = resultAvailableSim;
    selectedSim = availableSim.firstOrNull;

    // Load Machine detail if id is not -1
    ref.read(machineNotifier.notifier).getById(machineId: id);

    // Auto filled scan QR Code new machine
    autoFilledScanQRCodeNewMachine();

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => init());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _licenseController.dispose();
    _serialNumberController.dispose();
    _codeController.dispose();
    _ipController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Listen to onCreate
    ref.listen(machineNotifier.select((value) => value.onCreate),
        (previous, next) {
      next.when(
        data: (data) {
          if (data == null) return;
          showSnackbar(
            context: context,
            message: "Success create machine with number ${data.number}",
            backgroundColor: Colors.green,
          );

          ref.invalidate(getAllMachineFutureProvider);

          // Back to previous page
          context.pop();
        },
        error: (error, stackTrace) {
          showSnackbar(
            context: context,
            message: error.toString(),
            backgroundColor: Colors.red,
          );
        },
        loading: () {
          showSnackbar(
            context: context,
            message: "Loading...",
            backgroundColor: Colors.blue,
            duration: const Duration(days: 1),
          );
        },
      );
    });

    // Listen to onUpdate
    ref.listen(
      machineNotifier.select((value) => value.onUpdate),
      (previous, next) {
        next.when(
          data: (data) {
            if (data == null) return;
            showSnackbar(
              context: context,
              message: "Success update machine with number ${data.number}",
              backgroundColor: Colors.green,
            );

            // Update need reload
            _needReload = true;
            setState(() {});
          },
          error: (error, stackTrace) {
            showSnackbar(
              context: context,
              message: error.toString(),
              backgroundColor: Colors.red,
            );
          },
          loading: () {
            showSnackbar(
              context: context,
              message: "Loading...",
              backgroundColor: Colors.blue,
              duration: const Duration(days: 1),
            );
          },
        );
      },
    );

    // Listen to onGetById
    ref.listen(
      machineNotifier.select((value) => value.onGetById.unwrapPrevious()),
      (previous, next) {
        next.whenData((value) {
          if (value == null) return;
          final currentSim = availableSim
              .firstWhereOrNull((element) => element.value == value.number);

          _nameController.text = value.name;
          _licenseController.text = value.license ?? "";
          _serialNumberController.text = value.serialNumber;
          _codeController.text = value.code ?? "";
          _ipController.text = value.ip ?? "";
          selectedSim = currentSim;

          setState(() {});
        });
      },
    );

    final machine = ref.watch(machineNotifier).onGetById.unwrapPrevious();
    return PopScope(
      onPopInvoked: (didPop) {
        if (didPop && _needReload) {
          ref.invalidate(getAllMachineFutureProvider);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Form Machine"),
        ),
        body: Builder(builder: (context) {
          return machine.when(
            data: (machineDetail) => SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Card(
                      margin: EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 20),
                            FormBodyRow(
                              title: "Machine Name",
                              child: TextFormField(
                                controller: _nameController,
                                autofocus: widget.id == "-1",
                                style: bodyFont.copyWith(fontSize: 14.0),
                                decoration: inputDecorationRounded().copyWith(
                                  hintText: "Machine Name",
                                  border: const OutlineInputBorder(),
                                  fillColor: Colors.transparent,
                                  contentPadding: const EdgeInsets.all(8),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            FormBodyRow(
                              title: "Machine Phone Number",
                              child: DropdownButtonFormField<
                                  SimChooseDropdownModel>(
                                value: selectedSim,
                                onChanged: (value) {
                                  if (value == null) return;
                                  setState(() {
                                    selectedSim = value;
                                  });
                                },
                                decoration: inputDecorationRounded().copyWith(
                                  hintText: "Choose SIM",
                                  border: const OutlineInputBorder(),
                                  fillColor: Colors.transparent,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                ),
                                items: availableSim
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e.label),
                                      ),
                                    )
                                    .toList(),
                                validator: (value) {
                                  if (value == null) {
                                    return "Sim Should not be empty";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              margin: const EdgeInsets.only(),
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  FormBodyRow(
                                    title: "Machine Serial Number",
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                            controller: _serialNumberController,
                                            enabled: false,
                                            style: bodyFont.copyWith(
                                                fontSize: 14.0),
                                            decoration: inputDecorationRounded()
                                                .copyWith(
                                              border:
                                                  const OutlineInputBorder(),
                                              fillColor: Colors.transparent,
                                              contentPadding:
                                                  const EdgeInsets.all(8),
                                              hintText: "Serial Number",
                                            ),
                                          ),
                                        ),
                                        IconButton.outlined(
                                          onPressed: onScanQRCode,
                                          icon: const Icon(
                                            Icons.qr_code_scanner_rounded,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  // const SizedBox(height: 20),
                                  // FormBodyRow(
                                  //   title: "Activation License",
                                  //   child: TextFormField(
                                  //     controller: _licenseController,
                                  //     style: bodyFont.copyWith(fontSize: 14.0),
                                  //     keyboardType: TextInputType.phone,
                                  //     decoration: inputDecorationRounded().copyWith(
                                  //       border: const OutlineInputBorder(),
                                  //       fillColor: Colors.transparent,
                                  //       contentPadding: const EdgeInsets.all(8),
                                  //       hintText: "Activation License",
                                  //     ),
                                  //   ),
                                  // ),
                                  const SizedBox(height: 20),
                                  FormBodyRow(
                                    title: "PIN",
                                    child: TextFormField(
                                      controller: _codeController,
                                      enabled: false,
                                      style: bodyFont.copyWith(fontSize: 14.0),
                                      keyboardType: TextInputType.phone,
                                      decoration:
                                          inputDecorationRounded().copyWith(
                                        border: const OutlineInputBorder(),
                                        fillColor: Colors.transparent,
                                        contentPadding: const EdgeInsets.all(8),
                                        hintText: "PIN",
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  FormBodyRow(
                                    title: "IP",
                                    child: TextFormField(
                                      controller: _ipController,
                                      enabled: false,
                                      style: bodyFont.copyWith(fontSize: 14.0),
                                      keyboardType: TextInputType.phone,
                                      decoration:
                                          inputDecorationRounded().copyWith(
                                        border: const OutlineInputBorder(),
                                        fillColor: Colors.transparent,
                                        contentPadding: const EdgeInsets.all(8),
                                        hintText: "IP",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: onSubmit,
                              style: elevatedButtonStyle(),
                              child: const Text("Submit"),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                    // if (machineDetail != null) ...[
                    //   MachineTabBarConfiguration(idMachine: widget.id)
                    // ],
                  ],
                ),
              ),
            ),
            error: (error, stackTrace) => AsyncErrorBuilder(
              error: error.toString(),
              onRetry: () => "",
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
          );
        }),
      ),
    );
  }
}
