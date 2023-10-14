import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../injection.dart';
import '../../../model/model/helper/dropdown/machine_dropdown_model.dart';
import '../../../model/model/helper/form/form_machine_whatsapp_create_update.model.dart';
import '../../../utils/fonts.dart';
import '../../../utils/functions.dart';
import '../../../utils/styles.dart';
import '../../../view_model/custom_notifier/get_all_machine.notifier.dart';
import '../../../view_model/custom_provider/custom_provider.dart';
import '../../widgets/async_error_builder.dart';
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

  TextEditingController numberController = TextEditingController();

  MachineDropdownModel? _selectedMachine;

  void init() {
    final isEdit = widget.id != "-1";

    if (isEdit) {
      ref.read(machineWhatsappNotifier.notifier).getById(widget.id);
    }
  }

  Future<void> onSubmit() async {
    final validate = _formKey.currentState?.validate() ?? false;

    if (!validate) {
      return;
    }

    final isEdit = widget.id != "-1";

    final notifier = ref.read(machineWhatsappNotifier.notifier);

    final number = numberController.text;
    final machineId = _selectedMachine?.id ?? "";
    final form = FormMachineWhatsappCreateOrUpdateModel(
      number: number,
      machineId: machineId,
      whatsappId: null,
    );

    if (isEdit) {
      await notifier.update(
        form.copyWith(
          whatsappId: widget.id,
        ),
      );
    } else {
      await notifier.create(form);
    }
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => init());
  }

  @override
  void dispose() {
    numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Listen get by id machine whatsapp notifier
    ref.listen(
      machineWhatsappNotifier.select((value) => value.onGetById),
      (previous, next) {
        next.whenData(
          (value) {
            if (value == null) return;
            final machine = ref
                .read(CustomProvider.getMachineByIdProvider(value.machineId));
            numberController.text = value.number;
            _selectedMachine = MachineDropdownModel(
              id: machine?.id ?? "",
              name: machine?.name ?? "",
            );
          },
        );
      },
    );

    // Listen update machine whatsapp notifier
    ref.listen(
      machineWhatsappNotifier.select((value) => value.onUpdate),
      (previous, next) {
        next.when(
          data: (data) {
            if (data == null) return;
            showSnackbar(
              context: context,
              backgroundColor: Colors.green,
              message:
                  "Success update machine whatsapp with machine id: ${data.id} and number: ${numberController.text}",
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
      },
    );

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
                "Success create machine whatsapp with machine id: ${data.id} and number: ${numberController.text}",
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

    final machines = ref.watch(machineNotifier.select((value) => value.items));
    final whatsappAsync =
        ref.watch(machineWhatsappNotifier).onGetById.unwrapPrevious();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Machine WhatsApp Form"),
      ),
      body: Builder(builder: (context) {
        return whatsappAsync.when(
          data: (_) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FormBodyRow(
                      title: "Name / Number Whatsapp Business",
                      child: TextFormField(
                        controller: numberController,
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
                            .map((e) =>
                                MachineDropdownModel(id: e.id, name: e.name))
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
            );
          },
          error: (error, stackTrace) => AsyncErrorBuilder(
            error: error.toString(),
            onRetry: () => ref.invalidate(machineWhatsappNotifier),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
        );
      }),
    );
  }
}
