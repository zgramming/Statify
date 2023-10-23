import 'package:flutter/material.dart';

class FormBodyRow extends StatelessWidget {
  const FormBodyRow({
    Key? key,
    this.title,
    this.titleWidget,
    required this.child,
    this.titleFlex = 5,
    this.childFlex = 7,
  })  : // titleWidget and title cant be used together
        assert(titleWidget == null || title == null,
            "titleWidget and title cant be used together"),
        super(key: key);

  final String? title;
  final Widget? titleWidget;
  final Widget child;

  final int titleFlex;
  final int childFlex;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: titleFlex,
          child: titleWidget ??
              Text(title ?? "", style: Theme.of(context).textTheme.titleSmall),
        ),
        Expanded(flex: childFlex, child: child),
      ],
    );
  }
}
