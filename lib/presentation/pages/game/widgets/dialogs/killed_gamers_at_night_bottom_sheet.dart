part of game;

void showKilledGamersAtNight(
  BuildContext context,
  List<Gamer> killedGamers,
) {
  WoltModalSheet.show<void>(
    context: context,
    pageListBuilder: (BuildContext modalSheetContext) =>
        <SliverWoltModalSheetPage>[
          SliverWoltModalSheetPage(
        hasSabGradient: false,
        isTopBarLayerAlwaysVisible: true,
        hasTopBarLayer: true,
        topBarTitle: Text(
          AppStrings.killOfGamer,
          style: MafiaTheme.themeData.textTheme.headlineSmall,
        ),
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
            mainContentSlivers: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  final Gamer gamer = killedGamers[index];
                  return KilledGamerScreen(
                    killedGamer: gamer,
                    title: AppStrings.duringNightTrial,
                    isKillerExist: true,
                  );
                },
                childCount: killedGamers.length,
              ),
            ),
          ],
      ),
    ],
    modalTypeBuilder: (BuildContext context) => WoltModalType.bottomSheet,
  );
}
