import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../injection.dart';
import '../../../model/model/helper/dropdown/machine_dropdown_model.dart';
import '../../../utils/fonts.dart';
import '../../../utils/functions.dart';
import '../../../utils/styles.dart';
import '../../widgets/form_row_body.dart';

class MachineWhatsAppFormPage extends ConsumerStatefulWidget {
  const MachineWhatsAppFormPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  final String id;

  @override
  ConsumerState<MachineWhatsAppFormPage> createState() =>
      _MachineWhatsAppFormPageState();
}

class _MachineWhatsAppFormPageState
    extends ConsumerState<MachineWhatsAppFormPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _numberController;

  MachineDropdownModel? _selectedMachine;
  Future<void> onSubmit() async {
    final validate = _formKey.currentState?.validate() ?? false;

    if (!validate) {
      return;
    }

    final notifier = ref.read(machineWhatsappNotifier.notifier);

    final machineId = _selectedMachine?.id ?? "";
    await notifier.create(
      number: _numberController.text,
      machineId: machineId,
    );
  }

  @override
  void initState() {
    super.initState();
    _numberController = TextEditingController();
  }

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(machineWhatsappNotifier.select((value) => value.onCreate),
        (previous, next) {
      next.when(
        data: (data) {
          if (data == null) return;
          showSnackbar(
            context: context,
            backgroundColor: Colors.green,
            message:
                "Success create machine whatsapp with machine id: ${data.id} and number: ${_numberController.text}",
          );

          // Reset form
          _formKey.currentState?.reset();
          _numberController.clear();

          // Refresh data
          ref.invalidate(machineNotifier);
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

    final machines = ref.watch(machineNotifier).onGetAll.valueOrNull ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Machine WhatsApp Form"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FormBodyRow(
                title: "Number",
                child: TextFormField(
                  controller: _numberController,
                  style: bodyFont.copyWith(fontSize: 14.0),
                  keyboardType: TextInputType.number,
                  decoration: inputDecorationRounded().copyWith(
                    border: const UnderlineInputBorder(),
                    fillColor: Colors.transparent,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              FormBodyRow(
                title: "Choose Machine",
                child: DropdownButtonFormField<MachineDropdownModel>(
                  value: _selectedMachine,
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() {
                      _selectedMachine = value;
                    });
                  },
                  decoration: inputDecorationRounded().copyWith(
                    contentPadding: EdgeInsets.zero,
                    fillColor: Colors.transparent,
                    border: const UnderlineInputBorder(),
                  ),
                  items: machines
                      .map((e) => MachineDropdownModel(id: e.id, name: e.name))
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.name),
                        ),
                      )
                      .toList(),
                  validator: (value) {
                    if (value == null) {
                      return "Please select machine";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16.0),
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
