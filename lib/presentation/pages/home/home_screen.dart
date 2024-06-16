part of home;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  String? typeOfGame;

  String? typeOfController;
  int? numberOfGamers = 0;
  String? gameName = '';

  static const int _initTabIndex = 1;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: HomeViewModel.tabsCount,
      vsync: this,
      initialIndex: _initTabIndex,
    );
    // _onRefresh();
    BlocProvider.of<GameBloc>(context).add(
      GetGames(dateTime: DateTime.now()),
    );
  }

  @override
  Widget build(BuildContext context) => OrientationBuilder(
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
                title: AppStrings.title,
              ),
              backgroundColor: Colors.transparent,
              bottomNavigationBar: SizedBox(
                height: 75,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  color: MafiaTheme.themeData.colorScheme.secondary
                      .withOpacity(0.8),
                  child: TabBar(
                    controller: _tabController,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: MafiaTheme.themeData.colorScheme.surface,
                    labelColor: MafiaTheme.themeData.colorScheme.secondary,
                    unselectedLabelStyle:
                        MafiaTheme.themeData.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                    // unselectedLabelColor:
                    //     Colors.white,
                    tabs: List<Widget>.from(
                      HomeViewModel.create().tabs.map(
                            (HomeTab tab) => SizedBox(
                              height: 64,
                              child: MafiaGameTabs(
                                label: tab.title,
                                icon: tab.icon,
                                imageIcon: tab.imageIcon,
                              ),
                            ),
                          ),
                    ),
                  ),
                ).padding(
                  horizontal: 84,
                ),
              ).padding(
                bottom: 16,
              ),
              body: HomeContainer(
                tabController: _tabController,
              ),
            ),
          ),
        ),
      );
}
