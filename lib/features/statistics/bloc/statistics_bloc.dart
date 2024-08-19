part of 'bloc.dart';

class StatisticsBloc extends Bloc<StatisticsEvent, StatisticsState> {
  final StatisticsRepository statisticsRepository;

  StatisticsBloc(this.statisticsRepository) : super(StatisticsState()) {
    on<GetSearchData>(_getSearchResult);
    on<GetGamersForDate>(_getGamersForDate);
  }

  FutureOr<void> _getGamersForDate(
    GetGamersForDate event,
    Emitter<StatisticsState> emit,
  ) async {
    try {
      final List<Gamer> gamers = await statisticsRepository.getTop3Gamers(
        event.startDate,
        event.endDate,
      );
      print('Top 3 gamers: $gamers');
      emit(
        state.copyWith(
          pageList: gamers,
          pageStatus: DataLoaded(),
        ),
      );
    } catch (e) {
      print('Error getting top 3 gamers in Firebase: $e');
    }
  }

  FutureOr<void> _getSearchResult(
    GetSearchData event,
    Emitter<StatisticsState> emit,
  ) async {
    try {
      final List<Gamer> gamers =
          await statisticsRepository.getGamers(event.searchQuery);
      emit(
        state.copyWith(
          pageList: gamers,
          pageStatus: DataLoaded(),
        ),
      );
    } catch (e) {
      print('Error searching gamer in Firebase: $e');
    }
  }
}
