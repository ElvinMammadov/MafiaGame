part of game;

void showAddFunctionality(
  BuildContext context, {
  required bool isVotingStarted,
  required int gamerId,
  required int roleId,
}) {
  final ValueNotifier<bool> isButtonEnabledNotifier =
      ValueNotifier<bool>(false);
  final TextEditingController textEditingController = TextEditingController();
  textEditingController.addListener(() {
    isButtonEnabledNotifier.value = textEditingController.text.isNotEmpty;
  });

  final List<Gamer> gamers =
      BlocProvider.of<GameBloc>(context).state.gamersState.gamers;
  final bool isDay = BlocProvider.of<GameBloc>(context).state.game.isDay;
  final List<String> items = <String>[];
  for (int i = 0; i < gamers.length; i++) {
    if (gamers[i].id != gamerId) {
      if (gamers[i].wasKilled == false) {
        items.add(gamers[i].name!);
      }
    }
  }
  String buttonTitle = '';

  void checkGamer(String gamerName) {
    for (final Gamer gamer in gamers) {
      if (gamer.name == gamerName) {
        BlocProvider.of<GameBloc>(context).add(
          AddVoteToGamer(gamer: gamer),
        );
        Navigator.of(context).pop();
        break;
      }
    }
  }

  void createFunctionality() {
    switch (roleId) {
      case 2 || 3 || 6:
        buttonTitle = AppStrings.killGamer;
        break;
      case 1:
        buttonTitle = AppStrings.healGamer;
        break;
      case 4:
        buttonTitle = AppStrings.killGamer;
        break;
      default:
        break;
    }
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
            if (isVotingStarted)
              FunctionalDropDownButton(
                items: items,
                title: AppStrings.vote,
                onChanged: (String gamerName) {
                  checkGamer(gamerName);
                },
              ),
            if (!isDay)
              FunctionalDropDownButton(
                items: items,
                title: buttonTitle,
                onChanged: (String gamerName) {},
              ),
            BaseButton(
              label: AppStrings.fol,
              textStyle: MafiaTheme.themeData.textTheme.headlineSmall,
              backgroundColor:
                  MafiaTheme.themeData.colorScheme.secondary.withOpacity(0.5),
              action: () {
                BlocProvider.of<GameBloc>(context).add(
                  AddFaultToGamer(gamerId: gamerId),
                );
                Navigator.of(context).pop();
              },
            ),
            BaseButton(
              label: AppStrings.profile,
              textStyle: MafiaTheme.themeData.textTheme.headlineSmall,
              backgroundColor:
                  MafiaTheme.themeData.colorScheme.secondary.withOpacity(0.5),
              action: () {
                Navigator.of(context).pop();
              },
            ),
            BaseButton(
              label: AppStrings.delete,
              textStyle: MafiaTheme.themeData.textTheme.headlineSmall,
              backgroundColor: MafiaTheme.themeData.colorScheme.primary,
              action: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    ],
    modalTypeBuilder: (BuildContext context) => WoltModalType.dialog,
  );
}
