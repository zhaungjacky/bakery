import 'package:flutter/material.dart';

void handleScaffoldMessenger(
  BuildContext context,
  Duration? duration,
  Widget? widget,
) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: duration ?? const Duration(seconds: 3),
      content: widget ?? const Text("Default Message"),
    ),
  );
}
