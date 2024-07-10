import 'package:flutter/material.dart';
import 'package:mafia_game/features/game/game.dart';
import 'package:mafia_game/presentation/pages/home/widgets/custom_image_view.dart';
import 'package:mafia_game/presentation/pages/statistics/indicator_item.dart';
import 'package:mafia_game/utils/app_strings.dart';
import 'package:mafia_game/utils/theme/theme.dart';

class StatisticsItem extends StatelessWidget {
  const StatisticsItem({
    super.key,
    required this.customImageWidth,
    required this.gamer,
  });

  final double customImageWidth;
  final Gamer gamer;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: MafiaTheme.themeData.colorScheme.secondary.withOpacity(0.2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomImageView(
                      imagePath: gamer.imageUrl!,
                      radius: BorderRadius.circular(100),
                      width: customImageWidth,
                      height: customImageWidth,
                      border: Border.all(
                        width: 6,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
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
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(right: 8),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                  right: 16,
                                                ),
                                                child: const Text(
                                                  AppStrings.mafia,
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
                                                  AppStrings.citizen,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 22,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    right: 16),
                                                child: const Text(
                                                  AppStrings.other,
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
                                            children: [
                                              IndicatorItem(
                                                foregroundColor: MafiaTheme
                                                    .themeData
                                                    .colorScheme
                                                    .secondary,
                                                value: 0.43,
                                              ),
                                              const SizedBox(height: 8),
                                              IndicatorItem(
                                                foregroundColor: MafiaTheme
                                                    .themeData
                                                    .colorScheme
                                                    .primary,
                                                value: 0.64,
                                              ),
                                              const SizedBox(height: 8),
                                              IndicatorItem(
                                                foregroundColor: MafiaTheme
                                                    .themeData
                                                    .colorScheme
                                                    .surface,
                                                value: 0.75,
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
                                margin: const EdgeInsets.only(left: 8),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
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
                                                  right: 16,
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
                                                  AppStrings.point,
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
                                            children: [
                                              IndicatorItem(
                                                foregroundColor: MafiaTheme
                                                    .themeData
                                                    .colorScheme
                                                    .secondary,
                                                value: 0.43,
                                              ),
                                              const SizedBox(height: 8),
                                              IndicatorItem(
                                                foregroundColor: MafiaTheme
                                                    .themeData
                                                    .colorScheme
                                                    .primary,
                                                value: 0.64,
                                              ),
                                              const SizedBox(height: 8),
                                              IndicatorItem(
                                                foregroundColor: MafiaTheme
                                                    .themeData
                                                    .colorScheme
                                                    .surface,
                                                value: 0.75,
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
                        ),
                        const Divider(
                          color: Colors.white,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                                gamer.gamerCreated!,
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
                              child: const Text(
                                "2 il 5 ay",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                          ],
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
