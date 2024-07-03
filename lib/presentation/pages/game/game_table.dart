part of game;

class GameTableScreen extends StatefulWidget {
  @override
  State<GameTableScreen> createState() => _GameTableScreenState();
}

class _GameTableScreenState extends State<GameTableScreen> {
  bool showRoles = false;
  Gamer killedGamer = const Gamer.empty();

  void showLastResults(
    int mafiaCount,
    int civilianCount,
    List<Gamer> gamers,
    String gameName,
    DateTime? gameStartTime,
    BuildContext context,
  ) {
    print('mafiaCount: $mafiaCount, civilianCount: $civilianCount');
    if (mafiaCount == civilianCount) {
      showResults(
        context,
        gamers,
        isMafia: true,
        gameName: gameName,
        gameStartTime: DateFormat('yyyy-MM-dd').format(gameStartTime!),
      );
    } else if (mafiaCount == 0) {
      showResults(
        context,
        gamers,
        gameName: gameName,
        gameStartTime: DateFormat('yyyy-MM-dd').format(gameStartTime!),
      );
    }
  }

  @override
  Widget build(BuildContext context) => BlocConsumer<GameBloc, AppState>(
        listenWhen: (AppState previous, AppState current) =>
            previous.game.mafiaCount != current.game.mafiaCount ||
            previous.game.civilianCount != current.game.civilianCount,
        listener: (BuildContext context, AppState state) {
          final List<Gamer> gamers = state.gamersState.gamers;
          final String gameName = state.game.gameName;
          final int mafiaCount = state.game.mafiaCount;
          final int civilianCount = state.game.civilianCount;
          final DateTime? gameStartTime = state.game.gameStartTime;
          print('mafiaCount 1: $mafiaCount, '
              'civilianCount 1: $civilianCount');
          showLastResults(
            mafiaCount,
            civilianCount,
            gamers,
            gameName,
            gameStartTime,
            context,
          );
        },
        builder: (BuildContext context, AppState state) {
          final int numberOfGamers = state.game.numberOfGamers;
          final List<Gamer> gamers = state.gamersState.gamers;
          final bool isGameCouldStart = state.game.isGameCouldStart;
          final double screenWidth = MediaQuery.of(context).size.width;
          final double screenHeight = MediaQuery.of(context).size.height;
          final String gameName = state.game.gameName;
          final bool isGameStarted = state.game.isGameStarted;
          final bool isDiscussionStarted = state.game.isDiscussionStarted;
          final bool isVotingStarted = state.game.isVotingStarted;
          final int discussionTime = state.game.discussionTime;
          final int votingTime = state.game.votingTime;
          final String gameId = state.game.gameId;
          final DateTime? gameStartTime = state.game.gameStartTime;
          final bool isDay = state.game.isDay;
          final int dayNumber = state.game.dayNumber;
          final int nightNumber = state.game.nightNumber;
          final List<Gamer> killedGamers = <Gamer>[];

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
                          label: isGameStarted
                              ? !isDiscussionStarted
                                  ? isDay
                                      ? AppStrings.endVoting
                                      : AppStrings.endNight
                                  : AppStrings.endDiscussion
                              : AppStrings.startGame,
                          enabled: isGameStarted && !isDiscussionStarted ||
                              !isGameStarted && isGameCouldStart ||
                              isDiscussionStarted && !isVotingStarted,
                          textStyle:
                              MafiaTheme.themeData.textTheme.headlineSmall,
                          action: () {
                            if (isGameStarted) {
                              if (isDiscussionStarted) {
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
                              } else if (isVotingStarted) {
                                final int maxVotes = gamers.fold(
                                  0,
                                  (int prev, Gamer gamer) =>
                                      gamer.votesCount > prev
                                          ? gamer.votesCount
                                          : prev,
                                );

                                if (maxVotes == 0) {
                                  SnackBarManager.showFailure(
                                    context,
                                    message: AppStrings.votesHaveNotAdded,
                                  );
                                }
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
                                    const EndVoting(
                                      isVotingStarted: false,
                                    ),
                                  );
                                  BlocProvider.of<GameBloc>(context).add(
                                    const AddDayNumber(),
                                  );
                                  if (dayNumber == 1 &&
                                      topGamers[0].role!.roleId == 8) {
                                    Gamer leftGamer = const Gamer.empty();
                                    Gamer rightGamer = const Gamer.empty();
                                    print('topGamers[0].id:'
                                        ' ${topGamers[0].id}');
                                    if (topGamers[0].id == 1) {
                                      leftGamer = gamers.last;
                                    } else {
                                      leftGamer = gamers[topGamers[0].id! - 2];
                                    }
                                    rightGamer = gamers[topGamers[0].id!];

                                    BlocProvider.of<GameBloc>(context).add(
                                      KillGamer(gamer: leftGamer),
                                    );
                                    BlocProvider.of<GameBloc>(context).add(
                                      KillGamer(gamer: rightGamer),
                                    );
                                  }
                                  showKilledGamer(
                                    context,
                                    topGamers[0],
                                  );
                                } else if (topGamers.length > 1) {
                                  showPickNumber(
                                    context,
                                    topGamers,
                                    () {},
                                  );
                                }
                                BlocProvider.of<GameBloc>(context).add(
                                  const ResetVoters(),
                                );
                              } else if (!isDay) {
                                BlocProvider.of<GameBloc>(context).add(
                                  const UpdateAnimation(),
                                );
                                for (final Gamer gamer in gamers) {
                                  if (!gamer.wasKilled) {
                                    if (!gamer.wasSecured && !gamer.wasHealed) {
                                      if (gamer.wasKilledByMafia ||
                                          gamer.wasKilledByKiller ||
                                          gamer.wasKilledBySheriff ||
                                          gamer.wasBoomeranged) {
                                        killedGamers.add(gamer);
                                      }
                                    }
                                  }
                                }
                                if (killedGamers.isNotEmpty) {
                                  showKilledGamersAtNight(
                                    context,
                                    killedGamers,
                                  );

                                  for (final Gamer gamer in killedGamers) {
                                    if (gamer.role?.roleId != 14) {
                                      BlocProvider.of<GameBloc>(context).add(
                                        KillGamer(gamer: gamer),
                                      );
                                    }
                                  }
                                }
                                BlocProvider.of<GameBloc>(context).add(
                                  const AddNightNumber(),
                                );
                              }
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
                                const UpdateAnimation(),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    if (isDiscussionStarted && !isVotingStarted)
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
                    else if (isVotingStarted)
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
                    if (isGameCouldStart && !isGameStarted)
                      Positioned(
                        left: screenWidth / 3,
                        bottom: screenHeight / 3.3,
                        child: const RolesChanger(),
                      ),
                    if (!isDay)
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
                          label: isDay
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
