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
    }
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
    print('Save result mafiaCount $mafiaCount, civilianCount $civilianCount');
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
        ),
      );
      count++;
    } else if (mafiaCount == 0 && werewolf == null && count == 0) {
      BlocProvider.of<GameBloc>(context).add(
        CalculatePoints(
          gameState: game.copyWith(isMafiaWin: false, gamers: gamers),
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
        ),
      );
      count++;
    }
  }

  @override
  Widget build(BuildContext context) => BlocConsumer<GameBloc, AppState>(
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
          print('mafiacount $mafiaCount, civilianCount $civilianCount');
          victoryByWerewolf = state.game.victoryByWerewolf;
          werewolfWasDead = state.game.werewolfWasDead;
          isMafiaWin = state.game.isMafiaWin;
          /*  print('gamePhase $gamePhase');*/

          if (gamePhase == GamePhase.Discussion ||
              gamePhase == GamePhase.Voting) {
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
          final List<Gamer> gamers = state.gamersState.gamers;
          // final GamePhase gamePhase = state.game.gamePhase;
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
          // print('game phase is $gamePhase');

          const double buttonLeftPercentage = 0.07;
          const double buttonBottomPercentage = 0.02;
          const double roundButtonBottomPercentage = 0.05;
          return Scaffold(
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
                for (final Gamer gamer in gamers) {
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
                              print('Night was called');
                              BlocProvider.of<GameBloc>(context).add(
                                NightAction(
                                  showKilledGamers:
                                      (List<Gamer> newKilledGamers) {
                                    if (newKilledGamers.isNotEmpty) {
                                      showKilledGamersAtNight(
                                        context,
                                        newKilledGamers,
                                        () {
                                          // if (mafiaCount == civilianCount - 1) {
                                            // showContinueGameDialog(
                                            //   context,
                                            //   accepted: () {
                                            //     BlocProvider.of<GameBloc>(
                                            //       context,
                                            //     ).add(
                                            //       CalculatePoints(
                                            //         gameState:
                                            //             gameState.copyWith(
                                            //           isMafiaWin: true,
                                            //           gamers: gamers,
                                            //         ),
                                            //       ),
                                            //     );
                                                // if (gamePhase ==
                                                //     GamePhase.Finished) {
                                                //   Navigator.of(context)
                                                //       .popUntil(
                                                //     (Route<dynamic> route) =>
                                                //         route.isFirst,
                                                //   );
                                                //   Navigator.of(context).push(
                                                //     MaterialPageRoute<void>(
                                                //       builder: (
                                                //         BuildContext context,
                                                //       ) =>
                                                //           ResultScreen(
                                                //         gamers: gamers,
                                                //         isMafiaWinner:
                                                //             isMafiaWin,
                                                //         gameName: gameName,
                                                //         gameStartTime:
                                                //             DateFormat(
                                                //           'yyyy-MM-dd',
                                                //         ).format(
                                                //           gameStartTime!,
                                                //         ),
                                                //         gameId: gameId,
                                                //         victoryByWerewolf:
                                                //             victoryByWerewolf,
                                                //         werewolfWasDead:
                                                //             werewolfWasDead,
                                                //       ),
                                                //     ),
                                                //   );
                                                //   BlocProvider.of<GameBloc>(
                                                //     context,
                                                //   ).add(
                                                //     const EmptyGame(),
                                                //   );
                                                // }
                                              // },
                                            // );
                                          // }
                                        },
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          backgroundColor: Colors.green,
                                          content: Text(
                                            AppStrings.nobodyWasKilled,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16.0,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              );
                            } else {
                              switch (gamePhase) {
                                case GamePhase.CouldStart:
                                  isAllGamersCitizen = gamers.every(
                                    (Gamer gamer) =>
                                        gamer.role.roleType ==
                                        RoleType.Civilian,
                                  );
                                  isMafiaExist = gamers.any(
                                    (Gamer gamer) =>
                                        gamer.role.roleType == RoleType.Mafia ||
                                        gamer.role.roleType == RoleType.Don,
                                  );
                                  if (isAllGamersCitizen) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text(
                                          AppStrings.allGamersCitizens,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ),
                                    );
                                  } else if (!isMafiaExist) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text(
                                          AppStrings.mafiaDoesNotExist,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    BlocProvider.of<GameBloc>(context).add(
                                      SaveGame(
                                        gameState: state.game.copyWith(
                                          gameName: gameName,
                                          numberOfGamers: numberOfGamers,
                                          gameId: gameId,
                                          gamers: gamers,
                                          gameStartTime:
                                              gameStartTime ?? DateTime.now(),
                                        ),
                                      ),
                                    );

                                    BlocProvider.of<GameBloc>(context).add(
                                      const UpdateAnimation(animate: true),
                                    );
                                  }
                                  break;
                                case GamePhase.Discussion:
                                  print('Discussion was called');
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
                                case GamePhase.Voting:
                                  print('Voting was called');
                                  BlocProvider.of<GameBloc>(context).add(
                                    VotingAction(
                                      showFailureInfo: () {
                                        SnackBarManager.showFailure(
                                          context,
                                          message: AppStrings.votesHaveNotAdded,
                                        );
                                      },
                                      showKilledGamers: (Gamer killedGamer) {
                                        showKilledGamer(context, killedGamer,
                                            () {
                                          print('Killed gamer was shown, '
                                              'mafiaCount $mafiaCount, '
                                              'civilianCount $civilianCount');
                                          // if (mafiaCount == civilianCount - 1) {
                                          //   showContinueGameDialog(
                                          //     context,
                                          //     accepted: () {
                                          //       BlocProvider.of<GameBloc>(
                                          //         context,
                                          //       ).add(
                                          //         CalculatePoints(
                                          //           gameState:
                                          //               gameState.copyWith(
                                          //             isMafiaWin: true,
                                          //             gamers: gamers,
                                          //           ),
                                          //         ),
                                          //       );
                                          //     },
                                          //   );
                                          // }
                                          // if (gamePhase == GamePhase.Finished) {
                                          //   Navigator.of(context).popUntil(
                                          //     (Route<dynamic> route) =>
                                          //         route.isFirst,
                                          //   );
                                          //   Navigator.of(context).push(
                                          //     MaterialPageRoute<void>(
                                          //       builder:
                                          //           (BuildContext context) =>
                                          //               ResultScreen(
                                          //         gamers: gamers,
                                          //         isMafiaWinner: isMafiaWin,
                                          //         gameName: gameName,
                                          //         gameStartTime: DateFormat(
                                          //                 'yyyy-MM-dd')
                                          //             .format(gameStartTime!),
                                          //         gameId: gameId,
                                          //         victoryByWerewolf:
                                          //             victoryByWerewolf,
                                          //         werewolfWasDead:
                                          //             werewolfWasDead,
                                          //       ),
                                          //     ),
                                          //   );
                                          //   BlocProvider.of<GameBloc>(context)
                                          //       .add(
                                          //     const EmptyGame(),
                                          //   );
                                          // }
                                        });
                                      },
                                      showPickedNumber:
                                          (List<Gamer> topGamers) {
                                        showPickNumber(
                                          context,
                                          topGamers,
                                          () {
                                            // if (mafiaCount ==
                                            //     civilianCount - 1) {
                                            //   showContinueGameDialog(
                                            //     context,
                                            //     accepted: () {
                                                  // BlocProvider.of<GameBloc>(
                                                  //   context,
                                                  // ).add(
                                                  //   CalculatePoints(
                                                  //     gameState:
                                                  //         gameState.copyWith(
                                                  //       isMafiaWin: true,
                                                  //       gamers: gamers,
                                                  //     ),
                                                  //   ),
                                                  // );
                                                  // if (gamePhase ==
                                                  //     GamePhase.Finished) {
                                                  //   Navigator.of(context)
                                                  //       .popUntil(
                                                  //     (Route<dynamic> route) =>
                                                  //         route.isFirst,
                                                  //   );
                                                  //   Navigator.of(context).push(
                                                  //     MaterialPageRoute<void>(
                                                  //       builder: (
                                                  //         BuildContext context,
                                                  //       ) =>
                                                  //           ResultScreen(
                                                  //         gamers: gamers,
                                                  //         isMafiaWinner:
                                                  //             isMafiaWin,
                                                  //         gameName: gameName,
                                                  //         gameStartTime:
                                                  //             DateFormat(
                                                  //           'yyyy-MM-dd',
                                                  //         ).format(
                                                  //           gameStartTime!,
                                                  //         ),
                                                  //         gameId: gameId,
                                                  //         victoryByWerewolf:
                                                  //             victoryByWerewolf,
                                                  //         werewolfWasDead:
                                                  //             werewolfWasDead,
                                                  //       ),
                                                  //     ),
                                                  //   );
                                                  //   BlocProvider.of<GameBloc>(
                                                  //           context)
                                                  //       .add(
                                                  //     const EmptyGame(),
                                                  //   );
                                                  // }
                                              //   },
                                              // );
                                            // }
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
                      Center(
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
                      ),
                    if (gamePhase == GamePhase.CouldStart)
                      Positioned(
                        left: screenWidth / 2.5,
                        bottom: screenHeight / 3.3,
                        child: const RolesChanger(),
                      ),
                    if (gamePeriod == GamePeriod.Night)
                      Positioned(
                        left: screenWidth / 2.5,
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
          );
        },
      );
}
