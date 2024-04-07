import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

class BaseButton extends StatelessWidget {
  final VoidCallback? action;
  final String label;
  final bool enabled;
  final Color? backgroundColor;
  final Color? textColor;
  final double? height;
  final double? width;
  final TextStyle? textStyle;
  final Color? disabledColor;

  const BaseButton({
    this.action,
    required this.label,
    this.enabled = true,
    this.backgroundColor,
    this.textColor,
    this.height,
    this.width,
    this.textStyle,
    this.disabledColor,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return FilledButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color?>(
          enabled
              ? backgroundColor ?? theme.colorScheme.secondary
              : disabledColor ?? theme.disabledColor,
        ),
        minimumSize: MaterialStateProperty.all(
          const Size.fromHeight(48),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
          ),
        ),
        elevation: MaterialStateProperty.all(2),
      ),
      onPressed: enabled ? action : null,
      child: Text(
        label,
        style: textStyle,
      ),
    ).padding(
      vertical: 16,
      horizontal: 16,
    );
  }
}
