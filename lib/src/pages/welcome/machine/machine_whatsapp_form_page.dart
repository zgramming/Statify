import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../injection.dart';
import '../../../model/model/helper/dropdown/machine_dropdown_model.dart';
import '../../../utils/fonts.dart';
import '../../../utils/functions.dart';
import '../../../utils/styles.dart';
import '../../../view_model/custom_notifier/get_all_machine.notifier.dart';
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
    // Listen create machine whatsapp notifier
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

          // Refresh data
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

    final machines = ref.watch(machineNotifier).items;

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
                title: "Name / Number Whatsapp Business",
                child: TextFormField(
                  controller: _numberController,
                  style: bodyFont.copyWith(fontSize: 14.0),
                  decoration: inputDecorationRounded().copyWith(
                    hintText: "Enter name / number ",
                    border: const OutlineInputBorder(),
                    fillColor: Colors.transparent,
                    contentPadding: const EdgeInsets.all(8),
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
                    hintText: "Choose machine",
                    border: const OutlineInputBorder(),
                    fillColor: Colors.transparent,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
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
