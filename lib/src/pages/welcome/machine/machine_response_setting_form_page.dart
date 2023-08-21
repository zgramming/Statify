// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../injection.dart';
import '../../../utils/enum.dart';
import '../../../utils/functions.dart';
import '../../../utils/styles.dart';

class MachineResponseSettingFormPage extends ConsumerStatefulWidget {
  const MachineResponseSettingFormPage({
    Key? key,
    required this.idMachine,
    required this.id,
  }) : super(key: key);

  final String idMachine;
  final String id;

  @override
  ConsumerState<MachineResponseSettingFormPage> createState() =>
      _MachineResponseSettingFormPageState();
}

class _MachineResponseSettingFormPageState
    extends ConsumerState<MachineResponseSettingFormPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController keyController;
  late final TextEditingController valueController;
  MachineResponseSettingTypeEnum selectedType =
      MachineResponseSettingTypeEnum.welcome;

  Future<void> onSubmit() async {
    final validate = _formKey.currentState?.validate() ?? false;
    if (!validate) return;

    final idMachine = widget.idMachine;
    final id = widget.id;
    final isCreate = id == "-1";

    final notifier = ref.read(machineResponseSettingNotifier.notifier);
    final key = keyController.text;
    final value = valueController.text;

    if (isCreate) {
      await notifier.create(
        key: key,
        value: value,
        idMachine: idMachine,
        type: selectedType.valueString,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    keyController = TextEditingController();
    valueController = TextEditingController();
  }

  @override
  void dispose() {
    keyController.dispose();
    valueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(machineResponseSettingNotifier.select((value) => value.onCreate),
        (previous, next) {
      next.when(
        data: (data) {
          showSnackbar(
            context: context,
            message: "Berhasil membuat setting baru",
            backgroundColor: Colors.green,
          );

          // Reset form
          keyController.clear();
          valueController.clear();
          _formKey.currentState?.reset();

          // Reload data
          final notifier = ref.read(machineResponseSettingNotifier.notifier);
          final idMachine = widget.idMachine;
          Future.microtask(() => notifier.getAll(idMachine));
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
        title: const Text("Machine Response Setting Form"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: keyController,
                  decoration: inputDecorationRounded().copyWith(
                    hintText: "Masukkan key",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Key is required";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: valueController,
                  decoration: inputDecorationRounded().copyWith(
                    hintText: "Masukkan value",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Value is required";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                DropdownButtonFormField<MachineResponseSettingTypeEnum>(
                  value: selectedType,
                  decoration: inputDecorationRounded().copyWith(
                    hintText: "Pilih setting",
                  ),
                  items: MachineResponseSettingTypeEnum.values
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.valueStringReadable),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedType = value!;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return "Setting is required";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: onSubmit,
                  style: elevatedButtonStyle(),
                  child: const Text("Submit"),
                )
              ],
            )),
      ),
    );
  }
}
