import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../injection.dart';
import '../../../../../model/model/helper/props_provider/props_get_machine_by_ip.model.dart';
import '../../../../../model/model/machine/machine_config_boardips.model.dart';
import '../../../../../model/model/machine/machine_config_operator.model.dart';
import '../../../../../utils/fonts.dart';
import '../../../../../utils/functions.dart';
import '../../../../../utils/sizes.dart';
import '../../../../../utils/styles.dart';
import '../../../../../view_model/custom_notifier/get_machine_by_ip.notifier.dart';
import '../../../../../view_model/custom_provider/custom_form_provider.dart';
import '../../../../../view_model/custom_provider/custom_provider.dart';
import '../../../../../view_model/custom_provider/custom_state_provider.dart';
import '../../../../../view_model/custom_provider/model/lda_setting_sync_state.model.dart';

class LDASettingModalSyncronize extends ConsumerStatefulWidget {
  const LDASettingModalSyncronize({
    Key? key,
    required this.machineId,
  }) : super(key: key);
  final String machineId;

  @override
  ConsumerState<LDASettingModalSyncronize> createState() =>
      _LDASettingModalSyncronizeState();
}

class _LDASettingModalSyncronizeState
    extends ConsumerState<LDASettingModalSyncronize> {
  final ipController = TextEditingController();
  final intervalController = TextEditingController();

  void onTapSelectAll() {
    showSnackbar(context: context, message: "Not implemented yet");
  }

  void onTapUpload() async {
    try {
      final ip = ipController.text;
      final interval = intervalController.text;
      if (ip.isEmpty) {
        throw "IP cannot be empty";
      }

      final notifier = ref.read(machineNotifier.notifier);
      final form = ref
          .read(CustomFormProvider.ldaSettingForm(widget.machineId).notifier);

      final syncState = ref.read(CustomStateProvider.ldaSettingSyncState);
      for (final syn in syncState) {
        if (syn.twoGData.isNotEmpty) {
          form.update(
            (state) {
              final newTwoGData = [
                "${state.twoGData}",
                "${ip}_${syn.twoGData}",
              ];

              return state.copyWith(
                twoGData: newTwoGData.join("-"),
                twoGDataChanged: '1',
              );
            },
          );
        }

        if (syn.fourGDatas.isNotEmpty) {
          if (interval.isEmpty) {
            throw "Interval cannot be empty when 4G data is not empty";
          }

          form.update(
            (state) {
              final mapping4G = syn.fourGDatas
                  .map((e) => "${interval}_$e")
                  .toList()
                  .join("*");

              final newFourGData = [
                state.fourGData,
                "$ip=$mapping4G",
              ];

              return state.copyWith(
                fourGData: newFourGData.join("-"),
                fourGDataChanged: '1',
              );
            },
          );
        }

        final formState = form.state;
        await notifier.updateConfig(formState);

        // Close modal
        if (context.mounted) {
          Navigator.of(context).pop();
        }
      }
    } catch (e) {
      if (!context.mounted) return;

      showSnackbar(
        context: context,
        message: e.toString(),
        backgroundColor: Colors.red,
      );

      return;
    }
  }

  void onChangeIP(String value) {}

  void init() async {
    // Reset lda sync state

    ref
        .read(CustomStateProvider.ldaSettingSyncState.notifier)
        .update((state) => []);
  }

  @override
  void initState() {
    super.initState();

    Future.microtask(() => init());
  }

  @override
  void dispose() {
    ipController.dispose();
    intervalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    final machine =
        ref.watch(CustomProvider.getMachineByIdProvider(widget.machineId));
    final config = machine?.config;
    final boardIps = config?.boardIps ?? [];

    return AlertDialog(
      insetPadding: const EdgeInsets.all(8),
      contentPadding: const EdgeInsets.all(16),
      actionsPadding: const EdgeInsets.all(16),
      content: SizedBox(
        width: w(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text(
                "4G UPLOAD",
                style: headerFontBold.copyWith(fontSize: 20.0),
              ),
            ),
            const SizedBox(height: 10.0),
            SizedBox(
              height: h(context) / 3,
              width: w(context) * 0.8,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  child: _CustomDataTable(
                    boardIps: boardIps,
                    machineId: widget.machineId,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "IP",
                        style: bodyFont.copyWith(fontSize: 12.0),
                      ),
                      const SizedBox(height: 10.0),
                      TextFormField(
                        controller: ipController,
                        style: bodyFont.copyWith(fontSize: 14.0),
                        decoration: inputDecorationRounded().copyWith(
                          hintText: "IP",
                          border: const OutlineInputBorder(),
                          fillColor: Colors.transparent,
                          contentPadding: const EdgeInsets.all(8),
                        ),
                        onChanged: onChangeIP,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Interval",
                        style: bodyFont.copyWith(fontSize: 12.0),
                      ),
                      const SizedBox(height: 10.0),
                      TextFormField(
                        controller: intervalController,
                        style: bodyFont.copyWith(fontSize: 14.0),
                        decoration: inputDecorationRounded().copyWith(
                          hintText: "Interval",
                          border: const OutlineInputBorder(),
                          fillColor: Colors.transparent,
                          contentPadding: const EdgeInsets.all(8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
          ],
        ),
      ),
      actions: [
        if (!isKeyboardOpen)
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: onTapSelectAll,
                  style: elevatedButtonStyle(),
                  child: const Text("Select All"),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: ElevatedButton(
                  onPressed: onTapUpload,
                  style: elevatedButtonStyle(),
                  child: const Text("Upload"),
                ),
              ),
            ],
          ),
      ],
    );
  }
}

