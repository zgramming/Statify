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

  // Hide current snackbar if any
  ScaffoldMessenger.of(context).hideCurrentSnackBar();

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
