import 'package:flutter/material.dart';
import 'package:mafia_game/utils/theme/theme.dart';

void showSuccessSnackBar({
  required BuildContext context,
  required String message,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
      duration: const Duration(seconds: 2),
    ),
  );
}

void showErrorSnackBar({
  required BuildContext context,
  required String message,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: MafiaTheme.themeData.colorScheme.error,
      duration: const Duration(seconds: 2),
    ),
  );
}
