part of 'bloc.dart';


abstract class StatisticsEvent extends Equatable {
  const StatisticsEvent();
}
class FetchInitialData extends StatisticsEvent{

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}

class GetSearchResult extends StatisticsEvent{
  final String searchQuery;

  GetSearchResult({required this.searchQuery});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}