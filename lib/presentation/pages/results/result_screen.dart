part of result;

class ResultScreen extends StatefulWidget {
  final List<Gamer> gamers;
  final bool isMafiaWinner;
  final String gameName;
  final String gameStartTime;

  const ResultScreen({
    super.key,
    required this.gamers,
    required this.isMafiaWinner,
    required this.gameName,
    required this.gameStartTime,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Gamer> mafia = widget.gamers
        .where(
          (Gamer gamer) =>
              gamer.role.roleType == RoleType.Mafia ||
              gamer.role.roleType == RoleType.Don,
        )
        .toList();
    final List<Gamer> citizens = widget.gamers
        .where(
          (Gamer gamer) =>
              gamer.role.roleType != RoleType.Mafia &&
              gamer.role.roleType != RoleType.Don,
        )
        .toList();
    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) =>
          BlocBuilder<GameBloc, AppState>(
        builder: (BuildContext context, AppState state) => DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/faces.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Scaffold(
            appBar: const DefaultAppBar(
              title: AppStrings.results,
              showBackButton: true,
            ),
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                color:
                    MafiaTheme.themeData.colorScheme.secondary.withOpacity(0.2),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '${AppStrings.nameOfGame}: ${widget.gameName}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${AppStrings.date}: ${widget.gameStartTime}',
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
                      contentText: widget.isMafiaWinner
                          ? AppStrings.mafiaWonExplanation
                          : AppStrings.citizensWonExplanation,
                      winners: widget.isMafiaWinner
                          ? AppStrings.mafiaWon
                          : AppStrings.citizensWon,
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    AccordionBody(title: AppStrings.mafia, gamers: mafia)
                        .padding(
                      top: 8,
                    ),
                    AccordionBody(title: AppStrings.citizens, gamers: citizens),
                  ],
                ),
              ).padding(
                horizontal: 16,
                vertical: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AccordionBody extends StatelessWidget {
  final String title;
  final List<Gamer> gamers;

  const AccordionBody({
    super.key,
    required this.title,
    required this.gamers,
  });

  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          Center(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Accordion(
            headerBackgroundColor:
                MafiaTheme.themeData.colorScheme.secondary.withOpacity(
              0.6,
            ),
            headerPadding: const EdgeInsets.all(6),
            contentBackgroundColor:
                MafiaTheme.themeData.colorScheme.secondary.withOpacity(0.8),
            rightIcon: const Icon(
              Icons.arrow_drop_down_outlined,
              color: Colors.white,
              size: 32,
            ),
            children: gamers
                .map(
                  (Gamer gamer) => AccordionSection(
                    header: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          ' ${gamer.name!}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ).padding(horizontal: 8),
                        Text(
                          gamer.role.name,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${gamer.role.points?[AppStrings.totalPoints]}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ).padding(horizontal: 16),
                      ],
                    ),
                    content: SizedBox(
                      height: 400,
                      child: ListView.builder(
                        itemCount: gamer.role.points?.length,
                        itemBuilder: (BuildContext context, int index) {
                          final String? key =
                              gamer.role.points?.keys.elementAt(index);
                          final String? value = gamer.role.points?.values
                              .elementAt(index)
                              .toString();
                          return ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  key!,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  value!,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      );
}
