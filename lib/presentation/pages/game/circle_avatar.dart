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
            name: '${AppStrings.gamer} ${i + 1}',
            id: i + 1,
            role: roles.roles[4].name,
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
  Widget build(BuildContext context) => BlocBuilder<GameBloc, AppState>(
        builder: (BuildContext context, AppState state) {
          final Roles roles = state.gamersState.roles;
          final List<Gamer> gamers = state.gamersState.gamers;
          final int numberOfGamers = state.game.numberOfGamers;
          final bool isGameStarted = state.game.isGameStarted;
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
                  ),
                ),
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      );
}
