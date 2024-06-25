part of home;

class StatisticScreen extends StatefulWidget {
  const StatisticScreen({super.key});

  @override
  State<StatisticScreen> createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<StatisticsBloc>(
      create: (context) =>
          StatisticsBloc(StatisticsRepositoryImpl())..add(FetchInitialData()),
      child: BlocBuilder<StatisticsBloc, StatisticsState>(
        builder: (context, state) {
          return Column(
            children: [
              Container(
                margin: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.amber,
                ),
                child: SearchBar(
                  searchController: _searchController,
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: state.gamerList.length,
                        itemBuilder: (context, index) {
                          final gamer = state.gamerList[index];
                          return StatisticsItem(
                            customImageWidth: 96,
                            gamer: gamer,
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  SearchBar({
    super.key,
    required TextEditingController searchController,
  }) : _searchController = searchController;

  final TextEditingController _searchController;
  // final StatisticsBloc? statisticsBloc;
  Timer? _debounce;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: 'Поиск',
        hintStyle: TextStyle(
          color: Colors.black,
        ),
        prefixIcon: Icon(
          Icons.search,
          color: Colors.black,
        ),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      style: const TextStyle(
        color: Colors.black,
      ),
      onChanged: (value) => _onSearchChanged(value),
      onFieldSubmitted: (query) => _onSearchChanged(query),
    );
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 200), () {
      if (value.length >= 2) {
/*         searchBloc.add(
            // SearchQueryChanged(query: value),
            ); */
      } else if (value.isEmpty || value == "") {
/*         searchBloc.add(
            // ClearSearchResults(),
            ); */
      }
    });
  }
}
