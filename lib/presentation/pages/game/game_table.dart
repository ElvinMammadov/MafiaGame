part of game;

class GameTableScreen extends StatefulWidget {
  @override
  State<GameTableScreen> createState() => _GameTableScreenState();
}

class _GameTableScreenState extends State<GameTableScreen> {
  bool showRoles = false;

  @override
  Widget build(BuildContext context) => BlocBuilder<GameBloc, AppState>(
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
          print('isday $isDay');
          // print('isDiscussionStarted: $isDiscussionStarted');
          // print('isGameStarted: $isGameStarted');
          // print('isVotingStarted: $isVotingStarted');
          // print('isGameStarted: $isGameStarted');
          // print('isGameCouldStart: $isGameCouldStart');
          // print('discussionTime: $discussionTime');
          // print('votingTime: $votingTime');

          const double buttonLeftPercentage = 0.1;
          const double buttonBottomPercentage = 0.03;
          const double roundButtonBottomPercentage = 0.05;
          return Scaffold(
            appBar: DefaultAppBar(
              title: AppStrings.title,
              showBackButton: true,
              actionCallback: () {
                BlocProvider.of<GameBloc>(context).add(
                  const CleanGamers(gamers: <Gamer>[]),
                );
              },
            ),
            resizeToAvoidBottomInset: false,
            body: DecoratedBox(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/table.jpeg'),
                  fit: BoxFit.fill,
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
                                  const EndDiscussion(
                                    isDiscussionStarted: false,
                                  ),
                                );
                              } else if (isVotingStarted) {
                                BlocProvider.of<GameBloc>(context).add(
                                  const EndVoting(
                                    isVotingStarted: false,
                                  ),
                                );
                                BlocProvider.of<GameBloc>(context).add(
                                  const AddDayNumber(),
                                );
                              }
                             else if (!isDay) {
                                print('add night number');
                                BlocProvider.of<GameBloc>(context).add(
                                  const AddNightNumber(),
                                );
                              }
                            } else {
                              BlocProvider.of<GameBloc>(context).add(
                                SendGameToFirebase(
                                  gameName: gameName,
                                  numberOfGamers: numberOfGamers,
                                  gameId: gameId,
                                  gamers: gamers,
                                  gameStartTime:
                                      gameStartTime ?? DateTime.now(),
                                ),
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
