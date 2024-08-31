part of game;

void showContinueGameDialog(
  BuildContext context, {
  required VoidCallback accepted,
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
        child: Column(
          children: <Widget>[
            Text(
              AppStrings.continueGame,
              style: MafiaTheme.themeData.textTheme.headlineMedium,
            ).padding(
              bottom: 20.0,
              horizontal: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  width: 200.0,
                  child: FinishButton(
                    accepted: () {
                      Navigator.of(context).pop();
                      accepted();
                    },
                  ),
                ).padding(
                  horizontal: 16.0,
                ),
                SizedBox(
                  width: 200.0,
                  child: BaseButton(
                    action: () {
                      Navigator.of(context).pop();
                    },
                    label: AppStrings.continueGameLabel,
                    textStyle: MafiaTheme.themeData.textTheme.headlineSmall,
                  ),
                ).padding(
                  horizontal: 16.0,
                ),
              ],
            ).padding(vertical: 16.0),
          ],
        ).padding(
          horizontal: 16.0,
          vertical: 16.0,
        ),
      ),
    ],
    modalTypeBuilder: (BuildContext context) => WoltModalType.dialog,
  );
}

class FinishButton extends StatefulWidget {
  final VoidCallback accepted;

  const FinishButton({super.key, required this.accepted});

  @override
  _FinishButtonState createState() => _FinishButtonState();
}

class _FinishButtonState extends State<FinishButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) => BaseButton(
        isLoading: isLoading,
        action: () {
          final List<Gamer> gamers = BlocProvider.of<GameBloc>(context)
              .state
              .gamersState
              .gamers;
          final GameState game = BlocProvider.of<GameBloc>(context)
              .state
              .game;
          BlocProvider.of<GameBloc>(
            context,
          ).add(
            CalculatePoints(
              gameState: game.copyWith(
                    isMafiaWin: true,
                    gamers: gamers,
                  ),
              finished: () {
                setState(() {
                  isLoading = true;
                });
                Timer(const Duration(seconds: 2), () {
                  widget.accepted();
                });
              },
            ),
          );
        },
        label: AppStrings.endGameLabel,
        textStyle: MafiaTheme.themeData.textTheme.headlineSmall,
      );
}
