part of game;

void showKilledGamers(
  BuildContext context,
  List<Gamer> killedGamers,
  VoidCallback closeDialog, {
  bool isNightMode = true,
}) {
  WoltModalSheet.show<void>(
    context: context,
    barrierDismissible: false,
    pageListBuilder: (BuildContext modalSheetContext) =>
        <SliverWoltModalSheetPage>[
      SliverWoltModalSheetPage(
        hasSabGradient: false,
        isTopBarLayerAlwaysVisible: true,
        enableDrag: false,
        hasTopBarLayer: true,
        topBarTitle: Text(
          AppStrings.killOfGamers,
          style: MafiaTheme.themeData.textTheme.headlineSmall,
        ),
        trailingNavBarWidget: Padding(
          padding: const EdgeInsets.only(
            right: 16,
          ),
          child: CloseKilledGamersAtNightDialogButton(closeDialog: closeDialog),
        ),
        mainContentSlivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final Gamer gamer = killedGamers[index];
                return KilledGamerScreen(
                  killedGamer: gamer,
                  title: isNightMode
                      ? AppStrings.duringNightTrial
                      : AppStrings.duringDayTrial,
                  isKillerExist: isNightMode,
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

class CloseKilledGamersAtNightDialogButton extends StatefulWidget {
  final VoidCallback closeDialog;

  const CloseKilledGamersAtNightDialogButton({
    required this.closeDialog,
    super.key,
  });

  @override
  State<CloseKilledGamersAtNightDialogButton> createState() =>
      _CloseKilledGamersAtNightDialogButtonState();
}

class _CloseKilledGamersAtNightDialogButtonState
    extends State<CloseKilledGamersAtNightDialogButton> {
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
              } else {
                Navigator.of(context).pop();
                widget.closeDialog();
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
