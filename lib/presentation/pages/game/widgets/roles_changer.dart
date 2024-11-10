part of game;

class RolesChanger extends StatefulWidget {
  const RolesChanger();

  @override
  _RolesChangerState createState() => _RolesChangerState();
}

class _RolesChangerState extends State<RolesChanger> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<GameBloc, AppState>(
        builder: (BuildContext context, AppState state) {
          final Roles roles = state.gamersState.roles;
          final int roleIndex =
              BlocProvider.of<GameBloc>(context).state.game.roleIndex;
          final GamePeriod gamePeriod = state.game.gamePeriod;
          final RoleType roleType = roles.roles[roleIndex].roleType;
          final int infectedCount = state.game.infectedCount;
          return SizedBox(
            width: 380.0,
            height: 300.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      gamePeriod == GamePeriod.Night
                          ? AppStrings.wakesUp + roles.roles[roleIndex].name
                          : AppStrings.chooseRole +
                              roles.roles[roleIndex].name,
                      style:
                          MafiaTheme.themeData.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ).padding(bottom: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 120.0,
                          child: BaseButton(
                            label: AppStrings.back,
                            textStyle:
                                MafiaTheme.themeData.textTheme.titleMedium,
                            enabled: roleIndex >= 1,
                            action: () {
                              BlocProvider.of<GameBloc>(context).add(
                                ChangeRoleIndex(
                                  roleIndex: roleIndex - 1,
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: 120.0,
                          child: BaseButton(
                            label: AppStrings.next,
                            textStyle:
                                MafiaTheme.themeData.textTheme.titleMedium,
                            enabled: roleIndex < roles.roles.length - 1,
                            action: () {
                              BlocProvider.of<GameBloc>(context).add(
                                ChangeRoleIndex(
                                  roleIndex: roleIndex + 1,
                                ),
                              );
                            },
                          ),
                        ).padding(horizontal: 16.0),
                      ],
                    ),
                  ],
                ),
                if (roleType == RoleType.Virus &&
                    gamePeriod == GamePeriod.Night)
                  Text(
                    couldInfect(infectedCount),
                    style: MafiaTheme.themeData.textTheme.titleLarge
                        ?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ).padding(top: 25.0),
              ],
            ),
          );
        },
      );
}
