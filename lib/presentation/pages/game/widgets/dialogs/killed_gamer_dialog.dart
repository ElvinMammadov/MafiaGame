part of game;

void showKilledGamer(
    BuildContext context,
    Gamer killedGamer,
    ) {
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
        ), child: KilledGamerScreen(
          killedGamer: killedGamer,
          title: AppStrings.duringDayTrial,
        ),
        // child: ImagePickerSheet(
        // ),
      ),
    ],
    modalTypeBuilder: (BuildContext context) => WoltModalType.dialog,
  );
}
