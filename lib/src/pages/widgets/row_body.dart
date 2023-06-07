import 'package:flutter/material.dart';

class RowBody extends StatelessWidget {
  const RowBody({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);
  final String title;
  final String content;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: Text(title)),
        Expanded(flex: 2, child: Text(content)),
      ],
    );
  }
}
