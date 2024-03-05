part of game;

class GameTableScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => BlocBuilder<GameBloc, AppState>(
        builder: (BuildContext context, AppState state) {
          final int numberOfGamers = state.game.numberOfGamers;
          final List<Gamer> gamers = state.gamers.gamers;
          return Scaffold(
            appBar: const DefaultAppBar(
              title: AppStrings.title,
              showBackButton: true,
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
