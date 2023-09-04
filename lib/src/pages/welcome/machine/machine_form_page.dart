// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../injection.dart';
import '../../../utils/enum.dart';
import '../../../utils/functions.dart';
import '../../../utils/styles.dart';

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

    final number = _numberController.text;
    final license = _licenseController.text;

    if (isCreate) {
      await notifier.create(
        number: number,
        license: license,
        action: selectedAction.valueString,
        smsSetting: selectedSMSSetting.valueString,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _numberController = TextEditingController();
    _licenseController = TextEditingController();
  }

  @override
  void dispose() {
    _numberController.dispose();
    _licenseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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

          // Reload data
          ref.invalidate(machineNotifier);

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

    return Scaffold(
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
                TextFormField(
                    controller: _numberController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Nomor tidak boleh kosong";
                      }
                      return null;
                    },
                    decoration: inputDecorationRounded().copyWith(
                      hintText: "Masukkan Nomor",
                    )),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _licenseController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "License tidak boleh kosong";
                    }
                    return null;
                  },
                  decoration: inputDecorationRounded().copyWith(
                    hintText: 'Masukkan License',
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
    );
  }
}
