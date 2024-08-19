part of statistics;

class StatisticsItem extends StatelessWidget {
  const StatisticsItem({
    super.key,
    required this.customImageWidth,
    required this.gamer,
  });

  final double customImageWidth;
  final Gamer gamer;

  String calculateExperience(String dateString) {
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    final DateTime startDate = dateFormat.parse(dateString);
    final DateTime currentDate = DateTime.now();
    final Duration difference = currentDate.difference(startDate);

    final int years = (difference.inDays / 365).floor();
    final int remainingDaysAfterYears = difference.inDays % 365;
    final int months = (remainingDaysAfterYears / 30).floor();
    final int days = remainingDaysAfterYears % 30;

    String experience = '';
    if (years > 0) {
      experience += '$years ${AppStrings.years}${years > 1 ? 'а' : ''} ';
    }
    if (months > 0) {
      experience += '$months ${AppStrings.months}${months > 1 ? 'ов' : ''} ';
    }
    if (days > 0) {
      experience += '$days ${days > 1 ? AppStrings.days : AppStrings.day}';
    }

    return experience.trim();
  }

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: MafiaTheme.themeData.colorScheme.secondary.withOpacity(0.2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CustomImageView(
                      imagePath: gamer.imageUrl!,
                      radius: BorderRadius.circular(100),
                      width: customImageWidth,
                      height: customImageWidth,
                      border: Border.all(
                        width: 6,
                        color: Colors.white,
                      ),
                    ).padding(bottom: 16),
                    Container(
                      width: customImageWidth + 20,
                      padding: const EdgeInsets.symmetric(
                        vertical: 3,
                        horizontal: 6,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: MafiaTheme.themeData.highlightColor,
                        border: Border.all(
                          width: 0.8,
                          color: Colors.white,
                        ),
                      ),
                      child: Align(
                        child: Text(
                          gamer.name!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 16),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(left: 8),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                margin: const EdgeInsets.only(
                                                  right: 16,
                                                ),
                                                child: const Text(
                                                  AppStrings.victory,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 22,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                  right: 14,
                                                ),
                                                child: const Text(
                                                  AppStrings.defeat,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 22,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                  right: 16,
                                                ),
                                                child: const Text(
                                                  AppStrings.total,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 22,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            children: <Widget>[
                                              IndicatorItem(
                                                totalPlayedGames: gamer
                                                    .gamerCounts
                                                    .totalPlayedGames,
                                                foregroundColor: MafiaTheme
                                                    .themeData
                                                    .colorScheme
                                                    .secondary,
                                                value: gamer
                                                    .gamerCounts.winnerCount,
                                                totalPoints: gamer.gamerCounts
                                                    .totalPlayedGames,
                                              ).padding(bottom: 8),
                                              IndicatorItem(
                                                totalPlayedGames: gamer
                                                    .gamerCounts
                                                    .totalPlayedGames,
                                                foregroundColor: MafiaTheme
                                                    .themeData
                                                    .colorScheme
                                                    .primary,
                                                value: gamer
                                                    .gamerCounts.losingCount,
                                                totalPoints: gamer.gamerCounts
                                                    .totalPlayedGames,
                                              ).padding(bottom: 8),
                                              IndicatorItem(
                                                totalPlayedGames: gamer
                                                    .gamerCounts
                                                    .totalPlayedGames,
                                                foregroundColor: MafiaTheme
                                                    .themeData
                                                    .colorScheme
                                                    .surface,
                                                value: gamer.gamerCounts
                                                    .totalPlayedGames,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(right: 8),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                margin: const EdgeInsets.only(
                                                  right: 16,
                                                  left: 16,
                                                ),
                                                child: const Text(
                                                  AppStrings.points,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 22,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              IndicatorItem(
                                                totalPlayedGames: gamer
                                                    .gamerCounts
                                                    .totalPlayedGames,
                                                foregroundColor: MafiaTheme
                                                    .themeData
                                                    .colorScheme
                                                    .surface,
                                                value: gamer
                                                    .gamerCounts.totalPoints,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ).padding(bottom: 16),
                        const Divider(
                          color: Colors.white,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              AppStrings.registrationDate,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 8,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: MafiaTheme.themeData.highlightColor,
                              ),
                              child: Text(
                                gamer.gamerCreated,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                            const Text(
                              AppStrings.experience,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 8,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: MafiaTheme.themeData.highlightColor,
                              ),
                              child: Text(
                                calculateExperience(gamer.gamerCreated),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                          ],
                        ).padding(
                          vertical: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
