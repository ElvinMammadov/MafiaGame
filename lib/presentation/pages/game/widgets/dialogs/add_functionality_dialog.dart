part of game;

void showAddFunctionality(
  BuildContext context, {
  required bool isVotingStarted,
  required int gamerId,
  required int roleId,
  required int nightNumber,
}) {
  final List<Role> chosenRoles = <Role>[];

  final Roles roles =
      BlocProvider.of<GameBloc>(context).state.gamersState.roles;

  for (int i = 0; i < roles.roles.length; i++) {
    if (i != 0 && i != 1 && i != 10) chosenRoles.add(roles.roles[i]);
  }

  WoltModalSheet.show<void>(
    context: context,
    pageListBuilder: (BuildContext modalSheetContext) =>
        <SliverWoltModalSheetPage>[
      WoltModalSheetPage(
        hasSabGradient: false,
        isTopBarLayerAlwaysVisible: true,
        hasTopBarLayer: false,
        trailingNavBarWidget: Padding(
          padding: const EdgeInsets.only(
            right: 16,
          ),
          child: IconButton(
            onPressed: Navigator.of(context).pop,
            icon: const Icon(
              Icons.close,
              size: 32,
              color: Colors.white,
            ),
          ),
        ),
        child: Column(
          children: <Widget>[
            Text(
              AppStrings.chooseRoleForChameleon,
              style: MafiaTheme.themeData.textTheme.headlineMedium,
            ).padding(bottom: 20.0, horizontal: 20.0),
            SizedBox(
              height: 600.0,
              child: ListView.builder(
                itemCount: chosenRoles.length,
                itemBuilder: (BuildContext context, int index) {
                  final Role role = chosenRoles[index];
                  return BaseButton(
                    label: role.name,
                    textStyle: MafiaTheme.themeData.textTheme.headlineSmall,
                    backgroundColor: MafiaTheme.themeData.colorScheme.secondary
                        .withOpacity(0.5),
                    action: () {
                      print('roleId: ${role.roleId}');
                      BlocProvider.of<GameBloc>(context).add(
                        ChameleonChangeRole(
                          chameleonId: role.roleId,
                        ),
                      );
                      Navigator.of(context).pop();
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    ],
    modalTypeBuilder: (BuildContext context) => WoltModalType.dialog,
  );
}
