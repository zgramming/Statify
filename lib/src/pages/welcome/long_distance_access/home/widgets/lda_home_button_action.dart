import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

import '../../../../../model/model/machine/machine_config.model.dart';
import '../../../../../utils/fonts.dart';
import '../../../../../utils/styles.dart';

class LDAHomeButtonAction extends StatelessWidget {
  const LDAHomeButtonAction({
    Key? key,
    // ignore: unused_element
    this.config,
  }) : super(key: key);

  final MachineConfigModel? config;

  static String marqueeText(MachineConfigModel? config) {
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
            Card(
              margin: const EdgeInsets.all(0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 20,
                  child: Marquee(
                    blankSpace: 300.0,
                    text: marqueeText(config),
                    style: bodyFontBold.copyWith(
                      fontSize: 10.0,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: elevatedButtonStyle(),
                    child: const Text("Start"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: elevatedButtonStyle(),
                    child: const Text("Stop"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
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
