part of game;

List<Widget> gamersAvatars({
  required BoxConstraints constraints,
  required Roles roles,
  required bool showRoles,
  required bool isGameStarted,
  required int numberOfGamers,
  required List<Gamer> gamers,
  required BuildContext context,
}
) {
  final List<Widget> positionedAvatars = <Widget>[];
  final double ovalRadius = constraints.maxWidth / 2.6;

  final double screenWidth = MediaQuery.of(context).size.width;
  final double screenHeight = MediaQuery.of(context).size.height;

  const double minAvatarRadius = 20.0;
  const double maxAvatarRadius = 100.0;
  const double defaultAvatarRadiusPercentage = 0.05;

  final double radius = min(
    max(
      minAvatarRadius,
      min(screenWidth, screenHeight) * defaultAvatarRadiusPercentage,
    ),
    maxAvatarRadius,
  );
  final double angleStep = (2 * pi) / numberOfGamers;

  for (int i = 0; i < numberOfGamers; i++) {
    final double angle = (3 * pi / 2) + i * angleStep;
    final double avatarX =
        constraints.maxWidth / 2 + (ovalRadius + radius) * cos(angle);
    final double avatarY =
        constraints.maxHeight / 2 + (ovalRadius + radius) * sin(angle);

    positionedAvatars.add(
      Positioned(
        top: avatarY - radius,
        left: avatarX - radius,
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                SizedBox(
                  width: constraints.maxWidth / 13,
                  height: constraints.maxWidth / 13,
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(
                        color: MafiaTheme.themeData.colorScheme.secondary,
                        width: 2,
                      ),
                    ),
                    color: Colors.transparent,
                    child: GestureDetector(
                      onTap: () {
                        isGameStarted
                            ? DialogBuilder().showPlayGame(context)
                            :
                        DialogBuilder().showAddUserModal(
                          context,
                          i + 1,
                        );
                        // DialogBuilder().showPlayGame(context);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: showRoles == true
                            ? Center(
                                child: Text(
                                  gamers[i].role != null
                                      ? '${gamers[i].role}'
                                      : roles.roles[4].name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            : gamers[i].imageUrl == null
                                ? Icon(
                                    Icons.person_add_rounded,
                                    size: constraints.maxWidth / 20,
                                    color: MafiaTheme
                                        .themeData.colorScheme.secondary,
                                  )
                                : Image.network(
                                    gamers[i].imageUrl!,
                                    fit: BoxFit.fill,
                                    width: constraints.maxWidth / 13,
                                    height: constraints.maxWidth / 13,
                                  ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.transparent,
                minimumSize: const Size(60, 25),
                side: BorderSide(
                  color: MafiaTheme.themeData.colorScheme.secondary,
                  width: 2,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () {},
              child: Text(
                gamers.isNotEmpty ? '${gamers[i].name}' : '',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  return positionedAvatars;
}
