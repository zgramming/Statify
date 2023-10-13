import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../model/model/helper/form/form_machine_update_config.model.dart';
import '../../../../utils/fonts.dart';
import '../../../../utils/styles.dart';
import '../../../../view_model/custom_provider/custom_form_provider.dart';
import '../../../../view_model/custom_provider/custom_injection_provider.dart';
import '../../../widgets/form_row_body.dart';

class LongDistanceAccessSMSPage extends ConsumerStatefulWidget {
  const LongDistanceAccessSMSPage({super.key});

  @override
  ConsumerState<LongDistanceAccessSMSPage> createState() =>
      _LongDistanceAccessSMSPageState();
}

class _LongDistanceAccessSMSPageState
    extends ConsumerState<LongDistanceAccessSMSPage> {
  final taskCountOption = <int>[1, 2, 3, 4, 5];

  List<_TaskItem> taskCounts = [];

  int? _selectedTaskCount;
  bool _isFlashSMS = false;

  void onChangeTaskCount(int? value) {
    if (value == null) return;
    setState(
      () {
        _selectedTaskCount = value;
        taskCounts = [];
        taskCounts = [
          for (int i = 1; i <= value; i++) _TaskItem(index: i),
        ];

        // Set Form SMS LDA Provider
        final machineId = ref.read(CustomInjectionProvider.machineById)?.id;
        ref.read(CustomFormProvider.ldaSMSForm.notifier).update(
              (state) => FormMachineUpdateConfigModel(
                machineId: machineId ?? "",
                count: value,
                taskCount: value,
                isReboot: false,
              ),
            );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              margin: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FormBodyRow(
                      title: "Task Count",
                      child: DropdownButtonFormField<int>(
                        value: _selectedTaskCount,
                        onChanged: onChangeTaskCount,
                        decoration: inputDecorationRounded().copyWith(
                          hintText: "Choose task count",
                          border: const OutlineInputBorder(),
                          fillColor: Colors.transparent,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                        ),
                        items: taskCountOption
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text("$e"),
                              ),
                            )
                            .toList(),
                        validator: (value) {
                          if (value == null) {
                            return "Please select task count";
                          }
                          return null;
                        },
                      ),
                    ),
                    FormBodyRow(
                      title: "Flash SMS",
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Checkbox(
                          value: _isFlashSMS,
                          onChanged: (value) {
                            if (value == null) return;
                            setState(() => _isFlashSMS = value);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ...taskCounts,
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _selectedTaskCount == null
                          ? null
                          : () {
                              final form =
                                  ref.read(CustomFormProvider.ldaSMSForm);
                              log("form save : $form");
                            },
                      style: elevatedButtonStyle(),
                      child: const Text("Save"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _selectedTaskCount == null
                          ? null
                          : () {
                              final form = ref
                                  .read(CustomFormProvider.ldaSMSForm.notifier)
                                ..update(
                                    (state) => state.copyWith(isReboot: true));
                              log("form save & reboot : ${form.state}");
                            },
                      style: elevatedButtonStyle(),
                      child: const FittedBox(child: Text("Save & Reboot")),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _selectedTaskCount == null
                          ? null
                          : () {
                              final form = ref
                                  .read(CustomFormProvider.ldaSMSForm.notifier)
                                ..update(
                                    (state) => state.copyWith(isReboot: true));
                              log("form reboot : ${form.state}");
                            },
                      style: elevatedButtonStyle(),
                      child: const Text("Reboot"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TaskItem extends ConsumerStatefulWidget {
  const _TaskItem({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  ConsumerState<_TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends ConsumerState<_TaskItem> {
  final senderController = TextEditingController();
  final messageController = TextEditingController();

  void updateForm(
    bool isSender, {
    String? sender,
    String? message,
  }) {
    final form = ref.read(CustomFormProvider.ldaSMSForm.notifier);
    switch (widget.index) {
      case 1:
        form.update((state) {
          if (isSender) {
            return state = state.copyWith(sender1: sender);
          }

          return state = state.copyWith(sms1: message);
        });

        break;
      case 2:
        form.update((state) {
          if (isSender) {
            return state.copyWith(sender2: sender);
          }

          return state.copyWith(sms2: message);
        });
        break;
      case 3:
        form.update((state) {
          if (isSender) {
            return state.copyWith(sender3: sender);
          }

          return state.copyWith(sms3: message);
        });
        break;
      case 4:
        form.update((state) {
          if (isSender) {
            return state.copyWith(sender4: sender);
          }

          return state.copyWith(sms4: message);
        });
        break;
      case 5:
        form.update((state) {
          if (isSender) {
            return state.copyWith(sender5: sender);
          }

          return state.copyWith(sms5: message);
        });
        break;
      default:
    }
  }

  void onChangeSender(String? value) {
    if (value == null) return;
    log("sender : $value | index : ${widget.index}");
    updateForm(true, sender: value);
  }

  void onChangeMessage(String? value) {
    if (value == null) return;
    log("message : $value | index : ${widget.index}");
    updateForm(false, message: value);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    senderController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Task ${widget.index}",
              style: headerFontBold.copyWith(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8.0),
            FormBodyRow(
              title: "Sender",
              child: TextFormField(
                controller: senderController,
                style: bodyFont.copyWith(fontSize: 14.0),
                decoration: inputDecorationRounded().copyWith(
                  hintText: "Enter sender",
                  border: const OutlineInputBorder(),
                  fillColor: Colors.transparent,
                  contentPadding: const EdgeInsets.all(8),
                ),
                onChanged: onChangeSender,
              ),
            ),
            const SizedBox(height: 8.0),
            FormBodyRow(
              title: "Message",
              child: TextFormField(
                controller: messageController,
                style: bodyFont.copyWith(fontSize: 14.0),
                minLines: 3,
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                decoration: inputDecorationRounded().copyWith(
                  hintText: "Enter message",
                  border: const OutlineInputBorder(),
                  fillColor: Colors.transparent,
                  contentPadding: const EdgeInsets.all(8),
                ),
                onChanged: onChangeMessage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
