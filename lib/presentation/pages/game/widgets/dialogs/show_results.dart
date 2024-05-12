part of game;

void showResults(
  BuildContext context,
  List<Gamer> gamers, {
  bool isMafia = false,
  String gameName = '',
  String gameStartTime = '',
}) {
  WoltModalSheet.show<void>(
    context: context,
    maxDialogWidth: 1000,
    minDialogWidth: 800,
    maxPageHeight: 800,
    pageListBuilder: (BuildContext modalSheetContext) =>
        <SliverWoltModalSheetPage>[
      WoltModalSheetPage(
        hasSabGradient: false,
        isTopBarLayerAlwaysVisible: true,
        hasTopBarLayer: true,
        topBarTitle: Text(
          AppStrings.resultsOfBattle,
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
        child: GamesResults(
          gamers: gamers,
          isMafia: isMafia,
          gameName: gameName,
          gameStartTime: gameStartTime,
        ),
        // child: ImagePickerSheet(
        // ),
      ),
    ],
    modalTypeBuilder: (BuildContext context) => WoltModalType.dialog,
  );
}
