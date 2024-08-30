part of game;

void showContinueGameDialog(
  BuildContext context, {
  required VoidCallback accepted,
}) {
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
              AppStrings.continueGame,
              style: MafiaTheme.themeData.textTheme.headlineMedium,
            ).padding(bottom: 20.0, horizontal: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  width: 200.0,
                  child: BaseButton(
                    action: () {
                      Navigator.of(context).pop();
                      accepted();
                    },
                    label: AppStrings.endGameLabel,
                    textStyle:
                    MafiaTheme.themeData.textTheme.headlineSmall,
                  ),
                ),
                SizedBox(
                  width: 200.0,
                  child: BaseButton(
                    action: () {
                      Navigator.of(context).pop();
                    },
                    label: AppStrings.continueGameLabel,
                    textStyle:
                    MafiaTheme.themeData.textTheme.headlineSmall,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
    modalTypeBuilder: (BuildContext context) => WoltModalType.dialog,
  );
}
