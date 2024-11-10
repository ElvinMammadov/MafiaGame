part of game;

class GameTableScreen extends StatefulWidget {
  @override
  State<GameTableScreen> createState() => _GameTableScreenState();
}

class _GameTableScreenState extends State<GameTableScreen> {
  bool showRoles = false;
  Gamer killedGamer = const Gamer.empty();
  int count = 0;
  int civilianCount = 0;
  int mafiaCount = 0;
  GameState gameState = const GameState.empty();
  GamePhase gamePhase = GamePhase.IsReady;
  bool victoryByWerewolf = false;
  bool werewolfWasDead = false;
  bool isMafiaWin = false;

  String buttonTitle(GamePhase gamePhase) {
    switch (gamePhase) {
      case GamePhase.IsReady:
      case GamePhase.CouldStart:
      case GamePhase.Started:
      case GamePhase.Finished:
        return AppStrings.startGame;
      case GamePhase.Discussion:
        return AppStrings.endDiscussion;
      case GamePhase.Voting:
        return AppStrings.endVoting;
      case GamePhase.Sleeping:
        return AppStrings.startNight;
    }
  }

  void showResultScreen(BuildContext context) {
    final DateTime? gameStartTime =
        BlocProvider.of<GameBloc>(context).state.game.gameStartTime;
    Navigator.of(context).popUntil((Route<dynamic> route) => route.isFirst);
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => ResultScreen(
          gamers: BlocProvider.of<GameBloc>(context).state.gamersState.gamers,
          isMafiaWinner:
              BlocProvider.of<GameBloc>(context).state.game.isMafiaWin,
          gameName: BlocProvider.of<GameBloc>(context).state.game.gameName,
          gameStartTime: DateFormat('yyyy-MM-dd').format(
            gameStartTime ?? DateTime.now(),
          ),
          gameId: BlocProvider.of<GameBloc>(context).state.game.gameId,
          victoryByWerewolf:
              BlocProvider.of<GameBloc>(context).state.game.victoryByWerewolf,
          werewolfWasDead:
              BlocProvider.of<GameBloc>(context).state.game.werewolfWasDead,
          saveGame: true,
        ),
      ),
    );
  }

  void saveLastResults(
    int mafiaCount,
    int civilianCount,
    List<Gamer> gamers,
    String gameName,
    DateTime? gameStartTime,
    BuildContext context,
    GameState game,
  ) {
    final Gamer? werewolf = gamers
        .where((Gamer gamer) => gamer.role.roleType == RoleType.Werewolf)
        .firstOrNull;
    final bool victoryByWerewolf = werewolf != null && !werewolf.beforeChange;

    final bool werewolfWasDead =
        werewolf != null && werewolf.wasKilled && werewolf.beforeChange;

    if (mafiaCount == 0 && werewolf != null && !werewolf.wasKilled) {
      BlocProvider.of<GameBloc>(context).add(
        ChangeWerewolf(),
      );
    }
    if (mafiaCount == civilianCount && count == 0) {
      BlocProvider.of<GameBloc>(context).add(
        CalculatePoints(
          gameState: game.copyWith(
            isMafiaWin: true,
            gamers: gamers,
            victoryByWerewolf: victoryByWerewolf,
          ),
          finished: () {},
        ),
      );
      count++;
    } else if (mafiaCount == 0 && werewolf == null && count == 0) {
      BlocProvider.of<GameBloc>(context).add(
        CalculatePoints(
          gameState: game.copyWith(isMafiaWin: false, gamers: gamers),
          finished: () {},
        ),
      );
      count++;
    } else if (mafiaCount == 0 &&
        werewolf != null &&
        werewolf.wasKilled &&
        count == 0) {
      BlocProvider.of<GameBloc>(context).add(
        CalculatePoints(
          gameState: game.copyWith(
            isMafiaWin: false,
            gamers: gamers,
            werewolfWasDead: werewolfWasDead,
          ),
          finished: () {},
        ),
      );
      count++;
    }
  }

  @override
  Widget build(BuildContext context) => OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) =>
            BlocConsumer<GameBloc, AppState>(
          listenWhen: (AppState previous, AppState current) =>
              previous.game.mafiaCount != current.game.mafiaCount ||
              previous.game.civilianCount != current.game.civilianCount ||
              previous.game.gamePhase != current.game.gamePhase,
          listener: (BuildContext context, AppState state) {
            final List<Gamer> gamers = state.gamersState.gamers;
            final String gameName = state.game.gameName;
            mafiaCount = state.game.mafiaCount;
            civilianCount = state.game.civilianCount;
            final DateTime? gameStartTime = state.game.gameStartTime;
            gameState = state.game;
            gamePhase = state.game.gamePhase;
            victoryByWerewolf = state.game.victoryByWerewolf;
            werewolfWasDead = state.game.werewolfWasDead;
            isMafiaWin = state.game.isMafiaWin;

            if (gamePhase == GamePhase.Discussion ||
                gamePhase == GamePhase.Voting ||
                gamePhase == GamePhase.Sleeping) {
              saveLastResults(
                mafiaCount,
                civilianCount,
                gamers,
                gameName,
                gameStartTime ?? DateTime.now(),
                context,
                gameState,
              );
            }
          },
          builder: (BuildContext context, AppState state) {
            final int numberOfGamers = state.game.numberOfGamers;
            final List<Gamer> newGamers = state.gamersState.gamers;
            final double screenWidth = MediaQuery.of(context).size.width;
            final double screenHeight = MediaQuery.of(context).size.height;
            final String gameName = state.game.gameName;
            final int discussionTime = state.game.discussionTime;
            final int votingTime = state.game.votingTime;
            final String gameId = state.game.gameId;
            final DateTime? gameStartTime = state.game.gameStartTime;
            final GamePeriod gamePeriod = state.game.gamePeriod;
            final int dayNumber = state.game.dayNumber;
            final int nightNumber = state.game.nightNumber;
            bool isAllGamersCitizen = false;
            bool isMafiaExist = false;
            isMafiaWin = state.game.isMafiaWin;
            final VoteDirection voteDirection = state.game.voteDirection;

            const double buttonLeftPercentage = 0.07;
            const double buttonBottomPercentage = 0.02;
            const double roundButtonBottomPercentage = 0.05;
            final double directionButtonBottomPercentage =
                orientation == Orientation.portrait ? 3 : 3;
            final double directionButtonRightPercentage =
                orientation == Orientation.portrait ? 2.8 : 2.7;
            return PopScope(
              canPop:
                  !(Platform.isIOS && MediaQuery.of(context).size.width > 600),
              child: Scaffold(
                appBar: DefaultAppBar(
                  title: AppStrings.title,
                  showGameMenu: true,
                  actionCallback: () {
                    BlocProvider.of<GameBloc>(context).add(
                      const EmptyGame(),
                    );
                  },
                  onExit: () {
                    Navigator.of(context)
                        .popUntil((Route<dynamic> route) => route.isFirst);
                    BlocProvider.of<GameBloc>(context).add(
                      const EmptyGame(),
                    );
                  },
                  onAddGamer: () {
                    int? lastId = 0;
                    for (final Gamer gamer in newGamers) {
                      if (gamer.id! > lastId!) {
                        lastId = gamer.id;
                      }
                    }

                    DialogBuilder().showAddUserModal(
                      context,
                      lastId! + 1,
                      const Mirniy.empty(),
                      numberOfGamers: numberOfGamers,
                      isPositionMode: true,
                    );
                  },
                ),
                resizeToAvoidBottomInset: false,
                body: DecoratedBox(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/table.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: SizedBox.expand(
                    child: Stack(
                      children: <Widget>[
                        CircleAvatarWidget(
                          showRoles: showRoles,
                        ),
                        Positioned(
                          right: screenWidth * buttonLeftPercentage,
                          bottom: screenHeight * buttonBottomPercentage,
                          child: SizedBox(
                            width: 300,
                            child: BaseButton(
                              label: gamePeriod == GamePeriod.Day
                                  ? buttonTitle(gamePhase)
                                  : AppStrings.endNight,
                              enabled: gamePhase != GamePhase.IsReady,
                              textStyle:
                                  MafiaTheme.themeData.textTheme.titleMedium,
                              action: () {
                                if (gamePeriod != GamePeriod.Day) {
                                  BlocProvider.of<GameBloc>(context).add(
                                    NightAction(
                                      showKilledGamers:
                                          (List<Gamer> newKilledGamers) {
                                        if (newKilledGamers.isNotEmpty) {
                                          showKilledGamers(
                                            context,
                                            newKilledGamers,
                                            () {
                                              if (mafiaCount == 1 &&
                                                  civilianCount == 2) {
                                                showContinueGameDialog(
                                                  context,
                                                  accepted: () {
                                                    if (gamePhase ==
                                                        GamePhase.Finished) {
                                                      showResultScreen(context);
                                                    }
                                                  },
                                                );
                                              }
                                            },
                                          );
                                        } else {
                                          showSuccessSnackBar(
                                            context: context,
                                            message: AppStrings.nobodyWasKilled,
                                          );
                                        }
                                      },
                                    ),
                                  );
                                } else {
                                  switch (gamePhase) {
                                    case GamePhase.CouldStart:
                                      isAllGamersCitizen = newGamers.every(
                                        (Gamer gamer) =>
                                            gamer.role.roleType ==
                                            RoleType.Civilian,
                                      );
                                      isMafiaExist = newGamers.any(
                                        (Gamer gamer) =>
                                            gamer.role.roleType ==
                                                RoleType.Mafia ||
                                            gamer.role.roleType == RoleType.Don,
                                      );
                                      if (isAllGamersCitizen) {
                                        showErrorSnackBar(
                                          context: context,
                                          message: AppStrings.allGamersCitizens,
                                        );
                                      } else if (!isMafiaExist) {
                                        showErrorSnackBar(
                                          context: context,
                                          message: AppStrings.mafiaDoesNotExist,
                                        );
                                      } else {
                                        BlocProvider.of<GameBloc>(context).add(
                                          SaveGame(
                                            gameState: state.game.copyWith(
                                              gameName: gameName,
                                              numberOfGamers: numberOfGamers,
                                              gameId: gameId,
                                              gamers: newGamers,
                                              gameStartTime: gameStartTime ??
                                                  DateTime.now(),
                                            ),
                                          ),
                                        );
                                      }
                                      break;
                                    case GamePhase.Discussion:
                                      BlocProvider.of<GameBloc>(context).add(
                                        const ChangeRoleIndex(
                                          roleIndex: 0,
                                        ),
                                      );
                                      BlocProvider.of<GameBloc>(context).add(
                                        const EndDiscussion(
                                          isDiscussionStarted: false,
                                        ),
                                      );
                                      break;
                                    case GamePhase.Sleeping:
                                      BlocProvider.of<GameBloc>(context).add(
                                        const SleepingAction(),
                                      );
                                      break;
                                    case GamePhase.Voting:
                                      BlocProvider.of<GameBloc>(context).add(
                                        VotingAction(
                                          showFailureInfo: () {
                                            showErrorSnackBar(
                                              context: context,
                                              message:
                                                  AppStrings.votesHaveNotAdded,
                                            );
                                          },
                                          showKilledGamers:
                                              (List<Gamer> killedGamers) {
                                            if (killedGamers.length == 1) {
                                              showKilledGamer(
                                                context,
                                                killedGamers.first,
                                                () {
                                                  if (mafiaCount == 1 &&
                                                      civilianCount == 2) {
                                                    showContinueGameDialog(
                                                      context,
                                                      accepted: () {
                                                        if (gamePhase ==
                                                            GamePhase
                                                                .Finished) {
                                                          showResultScreen(
                                                            context,
                                                          );
                                                        }
                                                      },
                                                    );
                                                  }
                                                },
                                              );
                                            } else {
                                              showKilledGamers(
                                                context,
                                                killedGamers,
                                                isNightMode: false,
                                                () {
                                                  if (mafiaCount == 1 &&
                                                      civilianCount == 2) {
                                                    showContinueGameDialog(
                                                      context,
                                                      accepted: () {
                                                        if (gamePhase ==
                                                            GamePhase
                                                                .Finished) {
                                                          showResultScreen(
                                                            context,
                                                          );
                                                        }
                                                      },
                                                    );
                                                  }
                                                },
                                              );
                                            }
                                          },
                                          gamerHasAlibi: (Gamer gamer) {
                                            showInfoDialog(
                                              context,
                                              description: gamerHasAlibi(
                                                gamer.name ?? '',
                                              ),
                                            );
                                          },
                                          showPickedNumber:
                                              (List<Gamer> topGamers) {
                                            showPickNumber(
                                              context,
                                              topGamers,
                                              () {
                                                if (mafiaCount == 1 &&
                                                    civilianCount == 2) {
                                                  showContinueGameDialog(
                                                    context,
                                                    accepted: () {
                                                      if (gamePhase ==
                                                          GamePhase.Finished) {
                                                        showResultScreen(
                                                          context,
                                                        );
                                                      }
                                                    },
                                                  );
                                                }
                                              },
                                            );
                                          },
                                        ),
                                      );
                                      break;
                                    default:
                                      break;
                                  }
                                }
                              },
                            ),
                          ),
                        ),
                        if (gamePhase == GamePhase.Discussion &&
                            gamePeriod == GamePeriod.Day)
                          Center(
                            child: CountDownTimer(
                              durationTime: discussionTime,
                              changeTimer: (int time) {
                                BlocProvider.of<GameBloc>(context).add(
                                  ChangeDiscussionTime(
                                    discussionTime: time,
                                  ),
                                );
                              },
                            ),
                          )
                        else if (gamePhase == GamePhase.Voting)
                          voteDirection == VoteDirection.NotSet
                              ? Positioned(
                                  left: screenWidth /
                                      directionButtonRightPercentage,
                                  bottom: screenHeight /
                                      directionButtonBottomPercentage,
                                  child: const DirectionButtons(),
                                )
                              : Center(
                                  child: CountDownTimer(
                                    durationTime: votingTime,
                                    changeTimer: (int time) {
                                      BlocProvider.of<GameBloc>(context).add(
                                        ChangeVotingTime(
                                          votingTime: time,
                                        ),
                                      );
                                    },
                                  ),
                                )
                        else if (gamePhase == GamePhase.Sleeping)
                          Positioned(
                            left: screenWidth / directionButtonRightPercentage,
                            bottom:
                                screenHeight / directionButtonBottomPercentage,
                            child: const CenteredInfo(
                              description: AppStrings.allGamersGoingSleeping,
                            ),
                          ),
                        if (gamePhase == GamePhase.CouldStart)
                          Positioned(
                            left: screenWidth / 2.8,
                            bottom: screenHeight / 3.3,
                            child: const RolesChanger(),
                          ),
                        if (gamePeriod == GamePeriod.Night)
                          Positioned(
                            left: screenWidth / 2.8,
                            bottom: screenHeight / 3.3,
                            child: const RolesChanger(),
                          ),
                        Positioned(
                          left: screenWidth * buttonLeftPercentage,
                          top: screenHeight * roundButtonBottomPercentage,
                          child: SizedBox(
                            width: 120,
                            child: BaseButton(
                              label: gamePeriod == GamePeriod.Day
                                  ? "$dayNumber ${AppStrings.day}"
                                  : "$nightNumber ${AppStrings.night}",
                              enabled: false,
                              textStyle:
                                  MafiaTheme.themeData.textTheme.titleMedium,
                            ),
                          ),
                        ),
                        Positioned(
                          left: screenWidth * buttonLeftPercentage,
                          bottom: screenHeight * roundButtonBottomPercentage,
                          child: RoundedIconButton(
                            icon: showRoles
                                ? Icons.visibility_off_sharp
                                : Icons.visibility_sharp,
                            isVisible: true,
                            onPressed: () {
                              setState(() {
                                showRoles = !showRoles;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
}
