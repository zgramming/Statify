import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../injection.dart';
import '../../../../../model/model/helper/form/form_survey_create_update.model.dart';
import '../../../../../model/model/helper/form/form_survey_setting_create_update.model.dart';
import '../../../../../model/model/helper/props/props_get_survey_setting_detail.model.dart';
import '../../../../../utils/enum.dart';
import '../../../../../utils/fonts.dart';
import '../../../../../utils/functions.dart';
import '../../../../../utils/styles.dart';
import '../../../../../view_model/custom_notifier/get_machine_setting_detail.notifier.dart';
import '../../../../../view_model/custom_provider/custom_form_provider.dart';
import '../../../../widgets/form_row_body.dart';
import 'survey_tabbarview_response.dart';

class SurveyTabBarViewCategory extends ConsumerStatefulWidget {
  const SurveyTabBarViewCategory({
    Key? key,
    required this.surveyId,
    required this.idSetting,
    required this.isSMSBot,
  }) : super(key: key);

  final String surveyId;
  final String idSetting;
  final bool isSMSBot;

  @override
  ConsumerState<SurveyTabBarViewCategory> createState() =>
      SurveyTabBarViewCategoryState();
}

class SurveyTabBarViewCategoryState
    extends ConsumerState<SurveyTabBarViewCategory> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _timeoutController;
  late final TextEditingController _backoffController;
  late final TextEditingController _triesController;

  MachineSettingToolsOptionEnum selectedToolsOption =
      MachineSettingToolsOptionEnum.allNumber;

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
            usePassword: value == MachineSettingToolsOptionEnum.specific_number,
          ),
        ),
      );
    } else {
      form.update(
        (state) => state.copyWith(
          wa: state.wa?.copyWith(
            usePassword: value == MachineSettingToolsOptionEnum.specific_number,
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
        selectedToolsOption == MachineSettingToolsOptionEnum.specific_number
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
      if (!mounted) return;

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
              ? MachineSettingToolsOptionEnum.specific_number
              : MachineSettingToolsOptionEnum.allNumber;

          // setup form provider
          ref.read(CustomFormProvider.surveyForm.notifier).update(
            (state) {
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
            },
          );
        });
      },
    );

    final settingDetailAsync = ref.watch(getSurveySettingDetailNotifier(props));

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
                    style: bodyFont.copyWith(
                      fontSize: 12.0,
                      color: Colors.grey,
                    ),
                    onChanged: onChangeSurveyToolOption,
                    decoration: inputDecorationRounded().copyWith(
                      hintText: "Select Option",
                      border: const OutlineInputBorder(),
                      fillColor: Colors.transparent,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 4.0,
                        horizontal: 8.0,
                      ),
                    ),
                    items: MachineSettingToolsOptionEnum.values
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                              e.valueStringReadable,
                            ),
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
                    MachineSettingToolsOptionEnum.specific_number) ...[
                  const SizedBox(height: 20),
                  FormBodyRow(
                    title: "Invitation Timeout (hours)",
                    child: TextFormField(
                      controller: _timeoutController,
                      keyboardType: TextInputType.number,
                      style: bodyFont.copyWith(fontSize: 14.0),
                      decoration: inputDecorationRounded().copyWith(
                        hintText: "Input timeout",
                        border: const OutlineInputBorder(),
                        fillColor: Colors.transparent,
                        contentPadding: const EdgeInsets.all(8),
                      ),
                      onChanged: onChangeTimeout,
                    ),
                  ),
                  const SizedBox(height: 20),
                  FormBodyRow(
                    title: "Banned time (hours)",
                    child: TextFormField(
                      controller: _backoffController,
                      keyboardType: TextInputType.number,
                      style: bodyFont.copyWith(fontSize: 14.0),
                      decoration: inputDecorationRounded().copyWith(
                        hintText: "Input backoff",
                        border: const OutlineInputBorder(),
                        fillColor: Colors.transparent,
                        contentPadding: const EdgeInsets.all(8),
                      ),
                      onChanged: onChangeBackoff,
                    ),
                  ),
                  const SizedBox(height: 20),
                  FormBodyRow(
                    title: "Banned after attempts ",
                    child: TextFormField(
                      controller: _triesController,
                      keyboardType: TextInputType.number,
                      style: bodyFont.copyWith(fontSize: 14.0),
                      decoration: inputDecorationRounded().copyWith(
                        hintText: "Input tries",
                        border: const OutlineInputBorder(),
                        fillColor: Colors.transparent,
                        contentPadding: const EdgeInsets.all(8),
                      ),
                      onChanged: onChangeTries,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
                SurveyTabbarViewResponse(
                  surveyId: widget.surveyId,
                  isSMSBot: widget.isSMSBot,
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