class _CustomDataTable extends ConsumerStatefulWidget {
  const _CustomDataTable({
    required this.boardIps,
    required this.machineId,
  });

  final List<MachineBoardIpsModel> boardIps;
  final String machineId;
  @override
  ConsumerState<_CustomDataTable> createState() => __CustomDataTableState();
}

class __CustomDataTableState extends ConsumerState<_CustomDataTable> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: w(context) * 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "OPERATOR PLMN",
                  style: bodyFont.copyWith(fontSize: 12.0),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  "2G DATA",
                  style: bodyFont.copyWith(fontSize: 12.0),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  "3G DATA",
                  style: bodyFont.copyWith(fontSize: 12.0),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  "4G DATA",
                  style: bodyFont.copyWith(fontSize: 12.0),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          for (final boardIp in widget.boardIps) ...[
            _CustomTableRow(
              boardIp: boardIp,
              machineId: widget.machineId,
            ),
            const Divider(),
          ],
        ],
      ),
    );
  }
}

class _CustomTableRow extends ConsumerWidget {
  const _CustomTableRow({
    Key? key,
    required this.boardIp,
    required this.machineId,
  }) : super(key: key);

  final MachineBoardIpsModel boardIp;
  final String machineId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleText = bodyFont.copyWith(fontSize: 12.0);

    final props = PropsGetMachineByIPModel(
      ip: boardIp.ip,
      machineId: machineId,
    );
    final future =
        ref.watch(getMachineByIPFutureProvider(props)).unwrapPrevious();
    return future.when(
      data: (data) {
        final operators = data?.config?.operators ?? [];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (final opr in operators)
              if (opr.label?.toLowerCase() == boardIp.name.toLowerCase())
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(boardIp.ip, style: styleText),
                          Text(boardIp.name, style: styleText),
                          Text("${opr.mcc}${opr.mnc}", style: styleText),
                        ],
                      ),
                    ),
                    _TwoGData(opr: opr, boardIp: boardIp.ip),
                    Expanded(
                      child: Text("${opr.threeGArfcn}", style: styleText),
                    ),
                    _FourGData(opr: opr, boardIp: boardIp.ip),
                  ],
                ),
          ],
        );
      },
      error: (e, s) => Text(e.toString()),
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class _TwoGData extends ConsumerStatefulWidget {
  const _TwoGData({
    Key? key,
    required this.opr,
    required this.boardIp,
  }) : super(key: key);

  final MachineConfigOperatorsModel opr;
  final String boardIp;

  @override
  ConsumerState<_TwoGData> createState() => _TwoGDataState();
}

class _TwoGDataState extends ConsumerState<_TwoGData> {
  bool isChecked = false;

