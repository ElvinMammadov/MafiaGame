part of game;

class DirectionButtons extends StatefulWidget {
  const DirectionButtons();

  @override
  State<DirectionButtons> createState() => _DirectionButtonsState();
}

class _DirectionButtonsState extends State<DirectionButtons> {
  List<Gamer> gamers = <Gamer>[];
  @override
  Widget build(BuildContext context) => BlocBuilder<GameBloc, AppState>(
        builder: (BuildContext context, AppState state) {
          final Gamer currentVoter = state.game.currentVoter;
          final bool firstGamerVoted = state.game.firstGamerVoted;
          gamers = state.gamersState.gamers;
          final int currentVoterIndex = gamers.indexWhere(
            (Gamer gamer) => gamer.gamerId == currentVoter.gamerId,
          );
          int? newIndex;
          return currentVoter.name!.isNotEmpty
              ? firstGamerVoted
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
                            style: MafiaTheme.themeData.textTheme.titleLarge
                                ?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ).padding(bottom: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Card(
                                elevation: 5,
                                color: MafiaTheme
                                    .themeData.colorScheme.secondary
                                    .withOpacity(0.4),
                                child: SizedBox(
                                  width: 100.0,
                                  child: IconButton(
                                    iconSize: 80.0,
                                    color: MafiaTheme
                                        .themeData.colorScheme.secondary,
                                    onPressed: () {
                                      newIndex = (currentVoterIndex +
                                              1 +
                                              gamers.length) %
                                          gamers.length;
                                      while (gamers[newIndex!].wasKilled) {
                                        newIndex =
                                            (newIndex! + 1 + gamers.length) %
                                                gamers.length;
                                      }
                                      _setVoter(newIndex!);
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
                                color: MafiaTheme
                                    .themeData.colorScheme.secondary
                                    .withOpacity(0.4),
                                child: SizedBox(
                                  width: 100.0,
                                  child: IconButton(
                                    iconSize: 80.0,
                                    color: MafiaTheme
                                        .themeData.colorScheme.secondary,
                                    onPressed: () {
                                      newIndex = (currentVoterIndex -
                                              1 +
                                              gamers.length) %
                                          gamers.length;
                                      while (gamers[newIndex!].wasKilled) {
                                        newIndex =
                                            (newIndex! - 1 + gamers.length) %
                                                gamers.length;
                                      }
                                      _setVoter(newIndex!);
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
                            AppStrings.chooseFirstGamer,
                            textAlign: TextAlign.center,
                            style: MafiaTheme.themeData.textTheme.titleLarge
                                ?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ).padding(bottom: 20.0, horizontal: 16.0),
                        ),
                      ),
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
                      ).padding(bottom: 20.0, horizontal: 16.0),
                    ),
                  ),
                );
        },
      );

  void _setVoter(int newIndex) {
    BlocProvider.of<GameBloc>(context).add(
      SetVoter(
        voter: gamers[newIndex],
      ),
    );
    _changeAnimation(true, gamers[newIndex].gamerId ?? '');
  }

  void _changeAnimation(bool animate, String gamerId) {
    BlocProvider.of<GameBloc>(context).add(
      ChangeAnimation(
        gamerId: gamerId,
        animate: animate,
      ),
    );
  }
}
