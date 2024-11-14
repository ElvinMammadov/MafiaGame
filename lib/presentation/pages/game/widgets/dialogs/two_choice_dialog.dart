part of game;

void showTwoChoiceDialog(
  BuildContext context, {
  required VoidCallback accepted,
  String description = AppStrings.continueGame,
  String endButtonLabel = AppStrings.endGameLabel,
  bool isFoulDialog = false,
  String gamerName = '',
}) {
  WoltModalSheet.show<void>(
    context: context,
    maxDialogWidth: 540,
    minDialogWidth: 540,
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
            if(isFoulDialog)
              Text(
                '${AppStrings.gamer}: $gamerName',
                style: MafiaTheme.themeData.textTheme.headlineMedium,
              ).padding(
                bottom: 20.0,
                horizontal: 20.0,
              ),
            Text(
              description,
              style: MafiaTheme.themeData.textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ).padding(
              bottom: 20.0,
              horizontal: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  width: 220.0,
                  child: FinishButton(
                    endButtonLabel: endButtonLabel,
                    accepted: () {
                      Navigator.of(context).pop();
                      accepted();
                    },
                    isFoulDialog: isFoulDialog,
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
                    label: AppStrings.closeButton,
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
  final String endButtonLabel;
  final bool isFoulDialog;

  const FinishButton({
    super.key,
    required this.accepted,
    required this.endButtonLabel,
    this.isFoulDialog = false,
  });

  @override
  _FinishButtonState createState() => _FinishButtonState();
}

class _FinishButtonState extends State<FinishButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) => BaseButton(
        isLoading: isLoading,
        enabled: !isLoading,
        action: () {
          if (widget.isFoulDialog) {
            widget.accepted();
            setState(() {
              isLoading = true;
            });
            return;
          }
          final List<Gamer> gamers =
              BlocProvider.of<GameBloc>(context).state.gamersState.gamers;
          final GameState game = BlocProvider.of<GameBloc>(context).state.game;
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
        label: widget.endButtonLabel,
        textStyle: MafiaTheme.themeData.textTheme.headlineSmall,
      );
}
