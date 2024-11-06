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
  int currentRoleIndex = 0;

  void changeRole(Gamer gamer) {
    final Roles gamerRoles =
        BlocProvider.of<GameBloc>(context).state.gamersState.roles;
    final int roleIndex =
        BlocProvider.of<GameBloc>(context).state.game.roleIndex;
    BlocProvider.of<GameBloc>(context).add(
      AddRoleToGamer(
        targetedGamer: Gamer(
          gamerId: gamer.gamerId,
          role: Role(
            roleType: gamerRoles.roles[roleIndex].roleType,
            name: gamerRoles.roles[roleIndex].name,
            points: gamerRoles.roles[roleIndex].points,
          ),
          isRoleGiven: true,
        ),
      ),
    );
    if (gamerRoles.roles[roleIndex].roleType != RoleType.Mafia &&
        roleIndex < gamerRoles.roles.length - 1) {
      BlocProvider.of<GameBloc>(context).add(
        ChangeRoleIndex(
          roleIndex: roleIndex + 1,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  void isAllGamersNameChanged(List<Gamer> gamers) {
    if (gamers.isNotEmpty) {
      allNamesChanged = gamers.every(
        (Gamer gamer) => gamer.isNameChanged == true,
      );
      if (allNamesChanged) {
        BlocProvider.of<GameBloc>(context).add(
          const ChangeGameStartValue(),
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
            final GamePhase gamePhase = state.game.gamePhase;
            if (gamePhase == GamePhase.IsReady) {
              isAllGamersNameChanged(gamers);
            }
            if (gamers.isNotEmpty) {
              return SizedBox.expand(
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) =>
                      Stack(
                    children: gamersAvatars(
                      constraints: constraints,
                      roles: roles,
                      showRoles: widget.showRoles,
                      numberOfGamers: numberOfGamers,
                      gamers: gamers,
                      context: context,
                      orientation: orientation,
                      changeRole: changeRole,
                      gamePhase: gamePhase,
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
