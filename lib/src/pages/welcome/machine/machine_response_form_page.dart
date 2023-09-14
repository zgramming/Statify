import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../injection.dart';
import '../../../model/model/helper/form/form_machine_response_create_update_model.dart';
import '../../../utils/enum.dart';
import '../../../utils/fonts.dart';
import '../../../utils/functions.dart';
import '../../../utils/styles.dart';
import '../../widgets/form_row_body.dart';

class MachineResponseFormPage extends ConsumerStatefulWidget {
  const MachineResponseFormPage({
    Key? key,
    required this.isSMSBot,
    required this.idMachine,
    required this.id,
  }) : super(key: key);

  final bool isSMSBot;
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

  bool shouldReload = false;
  MachineResponsePlatformEnum selectedPlatform =
      MachineResponsePlatformEnum.sms;

  @override
  void initState() {
    super.initState();
    keyController = TextEditingController();
    valueController = TextEditingController();

    final idMachine = widget.idMachine;
    final id = widget.id;
    final isCreate = id == "-1";
    final notifier = ref.read(machineResponseNotifier(idMachine).notifier);
    if (!isCreate) {
      Future.microtask(() {
        notifier.getById(responseId: id);
      });
    } else {
      selectedPlatform = widget.isSMSBot
          ? MachineResponsePlatformEnum.sms
          : MachineResponsePlatformEnum.whatsapp;
    }

    setState(() {});
  }

  @override
  void dispose() {
    keyController.dispose();
    valueController.dispose();
    super.dispose();
  }

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
      platform: selectedPlatform.valueString,
    );

    if (isCreate) {
      await notifier.create(form: form);
    } else {
      await notifier.update(
        form: form,
        responseId: id,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Listen onCreate
    ref.listen(
        machineResponseNotifier(widget.idMachine)
            .select((value) => value.onCreate), (previous, next) {
      next.when(
        data: (data) {
          showSnackbar(
            context: context,
            message: "Success create machine response",
            backgroundColor: Colors.green,
          );

          // Reset form
          keyController.clear();
          valueController.clear();
          _formKey.currentState?.reset();

          // Reload data
          shouldReload = true;
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

    // Listen onUpdate
    ref.listen(
      machineResponseNotifier(widget.idMachine)
          .select((value) => value.onUpdate),
      (previous, next) {
        next.when(
          data: (data) {
            if (data == null) return null;
            showSnackbar(
              context: context,
              message: "Success update machine response",
              backgroundColor: Colors.green,
            );

            // Reload data
            shouldReload = true;
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

    // Listen onGetById
    ref.listen(
      machineResponseNotifier(widget.idMachine)
          .select((value) => value.onGetById),
      (previous, next) {
        next.whenData((value) {
          if (value != null) {
            keyController.text = value.key;
            valueController.text = value.value;
            selectedPlatform = value.platform;

            setState(() {});
          }
        });
      },
    );
    return WillPopScope(
      onWillPop: () {
        if (shouldReload) {
          ref.invalidate(machineResponseNotifier(widget.idMachine));
        }
        return Future.value(true);
      },
      child: Scaffold(
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
                  FormBodyRow(
                    title: "Insert key",
                    child: TextFormField(
                      controller: keyController,
                      style: bodyFont.copyWith(fontSize: 14.0),
                      decoration: inputDecorationRounded().copyWith(
                        border: const UnderlineInputBorder(),
                        fillColor: Colors.transparent,
                        contentPadding: EdgeInsets.zero,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Key is required";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  FormBodyRow(
                    title: "Insert value",
                    child: TextFormField(
                      controller: valueController,
                      style: bodyFont.copyWith(fontSize: 14.0),
                      keyboardType: TextInputType.multiline,
                      minLines: 3,
                      maxLines: 10,
                      decoration: inputDecorationRounded().copyWith(
                        border: const UnderlineInputBorder(),
                        fillColor: Colors.transparent,
                        contentPadding: EdgeInsets.zero,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Value is required";
                        }
                        return null;
                      },
                    ),
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
      ),
    );
  }
}
