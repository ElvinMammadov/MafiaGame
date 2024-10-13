part of game;

class DirectionButtons extends StatelessWidget {
  const DirectionButtons();

  @override
  Widget build(BuildContext context) => BlocBuilder<GameBloc, AppState>(
        builder: (BuildContext context, AppState state) {
          final Gamer currentVoter = state.game.currentVoter;
          return currentVoter.name!.isNotEmpty
              ? Column(
                  children: <Widget>[
                    Text(
                      AppStrings.chooseDirection,
                      style:
                          MafiaTheme.themeData.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ).padding(bottom: 20.0),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 120.0,
                          child: IconButton(
                            iconSize: 80.0,
                            color: MafiaTheme.themeData.colorScheme.secondary,
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
                        SizedBox(
                          width: 120.0,
                          child: IconButton(
                            iconSize: 80.0,
                            color: MafiaTheme.themeData.colorScheme.secondary,
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
                      ],
                    ),
                  ],
                )
              : SizedBox(
                  height: 100.0,
                  width: 300.0,
                  child: Text(
                    AppStrings.chooseGamerForVoting,
                    style: MafiaTheme.themeData.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ).padding(bottom: 20.0),
                );
        },
      );
}
