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
          final bool isDay = state.game.isDay;
          return Center(
            child: Column(
              children: <Widget>[
                Text(
                  !isDay
                      ? AppStrings.wakesUp + roles.roles[roleIndex].name
                      : AppStrings.chooseRole + roles.roles[roleIndex].name,
                  style:
                      MafiaTheme.themeData.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ).padding(bottom: 20.0),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 200.0,
                      child: BaseButton(
                        label: AppStrings.back,
                        textStyle: MafiaTheme.themeData.textTheme.headlineSmall,
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
                      width: 200.0,
                      child: BaseButton(
                        label: AppStrings.next,
                        textStyle: MafiaTheme.themeData.textTheme.headlineSmall,
                        enabled: roleIndex < roles.roles.length - 2,
                        action: () {
                          BlocProvider.of<GameBloc>(context).add(
                            ChangeRoleIndex(
                              roleIndex: roleIndex + 1,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
}
