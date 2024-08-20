part of statistics;

class StatisticScreen extends StatefulWidget {
  const StatisticScreen({super.key});

  @override
  State<StatisticScreen> createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) => BlocProvider<StatisticsBloc>(
        create: (BuildContext context) =>
            StatisticsBloc(StatisticsRepositoryImpl())
              ..add(GetSearchData(searchQuery: "")),
        child: BlocBuilder<StatisticsBloc, StatisticsState>(
          builder: (BuildContext context, StatisticsState state) => Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.transparent,
                    ),
                    child: SearchBar(
                      searchController: _searchController,
                      context: context,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () async {
                          // Calculate start and end dates for the last 30 days
                          final DateTime endDate = DateTime.now();
                          final DateTime startDate =
                              endDate.subtract(const Duration(days: 30));

                          // Call getTop3Gamers with the start and end dates
                          BlocProvider.of<StatisticsBloc>(context).add(
                            GetGamersForDate(
                              startDate: startDate,
                              endDate: endDate,
                            ),
                          );
                        },
                        child: Container(
                          width: 100,
                          padding: const EdgeInsets.symmetric(
                            vertical: 3,
                            horizontal: 6,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: MafiaTheme.themeData.highlightColor,
                            border: Border.all(
                              width: 0.8,
                              color: Colors.white,
                            ),
                          ),
                          child: const Align(
                            child: Text(
                              AppStrings.month,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          // Calculate start and end dates for the last 90 days
                          final DateTime endDate = DateTime.now();
                          final DateTime startDate =
                          endDate.subtract(const Duration(days: 90));

                          BlocProvider.of<StatisticsBloc>(context).add(
                            GetGamersForDate(
                              startDate: startDate,
                              endDate: endDate,
                            ),
                          );
                        },
                        child: Container(
                          width: 150,
                          padding: const EdgeInsets.symmetric(
                            vertical: 3,
                            horizontal: 6,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: MafiaTheme.themeData.highlightColor,
                            border: Border.all(
                              width: 0.8,
                              color: Colors.white,
                            ),
                          ),
                          child: const Align(
                            child: Text(
                              AppStrings.threeMonths,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          // Calculate start and end dates for the last 365 days
                          final DateTime endDate = DateTime.now();
                          final DateTime startDate =
                          endDate.subtract(const Duration(days: 365));

                          BlocProvider.of<StatisticsBloc>(context).add(
                            GetGamersForDate(
                              startDate: startDate,
                              endDate: endDate,
                            ),
                          );
                        },
                        child: Container(
                          width: 100,
                          padding: const EdgeInsets.symmetric(
                            vertical: 3,
                            horizontal: 6,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: MafiaTheme.themeData.highlightColor,
                            border: Border.all(
                              width: 0.8,
                              color: Colors.white,
                            ),
                          ),
                          child: const Align(
                            child: Text(
                              AppStrings.year,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ).padding(
                    top: 8,
                    horizontal: 16,
                    bottom: 16,
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      if (state.pageList.isEmpty &&
                          state.pageStatus is! Initial) {
                        return const Center(
                          child: Text(
                            AppStrings.notFound,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        );
                      } else {
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: state.pageList.length,
                          itemBuilder: (BuildContext context, int index) {
                            final Gamer gamer = state.pageList[index];
                            return StatisticsItem(
                              customImageWidth: 96,
                              gamer: gamer,
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}

class SearchBar extends StatefulWidget {
  final TextEditingController searchController;
  final BuildContext context;

  const SearchBar({
    super.key,
    required this.searchController,
    required this.context,
  });

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  Timer? _debounce;

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: widget.searchController,
        decoration: InputDecoration(
          fillColor: Colors.transparent,
          hintText: AppStrings.search,
          hintStyle: const TextStyle(
            color: Colors.white,
          ),
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.white,
          ),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(12.0)),
            borderSide: BorderSide(
              color: MafiaTheme.themeData.colorScheme.secondary,
              width: 0.5,
            ),
          ),
        ),
        style: const TextStyle(
          color: Colors.white,
        ),
        onChanged: (String value) => _onSearchChanged(value),
        onFieldSubmitted: (String query) => _onSearchChanged(query),
      );

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 200), () {
      if (value.length >= 2) {
        BlocProvider.of<StatisticsBloc>(widget.context).add(
          GetSearchData(searchQuery: value),
        );
      } else if (value.isEmpty || value == "") {
        BlocProvider.of<StatisticsBloc>(widget.context).add(
          const GetSearchData(searchQuery: ""),
        );
      }
    });
  }
}
