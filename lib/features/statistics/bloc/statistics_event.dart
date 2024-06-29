part of 'bloc.dart';

abstract class StatisticsEvent extends Equatable {
  const StatisticsEvent();
}

class GetSearchData extends StatisticsEvent {
  final String searchQuery;
  GetSearchData({required this.searchQuery});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class ClearSearchResult extends StatisticsEvent {
  @override
  List<Object?> get props => [];
}
