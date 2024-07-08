import 'package:flutter/material.dart';
import 'package:mafia_game/utils/theme/theme.dart';

class IndicatorItem extends StatelessWidget {
  const IndicatorItem({
    super.key,
    required this.foregroundColor,
    required this.value,
  });

  final Color foregroundColor;
  final double value;

  @override
  Widget build(BuildContext context) => Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: buildLinearIndicator(
            foregroundColor: foregroundColor,
            value: value,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
          ),
          margin: const EdgeInsets.only(left: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: MafiaTheme.themeData.highlightColor,
          ),
          child: Align(
            child: Text(
              value.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ),
        ),
      ],
    );
}

Widget buildLinearIndicator({
  required double value,
  required Color foregroundColor,
}) => SizedBox(
    height: 20,
    child: LinearProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(
        foregroundColor,
      ),
      backgroundColor: MafiaTheme.themeData.highlightColor,
      value: value,
      borderRadius: BorderRadius.circular(16),
    ),
  );
