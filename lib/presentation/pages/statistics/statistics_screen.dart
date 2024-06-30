part of home;

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
                ],
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: LayoutBuilder(builder:
                      (BuildContext context, BoxConstraints constraints) {
                    if (state.pageList.isEmpty && state.pageStatus is! Initial) {
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
                  }),
                ),
              )
            ],
          ),
        ),
      );
}

class SearchBar extends StatelessWidget {
  SearchBar({
    super.key,
    required this.searchController,
    required this.context,
  });

  final TextEditingController searchController;
  final BuildContext context;
  Timer? _debounce;

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: AppStrings.search,
          hintStyle: const TextStyle(
            color: Colors.black,
          ),
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.black,
          ),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            borderSide: BorderSide(
              color: MafiaTheme.themeData.colorScheme.secondary,
              width: 0.5,
            ),
          ),
        ),
        style: const TextStyle(
          color: Colors.black,
        ),
        onChanged: (String value) => _onSearchChanged(value),
        onFieldSubmitted: (String query) => _onSearchChanged(query),
      );

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 200), () {
      if (value.length >= 2) {
        BlocProvider.of<StatisticsBloc>(context).add(
          GetSearchData(searchQuery: value),
        );
      } else if (value.isEmpty || value == "") {
        BlocProvider.of<StatisticsBloc>(context).add(
          GetSearchData(searchQuery: ""),
        );
      }
    });
  }
}
