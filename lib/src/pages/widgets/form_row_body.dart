import 'package:flutter/material.dart';

class FormBodyRow extends StatelessWidget {
  const FormBodyRow({
    Key? key,
    required this.title,
    required this.child,
    this.titleFlex = 5,
    this.childFlex = 7,
  }) : super(key: key);
  final String title;
  final Widget child;

  final int titleFlex;
  final int childFlex;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: titleFlex, child: Text(title)),
        Expanded(flex: childFlex, child: child),
      ],
    );
  }
}
