part of game;

List<Widget> gamersAvatars({
  required BoxConstraints constraints,
  required Roles roles,
  required bool showRoles,
  required int numberOfGamers,
  required List<Gamer> gamers,
  required BuildContext context,
  required Orientation orientation,
  required GamePhase gamePhase,
  Function(Gamer)? changeRole,
}) {
  final double screenWidth = MediaQuery.of(context).size.width;
  final double screenHeight = MediaQuery.of(context).size.height;
  final List<Widget> positionedAvatars = <Widget>[];
  final GamePeriod gamePeriod =
      BlocProvider.of<GameBloc>(context).state.game.gamePeriod;
  final GamePhase gamePhase =
      BlocProvider.of<GameBloc>(context).state.game.gamePhase;
  final String starterId =
      BlocProvider.of<GameBloc>(context).state.game.starterId;

  final double ovalRadius;
  double minAvatarRadius;
  double maxAvatarRadius;
  double defaultAvatarRadiusPercentage;
  double sizeBoxSize;
  double iconSize;
  if (orientation == Orientation.portrait) {
    minAvatarRadius = 20.0;
    maxAvatarRadius = 100.0;
    defaultAvatarRadiusPercentage = 0.04;
    ovalRadius = constraints.maxWidth / 2.5;
    sizeBoxSize = constraints.maxWidth / 13;
    iconSize = constraints.maxWidth / 20;
  } else {
    minAvatarRadius = 10.0;
    maxAvatarRadius = 80.0;
    defaultAvatarRadiusPercentage = 0.065;
    ovalRadius = constraints.maxWidth / 4;
    sizeBoxSize = constraints.maxWidth / 20;
    iconSize = constraints.maxWidth / 27;
  }
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
        child: gamers[i].wasKilled
            ? const SizedBox.shrink()
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      SizedBox(
                        width: sizeBoxSize,
                        height: sizeBoxSize,
                        child: BlinkingAvatar(
                          showRoles: showRoles,
                          gamers: gamers,
                          index: i,
                          iconSize: iconSize,
                          sizeBoxSize: sizeBoxSize,
                          roles: roles,
                          changeRole: changeRole,
                          gamePeriod: gamePeriod,
                          gamePhase: gamePhase,
                        ),
                      ),
                      if (((gamers[i].gamerId == starterId &&
                                  starterId.isNotEmpty) &&
                              gamePhase == GamePhase.Voting) ||
                          (gamePeriod == GamePeriod.Night &&
                              gamers[i].wasInfected == true))
                        const Positioned(
                          top: 0,
                          left: 0,
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      if (gamePeriod == GamePeriod.Night &&
                          gamers[i].newlyInfected == true)
                        const Positioned(
                          top: 0,
                          left: 25,
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Colors.purple,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      if (gamers[i].foulCount >= 1)
                        Positioned(
                          top: 0,
                          right: 25,
                          child: Container(
                            width: 25,
                            height: 25,
                            decoration: const BoxDecoration(
                              color: Colors.yellow,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                gamers[i].foulCount.toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                        ),
                      if (gamers[i].votesCount >= 1)
                        Positioned(
                          top: 0,
                          right: 4,
                          child: Container(
                            width: 25,
                            height: 25,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                gamers[i].votesCount.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
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
                      minimumSize: const Size(60, 30),
                      side: BorderSide(
                        color: MafiaTheme.themeData.colorScheme.secondary,
                        width: 2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () {
                      if (gamePhase == GamePhase.IsReady ||
                          gamePhase == GamePhase.CouldStart) {
                        BlocProvider.of<GameBloc>(context).add(
                          RearrangeGamersPosition(
                            newPosition: gamers[i].id ?? 0,
                          ),
                        );
                      }
                    },
                    child: Text(
                      gamers.isNotEmpty
                          ? '${gamers[i].positionOnTable}  ${gamers[i].name}'
                          : '',
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
