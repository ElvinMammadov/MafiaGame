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
          final bool? isGameCouldStart = state.game.isGameCouldStart;
          final double screenWidth = MediaQuery.of(context).size.width;
          final double screenHeight = MediaQuery.of(context).size.height;
          final String gameName = state.game.gameName;
          final bool isGameStarted = state.game.isGameStarted;
          print('isGameStarted: $isGameStarted');

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
                  image: AssetImage('assets/mafia_table.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: SizedBox.expand(
                child: Stack(
                  children: <Widget>[
                    CircleAvatarWidget(
                      showRoles: showRoles,
                    ),
                    if (isGameStarted)
                      const SizedBox()
                    else
                      Positioned(
                        right: screenWidth * buttonLeftPercentage,
                        bottom: screenHeight * buttonBottomPercentage,
                        child: SizedBox(
                          width: 300,
                          child: BaseButton(
                            label: AppStrings.startGame,
                            enabled: isGameCouldStart!,
                            textStyle:
                                MafiaTheme.themeData.textTheme.headlineSmall,
                            action: () {
                              final String gameId = UniqueKey().toString();
                              BlocProvider.of<GameBloc>(context).add(
                                SendGameToFirebase(
                                  gameName: gameName,
                                  numberOfGamers: numberOfGamers,
                                  gameId: gameId,
                                  gamers: gamers,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    // Center(
                    //   child: CountDownTimer(),
                    // ),
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
