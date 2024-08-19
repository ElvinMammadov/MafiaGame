part of game;

class GameTableScreen extends StatefulWidget {
  @override
  State<GameTableScreen> createState() => _GameTableScreenState();
}

class _GameTableScreenState extends State<GameTableScreen> {
  bool showRoles = false;
  Gamer killedGamer = const Gamer.empty();
  int count = 0;

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
    print('werewolf $werewolf');
    // final bool isWerewolfAlive = false;

    if (mafiaCount == 0 && werewolf != null && !werewolf.wasKilled) {
      BlocProvider.of<GameBloc>(context).add(
        ChangeWerewolf(),
      );
    }
    if (mafiaCount == civilianCount && count == 0) {
      print('mafiaCount == civilianCount');
      BlocProvider.of<GameBloc>(context).add(
        CalculatePoints(
          gameState: game.copyWith(isMafiaWin: true, gamers: gamers),
        ),
      );
      count++;
    } else if (mafiaCount == 0 && werewolf == null && count == 0) {
      print('mafiaCount == 0 && !isWerewolfAlive');
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
          gameState: game.copyWith(isMafiaWin: true, gamers: gamers),
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
          final int mafiaCount = state.game.mafiaCount;
          final int civilianCount = state.game.civilianCount;
          final DateTime? gameStartTime = state.game.gameStartTime;
          final GameState gameState = state.game;
          final GamePhase gamePhase = state.game.gamePhase;
          final bool isMafiaWin = state.game.isMafiaWin;
          final String gameId = state.game.gameId;
          print('mafiacount $mafiaCount, civilianCount $civilianCount');
          print('gamePhase $gamePhase');
          if (gamePhase == GamePhase.Finished) {
            Navigator.of(context)
                .popUntil((Route<dynamic> route) => route.isFirst);
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (BuildContext context) => ResultScreen(
                  gamers: gamers,
                  isMafiaWinner: isMafiaWin,
                  gameName: gameName,
                  gameStartTime:
                      DateFormat('yyyy-MM-dd').format(gameStartTime!),
                  gameId: gameId,
                ),
              ),
            );
            BlocProvider.of<GameBloc>(context).add(
              const EmptyGame(),
            );
          }

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
          final GamePhase gamePhase = state.game.gamePhase;
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
          final List<Gamer> killedGamers = <Gamer>[];
          bool isAllGamersCitizen = false;
          bool isMafiaExist = false;
          print('game phase is $gamePhase');

          if (gamers.isNotEmpty) {
            // logger.log('Gamers are ${gamers.map(
            //       (Gamer gamer) => gamer.name,
            //     ).toList()}');
            // print('Gamers namesChanged ${gamers.map(
            //       (Gamer gamer) => gamer.isNameChanged,
            //     ).toList()}');
            // print('Gamers animates ${gamers.map(
            //       (Gamer gamer) => gamer.isAnimated,
            //     ).toList()}');
          }

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
                BlocProvider.of<GameBloc>(context).add(
                  const EmptyGame(),
                );
                Navigator.of(context)
                    .popUntil((Route<dynamic> route) => route.isFirst);
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
                        width: 400,
                        child: BaseButton(
                          label: gamePeriod == GamePeriod.Day
                              ? buttonTitle(gamePhase)
                              : AppStrings.endNight,
                          enabled: gamePhase != GamePhase.IsReady,
                          textStyle:
                              MafiaTheme.themeData.textTheme.headlineSmall,
                          action: () {
                            if (gamePeriod != GamePeriod.Day) {
                              BlocProvider.of<GameBloc>(context).add(
                                const UpdateAnimation(animate: true),
                              );

                              for (final Gamer gamer in gamers) {
                                if (!gamer.wasKilled) {
                                  if (!gamer.wasHealed) {
                                    if (gamer.wasKilledByMafia ||
                                        gamer.wasKilledByKiller ||
                                        gamer.wasKilledBySheriff ||
                                        gamer.wasBoomeranged ||
                                        gamer.killSecurity) {
                                      if (gamer.role.roleType !=
                                              RoleType.Boomerang &&
                                          gamer.role.roleType !=
                                              RoleType.Werewolf) {
                                        print('gamer $gamer');
                                        killedGamers.add(gamer);
                                      }
                                    }
                                  }
                                }
                              }
                              if (killedGamers.isNotEmpty) {
                                final List<Gamer> newKilledGamers = killedGamers
                                    .where(
                                      (Gamer gamer) => !gamer.wasSecured,
                                    )
                                    .toList();
                                if (newKilledGamers.isNotEmpty) {
                                  showKilledGamersAtNight(
                                    context,
                                    newKilledGamers,
                                  );
                                }
                                for (final Gamer gamer in killedGamers) {
                                  if (gamer.role.roleType !=
                                          RoleType.Boomerang &&
                                      gamer.role.roleType !=
                                          RoleType.Werewolf) {
                                    BlocProvider.of<GameBloc>(context).add(
                                      KillGamer(gamer: gamer),
                                    );
                                  }
                                }
                              }
                              BlocProvider.of<GameBloc>(context).add(
                                const AddNightNumber(),
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
                                            fontSize: 24.0,
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
                                            fontSize: 24.0,
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
                                  final int maxVotes = gamers.fold(
                                    0,
                                    (int prev, Gamer gamer) =>
                                        gamer.votesCount > prev
                                            ? gamer.votesCount
                                            : prev,
                                  );

                                  /// To show Chameleon functionality
                                  // if (roleIndex == 0) {
                                  //   showAddFunctionality(
                                  //     context,
                                  //     isVotingStarted: true,
                                  //     gamerId: 1,
                                  //     roleId: 1,
                                  //     nightNumber: 1,
                                  //   );
                                  // }

                                  if (maxVotes == 0) {
                                    SnackBarManager.showFailure(
                                      context,
                                      message: AppStrings.votesHaveNotAdded,
                                    );
                                  } else {
                                    final List<Gamer> topGamers = gamers
                                        .where(
                                          (Gamer gamer) =>
                                              gamer.votesCount == maxVotes &&
                                              maxVotes != 0,
                                        )
                                        .map((Gamer gamer) => gamer)
                                        .toList();

                                    if (topGamers.length == 1) {
                                      BlocProvider.of<GameBloc>(context).add(
                                        KillGamer(gamer: topGamers[0]),
                                      );

                                      BlocProvider.of<GameBloc>(context).add(
                                        const EndVoting(),
                                      );
                                      BlocProvider.of<GameBloc>(context).add(
                                        const AddDayNumber(),
                                      );
                                      if (dayNumber == 1 &&
                                          topGamers[0].role.roleType ==
                                              RoleType.Virus) {
                                        Gamer leftGamer = const Gamer.empty();
                                        Gamer rightGamer = const Gamer.empty();
                                        if (topGamers[0].id == 1) {
                                          leftGamer = gamers.last;
                                        } else {
                                          leftGamer =
                                              gamers[topGamers[0].id! - 2];
                                        }
                                        rightGamer = gamers[topGamers[0].id!];

                                        BlocProvider.of<GameBloc>(context).add(
                                          KillGamer(gamer: leftGamer),
                                        );
                                        BlocProvider.of<GameBloc>(context).add(
                                          KillGamer(gamer: rightGamer),
                                        );
                                      }
                                      if (!topGamers[0].hasAlibi &&
                                          !topGamers[0].wasSecured) {
                                        showKilledGamer(
                                          context,
                                          topGamers[0],
                                        );
                                      }
                                    } else if (topGamers.length > 1) {
                                      showPickNumber(
                                        context,
                                        topGamers,
                                        () {},
                                      );
                                    }
                                    if (dayNumber == 2) {
                                      for (final Gamer gamer in gamers) {
                                        BlocProvider.of<GameBloc>(context).add(
                                          InfectGamer(
                                            targetedGamer: gamer,
                                            infect: false,
                                          ),
                                        );
                                      }
                                    }
                                    BlocProvider.of<GameBloc>(context).add(
                                      const CleanGamersAfterDay(),
                                    );
                                    BlocProvider.of<GameBloc>(context).add(
                                      const ResetVoters(),
                                    );
                                    BlocProvider.of<GameBloc>(context).add(
                                      InfectedCount(
                                        infectedCount: state.game.mafiaCount,
                                      ),
                                    );
                                    BlocProvider.of<GameBloc>(context).add(
                                      const UpdateAnimation(animate: false),
                                    );
                                  }
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
                        left: screenWidth / 3,
                        bottom: screenHeight / 3.3,
                        child: const RolesChanger(),
                      ),
                    if (gamePeriod == GamePeriod.Night)
                      Positioned(
                        left: screenWidth / 3,
                        bottom: screenHeight / 3.3,
                        child: const RolesChanger(),
                      ),
                    Positioned(
                      left: screenWidth * buttonLeftPercentage,
                      top: screenHeight * roundButtonBottomPercentage,
                      child: SizedBox(
                        width: 200,
                        child: BaseButton(
                          label: gamePeriod == GamePeriod.Day
                              ? "$dayNumber ${AppStrings.day}"
                              : "$nightNumber ${AppStrings.night}",
                          enabled: false,
                          textStyle:
                              MafiaTheme.themeData.textTheme.headlineSmall,
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
