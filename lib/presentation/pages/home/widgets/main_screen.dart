part of home;

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String? typeOfGame;

  String? typeOfController;
  int? numberOfGamers = 0;
  String? gameName = '';
  @override
  Widget build(BuildContext context) => SizedBox.expand(
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
              backgroundColor: MafiaTheme
                  .themeData.colorScheme.secondary
                  .withOpacity(0.8),
              action: () {
                _startButtonPressed(context);
              },
              textStyle: MafiaTheme.themeData.textTheme.headlineSmall,
            ),
          ),
        ],
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

