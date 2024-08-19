part of home;

class GamesScreen extends StatefulWidget {
  const GamesScreen({super.key});

  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      // Refer step 1
      firstDate: DateTime(2023),
      lastDate: DateTime(2026),
      cancelText: AppStrings.cancel,
      confirmText: AppStrings.choose,
      locale: const Locale('ru', 'RU'),
      builder: (BuildContext context, Widget? child) => Theme(
        data: MafiaTheme.themeData.copyWith(
          colorScheme: MafiaTheme.themeData.colorScheme.copyWith(
            primary: MafiaTheme.themeData.colorScheme.secondary,
            // header background color
            onPrimary: MafiaTheme.themeData.colorScheme.primary,
            // header text color
            onSurface:
                MafiaTheme.themeData.colorScheme.primary, // body text color
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: MafiaTheme
                  .themeData.colorScheme.primary, // ok , cancel    buttons
            ),
          ),
          textTheme: MafiaTheme.themeData.textTheme.copyWith(
            headlineSmall:
                MafiaTheme.themeData.textTheme.headlineSmall?.copyWith(
              color: MafiaTheme.themeData.colorScheme.primary,
            ),
            bodySmall: MafiaTheme.themeData.textTheme.bodySmall?.copyWith(
              color: MafiaTheme.themeData.colorScheme.secondary,
            ),
          ),
          dialogBackgroundColor: MafiaTheme.themeData.colorScheme.secondary,
        ),
        child: child!,
      ),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      BlocProvider.of<GameBloc>(context).add(
        GetGames(dateTime: selectedDate),
      );
    }
  }

  @override
  void initState() {
    BlocProvider.of<GameBloc>(context).add(
      GetGames(dateTime: selectedDate),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    const double buttonLeftPercentage = 0.06;
    // const double buttonBottomPercentage = 0.02;
    const double roundButtonBottomPercentage = 0.03;
    print('GamesScreen build');

    return BlocBuilder<GameBloc, AppState>(
      builder: (BuildContext context, AppState state) {
        final List<GameState> games = state.games;
        return Stack(
          children: <Widget>[
            Positioned(
              right: screenWidth * buttonLeftPercentage,
              top: screenHeight * roundButtonBottomPercentage,
              child: RoundedIconButton(
                icon: Icons.calendar_month,
                onPressed: () {
                  _selectDate(context);
                  setState(() {
                    // showRoles = !showRoles;
                  });
                },
                isVisible: true,
              ),
            ),
            if (games.isNotEmpty)
              Positioned(
                right: screenWidth * 0.05,
                top: screenHeight * 0.10,
                child: SizedBox(
                  height: screenHeight * 0.8,
                  width: screenWidth * 0.9,
                  child: ListView.builder(
                    itemCount: games.length,
                    itemBuilder: (BuildContext context, int index) =>
                        GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => ResultScreen(
                              gamers: games[index].gamers,
                              isMafiaWinner: games[index].isMafiaWin,
                              gameName: games[index].gameName,
                              gameStartTime: DateFormat('yyyy-MM-dd')
                                  .format(games[index].gameStartTime!),
                              gameId: games[index].gameId,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        color: MafiaTheme.themeData.colorScheme.secondary
                            .withOpacity(0.4),
                        child: SizedBox(
                          // height: 600,
                          // width: 900,
                          child: GamesResults(
                            gamers: games[index].gamers,
                            isMafia: games[index].isMafiaWin,
                            gameName: games[index].gameName,
                            gameStartTime: DateFormat('yyyy-MM-dd')
                                .format(games[index].gameStartTime!),
                          ),
                        ),
                      ).padding(
                        bottom: 16,
                      ),
                    ),
                  ),
                ),
              )
            else
              Center(
                child: Text(
                  AppStrings.doesNotHaveGame,
                  style: MafiaTheme.themeData.textTheme.headlineSmall,
                ),
              ),
          ],
        );
      },
    );
  }
}
