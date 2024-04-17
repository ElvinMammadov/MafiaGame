part of home;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final bool _isLoading = false;
  String? typeOfGame;

  String? typeOfController;
  int? numberOfGamers = 0;
  String? gameName = '';

  @override
  Widget build(BuildContext context) => BlocBuilder<GameBloc, AppState>(
        builder: (BuildContext context, AppState state) => Scaffold(
          appBar: const DefaultAppBar(
            title: AppStrings.title,
          ),
          body: DecoratedBox(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: SizedBox.expand(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  HomeScreenForm(
                    onChange: _onChange,
                  ),
                  SizedBox(
                    width: 300,
                    child: BaseButton(
                      label: AppStrings.start,
                      enabled: gameName != null &&
                          gameName!.isNotEmpty &&
                          numberOfGamers != null &&
                          numberOfGamers! > 0,
                      backgroundColor:
                          MafiaTheme.themeData.colorScheme.secondary,
                      action: () {
                        _startButtonPressed(context);
                      },
                      textStyle: MafiaTheme.themeData.textTheme.headlineSmall,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  void _onChange({
    String? typeOfGame,
    String? typeOfController,
    int? numberOfGamers,
    String? gameName,
  }) {
    setState(() {
      this.typeOfGame = typeOfGame ?? this.typeOfGame;
      this.typeOfController = typeOfController ?? this.typeOfController;
      this.numberOfGamers = numberOfGamers ?? this.numberOfGamers;
      this.gameName = gameName ?? this.gameName;
    });
  }

  void _startButtonPressed(BuildContext context) {
    final String gameId = UniqueKey().toString();
    BlocProvider.of<GameBloc>(context).add(
      UpdateGameDetails(
        gameName: gameName ?? '',
        typeOfGame: typeOfGame ?? '',
        typeOfController: typeOfController ?? '',
        numberOfGamers: numberOfGamers ?? 0,
        gameId: gameId,
      ),
    );
    AppNavigator.navigateToTablePage(context);
  }
}
