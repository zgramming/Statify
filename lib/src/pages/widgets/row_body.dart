// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class RowBody extends StatelessWidget {
  const RowBody({
    Key? key,
    required this.title,
    required this.content,
    this.titleFlex,
    this.contentFlex,
    this.spacing = 8.0,
  }) : super(key: key);

  final String title;
  final String content;
  final int? titleFlex;
  final int? contentFlex;
  final double spacing;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: titleFlex ?? 1, child: Text(title)),
        SizedBox(width: spacing),
        Expanded(flex: contentFlex ?? 2, child: Text(content)),
      ],
    );
  }
}
