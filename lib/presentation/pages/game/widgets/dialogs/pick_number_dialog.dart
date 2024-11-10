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
            final int mafiaCount =
                BlocProvider.of<GameBloc>(context).state.game.mafiaCount;
            closeDialog();
            final int civilianCount =
                BlocProvider.of<GameBloc>(context).state.game.civilianCount;
            final GamePhase gamePhase =
                BlocProvider.of<GameBloc>(context).state.game.gamePhase;

            Navigator.of(context).pop();
            BlocProvider.of<GameBloc>(context).add(
              VotingAction(
                showFailureInfo: () {
                  showErrorSnackBar(
                    context: context,
                    message: AppStrings.votesHaveNotAdded,
                  );
                },
                showKilledGamers: (List<Gamer> killedGamers) {
                  if (killedGamers.length == 1) {
                    showKilledGamer(
                      context,
                      killedGamers.first,
                      () {
                        if (mafiaCount == 1 && civilianCount == 2) {
                          showContinueGameDialog(
                            context,
                            accepted: () {
                              if (gamePhase == GamePhase.Finished) {
                                showResultScreen(
                                  context,
                                );
                              }
                            },
                          );
                        }
                      },
                    );
                  } else {
                    showKilledGamers(
                      context,
                      killedGamers,
                      isNightMode: false,
                      () {
                        if (mafiaCount == 1 && civilianCount == 2) {
                          showContinueGameDialog(
                            context,
                            accepted: () {
                              if (gamePhase == GamePhase.Finished) {
                                showResultScreen(
                                  context,
                                );
                              }
                            },
                          );
                        }
                      },
                    );
                  }
                },
                gamerHasAlibi: (Gamer gamer) {
                  showInfoDialog(
                    context,
                    description: gamerHasAlibi(
                      gamer.name ?? '',
                    ),
                  );
                },
                showPickedNumber: (List<Gamer> topGamers) {
                  showPickNumber(
                    context,
                    topGamers,
                    () {
                      if (mafiaCount == 1 && civilianCount == 2) {
                        showContinueGameDialog(
                          context,
                          accepted: () {
                            if (gamePhase == GamePhase.Finished) {
                              showResultScreen(
                                context,
                              );
                            }
                          },
                        );
                      }
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    ],
    modalTypeBuilder: (BuildContext context) => WoltModalType.dialog,
  );
}

void showResultScreen(BuildContext context) {
  final DateTime? gameStartTime =
      BlocProvider.of<GameBloc>(context).state.game.gameStartTime;
  Navigator.of(context).popUntil((Route<dynamic> route) => route.isFirst);
  Navigator.push(
    context,
    MaterialPageRoute<void>(
      builder: (BuildContext context) => ResultScreen(
        gamers: BlocProvider.of<GameBloc>(context).state.gamersState.gamers,
        isMafiaWinner: BlocProvider.of<GameBloc>(context).state.game.isMafiaWin,
        gameName: BlocProvider.of<GameBloc>(context).state.game.gameName,
        gameStartTime: DateFormat('yyyy-MM-dd').format(
          gameStartTime ?? DateTime.now(),
        ),
        gameId: BlocProvider.of<GameBloc>(context).state.game.gameId,
        victoryByWerewolf:
            BlocProvider.of<GameBloc>(context).state.game.victoryByWerewolf,
        werewolfWasDead:
            BlocProvider.of<GameBloc>(context).state.game.werewolfWasDead,
        saveGame: true,
      ),
    ),
  );
}
