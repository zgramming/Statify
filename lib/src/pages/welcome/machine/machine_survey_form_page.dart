import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../injection.dart';
import '../../../utils/functions.dart';
import '../../../utils/styles.dart';

class MachineSurveyFormPage extends ConsumerStatefulWidget {
  const MachineSurveyFormPage({
    super.key,
    required this.idMachine,
    required this.id,
  });

  final String idMachine;
  final String id;

  @override
  ConsumerState<MachineSurveyFormPage> createState() =>
      _MachineSurveyFormPageState();
}

class _MachineSurveyFormPageState extends ConsumerState<MachineSurveyFormPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _numberController;

  Future<void> onSubmit() async {
    try {
      final validate = _formKey.currentState?.validate() ?? false;

      if (!validate) {
        return;
      }

      final notifier = ref.read(surveyNotifier.notifier);
      final machineId = widget.idMachine;
      await notifier.create(
        machineId: machineId,
        number: _numberController.text,
      );
    } catch (e) {
      log(e.toString());
    }
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
    ref.listen(surveyNotifier.select((value) => value.onCreate),
        (previous, next) {
      next.when(
        data: (data) {
          showSnackbar(
            context: context,
            message: "Berhasil membuat survey dengan nomor ${data?.number}",
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
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Machine Survey Form"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _numberController,
                  decoration: inputDecorationRounded().copyWith(
                    hintText: "Masukkan nomor handphone",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Nomor handphone tidak boleh kosong";
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
      ),
    );
  }
}
