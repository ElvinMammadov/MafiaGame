part of game;

class GameTableScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => BlocBuilder<GameBloc, AppState>(
        builder: (BuildContext context, AppState state) {
          print('state 2 is $state');
          final int numberOfGamers = state.game.numberOfGamers;
          final List<Gamer> gamers = state.gamers.gamers;
          return Scaffold(
            appBar: const DefaultAppBar(
              title: AppStrings.title,
              showBackButton: true,
            ),
            resizeToAvoidBottomInset: false,
            body: ColoredBox(
              color: Colors.grey,
              child: SizedBox.expand(
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: ClipOval(
                        child: Container(
                          width: 400.0,
                          height: 730.0,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/table.jpeg'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                    CircleAvatarWidget(
                      numberOfGamers: numberOfGamers,
                      gamers: gamers,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
}
