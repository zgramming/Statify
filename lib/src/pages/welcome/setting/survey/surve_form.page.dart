// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection.dart';
import '../../../../model/datasource/remote/survey_remote_datasource.dart';
import '../../../../utils/enum.dart';
import '../../../../utils/fonts.dart';
import '../../../../utils/functions.dart';
import '../../../../utils/styles.dart';
import '../../../widgets/async_error_builder.dart';
import '../../../widgets/form_row_body.dart';

class SurveyFormPage extends ConsumerStatefulWidget {
  const SurveyFormPage({
    Key? key,
    required this.id,
    required this.idMachine,
  }) : super(key: key);
  final String id;
  final String idMachine;

  @override
  ConsumerState<SurveyFormPage> createState() => _SurveyFormPageState();
}

class _SurveyFormPageState extends ConsumerState<SurveyFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  MachineActionEnum selectedAction = MachineActionEnum.sms;
  SurveyTemplateEnum selectedTemplate = SurveyTemplateEnum.canditate;

  bool isEdit = false;

  Future<void> onSubmit() async {
    final validate = _formKey.currentState?.validate() ?? false;
    if (!validate) return;
    final name = _nameController.text;

    final notifier = ref.read(surveyNotifier(widget.idMachine).notifier);
    final isEdit = widget.id != "-1";
    final form = FormSurveyCreateOrUpdateModel(
      name: name,
      action: selectedAction.valueString,
      template: selectedTemplate.valueString,
    );
    if (isEdit) {
      final id = widget.id;
      await notifier.update(
        surveyId: id,
        form: form,
      );
    } else {
      await notifier.create(form: form);
    }
  }

  Future<void> init() async {
    isEdit = widget.id != "-1";

    final notifier = ref.read(surveyNotifier(widget.idMachine).notifier);
    await notifier.getById(surveyId: widget.id);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => init());
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifierListen = surveyNotifier(widget.idMachine);

    // Listen Update
    ref.listen(notifierListen.select((value) => value.onUpdate),
        (previous, next) {
      next.when(
        data: (data) {
          if (data == null) return;

          showSnackbar(
            context: context,
            message: "Success Update Survey ${data.name}",
            backgroundColor: Colors.green,
          );

          // Invalidate Machine
          ref.invalidate(surveyNotifier);
        },
        error: (error, stackTrace) => showSnackbar(
          context: context,
          message: error.toString(),
          backgroundColor: Colors.red,
        ),
        loading: () => showSnackbar(
          context: context,
          message: "Loading",
          backgroundColor: Colors.blue,
        ),
      );
    });

    // Listen Create
    ref.listen(notifierListen.select((value) => value.onCreate),
        (previous, next) {
      next.when(
        data: (data) {
          if (data == null) return;

          showSnackbar(
            context: context,
            message: "Success Create Survey ${data.name}",
            backgroundColor: Colors.green,
          );

          // Invalidate Machine
          ref.invalidate(surveyNotifier);
        },
        error: (error, stackTrace) => showSnackbar(
          context: context,
          message: error.toString(),
          backgroundColor: Colors.red,
        ),
        loading: () => showSnackbar(
            context: context, message: "Loading", backgroundColor: Colors.blue),
      );
    });

    // Listen Get By Id
    ref.listen(
      notifierListen.select((value) => value.onGetById),
      (previous, next) {
        next.whenData((value) {
          if (value == null) return;
          _nameController.text = value.name;
          selectedAction = value.action;
          setState(() {});
        });
      },
    );

    final surveyAsync =
        ref.watch(surveyNotifier(widget.idMachine)).onGetById.unwrapPrevious();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Survey Form"),
      ),
      body: Builder(
        builder: (context) {
          return surveyAsync.when(
            data: (surveyDetail) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Card(
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 20),
                          FormBodyRow(
                            title: "Name",
                            child: TextFormField(
                              controller: _nameController,
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
                            title: "Action",
                            child: DropdownButtonFormField<MachineActionEnum>(
                              value: selectedAction,
                              onChanged: (value) {
                                if (value == null) return;
                                setState(() {
                                  selectedAction = value;
                                });
                              },
                              decoration: inputDecorationRounded().copyWith(
                                hintText: "Choose Template",
                                contentPadding: EdgeInsets.zero,
                                fillColor: Colors.transparent,
                                border: const UnderlineInputBorder(),
                              ),
                              items: MachineActionEnum.values
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(
                                        e.valueStringReadable,
                                        style: bodyFont.copyWith(
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              validator: (value) {
                                if (value == null) {
                                  return "Action Should not be empty";
                                }
                                return null;
                              },
                            ),
                          ),
                          //  Only show template if create
                          if (!isEdit) ...[
                            const SizedBox(height: 20),
                            FormBodyRow(
                              title: "Template",
                              child:
                                  DropdownButtonFormField<SurveyTemplateEnum>(
                                value: selectedTemplate,
                                onChanged: (value) {
                                  if (value == null) return;
                                  setState(() {
                                    selectedTemplate = value;
                                  });
                                },
                                decoration: inputDecorationRounded().copyWith(
                                  hintText: "Choose Template",
                                  contentPadding: EdgeInsets.zero,
                                  fillColor: Colors.transparent,
                                  border: const UnderlineInputBorder(),
                                ),
                                items: SurveyTemplateEnum.values
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(
                                          e.valueStringReadable,
                                          style: bodyFont.copyWith(
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                                validator: (value) {
                                  if (value == null) {
                                    return "Template Should not be empty";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
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
            },
            error: (error, stackTrace) => AsyncErrorBuilder(
              error: error.toString(),
              onRetry: () => ref.invalidate(surveyNotifier),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
