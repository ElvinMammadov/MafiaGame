part of statistics;

class IndicatorItem extends StatelessWidget {
  final Color foregroundColor;
  final int value;
  final int? totalPoints;
  final int totalPlayedGames;

  const IndicatorItem({
    super.key,
    required this.foregroundColor,
    required this.value,
    this.totalPoints,
    required this.totalPlayedGames,
  });

  double getIndicatorValue(int value, int totalPoints) {
    final double percentage = value / totalPoints;
    return percentage;
  }

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          if (totalPoints != null)
            Expanded(
              child: SizedBox(
                height: 12,
                child: LinearProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    foregroundColor,
                  ),
                  backgroundColor: MafiaTheme.themeData.highlightColor,
                  value: totalPlayedGames != 0
                      ? getIndicatorValue(
                          value,
                          totalPoints ?? 0,
                        )
                      : 0,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            )
          else
            const SizedBox(),
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
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      );
}
