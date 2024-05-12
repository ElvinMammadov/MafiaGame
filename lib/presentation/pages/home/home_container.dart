part of home;

class HomeContainer extends StatefulWidget {
  final TabController tabController;

  const HomeContainer({
    required this.tabController,
    super.key,
  });

  @override
  State<HomeContainer> createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer> {
  @override
  Widget build(BuildContext context) =>  TabBarView(
    controller: widget.tabController,
    children: const <Widget>[
      StatisticScreen(),
      MainScreen(),
      GamesScreen(),
    ],
  );
}

