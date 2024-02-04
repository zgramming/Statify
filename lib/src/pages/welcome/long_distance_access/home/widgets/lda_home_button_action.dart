import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquee/marquee.dart';

import '../../../../../injection.dart';
import '../../../../../model/model/helper/form/form_machine_update_config.model.dart';
import '../../../../../model/model/machine/machine_config.model.dart';
import '../../../../../utils/constant.dart';
import '../../../../../utils/fonts.dart';
import '../../../../../utils/functions.dart';
import '../../../../../utils/styles.dart';
import '../../../../../view_model/custom_provider/custom_provider.dart';

enum _ButtonState {
  start,
  stop,
  reset,
}

class LDAHomeButtonAction extends ConsumerStatefulWidget {
  const LDAHomeButtonAction({
    Key? key,
    this.config,
    required this.machineId,
  }) : super(key: key);

  final String machineId;
  final MachineConfigModel? config;

  @override
  ConsumerState<LDAHomeButtonAction> createState() =>
      _LDAHomeButtonActionState();
}

class _LDAHomeButtonActionState extends ConsumerState<LDAHomeButtonAction> {
  Future<void> onSubmit(_ButtonState currentState) async {
    final machine =
        ref.read(CustomProvider.getMachineByIdProvider(widget.machineId));
    final config = machine?.config;
    if (config == null) {
      return;
    }

    var form = FormMachineUpdateConfigModel.fromMachineConfigModel(
      widget.machineId,
      config,
    );

    switch (currentState) {
      case _ButtonState.start:
        form = form.copyWith(start: '1');
        break;
      case _ButtonState.stop:
        form = form.copyWith(start: '0');
        break;
      case _ButtonState.reset:
        form = form.copyWith(
          count: '0',
          successMessage: kSuccessMessageResetMachine,
        );
        break;

      default:
        form = form;
    }

    final notifier = ref.read(machineNotifier.notifier);
    await notifier.updateConfig(form);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.all(0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey.withOpacity(0.5),
                ),
              ),
              child: SizedBox(
                height: 20,
                child: Marquee(
                  blankSpace: 300.0,
                  text: textMachineConnectOrDisconnected(widget.config),
                  style: bodyFontBold.copyWith(
                    fontSize: 10.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => onSubmit(_ButtonState.start),
                    style: elevatedButtonStyle(),
                    child: const Text("Start"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => onSubmit(_ButtonState.stop),
                    style: elevatedButtonStyle(),
                    child: const Text("Stop"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => onSubmit(_ButtonState.reset),
                    style: elevatedButtonStyle(),
                    child: const Text("Reset"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
