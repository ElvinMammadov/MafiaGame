part of 'bloc.dart';
class StatisticsBloc extends Bloc<StatisticsEvent, StatisticsState>{
  final StatisticsRepository statisticsRepository;

  StatisticsBloc( this.statisticsRepository):super(StatisticsState.empty()){
    on<FetchInitialData>(_getSearchResult);
    // on<GetSearchResult>(_getSearchResult);
  }


  FutureOr<void> _getSearchResult(FetchInitialData event, emit) async{
    print("HERE I AM");
    final List<Gamer> gamers = await statisticsRepository.getGamers("");
    print(gamers.length);
    print(gamers[0].id);
    emit(state.copyWith(gamerList: gamers));
  }
}