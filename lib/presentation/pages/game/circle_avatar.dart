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

  void addGamers(Roles roles, int numberOfGamers) {
    for (int i = 0; i < numberOfGamers; i++) {
      BlocProvider.of<GameBloc>(context).add(
        AddGamer(
          gamer: Gamer(
            name: AppStrings.gamer,
            id: i + 1,
            positionOnTable: i + 1,
            role: const Mirniy.empty(),
          ),
        ),
      );
    }
  }

  void changeRole(Gamer gamer) {
    final Roles gamerRoles =
        BlocProvider.of<GameBloc>(context).state.gamersState.roles;
    final int roleIndex =
        BlocProvider.of<GameBloc>(context).state.game.roleIndex;
    print('roleIndex: $roleIndex , length: ${gamerRoles.roles.length}');
    print('rolename: ${gamerRoles.roles[roleIndex].name}, '
        'roleid: ${gamerRoles.roles[roleIndex].roleId}');
    BlocProvider.of<GameBloc>(context).add(
      AddRoleToGamer(
        targetedGamer: Gamer(
          gamerId: gamer.gamerId,
          role: Role(
            roleId: gamerRoles.roles[roleIndex].roleId,
            name: gamerRoles.roles[roleIndex].name,
            points: gamerRoles.roles[roleIndex].points,
          ),
          isRoleGiven: true,
        ),
      ),
    );
    if (gamerRoles.roles[roleIndex].roleId != 2) {
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
            final bool isGameCouldStart = state.game.isGameCouldStart;
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
                      isGameCouldStart: isGameCouldStart,
                      changeRole: changeRole,
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