  void onTapCheckbox(bool checked) {
    final notifier = ref.read(CustomStateProvider.ldaSettingSyncState.notifier);
    notifier.update((state) {
      final result = state
          .firstWhereOrNull((element) => element.boardIp == widget.boardIp);

      // Jika checklist
      if (checked) {
        // Tambahkan data baru
        final mcc = widget.opr.mcc;
        final mnc = widget.opr.mnc;
        final arfcn = widget.opr.arfcn;
        final newTwoGData =
            "${mcc}_${mnc}_$arfcn"; // NANTI DITAMBAHKAN PREFIX IP TEXTBOX
        state = [
          if (result == null) ...[
            ...state,
            LDASettingSyncStateModel(
              boardIp: widget.boardIp,
              twoGData: newTwoGData,
              fourGDatas: result?.fourGDatas ?? [],
            ),
          ] else
            for (final val in state)
              if (val.boardIp != widget.boardIp)
                val
              else
                LDASettingSyncStateModel(
                  boardIp: widget.boardIp,
                  twoGData: newTwoGData,
                  fourGDatas: result.fourGDatas,
                ),
        ];
      } else {
        state = [
          for (final val in state)
            if (val.boardIp != widget.boardIp)
              val
            else
              LDASettingSyncStateModel(
                boardIp: widget.boardIp,
                twoGData: "",
                fourGDatas: result?.fourGDatas ?? [],
              )
        ];
      }

      return state;
    });

    // Update state checkbox
    isChecked = checked;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final styleText = bodyFont.copyWith(fontSize: 12.0);

    return Expanded(
      child: Row(
        children: [
          Checkbox.adaptive(
            visualDensity: VisualDensity.compact,
            value: isChecked,
            onChanged: (value) {
              if (value == null) return;
              onTapCheckbox(value);
            },
          ),
          Text("${widget.opr.arfcn}", style: styleText),
        ],
      ),
    );
  }
}

class _FourGData extends ConsumerStatefulWidget {
  const _FourGData({
    Key? key,
    required this.opr,
    required this.boardIp,
  }) : super(key: key);

  final MachineConfigOperatorsModel opr;
  final String boardIp;

  @override
  ConsumerState<_FourGData> createState() => _FourGDataState();
}

class _FourGDataState extends ConsumerState<_FourGData> {
  final styleText = bodyFont.copyWith(fontSize: 12.0);

  List<String> checked = [];

  bool isChecked(String value) {
    return checked.contains(value);
  }

  void onTapCheckbox(String value) {
    if (isChecked(value)) {
      checked.remove(value);
    } else {
      checked.add(value);
    }

    final notifier = ref.read(CustomStateProvider.ldaSettingSyncState.notifier);
    notifier.update((state) {
      final result = state
          .firstWhereOrNull((element) => element.boardIp == widget.boardIp);
      final mcc = widget.opr.mcc;
      final mnc = widget.opr.mnc;
      final mappingChecked = checked.map((e) => "${mcc}_${mnc}_$e").toList();
      if (isChecked(value)) {
        state = [
          if (result == null) ...[
            ...state,
            LDASettingSyncStateModel(
              boardIp: widget.boardIp,
              twoGData: result?.twoGData ?? "",
              fourGDatas: [
                ...mappingChecked,
              ],
            ),
          ] else
            for (final val in state)
              if (val.boardIp != widget.boardIp)
                val
              else
                LDASettingSyncStateModel(
                  boardIp: widget.boardIp,
                  twoGData: result.twoGData,
                  fourGDatas: [
                    ...mappingChecked,
                  ],
                ),
        ];
      } else {
        state = [
          for (final val in state)
            if (val.boardIp != widget.boardIp)
              val
            else
              LDASettingSyncStateModel(
                boardIp: widget.boardIp,
                twoGData: result?.twoGData ?? "",
                fourGDatas: [
                  ...mappingChecked,
                ],
              ),
        ];
      }

      return state;
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final splitedLteArfcn = widget.opr.lteArfcn?.split(",") ?? [];
    final splittedLtePci = widget.opr.ltePci?.split(",") ?? [];
    final splittedLteTac = widget.opr.lteTac?.split(",") ?? [];
    final splittedLteCellId = widget.opr.lteCellId?.split(",") ?? [];

    return Expanded(
      flex: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int index = 0; index < splitedLteArfcn.length; index++)
            Builder(builder: (context) {
              final value =
                  "${splitedLteArfcn[index]}_${splittedLtePci[index]}_${splittedLteTac[index]}_${splittedLteCellId[index]}";
              return Row(
                children: [
                  Checkbox.adaptive(
                    visualDensity: VisualDensity.compact,
                    value: isChecked(value),
                    onChanged: (_) {
                      onTapCheckbox(value);
                    },
                  ),
                  FittedBox(
                    child: Text(
                      value.split("_").join(","),
                      style: styleText,
                    ),
                  ),
                ],
              );
            }),
        ],
      ),
    );
  }
}
