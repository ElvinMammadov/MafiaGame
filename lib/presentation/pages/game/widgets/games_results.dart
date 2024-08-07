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

  List<PageViewModel> getPageViewModels(
    List<Gamer> gamers,
  ) {
    final List<PageViewModel> viewModels = <PageViewModel>[];
    final List<Gamer> mafia = gamers
        .where(
          (Gamer gamer) => gamer.role?.roleId == 2 || gamer.role?.roleId == 3,
        )
        .toList();
    final List<Gamer> citizens = gamers
        .where(
          (Gamer gamer) => gamer.role?.roleId != 2 && gamer.role?.roleId != 3,
        )
        .toList();
    viewModels.add(
      PageViewModel(
        titleWidget: Column(
          children: <Widget>[
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              color:
                  MafiaTheme.themeData.colorScheme.secondary.withOpacity(0.8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    '${AppStrings.nameOfGame}: $gameName',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${AppStrings.date}: $gameStartTime',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ).padding(
                vertical: 8,
              ),
            ).padding(
              vertical: 16,
              horizontal: 32,
            ),
            SizedBox(
              height: 200,
              width: 700,
              child: ListView.builder(
                itemCount: isMafia ? mafia.length : citizens.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final Gamer gamer = isMafia ? mafia[index] : citizens[index];
                  return Wrap(
                    // Set the spacing between items (optional)
                    spacing: 16.0,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: <Widget>[
                      GamerListItem(gamer: gamer).padding(
                        horizontal: 16,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
        // title: "Winners",
        bodyWidget: ResultsBody(
          contentText: isMafia
              ? AppStrings.mafiaWonExplanation
              : AppStrings.citizensWonExplanation,
          winners: isMafia ? AppStrings.mafiaWon : AppStrings.citizensWon,
        ),
        decoration: const PageDecoration(
          safeArea: 20,
          bodyPadding: EdgeInsets.only(top: 16),
          titlePadding: EdgeInsets.only(top: 16),
        ),
      ),
    );
    viewModels.add(
      PageViewModel(
        titleWidget: Column(
          children: <Widget>[
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              color:
              MafiaTheme.themeData.colorScheme.secondary.withOpacity(0.8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    '${AppStrings.nameOfGame}: $gameName',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${AppStrings.date}: $gameStartTime',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ).padding(
                vertical: 8,
              ),
            ).padding(
              vertical: 16,
              horizontal: 32,
            ),
            SizedBox(
              height: 200,
              width: 700,
              child: ListView.builder(
                itemCount: mafia.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final Gamer gamer = mafia[index];
                  return Wrap(
                    spacing: 16.0,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: <Widget>[
                      GamerListItem(gamer: gamer).padding(
                        horizontal: 16,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
        // title: "Winners",
        bodyWidget: const ResultsBody(
          winners: AppStrings.mafia,
        ),
        decoration: const PageDecoration(
          safeArea: 20,
          bodyPadding: EdgeInsets.only(top: 16),
          titlePadding: EdgeInsets.only(top: 16),
        ),
      ),
    );
    viewModels.add(
      PageViewModel(
        titleWidget: Column(
          children: <Widget>[
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              color:
              MafiaTheme.themeData.colorScheme.secondary.withOpacity(0.8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    '${AppStrings.nameOfGame}: $gameName',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${AppStrings.date}: $gameStartTime',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ).padding(
                vertical: 8,
              ),
            ).padding(
              vertical: 16,
              horizontal: 32,
            ),
            SizedBox(
              height: 200,
              width: 700,
              child: ListView.builder(
                itemCount: citizens.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final Gamer gamer = citizens[index];
                  return Wrap(
                    // Set the spacing between items (optional)
                    spacing: 16.0,
                    children: <Widget>[
                      GamerListItem(gamer: gamer).padding(
                        horizontal: 16,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
        bodyWidget: const ResultsBody(
          winners: AppStrings.civilians,
        ),
        decoration: const PageDecoration(
          safeArea: 20,
          bodyPadding: EdgeInsets.only(top: 16),
          titlePadding: EdgeInsets.only(top: 16),
        ),
      ),
    );

    return viewModels;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = MafiaTheme.themeData;

    GlobalKey<IntroductionScreenState>();
    return BlocBuilder<GameBloc, AppState>(
      builder: (BuildContext context, AppState state) => SizedBox(
        height: 700,
        child: IntroductionScreen(
          globalBackgroundColor: Colors.transparent,
          pages: getPageViewModels(
            gamers,
          ),
          showDoneButton: false,
          showNextButton: false,
          allowImplicitScrolling: true,
          dotsDecorator: DotsDecorator(
            size: const Size(10.0, 10.0),
            color: theme.colorScheme.secondary.withOpacity(0.8),
            activeSize: const Size(22.0, 10.0),
            activeColor: theme.colorScheme.primary,
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
            ),
          ),
        ),
      ),
    );
  }
}

class GamerListItem extends StatelessWidget {
  final Gamer gamer;

  const GamerListItem({
    super.key,
    required this.gamer,
  });

  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              gamer.imageUrl!,
              fit: BoxFit.fill,
              width: 100,
              height: 100,
            ),
          ),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.transparent,
              minimumSize: const Size(60, 30),
              side: BorderSide(
                color: MafiaTheme.themeData.colorScheme.secondary,
                width: 2,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onPressed: () {},
            child: Text(
              gamer.name ?? "",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.transparent,
              minimumSize: const Size(60, 30),
              side: BorderSide(
                color: MafiaTheme.themeData.colorScheme.secondary,
                width: 2,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onPressed: () {},
            child: Text(
              gamer.role?.name ?? "",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
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
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      color: theme.colorScheme.secondary.withOpacity(0.8),
      child: Column(
        children: <Widget>[
          Text(
            winners,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 32,
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
              style: const TextStyle(
                color: Colors.black,
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
      top: 32,
      horizontal: 32,
    );
  }
}
