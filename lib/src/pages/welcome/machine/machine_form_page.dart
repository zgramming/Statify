// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../injection.dart';
import '../../../model/model/form/form_machine_create_update_model.dart';
import '../../../utils/enum.dart';
import '../../../utils/fonts.dart';
import '../../../utils/functions.dart';
import '../../../utils/styles.dart';

class _FormBodyRow extends StatelessWidget {
  const _FormBodyRow({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: 5, child: Text(title)),
        Expanded(flex: 7, child: child),
      ],
    );
  }
}

class MachineFormPage extends ConsumerStatefulWidget {
  const MachineFormPage({
    super.key,
    required this.id,
  });

  final String id;

  @override
  ConsumerState<MachineFormPage> createState() => _MachineFormPageState();
}

class _MachineFormPageState extends ConsumerState<MachineFormPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _numberController;
  late final TextEditingController _licenseController;
  MachineActionEnum selectedAction = MachineActionEnum.sms;
  MachineSMSSettingEnum selectedSMSSetting = MachineSMSSettingEnum.sim1;

  Future<void> onSubmit() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    final id = widget.id;
    final isCreate = id == "-1";

    final notifier = ref.read(machineNotifier.notifier);

    final name = _nameController.text;
    final number = _numberController.text;
    final license = _licenseController.text;

    final form = FormMachineCreateUpdateModel(
      name: name,
      number: number,
      license: license,
      action: selectedAction.valueString,
      smsSetting: selectedSMSSetting.valueString,
    );

    if (isCreate) {
      await notifier.create(form);
    } else {
      await notifier.update(machineId: id, form: form);
    }
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _numberController = TextEditingController();
    _licenseController = TextEditingController();

    // Load Machine detail if id is not -1
    final id = widget.id;
    if (id != "-1") {
      Future.microtask(() {
        ref.read(machineNotifier.notifier).getById(machineId: id);
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    _licenseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Listen to onCreate
    ref.listen(machineNotifier.select((value) => value.onCreate),
        (previous, next) {
      next.when(
        data: (data) {
          showSnackbar(
            context: context,
            message: "Berhasil membuat mesin dengan nomor ${data?.number}",
            backgroundColor: Colors.green,
          );

          // Reset form
          _numberController.clear();
          _licenseController.clear();
          selectedAction = MachineActionEnum.sms;
          selectedSMSSetting = MachineSMSSettingEnum.sim1;
          _formKey.currentState?.reset();

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
    });

    // Listen to onUpdate

    ref.listen(
      machineNotifier.select((value) => value.onUpdate),
      (previous, next) {
        next.when(
          data: (data) {
            showSnackbar(
              context: context,
              message: "Berhasil mengubah mesin dengan nomor ${data?.number}",
              backgroundColor: Colors.green,
            );
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
      machineNotifier.select((value) => value.onGetById),
      (previous, next) {
        next.whenData((value) {
          _nameController.text = value?.name ?? "";
          _numberController.text = value?.number ?? "";
          _licenseController.text = value?.license ?? "";
          selectedAction = MachineActionEnum.values.byName(value?.action ?? "");
          selectedSMSSetting =
              MachineSMSSettingEnum.values.byName(value?.smsSetting ?? "");

          setState(() {});
        });
      },
    );

    return WillPopScope(
      onWillPop: () {
        ref.invalidate(machineNotifier);
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Form Mesin"),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  _FormBodyRow(
                    title: "Machine Name",
                    child: TextFormField(
                      controller: _nameController,
                      style: bodyFont.copyWith(fontSize: 14.0),
                      decoration: inputDecorationRounded().copyWith(
                        border: const UnderlineInputBorder(),
                        fillColor: Colors.transparent,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _FormBodyRow(
                    title: "No Serial Machine",
                    child: TextFormField(
                      controller: _numberController,
                      style: bodyFont.copyWith(fontSize: 14.0),
                      keyboardType: TextInputType.phone,
                      decoration: inputDecorationRounded().copyWith(
                        border: const UnderlineInputBorder(),
                        fillColor: Colors.transparent,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _FormBodyRow(
                    title: "Activation License",
                    child: TextFormField(
                      controller: _licenseController,
                      style: bodyFont.copyWith(fontSize: 14.0),
                      decoration: inputDecorationRounded().copyWith(
                        border: const UnderlineInputBorder(),
                        fillColor: Colors.transparent,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<MachineActionEnum>(
                    value: selectedAction,
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() {
                        selectedAction = value;
                      });
                    },
                    decoration: inputDecorationRounded(),
                    items: MachineActionEnum.values
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.valueStringReadable),
                          ),
                        )
                        .toList(),
                    validator: (value) {
                      if (value == null) {
                        return "Action tidak boleh kosong";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<MachineSMSSettingEnum>(
                    value: selectedSMSSetting,
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() {
                        selectedSMSSetting = value;
                      });
                    },
                    decoration: inputDecorationRounded(),
                    items: MachineSMSSettingEnum.values
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.valueStringReadable),
                          ),
                        )
                        .toList(),
                    validator: (value) {
                      if (value == null) {
                        return "SMS Setting tidak boleh kosong";
                      }
                      return null;
                    },
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
        ),
      ),
    );
  }
}
