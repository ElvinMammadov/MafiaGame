part of 'bloc.dart';

class StatisticsBloc extends Bloc<StatisticsEvent, StatisticsState> {
  final StatisticsRepository statisticsRepository;

  StatisticsBloc(this.statisticsRepository) : super(StatisticsState()) {
    on<GetSearchData>(_getSearchResult);
    on<ClearSearchResult>(_clearSearchResult);
  }

  FutureOr<void> _getSearchResult(GetSearchData event, emit) async {
    print("HERE I AM");
    try {
      final List<Gamer> gamers =
          await statisticsRepository.getGamers(event.searchQuery);
      emit(
        state.copyWith(
          pageList: gamers,
        ),
      );
    } catch (e) {
      print('Error searching gamer in Firebase: $e');
    }
  }

  FutureOr<void> _clearSearchResult(ClearSearchResult event, emit) {
    emit(
      state.copyWith(pageList: []),
    );
  }
}
