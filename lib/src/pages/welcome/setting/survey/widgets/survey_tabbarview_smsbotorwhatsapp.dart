import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../injection.dart';
import '../../../../../model/model/helper/form/form_survey_create_update.model.dart';
import '../../../../../model/model/helper/form/form_survey_setting_create_update_model.dart';
import '../../../../../model/model/helper/props/props_get_survey_setting_detail.model.dart';
import '../../../../../model/model/survey_response/survey_response_model.dart';
import '../../../../../router.dart';
import '../../../../../utils/enum.dart';
import '../../../../../utils/fonts.dart';
import '../../../../../utils/functions.dart';
import '../../../../../utils/styles.dart';
import '../../../../../view_model/custom_notifier/get_machine_setting_detail.notifier.dart';
import '../../../../../view_model/custom_provider/custom_form_provider.dart';
import '../../../../widgets/async_error_builder.dart';
import '../../../../widgets/form_row_body.dart';

class SurveyTabBarViewSMSBotOrWhatsapp extends ConsumerStatefulWidget {
  const SurveyTabBarViewSMSBotOrWhatsapp({
    Key? key,
    required this.surveyId,
    required this.idSetting,
    required this.isSMSBot,
  }) : super(key: key);

  final String surveyId;
  final String idSetting;
  final bool isSMSBot;

  @override
  ConsumerState<SurveyTabBarViewSMSBotOrWhatsapp> createState() =>
      SurveyTabBarViewSMSBotOrWhatsappState();
}

