import 'package:flutter/material.dart';

import '../../utils/fonts.dart';

class RowBody extends StatelessWidget {
  const RowBody({
    Key? key,
    required this.title,
    this.titleTrailing,
    required this.content,
    this.titleFlex,
    this.contentFlex,
    this.spacing = 8.0,
    this.titleStyle,
    this.contentStyle,
  }) : super(key: key);

  final String title;
  final List<Widget>? titleTrailing;
  final String content;
  final int? titleFlex;
  final int? contentFlex;
  final double spacing;
  final TextStyle? titleStyle;

  final TextStyle? contentStyle;
  @override
  Widget build(BuildContext context) {
    final defaultStyle = bodyFont.copyWith(
      fontSize: 12.0,
      color: Colors.black,
    );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: titleFlex ?? 1,
          child: Text(
            title,
            style: titleStyle ?? defaultStyle,
          ),
        ),
        SizedBox(width: spacing),
        Expanded(
          flex: contentFlex ?? 2,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  content,
                  style: contentStyle ?? defaultStyle,
                ),
              ),
              if (titleTrailing != null) ...titleTrailing!,
            ],
          ),
        ),
      ],
    );
  }
}
