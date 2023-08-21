import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../injection.dart';
import '../../../utils/functions.dart';
import '../../../utils/styles.dart';

class MachineWhatsAppFormPage extends ConsumerStatefulWidget {
  const MachineWhatsAppFormPage({
    Key? key,
    required this.idMachine,
    required this.id,
  }) : super(key: key);

  final String idMachine;
  final String id;

  @override
  ConsumerState<MachineWhatsAppFormPage> createState() =>
      _MachineWhatsAppFormPageState();
}

class _MachineWhatsAppFormPageState
    extends ConsumerState<MachineWhatsAppFormPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _numberController;

  Future<void> onSubmit() async {
    final validate = _formKey.currentState?.validate() ?? false;

    if (!validate) {
      return;
    }

    final notifier = ref.read(machineWhatsappNotifier.notifier);

    final machineId = widget.idMachine;
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
          showSnackbar(
            context: context,
            backgroundColor: Colors.green,
            message:
                "Berhasil membuat mesin whatsapp dengan nomor ${data?.number}",
          );

          // Reset form
          _formKey.currentState?.reset();
          _numberController.clear();

          // Refresh data
          final userId = ref.read(authenticationNotifier).user?.id ?? "";
          ref.read(machineNotifier.notifier).getAll(userId);
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
        title: const Text("Machine WhatsApp Form"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _numberController,
                decoration: inputDecorationRounded().copyWith(
                  hintText: "Masukkan nomor WhatsApp",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Nomor WhatsApp tidak boleh kosong";
                  }
                  return null;
                },
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