class SurveyTabBarViewSMSBotOrWhatsappState
    extends ConsumerState<SurveyTabBarViewSMSBotOrWhatsapp> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _timeoutController;
  late final TextEditingController _backoffController;
  late final TextEditingController _triesController;

  MachineSettingToolsOptionEnum selectedToolsOption =
      MachineSettingToolsOptionEnum.allNumber;

  Future<void> init() async {
    final notifier = ref.read(surveyResponseNotifier(widget.surveyId).notifier);
    await notifier.getAll();
  }

  Future<void> onAdd() async {
    context.pushNamed(
      routeSurveyResponseForm,
      pathParameters: {
        "id": "-1",
        "idSurvey": widget.surveyId,
      },
      extra: {
        "isSMSBot": widget.isSMSBot,
      },
    );
  }

  void onChangeTries(String? value) {
    if (value == null) return;

    final form = ref.read(CustomFormProvider.surveyForm.notifier);
    if (widget.isSMSBot) {
      form.update(
        (state) => state.copyWith(
          sms: state.sms?.copyWith(
            tries: int.tryParse(value) ?? 0,
          ),
        ),
      );
    } else {
      form.update(
        (state) => state.copyWith(
          wa: state.wa?.copyWith(
            tries: int.tryParse(value) ?? 0,
          ),
        ),
      );
    }
  }

  void onChangeBackoff(String? value) {
    if (value == null) return;

    final form = ref.read(CustomFormProvider.surveyForm.notifier);
    if (widget.isSMSBot) {
      form.update(
        (state) => state.copyWith(
          sms: state.sms?.copyWith(
            backoff: int.tryParse(value) ?? 0,
          ),
        ),
      );
    } else {
      form.update(
        (state) => state.copyWith(
          wa: state.wa?.copyWith(
            backoff: int.tryParse(value) ?? 0,
          ),
        ),
      );
    }
  }

  void onChangeTimeout(String? value) {
    if (value == null) return;

    final form = ref.read(CustomFormProvider.surveyForm.notifier);
    if (widget.isSMSBot) {
      form.update(
        (state) => state.copyWith(
          sms: state.sms?.copyWith(
            timeout: int.tryParse(value) ?? 0,
          ),
        ),
      );
    } else {
      form.update(
        (state) => state.copyWith(
          wa: state.wa?.copyWith(
            timeout: int.tryParse(value) ?? 0,
          ),
        ),
      );
    }
  }

  void onChangeSurveyToolOption(
    MachineSettingToolsOptionEnum? value,
  ) async {
    if (value == null) return;

    final form = ref.read(CustomFormProvider.surveyForm.notifier);
    if (widget.isSMSBot) {
      form.update(
        (state) => state.copyWith(
          sms: state.sms?.copyWith(
            usePassword: value == MachineSettingToolsOptionEnum.specificNumber,
          ),
        ),
      );
    } else {
      form.update(
        (state) => state.copyWith(
          wa: state.wa?.copyWith(
            usePassword: value == MachineSettingToolsOptionEnum.specificNumber,
          ),
        ),
      );
    }

    // Update state
    setState(() => selectedToolsOption = value);
  }

  Future<void> onSaveSetting() async {
    if (!_formKey.currentState!.validate()) return;

    final settingId = widget.idSetting;
    final surveyId = widget.surveyId;

    final timeout = _timeoutController.text;
    final backoff = _backoffController.text;
    final tries = _triesController.text;
    final usePassword =
        selectedToolsOption == MachineSettingToolsOptionEnum.specificNumber
            ? true
            : false;

    final notifier = ref.read(surveySettingNotifier(surveyId).notifier);
    final form = FormSurveySettingCreateUpdateModel(
      backoff: int.tryParse(backoff) ?? 0,
      timeout: int.tryParse(timeout) ?? 0,
      tries: int.tryParse(tries) ?? 0,
      usePassword: usePassword,
    );

    try {
      final result = await notifier.update(form: form, settingId: settingId);

      result.onUpdate.when(
        data: (data) {
          if (data == null) return;
          showSnackbar(
            context: context,
            message: "Success update setting",
            backgroundColor: Colors.green,
          );

          // Reload survey setting
          ref.invalidate(surveySettingNotifier);
        },
        error: (error, stackTrace) => showSnackbar(
          context: context,
          message: error.toString(),
          backgroundColor: Colors.red,
        ),
        loading: () => showSnackbar(
          context: context,
          message: "Updating...",
          backgroundColor: Colors.blue,
        ),
      );
    } catch (e) {
      showSnackbar(
        context: context,
        message: e.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _timeoutController = TextEditingController();
    _backoffController = TextEditingController();
    _triesController = TextEditingController();

    Future.microtask(() => init());
  }

  @override
  void dispose() {
    _timeoutController.dispose();
    _backoffController.dispose();
    _triesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final props = PropsGetSurveySettingDetail(
      surveyId: widget.surveyId,
      settingId: widget.idSetting,
    );
    ref.listen(
      getSurveySettingDetailNotifier(props),
      (previous, next) {
        next.whenData((value) {
          if (value == null) return;
          _timeoutController.text = value.timeout.toString();
          _backoffController.text = value.backoff.toString();
          _triesController.text = value.tries.toString();
          selectedToolsOption = value.usePassword
              ? MachineSettingToolsOptionEnum.specificNumber
              : MachineSettingToolsOptionEnum.allNumber;

          // setup form provider
          ref.read(CustomFormProvider.surveyForm.notifier).update((state) {
            if (widget.isSMSBot) {
              final result = state.copyWith(
                sms: FormSurveyCreateOrUpdateWAorSMSBotModel(
                  usePassword: value.usePassword,
                  timeout: value.timeout,
                  backoff: value.backoff,
                  tries: value.tries,
                  settingId: value.id,
                ),
              );

              return state = result;
            } else {
              final result = state.copyWith(
                wa: FormSurveyCreateOrUpdateWAorSMSBotModel(
                  usePassword: value.usePassword,
                  timeout: value.timeout,
                  backoff: value.backoff,
                  tries: value.tries,
                  settingId: value.id,
                ),
              );

              return state = result;
            }
          });
        });
      },
    );

    final settingDetailAsync = ref.watch(getSurveySettingDetailNotifier(props));
    final responseAsync =
        ref.watch(surveyResponseNotifier(widget.surveyId)).onGetAll;
    return settingDetailAsync.when(
      data: (_) {
        return SingleChildScrollView(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                FormBodyRow(
                  title: "Survey Tool Option",
                  child: DropdownButtonFormField<MachineSettingToolsOptionEnum>(
                    value: selectedToolsOption,
                    isExpanded: true,
                    style:
                        bodyFont.copyWith(fontSize: 12.0, color: Colors.grey),
                    onChanged: onChangeSurveyToolOption,
                    decoration: inputDecorationRounded().copyWith(
                      contentPadding: EdgeInsets.zero,
                      fillColor: Colors.transparent,
                      border: const UnderlineInputBorder(),
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
                ),
                const SizedBox(height: 20),
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
                      onChanged: onChangeTimeout,
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
                      onChanged: onChangeBackoff,
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
                      onChanged: onChangeTries,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
                Builder(
                  builder: (context) {
                    return responseAsync.when(
                      data: (responses) {
                        final responseSMS = responses.where((element) {
                          return element.platform ==
                              MachineResponsePlatformEnum.sms;
                        }).toList();
                        final responseWhatsapp = responses.where((element) {
                          return element.platform ==
                              MachineResponsePlatformEnum.whatsapp;
                        }).toList();
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children:
                              ListTile.divideTiles(context: context, tiles: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: ElevatedButton.icon(
                                onPressed: onAdd,
                                icon: const Icon(Icons.add),
                                label: const Text("Add Response"),
                              ),
                            ),
                            if (widget.isSMSBot) ...[
                              ...responseSMS.map((e) {
                                return _ResponseItem(item: e);
                              }).toList()
                            ],
                            if (!widget.isSMSBot) ...[
                              ...responseWhatsapp.map((e) {
                                return _ResponseItem(item: e);
                              }).toList()
                            ],
                          ]).toList(),
                        );
                      },
                      error: (error, stackTrace) => AsyncErrorBuilder(
                        error: error.toString(),
                        onRetry: () => ref.invalidate(surveyResponseNotifier),
                      ),
                      loading: () => const Center(
                        child: CircularProgressIndicator(color: Colors.blue),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
      error: (error, stackTrace) {
        return Center(
          child: Text(
            error.toString(),
            style: bodyFont.copyWith(color: Colors.red),
          ),
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(color: Colors.blue),
      ),
    );
  }
}

class _ResponseItem extends ConsumerStatefulWidget {
  const _ResponseItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  final SurveyResponseModel item;

  @override
  ConsumerState<_ResponseItem> createState() => _ResponseItemState();
}

class _ResponseItemState extends ConsumerState<_ResponseItem> {
  Future<void> onEdit() async {
    context.pushNamed(routeSurveyResponseForm, pathParameters: {
      "id": widget.item.id,
      "idSurvey": widget.item.surveyId,
    });
  }

  Future<void> onDelete() async {
    final result = await ref
        .read(surveyResponseNotifier(widget.item.surveyId).notifier)
        .delete(responseId: widget.item.id);
    result.onDelete.when(
      data: (data) => ref.invalidate(surveyResponseNotifier),
      error: (error, stackTrace) => showSnackbar(
        context: context,
        message: error.toString(),
        backgroundColor: Colors.red,
      ),
      loading: () => showSnackbar(
        context: context,
        message: "Deleting...",
        backgroundColor: Colors.blue,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              widget.item.key,
              style: bodyFontBold.copyWith(fontSize: 12.0),
            ),
          ),
          Wrap(
            alignment: WrapAlignment.end,
            spacing: 8.0,
            children: [
              InkWell(
                onTap: onEdit,
                child: const Icon(
                  Icons.edit,
                  color: Colors.blue,
                  size: 16.0,
                ),
              ),
              InkWell(
                onTap: onDelete,
                child: const Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: 16.0,
                ),
              ),
            ],
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 10.0),
          Text(
            widget.item.value,
            style: bodyFont.copyWith(fontSize: 10.0),
          ),
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }
}
