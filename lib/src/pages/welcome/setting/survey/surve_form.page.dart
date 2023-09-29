import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../injection.dart';
import '../../../../model/model/helper/dropdown/machine_dropdown_model.dart';
import '../../../../model/model/helper/form/form_survey_create_update.model.dart';
import '../../../../utils/enum.dart';
import '../../../../utils/fonts.dart';
import '../../../../utils/functions.dart';
import '../../../../utils/styles.dart';
import '../../../../view_model/custom_notifier/get_all_survey_by_user.notifier.dart';
import '../../../../view_model/custom_provider/custom_form_provider.dart';
import '../../../../view_model/custom_provider/custom_provider.dart';
import '../../../widgets/async_error_builder.dart';
import '../../../widgets/form_row_body.dart';
import 'widgets/survey_tabbar_configuration.dart';

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
  MachineDropdownModel? _selectedMachine;

  bool isEdit = false;

  Future<void> onSubmit() async {
    final validate = _formKey.currentState?.validate() ?? false;
    if (!validate) return;

    try {
      final name = _nameController.text;

      final isEdit = widget.id != "-1";

      final defaultForm = FormSurveyCreateOrUpdateModel(
        idMachine: _selectedMachine?.id ?? "-1",
        name: name,
        action: selectedAction.valueString,
        template: selectedTemplate.valueString,
      );

      final formState =
          ref.read(CustomFormProvider.surveyForm.notifier).state.copyWith(
                action: defaultForm.action,
                idMachine: defaultForm.idMachine,
                name: defaultForm.name,
                template: defaultForm.template,
              );

      if (isEdit) {
        final id = widget.id;
        final notifier = ref.read(surveyNotifier(widget.idMachine).notifier);
        await notifier.update(
          surveyId: id,
          form: formState,
        );
      } else {
        final notifier = ref.read(
          surveyNotifier(_selectedMachine!.id).notifier,
        );

        await notifier.create(form: formState);
      }
    } catch (e) {
      if (!mounted) return;

      showSnackbar(
        context: context,
        message: e.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  Future<void> init() async {
    isEdit = widget.id != "-1";
    if (!isEdit) return;

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
    final notifierListen = surveyNotifier(
      isEdit ? widget.idMachine : _selectedMachine?.id ?? "-1",
    );

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
          ref.invalidate(getAllSurveyByUserGroupByMachineFutureProvider);

          // Back to previous page
          context.pop();
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
    ref.listen(
      notifierListen.select((value) => value.onCreate),
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
            ref.invalidate(getAllSurveyByUserGroupByMachineFutureProvider);

            // Back to previous page
            context.pop();
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
      },
    );

    // Listen Get By Id
    ref.listen(
      notifierListen.select((value) => value.onGetById),
      (previous, next) {
        next.whenData((value) {
          if (value == null) return;
          final machine =
              ref.read(CustomProvider.getMachineByIdProvider(value.machineId));
          _nameController.text = value.name;
          selectedAction = value.action;
          _selectedMachine = MachineDropdownModel(
            id: machine?.id ?? "-1",
            name: machine?.name ?? "Unknown",
          );

          setState(() {});
        });
      },
    );

    final surveyAsync =
        ref.watch(surveyNotifier(widget.idMachine)).onGetById.unwrapPrevious();
    final machines = ref.watch(machineNotifier).items;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Survey Form"),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Builder(
              builder: (context) {
                return surveyAsync.when(
                  data: (surveyDetail) {
                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Card(
                              elevation: 5,
                              margin: EdgeInsets.zero,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    FormBodyRow(
                                      title: "Choose Machine",
                                      child: DropdownButtonFormField<
                                          MachineDropdownModel>(
                                        value: _selectedMachine,
                                        onChanged: (value) {
                                          if (value == null) return;
                                          setState(() {
                                            _selectedMachine = value;
                                          });
                                        },
                                        decoration:
                                            inputDecorationRounded().copyWith(
                                          hintText: "Choose machine",
                                          border: const OutlineInputBorder(),
                                          fillColor: Colors.transparent,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                        ),
                                        items: machines
                                            .map((e) => MachineDropdownModel(
                                                id: e.id, name: e.name))
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
                                    const SizedBox(height: 20),
                                    FormBodyRow(
                                      title: "Name",
                                      child: TextFormField(
                                        controller: _nameController,
                                        style:
                                            bodyFont.copyWith(fontSize: 14.0),
                                        decoration:
                                            inputDecorationRounded().copyWith(
                                          hintText: "Enter name",
                                          border: const OutlineInputBorder(),
                                          fillColor: Colors.transparent,
                                          contentPadding:
                                              const EdgeInsets.all(8),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Name Should not be empty";
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    FormBodyRow(
                                      title: "Action",
                                      child: DropdownButtonFormField<
                                          MachineActionEnum>(
                                        value: selectedAction,
                                        onChanged: (value) {
                                          if (value == null) return;
                                          setState(() {
                                            selectedAction = value;
                                          });
                                        },
                                        decoration:
                                            inputDecorationRounded().copyWith(
                                          hintText: "Choose Action",
                                          border: const OutlineInputBorder(),
                                          fillColor: Colors.transparent,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
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
                                    if (!isEdit) ...[
                                      const SizedBox(height: 20),
                                      FormBodyRow(
                                        title: "Template",
                                        child: DropdownButtonFormField<
                                            SurveyTemplateEnum>(
                                          value: selectedTemplate,
                                          onChanged: (value) {
                                            if (value == null) return;
                                            setState(() {
                                              selectedTemplate = value;
                                            });
                                          },
                                          decoration:
                                              inputDecorationRounded().copyWith(
                                            hintText: "Choose Template",
                                            border: const OutlineInputBorder(),
                                            fillColor: Colors.transparent,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 4,
                                            ),
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
                                  ],
                                ),
                              ),
                            ),
                            //  Only show template if create

                            if (isEdit) ...[
                              const SizedBox(height: 20),
                              SurveyTabBarConfiguration(surveyId: widget.id)
                            ],
                          ],
                        ),
                      ),
                    );
                  },
                  error: (error, stackTrace) => AsyncErrorBuilder(
                    error: error.toString(),
                    onRetry: () => ref.invalidate(surveyNotifier),
                  ),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                );
              },
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: onSubmit,
                style: elevatedButtonStyle(),
                child: const Text("Save"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
