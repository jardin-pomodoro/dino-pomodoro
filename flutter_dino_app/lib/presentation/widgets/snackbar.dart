import 'package:flutter/material.dart';

import '../theme/theme.dart';

void showSnackBar(
  BuildContext context,
  String message, {
  Duration duration = const Duration(seconds: 2),
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: duration,
      backgroundColor: PomodoroTheme.primary,
      content: Text(
        message,
        style: PomodoroTheme.textLarge.copyWith(color: PomodoroTheme.white),
      ),
    ),
  );
}

void showErrorSnackBar(
  BuildContext context,
  String message, {
  Duration duration = const Duration(seconds: 2),
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: duration,
      backgroundColor: PomodoroTheme.errorColor,
      content: Text(message, style: PomodoroTheme.textLarge),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
