import 'package:flutter/material.dart';

import '../../../../../utils/fonts.dart';
import '../../../../../utils/functions.dart';
import 'lda_setting_modal_gsm.dart';
import 'lda_setting_modal_lte.dart';

class LDASettingNetworkItems extends StatefulWidget {
  const LDASettingNetworkItems({
    Key? key,
    required this.idMachine,
  }) : super(key: key);
  final String idMachine;

  static Future<void> onGSMtap(BuildContext context, String idMachine) async {
    await showDialog(
      context: context,
      builder: (context) => LDASettingModalGSM(idMachine: idMachine),
    );
  }

  static Future<void> onLTEtap(BuildContext context, String idMachine) async {
    await showDialog(
      context: context,
      builder: (context) => LDASettingModalLTE(idMachine: idMachine),
    );
  }

  @override
  State<LDASettingNetworkItems> createState() => _LDASettingNetworkItemsState();
}

class _LDASettingNetworkItemsState extends State<LDASettingNetworkItems> {
  bool _isGSM = true;
  bool _isWCDMA = true;
  bool _isLTE = true;

  void onTapGSM(bool? value) {
    setState(() {
      _isGSM = value ?? false;
    });
  }

  void onTapWCDMA(bool? value) {
    setState(() {
      _isWCDMA = value ?? false;
    });
  }

  void onTapLTE(bool? value) {
    setState(() {
      _isLTE = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Row(
        children: [
          InkWell(
            onTap: () =>
                LDASettingNetworkItems.onGSMtap(context, widget.idMachine),
            child: Row(
              children: [
                SizedBox(
                  width: 28,
                  child: Checkbox(
                    value: _isGSM,
                    onChanged: onTapGSM,
                  ),
                ),
                Text(
                  "GSM",
                  style: bodyFont.copyWith(
                    fontSize: 9.0,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16.0),
          Row(
            children: [
              SizedBox(
                width: 28,
                child: Checkbox(
                  value: _isWCDMA,
                  onChanged: onTapWCDMA,
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
          const SizedBox(width: 16.0),
          InkWell(
            onTap: () =>
                LDASettingNetworkItems.onLTEtap(context, widget.idMachine),
            child: Row(
              children: [
                SizedBox(
                  width: 28,
                  child: Checkbox(
                    value: _isLTE,
                    onChanged: onTapLTE,
                  ),
                ),
                Text(
                  "LTE / 5G",
                  style: bodyFont.copyWith(
                    fontSize: 9.0,
                    decoration: TextDecoration.underline,
                  ),
                ),
                const SizedBox(width: 8.0),
                InkWell(
                  onTap: () {
                    showSnackbar(context: context, message: "Coming soon");
                  },
                  child: const Icon(Icons.send_and_archive_outlined),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
