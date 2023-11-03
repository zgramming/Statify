import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../../utils/fonts.dart';
import 'lda_setting_modal_gsm.dart';
import 'lda_setting_modal_lte.dart';

class LDASettingNetworkItems extends StatelessWidget {
  const LDASettingNetworkItems({
    Key? key,
    required this.idMachine,
  }) : super(key: key);
  final String idMachine;

  static Future<void> onGSMtap(BuildContext context, String idMachine) async {
    final result = await showDialog(
      context: context,
      builder: (context) => LDASettingModalGSM(idMachine: idMachine),
    );

    log("result after open dialog: $result");
  }

  static Future<void> onLTEtap(BuildContext context, String idMachine) async {
    final result = await showDialog(
      context: context,
      builder: (context) => LDASettingModalLTE(idMachine: idMachine),
    );

    log("result after open dialog: $result");
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Row(
        children: [
          InkWell(
            onTap: () => onGSMtap(context, idMachine),
            child: Row(
              children: [
                Transform.scale(
                  scale: 0.8,
                  child: Checkbox(
                    value: true,
                    onChanged: (value) {},
                  ),
                ),
                Text("GSM", style: bodyFont.copyWith(fontSize: 9.0)),
              ],
            ),
          ),
          Row(
            children: [
              Transform.scale(
                scale: 0.8,
                child: Checkbox(
                  value: true,
                  onChanged: (value) {},
                ),
              ),
              Text(
                "WCDMA",
                style: bodyFont.copyWith(
                  fontSize: 9.0,
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () => onLTEtap(context, idMachine),
            child: Row(
              children: [
                Transform.scale(
                  scale: 0.8,
                  child: Checkbox(
                    value: true,
                    onChanged: (value) {},
                  ),
                ),
                Text(
                  "LTE",
                  style: bodyFont.copyWith(
                    fontSize: 9.0,
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
