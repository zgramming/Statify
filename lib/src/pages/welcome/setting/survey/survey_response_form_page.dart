import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection.dart';
import '../../../../model/model/helper/form/form_machine_response_create_update.model.dart';
import '../../../../utils/enum.dart';
import '../../../../utils/fonts.dart';
import '../../../../utils/functions.dart';
import '../../../../utils/styles.dart';
import '../../../widgets/form_body_row.dart';

class SurveyResponseFormPage extends ConsumerStatefulWidget {
  const SurveyResponseFormPage({
    Key? key,
    required this.isSMSBot,
    required this.id,
    required this.idSurvey,
  }) : super(key: key);

  final bool isSMSBot;
  final String id;
  final String idSurvey;

  @override
  ConsumerState<SurveyResponseFormPage> createState() =>
      _SurveyResponseFormPageState();
}

class _SurveyResponseFormPageState
    extends ConsumerState<SurveyResponseFormPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController keyController;
  late final TextEditingController valueController;
  MachineResponsePlatformEnum selectedPlatform =
      MachineResponsePlatformEnum.sms;
  bool isVoting = false;
  bool isFinish = false;

  bool shouldReload = false;

  @override
  void initState() {
    super.initState();
    keyController = TextEditingController();
    valueController = TextEditingController();

    final id = widget.id;
    final isCreate = id == "-1";
    final notifier = ref.read(surveyResponseNotifier(widget.idSurvey).notifier);
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

    final id = widget.id;
    final isCreate = id == "-1";

    final notifier = ref.read(surveyResponseNotifier(widget.idSurvey).notifier);
    final key = keyController.text;
    final value = valueController.text;

    final form = FormMachineResponseCreateUpdateModel(
      key: key,
      value: value,
      platform: selectedPlatform.valueString,
      isVoting: isVoting,
      isFinish: isFinish,
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
    final listenNotifier = surveyResponseNotifier(widget.idSurvey);

    // Listen onCreate
    ref.listen(listenNotifier.select((value) => value.onCreate),
        (previous, next) {
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
      listenNotifier.select((value) => value.onUpdate),
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
      listenNotifier.select((value) => value.onGetById),
      (previous, next) {
        next.whenData((value) {
          if (value != null) {
            keyController.text = value.key;
            valueController.text = value.value;
            selectedPlatform = value.platform;
            isVoting = value.voting;
            isFinish = value.finish;

            setState(() {});
          }
        });
      },
    );
    return WillPopScope(
      onWillPop: () {
        if (shouldReload) {
          ref.invalidate(surveyResponseNotifier(widget.idSurvey));
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
                FormBodyRow(
                  title: "Voting",
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Checkbox(
                      value: isVoting,
                      onChanged: (value) {
                        isVoting = value ?? false;
                        setState(() {});
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                FormBodyRow(
                  title: "Finish",
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Checkbox(
                      value: isFinish,
                      onChanged: (value) {
                        isFinish = value ?? false;
                        setState(() {});
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: onSubmit,
                  style: elevatedButtonStyle(),
                  child: const Text("Submit"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
