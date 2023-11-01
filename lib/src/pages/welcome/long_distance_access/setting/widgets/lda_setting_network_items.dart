import 'package:flutter/material.dart';

import '../../../../../utils/fonts.dart';

class LDASettingNetworkItems extends StatelessWidget {
  const LDASettingNetworkItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Row(
        children: [
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
                "GSM",
                style: bodyFont.copyWith(
                  fontSize: 9.0,
                ),
              ),
            ],
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
                "LTE",
                style: bodyFont.copyWith(
                  fontSize: 9.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
