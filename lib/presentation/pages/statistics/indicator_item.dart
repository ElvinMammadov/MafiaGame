import 'package:flutter/material.dart';
import 'package:mafia_game/utils/theme/theme.dart';

class IndicatorItem extends StatelessWidget {
  const IndicatorItem({
    super.key,
    required this.foregroundColor,
    required this.title,
    required this.value,
  });

  final Color foregroundColor;
  final String title;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 16),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
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
          child: const Align(
            child: Text(
              "5",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Widget buildLinearIndicator({
  required double value,
  required Color foregroundColor,
}) {
  return SizedBox(
    height: 30,
    child: LinearProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(
        foregroundColor,
      ),
      backgroundColor: MafiaTheme.themeData.highlightColor,
      value: value,
      borderRadius: BorderRadius.circular(16),
    ),
  );
}
