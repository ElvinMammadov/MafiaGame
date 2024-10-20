part of game;

class DirectionButtons extends StatelessWidget {
  const DirectionButtons();

  @override
  Widget build(BuildContext context) => BlocBuilder<GameBloc, AppState>(
        builder: (BuildContext context, AppState state) {
          final Gamer currentVoter = state.game.currentVoter;
          return currentVoter.name!.isNotEmpty
              ? Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: MafiaTheme.themeData.colorScheme.secondary
                      .withOpacity(0.2),
                  child: Column(
                    children: <Widget>[
                      Text(
                        AppStrings.chooseDirection,
                        style:
                            MafiaTheme.themeData.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ).padding(bottom: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Card(
                            elevation: 5,
                            color: MafiaTheme.themeData.colorScheme.secondary
                                .withOpacity(0.4),
                            child: SizedBox(
                              width: 100.0,
                              child: IconButton(
                                iconSize: 80.0,
                                color:
                                    MafiaTheme.themeData.colorScheme.secondary,
                                onPressed: () {
                                  BlocProvider.of<GameBloc>(context).add(
                                    const SetVotingDirection(
                                      votingDirection: VoteDirection.Left,
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.rotate_right),
                              ),
                            ),
                          ).padding(right: 16.0),
                          Card(
                            elevation: 5,
                            color: MafiaTheme.themeData.colorScheme.secondary
                                .withOpacity(0.4),
                            child: SizedBox(
                              width: 100.0,
                              child: IconButton(
                                iconSize: 80.0,
                                color:
                                    MafiaTheme.themeData.colorScheme.secondary,
                                onPressed: () {
                                  BlocProvider.of<GameBloc>(context).add(
                                    const SetVotingDirection(
                                      votingDirection: VoteDirection.Right,
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.rotate_left),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ).padding(horizontal: 16.0, vertical: 16.0),
                )
              : Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: MafiaTheme.themeData.colorScheme.secondary
                      .withOpacity(0.4),
                  child: SizedBox(
                    height: 100.0,
                    width: 300.0,
                    child: Center(
                      child: Text(
                        AppStrings.chooseGamerForVoting,
                        textAlign: TextAlign.center,
                        style:
                            MafiaTheme.themeData.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ).padding(bottom: 20.0),
                    ),
                  ),
                );
        },
      );
}
