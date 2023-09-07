// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../injection.dart';
import '../../../model/model/form/form_machine_setting_create_update_model.dart';
import '../../../utils/enum.dart';
import '../../../utils/fonts.dart';
import '../../../utils/functions.dart';
import '../../../utils/styles.dart';
import '../../widgets/form_row_body.dart';

class MachineSettingFormPage extends ConsumerStatefulWidget {
  const MachineSettingFormPage({
    Key? key,
    required this.idMachine,
    required this.id,
  }) : super(key: key);
  final String idMachine;
  final String id;

  @override
  ConsumerState<MachineSettingFormPage> createState() =>
      _MachineSettingFormPageState();
}

class _MachineSettingFormPageState
    extends ConsumerState<MachineSettingFormPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _timeoutController;
  late final TextEditingController _backoffController;
  late final TextEditingController _triesController;

  MachineSettingToolsOptionEnum selectedToolsOption =
      MachineSettingToolsOptionEnum.allNumber;

  @override
  void initState() {
    super.initState();
    _timeoutController = TextEditingController();
    _backoffController = TextEditingController();
    _triesController = TextEditingController();

    final id = widget.id;
    final machineId = widget.idMachine;
    final isCreate = id == "-1";

    if (!isCreate) {
      Future.microtask(() {
        ref.read(machineSettingNotifier(widget.idMachine).notifier).getById(
              settingId: id,
              machineId: machineId,
            );
      });
    }
  }

  @override
  void dispose() {
    _timeoutController.dispose();
    _backoffController.dispose();
    _triesController.dispose();
    super.dispose();
  }

  Future<void> onSubmit() async {
    final validate = _formKey.currentState?.validate() ?? false;

    if (!validate) {
      return;
    }

    final notifier =
        ref.read(machineSettingNotifier(widget.idMachine).notifier);

    final settingId = widget.id;
    final machineId = widget.idMachine;
    final usePassword =
        selectedToolsOption == MachineSettingToolsOptionEnum.specificNumber
            ? true
            : false;
    final timeout = int.tryParse(_timeoutController.text) ?? 0;
    final backoff = int.tryParse(_backoffController.text) ?? 0;
    final tries = int.tryParse(_triesController.text) ?? 0;

    final form = FormMachineSettingCreateUpdateModel(
      machineId: machineId,
      usePassword: usePassword,
      timeout: timeout,
      tries: tries,
      backoff: backoff,
    );
    await notifier.update(
      form: form,
      settingId: settingId,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Listen to update
    ref.listen(
      machineSettingNotifier(widget.idMachine)
          .select((value) => value.onUpdate),
      (previous, next) {
        next.when(
          data: (data) {
            if (data != null) {
              showSnackbar(
                context: context,
                message: "Success update",
                backgroundColor: Colors.green,
              );
            }
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
            );
          },
        );
      },
    );

    // Listen to getById
    ref.listen(
      machineSettingNotifier(widget.idMachine)
          .select((value) => value.onGetById),
      (previous, next) {
        next.whenData((value) {
          if (value != null) {
            final isUsePassword = value.usePassword == 1;
            _timeoutController.text = value.timeout.toString();
            _backoffController.text = value.backoff.toString();
            _triesController.text = value.tries.toString();
            selectedToolsOption = isUsePassword
                ? MachineSettingToolsOptionEnum.specificNumber
                : MachineSettingToolsOptionEnum.allNumber;

            setState(() {});
          }
        });
      },
    );

    return WillPopScope(
      onWillPop: () async {
        ref.invalidate(machineSettingNotifier(widget.idMachine));
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Machine Setting Form"),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Action",
                          style: bodyFont.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        const Divider(),
                        Text(
                          "Select Option :",
                          style: bodyFont.copyWith(fontSize: 12.0),
                        ),
                        const SizedBox(height: 8.0),
                        DropdownButtonFormField<MachineSettingToolsOptionEnum>(
                          value: selectedToolsOption,
                          isExpanded: true,
                          style: bodyFont.copyWith(
                              fontSize: 12.0, color: Colors.grey),
                          onChanged: (value) {
                            if (value == null) return;
                            setState(() {
                              selectedToolsOption = value;
                            });
                          },
                          decoration: inputDecorationRounded().copyWith(
                            contentPadding: EdgeInsets.zero,
                            fillColor: Colors.transparent,
                          ),
                          items: MachineSettingToolsOptionEnum.values
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e.valueStringReadable),
                                ),
                              )
                              .toList(),
                          validator: (value) {
                            if (value == null) {
                              return "Select action is required";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20.0),
                        if (selectedToolsOption ==
                            MachineSettingToolsOptionEnum.specificNumber) ...[
                          const SizedBox(height: 20),
                          FormBodyRow(
                            title: "Timeout (hours)",
                            child: TextFormField(
                              controller: _timeoutController,
                              keyboardType: TextInputType.number,
                              style: bodyFont.copyWith(fontSize: 14.0),
                              decoration: inputDecorationRounded().copyWith(
                                border: const UnderlineInputBorder(),
                                fillColor: Colors.transparent,
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          FormBodyRow(
                            title: "Backoff (hours)",
                            child: TextFormField(
                              controller: _backoffController,
                              keyboardType: TextInputType.number,
                              style: bodyFont.copyWith(fontSize: 14.0),
                              decoration: inputDecorationRounded().copyWith(
                                border: const UnderlineInputBorder(),
                                fillColor: Colors.transparent,
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          FormBodyRow(
                            title: "Tries",
                            child: TextFormField(
                              controller: _triesController,
                              keyboardType: TextInputType.number,
                              style: bodyFont.copyWith(fontSize: 14.0),
                              decoration: inputDecorationRounded().copyWith(
                                border: const UnderlineInputBorder(),
                                fillColor: Colors.transparent,
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: onSubmit,
                  style: elevatedButtonStyle(),
                  child: const Text("Submit"),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
