import 'package:flutter/material.dart';

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
  final bool isLoading;

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
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return FilledButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color?>(
          enabled
              ? backgroundColor ?? theme.colorScheme.secondary.withOpacity(0.5)
              : disabledColor ?? theme.disabledColor,
        ),
        minimumSize: WidgetStateProperty.all(
           Size.fromHeight(height ?? 48),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
          ),
        ),
        elevation: WidgetStateProperty.all(2),
      ),
      onPressed: enabled ? action : null,
      child: isLoading
          ? const SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : Text(
              label,
              style: textStyle,
            ),
    );
  }
}
