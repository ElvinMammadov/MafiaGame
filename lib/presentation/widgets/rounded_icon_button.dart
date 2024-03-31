import 'package:flutter/material.dart';

class RoundedIconButton extends StatelessWidget {
  final IconData icon;
  final bool isVisible;
  final VoidCallback onPressed;

  const RoundedIconButton({
    required this.icon,
    required this.isVisible,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: theme.colorScheme.secondary.withOpacity(0.5),
        ),
        child: Icon(
          size: 32.0,
          icon,
          color: isVisible ? Colors.black : Colors.transparent,
        ),
      ),
    );
  }
}
