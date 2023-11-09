import 'package:flutter/material.dart';

import '../../../../../utils/fonts.dart';

class LDAHomeContentItem extends StatelessWidget {
  const LDAHomeContentItem({
    Key? key,
    required this.index,
    this.sender,
    this.sms,
    // ignore: unused_element
    this.onTap,
  }) : super(key: key);

  final int index;
  final String? sender;
  final String? sms;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    if (sender == null || sms == null) {
      return const SizedBox();
    }

    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        radius: 15.0,
        child: FittedBox(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("#$index"),
          ),
        ),
      ),
      title: Text(
        "$sender",
        style: bodyFont.copyWith(
          fontSize: 14.0,
        ),
      ),
      subtitle: Text(
        "$sms",
        style: bodyFontBold.copyWith(
          fontSize: 14.0,
        ),
      ),
    );
  }
}
