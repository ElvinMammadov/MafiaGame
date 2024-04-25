import 'package:flutter/material.dart';
import 'package:mafia_game/utils/theme/theme.dart';

// ignore_for_file: avoid_classes_with_only_static_members

class SnackBarManager {
  static void showSuccess(
    BuildContext context, {
    required Object message,
  }) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SuccessSnackBar(
          context: context,
          text: message.toString(),
        ),
      );

  static void showFailure(
    BuildContext context, {
    required Object message,
  }) =>
      ScaffoldMessenger.of(context).showSnackBar(
        FailSnackBar(
          context: context,
          text: message.toString(),
        ),
      );
}

class FailSnackBar extends SnackBar {
  FailSnackBar({
    required String text,
    required BuildContext context,
  }) : super(
          content: Text(
            text,
            style: MafiaTheme.themeData.textTheme.titleMedium,
          ),
          backgroundColor: MafiaTheme.themeData.colorScheme.error,
          behavior: SnackBarBehavior.floating,
          width: 400,
        );
}

class SuccessSnackBar extends SnackBar {
  SuccessSnackBar({
    required String text,
    required BuildContext context,
  }) : super(
          content: Text(
            text,
            style: MafiaTheme.themeData.textTheme.titleMedium,
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          width: 400,
        );
}
