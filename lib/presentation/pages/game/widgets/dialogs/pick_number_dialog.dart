part of game;

void showPickNumber(
    BuildContext context,
    List<Gamer> gamers,
    ) {
  WoltModalSheet.show<void>(
    context: context,
    maxDialogWidth: 1000,
    minDialogWidth: 700,
    maxPageHeight: 600,
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
        child: NumberPicker(
          gamers: gamers,
          deletedGamer: (Gamer gamer) {
            print('deleted gamer ${gamer.name}');

            Navigator.of(context).pop();
            showKilledGamer(context, gamer);
          },
        ),
      ),
    ],
    modalTypeBuilder: (BuildContext context) => WoltModalType.dialog,
  );
}
