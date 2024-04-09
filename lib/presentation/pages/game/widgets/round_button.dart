import 'package:flutter/material.dart';
import 'package:mafia_game/utils/theme/theme.dart';

class RoundButton extends StatelessWidget {
  const RoundButton({
    super.key,
    required this.icon,
  });

  final IconData icon;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 5,
        ),
        child: CircleAvatar(
          backgroundColor:
              MafiaTheme.themeData.colorScheme.secondary,
          radius: 36,
          child: Icon(
            color: Colors.black,
            icon,
            size: 36,
          ),
        ),
      );
}
