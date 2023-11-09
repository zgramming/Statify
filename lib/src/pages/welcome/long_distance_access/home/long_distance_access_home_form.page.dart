import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../injection.dart';
import '../../../../model/model/helper/form/form_machine_update_config.model.dart';
import '../../../../utils/fonts.dart';
import '../../../../utils/functions.dart';
import '../../../../utils/styles.dart';
import '../../../../view_model/custom_provider/custom_provider.dart';

class LongDistanceAccessHomeFormPage extends ConsumerStatefulWidget {
  const LongDistanceAccessHomeFormPage({
    super.key,
    required this.idMachine,
    required this.index,
  });
  final String idMachine;
  final int index;

  @override
  ConsumerState<LongDistanceAccessHomeFormPage> createState() =>
      _LongDistanceAccessHomeFormPageState();
}

class _LongDistanceAccessHomeFormPageState
    extends ConsumerState<LongDistanceAccessHomeFormPage> {
  final senderController = TextEditingController();
  final messageController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void init() async {
    final machine = ref.watch(
      CustomProvider.getMachineByIdProvider(
        widget.idMachine,
      ),
    );

    final index = widget.index;
    if (machine == null) return;

    final config = machine.config;
    if (config == null) return;

    if (index == 1) {
      senderController.text = config.sender1 ?? "";
      messageController.text = config.sms1 ?? "";
    }

    if (index == 2) {
      senderController.text = config.sender2 ?? "";
      messageController.text = config.sms2 ?? "";
    }

    if (index == 3) {
      senderController.text = config.sender3 ?? "";
      messageController.text = config.sms3 ?? "";
    }

    if (index == 4) {
      senderController.text = config.sender4 ?? "";
      messageController.text = config.sms4 ?? "";
    }

    if (index == 5) {
      senderController.text = config.sender5 ?? "";
      messageController.text = config.sms5 ?? "";
    }
  }

  void onSubmit() async {
    final validate = formKey.currentState?.validate() ?? false;
    if (!validate) return;

    final machine = ref.read(
      CustomProvider.getMachineByIdProvider(
        widget.idMachine,
      ),
    );
    if (machine == null) return;
    final config = machine.config;
    if (config == null) return;

    final index = widget.index;
    FormMachineUpdateConfigModel form =
        FormMachineUpdateConfigModel.fromMachineConfigModel(machine.id, config);

    if (index == 1) {
      form = form.copyWith(
        sender1: senderController.text,
        sms1: messageController.text,
      );
    }

    if (index == 2) {
      form = form.copyWith(
        sender2: senderController.text,
        sms2: messageController.text,
      );
    }

    if (index == 3) {
      form = form.copyWith(
        sender3: senderController.text,
        sms3: messageController.text,
      );
    }

    if (index == 4) {
      form = form.copyWith(
        sender4: senderController.text,
        sms4: messageController.text,
      );
    }

    if (index == 5) {
      form = form.copyWith(
        sender5: senderController.text,
        sms5: messageController.text,
      );
    }

    final notifier = ref.read(machineNotifier.notifier);
    await notifier.updateConfig(form);
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => init());
  }

  @override
  void dispose() {
    senderController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      machineNotifier.select((value) => value.onUpdateConfig),
      (previous, next) {
        next.when(
          data: (data) {
            if (data == null) return;

            context.pop();
          },
          error: (error, stackTrace) => showSnackbar(
            context: context,
            message: error.toString(),
            backgroundColor: Colors.red,
          ),
          loading: () => showSnackbar(
            context: context,
            message: "Loading...",
            backgroundColor: Colors.blue,
          ),
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("LDA Home Form"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Text(
                        "Sender ${widget.index}",
                        style: bodyFontBold.copyWith(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Sender Name",
                          style: bodyFontBold.copyWith(
                            fontSize: 14.0,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: senderController,
                          style: bodyFont.copyWith(fontSize: 14.0),
                          decoration: inputDecorationRounded().copyWith(
                            border: const OutlineInputBorder(),
                            fillColor: Colors.transparent,
                            contentPadding: const EdgeInsets.all(8),
                            hintText: "Sender",
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Sender is required";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Message",
                          style: bodyFontBold.copyWith(
                            fontSize: 14.0,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: messageController,
                          minLines: 3,
                          maxLines: 5,
                          style: bodyFont.copyWith(fontSize: 14.0),
                          textInputAction: TextInputAction.newline,
                          decoration: inputDecorationRounded().copyWith(
                            border: const OutlineInputBorder(),
                            fillColor: Colors.transparent,
                            contentPadding: const EdgeInsets.all(8),
                            hintText: "Message",
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Message is required";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),

                    // FormBodyRow(
                    //   titleFlex: 3,
                    //   childFlex: 9,
                    //   title: "Sender",
                    //   child: TextFormField(
                    //     controller: senderController,
                    //     style: bodyFont.copyWith(fontSize: 14.0),
                    //     decoration: inputDecorationRounded().copyWith(
                    //       border: const OutlineInputBorder(),
                    //       fillColor: Colors.transparent,
                    //       contentPadding: const EdgeInsets.all(8),
                    //       hintText: "Sender",
                    //     ),
                    //     validator: (value) {
                    //       if (value == null || value.isEmpty) {
                    //         return "Sender is required";
                    //       }
                    //       return null;
                    //     },
                    //   ),
                    // ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: onSubmit,
              style: elevatedButtonStyle(),
              child: const Text("Submit"),
            ),
          ),
        ],
      ),
    );
  }
}
