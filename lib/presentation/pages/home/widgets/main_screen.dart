part of home;

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String typeOfGamer = AppStrings.savedGamers;
  String? typeOfController;
  int? numberOfGamers = 0;
  String? gameName = '';
  List<Role>? roles = <Role>[];

  @override
  Widget build(BuildContext context) => SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            HomeScreenForm(
              onChange: _onChange,
            ),
            SizedBox(
              width: 250,
              child: BaseButton(
                label: AppStrings.start,
                enabled: gameName != null &&
                    gameName!.isNotEmpty &&
                    numberOfGamers != null &&
                    numberOfGamers! > 0,
                backgroundColor:
                    MafiaTheme.themeData.colorScheme.secondary.withOpacity(0.8),
                action: () {
                  _startButtonPressed(context);
                },
                textStyle: MafiaTheme.themeData.textTheme.headlineSmall,
              ).padding(
                horizontal: 16.0,
                vertical: 16.0,
              ),
            ),
          ],
        ),
      );

  void _onChange({
    String? typeOfGamer,
    String? typeOfController,
    int? numberOfGamers,
    String? gameName,
    List<Role>? selectedRoles,
  }) {
    setState(() {
      this.typeOfGamer = typeOfGamer ?? this.typeOfGamer;
      this.typeOfController = typeOfController ?? this.typeOfController;
      this.numberOfGamers = numberOfGamers ?? this.numberOfGamers;
      this.gameName = gameName ?? this.gameName;
      roles = selectedRoles ?? roles;
    });
  }

  void addGamers(int numberOfGamers) {
    final GameBloc gameBloc = BlocProvider.of<GameBloc>(context);
    final List<Gamer> existingGamers = gameBloc.state.gamersState.gamers;
    final bool useSavedGamers = typeOfGamer == AppStrings.savedGamers;
    /* print('useSavedGamers is $useSavedGamers');*/

    final List<Gamer> newGamers = <Gamer>[];
    for (int i = 0; i < numberOfGamers; i++) {
      if (useSavedGamers && i < existingGamers.length) {
        /*   print('saved gamers');*/
        final Gamer gamer = existingGamers[i];
        newGamers.add(
          Gamer(
            name: gamer.name ?? AppStrings.gamer,
            gamerId: gamer.gamerId,
            imageUrl: gamer.imageUrl,
            id: i + 1,
            isNameChanged: gamer.isNameChanged ?? false,
            positionOnTable: i + 1,
            role: const Mirniy.empty(),
          ),
        );
      } else {
/*        print('new gamers');*/
        newGamers.add(
          Gamer(
            name: AppStrings.gamer,
            id: i + 1,
            positionOnTable: i + 1,
            role: const Mirniy.empty(),
          ),
        );
      }
    }

    gameBloc.add(const CleanGamers());
    for (final Gamer gamer in newGamers) {
      gameBloc.add(AddGamer(gamer: gamer));
    }
  }

  void _startButtonPressed(BuildContext context) {
    addGamers(numberOfGamers ?? 0);
    final String gameId = UniqueKey().toString();
    BlocProvider.of<GameBloc>(context).add(
      UpdateGameDetails(
        gameName: gameName ?? '',
        typeOfGame: typeOfGamer,
        typeOfController: typeOfController ?? '',
        numberOfGamers: numberOfGamers ?? 0,
        gameId: gameId,
        roles: roles ?? <Role>[],
      ),
    );
    AppNavigator.navigateToTablePage(context);
  }
}
