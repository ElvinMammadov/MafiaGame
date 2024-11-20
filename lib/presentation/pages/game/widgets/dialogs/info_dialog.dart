part of game;

void showInfoDialog(
  BuildContext context, {
  required String description,
}) {
  WoltModalSheet.show<void>(
    context: context,
    maxDialogWidth: 500,
    minDialogWidth: 500,
    pageListBuilder: (BuildContext modalSheetContext) =>
        <SliverWoltModalSheetPage>[
      WoltModalSheetPage(
        hasSabGradient: false,
        isTopBarLayerAlwaysVisible: true,
        hasTopBarLayer: true,
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
        child: Center(
          child: Text(
            description,
            style: MafiaTheme.themeData.textTheme.headlineMedium,
          ).padding(
            vertical: 40.0,
            horizontal: 20.0,
          ),
        ),
      ),
    ],
  );
}
