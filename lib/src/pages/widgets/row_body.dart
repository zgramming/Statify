import 'package:flutter/material.dart';

class RowBody extends StatelessWidget {
  const RowBody({
    Key? key,
    required this.title,
    required this.content,
    this.titleFlex,
    this.contentFlex,
  }) : super(key: key);

  final String title;
  final String content;
  final int? titleFlex;
  final int? contentFlex;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: titleFlex ?? 1, child: Text(title)),
        Expanded(flex: contentFlex ?? 2, child: Text(content)),
      ],
    );
  }
}
