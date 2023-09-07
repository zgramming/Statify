// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../injection.dart';
import '../../../model/model/form/form_machine_response_create_update_model.dart';
import '../../../utils/enum.dart';
import '../../../utils/functions.dart';
import '../../../utils/styles.dart';

class MachineResponseFormPage extends ConsumerStatefulWidget {
  const MachineResponseFormPage({
    Key? key,
    required this.idMachine,
    required this.id,
  }) : super(key: key);

  final String idMachine;
  final String id;

  @override
  ConsumerState<MachineResponseFormPage> createState() =>
      _MachineResponseFormPageState();
}

class _MachineResponseFormPageState
    extends ConsumerState<MachineResponseFormPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController keyController;
  late final TextEditingController valueController;
  MachineResponseTypeEnum selectedType = MachineResponseTypeEnum.welcome;
  MachineResponsePlatform selectedPlatform = MachineResponsePlatform.sms;

  Future<void> onSubmit() async {
    final validate = _formKey.currentState?.validate() ?? false;
    if (!validate) return;

    final idMachine = widget.idMachine;
    final id = widget.id;
    final isCreate = id == "-1";

    final notifier = ref.read(machineResponseNotifier(idMachine).notifier);
    final key = keyController.text;
    final value = valueController.text;

    final form = FormMachineResponseCreateUpdateModel(
      key: key,
      value: value,
      type: selectedType.valueString,
      platform: selectedPlatform.valueString,
    );
    if (isCreate) {
      await notifier.create(form: form);
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
    ref.listen(
        machineResponseNotifier(widget.idMachine)
            .select((value) => value.onCreate), (previous, next) {
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
          final idMachine = widget.idMachine;
          final notifier =
              ref.read(machineResponseNotifier(idMachine).notifier);
          Future.microtask(() => notifier.getAll());
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
                DropdownButtonFormField<MachineResponseTypeEnum>(
                  value: selectedType,
                  decoration: inputDecorationRounded().copyWith(
                    hintText: "Pilih setting",
                  ),
                  items: MachineResponseTypeEnum.values
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
                DropdownButtonFormField<MachineResponsePlatform>(
                  value: selectedPlatform,
                  decoration: inputDecorationRounded().copyWith(
                    hintText: "Pilih setting",
                  ),
                  items: MachineResponsePlatform.values
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.valueStringReadable),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedPlatform = value!;
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
