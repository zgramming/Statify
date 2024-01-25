// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../utils/fonts.dart';

class ListTileSettingMenu extends StatelessWidget {
  const ListTileSettingMenu({
    Key? key,
    required this.onTap,
    required this.title,
    required this.subtitle,
    required this.leadingIcon,
    this.trailing = const Icon(Icons.chevron_right),
    this.leadingBackgroundColor,
  }) : super(key: key);

  final void Function() onTap;
  final String title;
  final String subtitle;
  final IconData leadingIcon;
  final Widget trailing;
  final Color? leadingBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: leadingBackgroundColor ?? Colors.blue,
          child: Icon(
            leadingIcon,
            color: Colors.white,
          ),
        ),
        title: Text(
          title,
          style: bodyFont.copyWith(
            fontSize: 14.0,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: bodyFont.copyWith(fontSize: 10.0, color: Colors.grey),
        ),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}
