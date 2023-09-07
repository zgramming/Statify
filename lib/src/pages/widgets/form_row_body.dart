import 'package:flutter/material.dart';

class FormBodyRow extends StatelessWidget {
  const FormBodyRow({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: 5, child: Text(title)),
        Expanded(flex: 7, child: child),
      ],
    );
  }
}
