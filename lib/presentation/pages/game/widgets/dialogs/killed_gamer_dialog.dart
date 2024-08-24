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
    barrierDismissible: false,
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
        trailingNavBarWidget: const Padding(
          padding: EdgeInsets.only(
            right: 16,
          ),
          child: CloseKilledGamerDialogButton(),
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

class CloseKilledGamerDialogButton extends StatefulWidget {
  const CloseKilledGamerDialogButton({
    super.key,
  });

  @override
  State<CloseKilledGamerDialogButton> createState() =>
      _CloseKilledGamerDialogButtonState();

}
class _CloseKilledGamerDialogButtonState
    extends State<CloseKilledGamerDialogButton> {
  @override
  Widget build(BuildContext context) => BlocBuilder<GameBloc, AppState>(
    builder: (BuildContext context, AppState state) {
      final GamePhase gamePhase = state.game.gamePhase;
      final List<Gamer> gamers = state.gamersState.gamers;
      final String gameName = state.game.gameName;
      final bool isMafiaWin = state.game.isMafiaWin;
      final String gameId = state.game.gameId;
      final DateTime? gameStartTime = state.game.gameStartTime;
      final bool victoryByWerewolf = state.game.victoryByWerewolf;
      final bool werewolfWasDead = state.game.werewolfWasDead;

      return IconButton(
        onPressed: () {
          if (gamePhase == GamePhase.Finished) {
            Navigator.of(context)
                .popUntil((Route<dynamic> route) => route.isFirst);
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (BuildContext context) => ResultScreen(
                  gamers: gamers,
                  isMafiaWinner: isMafiaWin,
                  gameName: gameName,
                  gameStartTime:
                  DateFormat('yyyy-MM-dd').format(gameStartTime!),
                  gameId: gameId,
                  victoryByWerewolf: victoryByWerewolf,
                  werewolfWasDead: werewolfWasDead,
                ),
              ),
            );
            BlocProvider.of<GameBloc>(context).add(
              const EmptyGame(),
            );
          }else {
            Navigator.of(context).pop();
          }
        },
        icon: const Icon(
          Icons.close,
          size: 32,
          color: Colors.white,
        ),
      );
    },
  );
}
