import 'package:flutter/material.dart';
import 'package:mafia_game/features/game/game.dart';
import 'package:mafia_game/presentation/pages/home/widgets/custom_image_view.dart';
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
        padding: const EdgeInsets.symmetric(
          vertical: 16,
        ),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: MafiaTheme.themeData.colorScheme.secondary.withOpacity(0.2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                    color: Colors.grey.shade500,
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
            Row(
              // mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Align(
                  child: Text(
                    "Дата регистрации",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  margin: const EdgeInsets.only(left: 32),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.grey.shade500,
                  ),
                  child: Align(
                    child: Text(
                      gamer.gamerCreated!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      );
}
