import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection.dart';
import '../../../../model/model/machine/machine_model.dart';
import '../../../../utils/fonts.dart';
import '../../../../utils/styles.dart';
import '../../../../view_model/custom_notifier/get_all_machine.notifier.dart';
import '../../../../view_model/custom_provider/custom_form_provider.dart';
import '../../../../view_model/custom_provider/custom_provider.dart';
import '../../../widgets/form_body_row.dart';

class LongDistanceAccessSMSPage extends ConsumerStatefulWidget {
  const LongDistanceAccessSMSPage({
    super.key,
    required this.idMachine,
  });
  final String idMachine;

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

  void init() {
    final machine = ref.read(
      CustomProvider.getMachineByIdProvider(widget.idMachine),
    );
    final config = machine?.config;

    if (config == null) {
      return;
    }

    _selectedTaskCount = config.taskCount == null
        ? null
        : int.parse(
            config.taskCount!,
          );

    onChangeTaskCount(_selectedTaskCount);

    setState(() {});
  }

  Future<void> onSubmit(bool isReboot) async {
    final form =
        ref.read(CustomFormProvider.ldaSMSForm(widget.idMachine).notifier);
    if (isReboot) {
      form.update((state) => state.copyWith(reboot: '1'));
    }

    final formState = form.state;
    final notifier = ref.read(machineNotifier.notifier);
    await notifier.updateConfig(formState);
  }

  void onChangeTaskCount(int? value) {
    if (value == null) return;

    // Set Form SMS LDC Provider
    final form =
        ref.read(CustomFormProvider.ldaSMSForm(widget.idMachine).notifier);
    final machine =
        ref.read(CustomProvider.getMachineByIdProvider(widget.idMachine));

    if (machine == null) return;

    form.update(
      (state) => state.copyWith(
        machineId: machine.id,
        count: "$value",
        taskCount: "$value",
      ),
    );

    setState(
      () {
        _selectedTaskCount = value;
        taskCounts.clear();
        for (int i = 1; i <= value; i++) {
          taskCounts.add(
            _TaskItem(
              key: UniqueKey(),
              index: i,
              machine: machine,
            ),
          );
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => init());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppBar(
            title: const Text('SMS'),
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
          Expanded(
            child: LayoutBuilder(builder: (context, constraints) {
              final height = constraints.maxHeight;
              return RefreshIndicator(
                onRefresh: () async =>
                    ref.invalidate(getAllMachineFutureProvider),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(8.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: height),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Card(
                          margin: const EdgeInsets.only(),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        "Task Count",
                                        style: bodyFontBold.copyWith(
                                            fontSize: 14.0),
                                      ),
                                      const SizedBox(height: 8.0),
                                      DropdownButtonFormField<int>(
                                        value: _selectedTaskCount,
                                        onChanged: onChangeTaskCount,
                                        decoration:
                                            inputDecorationRounded().copyWith(
                                          hintText: "Choose task count",
                                          border: const OutlineInputBorder(),
                                          fillColor: Colors.transparent,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
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
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        "Flash SMS",
                                        style: bodyFontBold.copyWith(
                                            fontSize: 14.0),
                                      ),
                                      const SizedBox(height: 8.0),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: SizedBox(
                                          height: 32,
                                          child: Switch.adaptive(
                                            value: _isFlashSMS,
                                            onChanged: (value) {
                                              setState(
                                                  () => _isFlashSMS = value);
                                            },
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ...taskCounts,
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _selectedTaskCount == null
                        ? null
                        : () => onSubmit(false),
                    style: elevatedButtonStyle(),
                    child: const Text("Save"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _selectedTaskCount == null
                        ? null
                        : () => onSubmit(true),
                    style: elevatedButtonStyle(),
                    child: const FittedBox(child: Text("Save & Reboot")),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _selectedTaskCount == null
                        ? null
                        : () => onSubmit(true),
                    style: elevatedButtonStyle(),
                    child: const Text("Reboot"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TaskItem extends ConsumerStatefulWidget {
  const _TaskItem({
    Key? key,
    required this.index,
    required this.machine,
  }) : super(key: key);

  final int index;
  final MachineModel machine;

  @override
  ConsumerState<_TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends ConsumerState<_TaskItem> {
  final senderController = TextEditingController();
  final messageController = TextEditingController();

  void init() {
    final config = widget.machine.config;
    if (config == null) return;

    String sender = "";
    String message = "";

    switch (widget.index) {
      case 1:
        sender = config.sender1 ?? "";
        message = config.sms1 ?? "";

        break;
      case 2:
        sender = config.sender2 ?? "";
        message = config.sms2 ?? "";
        break;
      case 3:
        sender = config.sender3 ?? "";
        message = config.sms3 ?? "";

        break;
      case 4:
        sender = config.sender4 ?? "";
        message = config.sms4 ?? "";

        break;
      case 5:
        sender = config.sender5 ?? "";
        message = config.sms5 ?? "";

        break;
      default:
    }

    senderController.text = sender;
    messageController.text = message;
    updateForm(true, sender: sender);
    updateForm(false, message: message);
  }

  void updateForm(
    bool isSender, {
    String? sender,
    String? message,
  }) {
    final idMachine = widget.machine.id;
    final form = ref.read(CustomFormProvider.ldaSMSForm(idMachine).notifier);
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
    updateForm(true, sender: value);
  }

  void onChangeMessage(String? value) {
    if (value == null) return;
    updateForm(false, message: value);
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
    return Container(
      margin: const EdgeInsets.only(top: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
        border: Border.all(
          color: Colors.grey.withOpacity(0.5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(1),
            blurRadius: 2,
            offset: const Offset(0, 0),
          ),
        ],
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
              titleFlex: 3,
              childFlex: 9,
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
            TextFormField(
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
          ],
        ),
      ),
    );
  }
}
