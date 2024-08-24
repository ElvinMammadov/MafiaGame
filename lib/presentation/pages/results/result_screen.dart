part of result;

class ResultScreen extends StatefulWidget {
  final List<Gamer> gamers;
  final bool isMafiaWinner;
  final String gameName;
  final String gameStartTime;
  final String gameId;
  final bool victoryByWerewolf;
  final bool werewolfWasDead;

  const ResultScreen({
    super.key,
    required this.gamers,
    required this.isMafiaWinner,
    required this.gameName,
    required this.gameStartTime,
    required this.gameId,
    this.victoryByWerewolf = false,
    this.werewolfWasDead = false,
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
    final Gamer? wereWolf = widget.gamers
        .where((Gamer gamer) => gamer.role.roleType == RoleType.Werewolf)
        .firstOrNull;
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
    if (widget.victoryByWerewolf && wereWolf != null) {
      mafia.add(wereWolf);
      citizens.remove(wereWolf);
    } else if (!widget.isMafiaWinner &&
        !widget.werewolfWasDead &&
        wereWolf != null) {
      mafia.add(wereWolf);
      citizens.remove(wereWolf);
    }
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
                    AccordionBody(
                      title: AppStrings.mafia,
                      gamers: mafia,
                      gameId: widget.gameId,
                    ).padding(
                      top: 8,
                    ),
                    AccordionBody(
                      title: AppStrings.citizens,
                      gamers: citizens,
                      gameId: widget.gameId,
                    ),
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

class AccordionBody extends StatefulWidget {
  final String title;
  final List<Gamer> gamers;
  final String gameId;

  const AccordionBody({
    super.key,
    required this.title,
    required this.gamers,
    required this.gameId,
  });

  @override
  State<AccordionBody> createState() => _AccordionBodyState();
}

class _AccordionBodyState extends State<AccordionBody> {
  final Map<String, Map<String, TextEditingController>> _controllers =
      <String, Map<String, TextEditingController>>{};

  @override
  void initState() {
    super.initState();
    for (final Gamer gamer in widget.gamers) {
      _controllers[gamer.name!] = <String, TextEditingController>{};
      gamer.role.points?.forEach((String key, int value) {
        _controllers[gamer.name!]![key] =
            TextEditingController(text: value.toString());
      });
    }
  }

  @override
  void dispose() {
    _controllers
        .forEach((_, Map<String, TextEditingController> gamerControllers) {
      gamerControllers.forEach((_, TextEditingController controller) {
        controller.dispose();
      });
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          Center(
            child: Text(
              widget.title,
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
            children: widget.gamers
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
                    content: Column(
                      children: <Widget>[
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: gamer.role.points?.length,
                          itemBuilder: (BuildContext context, int index) {
                            final String? key =
                                gamer.role.points?.keys.elementAt(index);
                            final TextEditingController controller =
                                _controllers[gamer.name!]![key]!;
                            return ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              title: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        key!,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 70,
                                        height: 40,
                                        child: TextField(
                                          controller: controller,
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                          ),
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          onChanged: (String value) {
                                            final int points =
                                                int.tryParse(value) ?? 0;
                                            gamer.role.points![key] = points;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                    color: Colors.grey,
                                  ).padding(
                                    vertical: 4,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          width: 250,
                          child: BaseButton(
                            label: AppStrings.save,
                            backgroundColor: Colors.transparent,
                            textStyle:
                                MafiaTheme.themeData.textTheme.headlineSmall,
                            action: () {
                              final Map<String, int> points = <String, int>{};
                              _controllers[gamer.name!]!.forEach((
                                String key,
                                TextEditingController controller,
                              ) {
                                final int value =
                                    int.tryParse(controller.text) ?? 0;
                                points[key] = value;
                              });
                              final int totalPoints = points.entries
                                  .where(
                                    (MapEntry<String, int> entry) =>
                                        entry.key != AppStrings.totalPoints,
                                  )
                                  .fold<int>(
                                    0,
                                    (int sum, MapEntry<String, int> entry) =>
                                        sum + entry.value,
                                  );

                              points[AppStrings.totalPoints] = totalPoints;
                              print('points: $points');

                              // Optionally, call setState to rebuild the widget
                              setState(() {
                                // Update controller values
                                _controllers[gamer.name!]!.forEach((
                                  String key,
                                  TextEditingController controller,
                                ) {
                                  controller.text = points[key].toString();
                                });
                              });
                              BlocProvider.of<GameBloc>(context).add(
                                UpdateGamerPoints(
                                  gameId: widget.gameId,
                                  gamerId: gamer.gamerId ?? '',
                                  points: points,
                                ),
                              );
                            },
                          ).padding(
                            top: 8,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      );
}
