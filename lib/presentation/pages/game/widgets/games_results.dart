part of game;

class GamesResults extends StatelessWidget {
  final List<Gamer> gamers;
  final bool isMafia;
  final String gameName;
  final String gameStartTime;

  const GamesResults({
    super.key,
    required this.gamers,
    required this.isMafia,
    required this.gameName,
    required this.gameStartTime,
  });

  @override
  Widget build(BuildContext context) => BlocBuilder<GameBloc, AppState>(
      builder: (BuildContext context, AppState state) => Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '${AppStrings.nameOfGame}: $gameName',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${AppStrings.date}: $gameStartTime',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ).padding(
            vertical: 8,
            horizontal: 16,
          ),
          const Divider(
            color: Colors.grey,
          ),
          ResultsBody(
            contentText: isMafia
                ? AppStrings.mafiaWonExplanation
                : AppStrings.citizensWonExplanation,
            winners: isMafia ? AppStrings.mafiaWon : AppStrings.citizensWon,
          ),
        ],
      ),
    );
}

class ResultsBody extends StatelessWidget {
  final String winners;
  final String? contentText;

  const ResultsBody({
    required this.winners,
    this.contentText,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = MafiaTheme.themeData;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      color: Colors.transparent,
      child: Column(
        children: <Widget>[
          Text(
            winners,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ).padding(
            horizontal: 48,
          ),
          Divider(
            height: 16.0,
            thickness: 1.0,
            color: theme.colorScheme.primary, // Subtle divider
          ),
          if (contentText != null)
            Text(
              contentText!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ).padding(
        vertical: 16,
        horizontal: 16,
      ),
    ).padding(
      vertical: 16,
      horizontal: 8,
    );
  }
}
