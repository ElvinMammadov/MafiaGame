part of 'bloc.dart';

class StatisticsBloc extends Bloc<StatisticsEvent, StatisticsState> {
  final StatisticsRepository statisticsRepository;

  StatisticsBloc(this.statisticsRepository) : super(StatisticsState()) {
    on<GetSearchData>(_getSearchResult);
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
