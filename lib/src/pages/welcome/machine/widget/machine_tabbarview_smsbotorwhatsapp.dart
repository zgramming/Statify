import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../injection.dart';
import '../../../../model/model/helper/form/form_machine_setting_create_update_model.dart';
import '../../../../model/model/helper/props/props.get_machine_setting_detail.dart';
import '../../../../model/model/machine_response/machine_response_model.dart';
import '../../../../router.dart';
import '../../../../utils/enum.dart';
import '../../../../utils/fonts.dart';
import '../../../../utils/functions.dart';
import '../../../../utils/styles.dart';
import '../../../../view_model/custom_notifier/get_machine_setting_detail.notifier.dart';
import '../../../widgets/async_error_builder.dart';
import '../../../widgets/form_row_body.dart';

class MachineTabBarViewSMSBotOrWhatsapp extends ConsumerStatefulWidget {
  const MachineTabBarViewSMSBotOrWhatsapp({
    Key? key,
    required this.idMachine,
    required this.idSetting,
    required this.isSMSBot,
  }) : super(key: key);

  final String idMachine;
  final String idSetting;
  final bool isSMSBot;

  @override
  ConsumerState<MachineTabBarViewSMSBotOrWhatsapp> createState() =>
      MachineTabBarViewSMSBotOrWhatsappState();
}

class MachineTabBarViewSMSBotOrWhatsappState
    extends ConsumerState<MachineTabBarViewSMSBotOrWhatsapp> {
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
  }

  @override
  void dispose() {
    _timeoutController.dispose();
    _backoffController.dispose();
    _triesController.dispose();
    super.dispose();
  }

  Future<void> onAddMachineResponse() async {
    context.pushNamed(
      routeMachineResponseForm,
      pathParameters: {
        "id": "-1",
        "idMachine": widget.idMachine,
      },
      extra: {
        "isSMSBot": widget.isSMSBot,
      },
    );
  }

  Future<void> onSaveSetting() async {
    if (!_formKey.currentState!.validate()) return;

    final settingId = widget.idSetting;
    final machineId = widget.idMachine;

    final timeout = _timeoutController.text;
    final backoff = _backoffController.text;
    final tries = _triesController.text;
    final usePassword =
        selectedToolsOption == MachineSettingToolsOptionEnum.specificNumber
            ? true
            : false;

    final notifier = ref.read(machineSettingNotifier(machineId).notifier);
    final form = FormMachineSettingCreateUpdateModel(
      backoff: int.tryParse(backoff) ?? 0,
      timeout: int.tryParse(timeout) ?? 0,
      tries: int.tryParse(tries) ?? 0,
      machineId: machineId,
      usePassword: usePassword,
    );

    try {
      await notifier.update(
        form: form,
        settingId: settingId,
        onLoading: () => showSnackbar(
          context: context,
          message: "Updating...",
          backgroundColor: Colors.blue,
        ),
        onError: (error) => showSnackbar(
          context: context,
          message: error,
          backgroundColor: Colors.red,
        ),
        onSuccess: (data) {
          showSnackbar(
            context: context,
            message: "Success update setting",
            backgroundColor: Colors.green,
          );

          // Reload machine setting
          ref.read(machineSettingNotifier(machineId).notifier).getAll();
        },
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
  Widget build(BuildContext context) {
    final props = PropsGetMachineSettingDetail(
      machineId: widget.idMachine,
      settingId: widget.idSetting,
    );
    ref.listen(
      getMachineSettingDetailNotifier(props),
      (previous, next) {
        next.whenData((value) {
          if (value == null) return;
          _timeoutController.text = value.timeout.toString();
          _backoffController.text = value.backoff.toString();
          _triesController.text = value.tries.toString();
          selectedToolsOption = value.usePassword
              ? MachineSettingToolsOptionEnum.specificNumber
              : MachineSettingToolsOptionEnum.allNumber;
        });
      },
    );

    final settingDetailAsync =
        ref.watch(getMachineSettingDetailNotifier(props));
    final responseAsync =
        ref.watch(machineResponseNotifier(widget.idMachine)).onGetAll;
    return settingDetailAsync.when(
      data: (_) {
        return SingleChildScrollView(
          child: Form(
            key: _formKey,
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
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() {
                        selectedToolsOption = value;
                      });
                    },
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
                ElevatedButton(
                  onPressed: onSaveSetting,
                  style: elevatedButtonStyle(),
                  child: const Text("Save Setting"),
                ),
                const SizedBox(height: 20),
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
                                onPressed: onAddMachineResponse,
                                icon: const Icon(Icons.add),
                                label: const Text("Add Response"),
                              ),
                            ),
                            if (widget.isSMSBot) ...[
                              ...responseSMS.map((e) {
                                return _MachineResponseItem(item: e);
                              }).toList()
                            ],
                            if (!widget.isSMSBot) ...[
                              ...responseWhatsapp.map((e) {
                                return _MachineResponseItem(item: e);
                              }).toList()
                            ],
                          ]).toList(),
                        );
                      },
                      error: (error, stackTrace) => AsyncErrorBuilder(
                        error: error.toString(),
                        onRetry: () => ref.invalidate(machineResponseNotifier),
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

class _MachineResponseItem extends ConsumerStatefulWidget {
  const _MachineResponseItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  final MachineResponseModel item;

  @override
  ConsumerState<_MachineResponseItem> createState() =>
      _MachineResponseItemState();
}

class _MachineResponseItemState extends ConsumerState<_MachineResponseItem> {
  Future<void> onEdit() async {
    context.pushNamed(routeMachineResponseForm, pathParameters: {
      "id": widget.item.id,
      "idMachine": widget.item.machineId,
    });
  }

  Future<void> onDelete() async {
    await ref
        .read(machineResponseNotifier(widget.item.machineId).notifier)
        .delete(
          responseId: widget.item.id,
          onLoading: () {
            showSnackbar(
                context: context,
                message: "Deleting...",
                backgroundColor: Colors.blue);
          },
          onError: (error) {
            showSnackbar(
              context: context,
              message: error,
              backgroundColor: Colors.red,
            );
          },
          onSuccess: (data) {
            showSnackbar(
              context: context,
              message: "Success delete response",
              backgroundColor: Colors.green,
            );

            // Reload machine response
            ref
                .read(machineResponseNotifier(widget.item.machineId).notifier)
                .getAll();
          },
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
