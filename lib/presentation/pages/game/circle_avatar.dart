part of game;

class CircleAvatarWidget extends StatefulWidget {
  final bool showRoles;

  const CircleAvatarWidget({
    required this.showRoles,
  });

  @override
  _CircleAvatarWidgetState createState() => _CircleAvatarWidgetState();
}

class _CircleAvatarWidgetState extends State<CircleAvatarWidget> {
  late List<Widget> positionedAvatars = <Widget>[];
  bool allNamesChanged = false;

  void addGamers(Roles roles, int numberOfGamers) {
    for (int i = 0; i < numberOfGamers; i++) {
      BlocProvider.of<GameBloc>(context).add(
        AddGamer(
          gamer: Gamer(
            name: AppStrings.gamer,
            id: i + 1,
            positionOnTable: i + 1,
            role: roles.roles[10],
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    addGamers(
      BlocProvider.of<GameBloc>(context).state.gamersState.roles,
      BlocProvider.of<GameBloc>(context).state.game.numberOfGamers,
    );
  }

  void isAllGamersNameChanged(List<Gamer> gamers) {
    if (gamers.isNotEmpty) {
      allNamesChanged = gamers.every(
        (Gamer gamer) => gamer.isNameChanged == true,
      );
      if (allNamesChanged) {
        BlocProvider.of<GameBloc>(context).add(
          const ChangeGameStartValue(
            isGameCouldStart: true,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) => OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) =>
            BlocBuilder<GameBloc, AppState>(
          builder: (BuildContext context, AppState state) {
            final Roles roles = state.gamersState.roles;
            final List<Gamer> gamers = state.gamersState.gamers;
            final int numberOfGamers = state.game.numberOfGamers;
            final bool isGameStarted = state.game.isGameStarted;
            final bool isVotingStarted = state.game.isVotingStarted;
            logger.log('gamers are $gamers');
            isAllGamersNameChanged(gamers);
            if (gamers.isNotEmpty) {
              return SizedBox.expand(
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) =>
                      Stack(
                    children: gamersAvatars(
                      constraints: constraints,
                      roles: roles,
                      showRoles: widget.showRoles,
                      isGameStarted: isGameStarted,
                      numberOfGamers: numberOfGamers,
                      gamers: gamers,
                      context: context,
                      isVotingStarted: isVotingStarted,
                      orientation: orientation,
                    ),
                  ),
                ),
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      );
}
