import 'package:flutter/material.dart';

void showSnackbar({
  required BuildContext context,
  required String message,
  Color? backgroundColor,
}) {
  final snackBar = SnackBar(
    content: Text(message),
    backgroundColor: backgroundColor,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
