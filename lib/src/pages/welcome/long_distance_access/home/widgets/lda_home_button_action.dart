import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquee/marquee.dart';

import '../../../../../injection.dart';
import '../../../../../model/model/machine/machine_config.model.dart';
import '../../../../../utils/fonts.dart';
import '../../../../../utils/styles.dart';
import '../../../../../view_model/custom_provider/custom_form_provider.dart';

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
  String marqueeText(MachineConfigModel? config) {
    if (config == null) {
      return "-";
    }

    final runningText = config.runningText;
    final connectedWith = config.operators.firstWhereOrNull((element) {
      return element.ltePlmn == config.plmn;
    });

    if (connectedWith == null) {
      return "Device is not connected | $runningText";
    }

    return "Device is Connected with ${connectedWith.name} ${connectedWith.arfcn} ${connectedWith.lteArfcn} | $runningText";
  }

  Future<void> onSubmit(_ButtonState currentState) async {
    final form = ref.read(
      CustomFormProvider.ldaHomeForm(widget.machineId).notifier,
    )..update(
        (state) {
          switch (currentState) {
            case _ButtonState.start:
              return state = state.copyWith(start: '1');
            case _ButtonState.stop:
              return state = state.copyWith(start: '0');
            case _ButtonState.reset:
              return state = state.copyWith(count: '0');
            default:
              return state;
          }
        },
      );

    final formState = form.state;
    final notifier = ref.read(machineNotifier.notifier);
    await notifier.updateConfig(formState);
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
                  text: marqueeText(widget.config),
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
