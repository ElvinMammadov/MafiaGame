part of home;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final bool _isLoading = false;
  String? typeOfGame;

  String? typeOfController;
  int? numberOfGamers = 0;
  String? gameName = '';

  @override
  Widget build(BuildContext context) => BlocBuilder<GameBloc, AppState>(
        builder: (BuildContext context, AppState state) {
          print('state is $state');
          return Scaffold(
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
              child: ConstrainedBox(
                constraints: const BoxConstraints(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    HomeScreenForm(
                      onChange: _onChange,
                    ),
                    SizedBox(
                      width: 200,
                      height: Dimensions.itemHeight50,
                      child: ElevatedButton(
                        onPressed:()
                             {_startButtonPressed(context);},
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              MafiaTheme.themeData.colorScheme.secondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        child: _isLoading
                            ? CircularProgressIndicator(
                                color: MafiaTheme.themeData.colorScheme.surface,
                              )
                            : Text(
                                AppStrings.start,
                                style: MafiaTheme
                                    .themeData.textTheme.headlineMedium,
                              ),
                      ).padding(top: Dimensions.padding16),
                    ),
                  ],
                ),
              ).padding(
                top: Dimensions.padding16,
                bottom: 200.0,
              ),
            ),
          );
        },
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
    print('gameName $gameName, typeOfGame $typeOfGame, typeOfController'
        ' $typeOfController, numberOfGamers $numberOfGamers');
  }

  void _startButtonPressed(BuildContext context)  {
    AppNavigator.navigateToTablePage(context);
    print('gameName $gameName, typeOfGame $typeOfGame, typeOfController'
        ' $typeOfController, numberOfGamers $numberOfGamers');
    BlocProvider.of<GameBloc>(context).add(
      UpdateGameDetails(
        gameName: gameName ?? '',
        typeOfGame: typeOfGame ?? '',
        typeOfController: typeOfController ?? '',
        numberOfGamers: numberOfGamers ?? 0,
      ),
    );
  }
}
