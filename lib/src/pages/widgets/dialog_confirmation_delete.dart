import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DialogDeleteConfirmation extends StatelessWidget {
  const DialogDeleteConfirmation({
    Key? key,
    this.title = "Delete Confirmation",
    this.content = "Are you sure want to delete this data?",
    this.onConfirm,
  }) : super(key: key);

  final String title;
  final String content;
  final void Function()? onConfirm;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () {
            context.pop();
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            onConfirm?.call();
          },
          child: const Text("Delete"),
        ),
      ],
    );
  }
}
