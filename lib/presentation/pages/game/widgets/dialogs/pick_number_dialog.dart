part of game;

void showPickNumber(
  BuildContext context,
  List<Gamer> gamers,
  Function() closeDialog,
) {
  WoltModalSheet.show<void>(
    context: context,
    maxDialogWidth: 1000,
    minDialogWidth: 700,
    maxPageHeight: 600,
    barrierDismissible: false,
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
            closeDialog();
            Navigator.of(context).pop();
            if (!gamer.wasSecured && !gamer.hasAlibi) {
              BlocProvider.of<GameBloc>(context).add(
                KillGamer(gamer: gamer),
              );
              showKilledGamer(context, gamer, closeDialog);
            } else if (gamer.hasAlibi) {
              showSuccessSnackBar(
                message: gamerHasAlibi(gamer.name ?? ''),
                context: context,
              );
            }

            BlocProvider.of<GameBloc>(context).add(
              const EndVoting(),
            );
            BlocProvider.of<GameBloc>(context).add(
              const AddDayNumber(),
            );
          },
        ),
      ),
    ],
    modalTypeBuilder: (BuildContext context) => WoltModalType.dialog,
  );
}
