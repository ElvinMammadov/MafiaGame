part of 'bloc.dart';

class StatisticsState {
  final List<Gamer> pageList;
  final List<Gamer> searchList;

  StatisticsState({
    this.pageList = const [],
    this.searchList = const [],
  });

  StatisticsState copyWith({
    List<Gamer>? pageList,
    List<Gamer>? searchList,
  }) =>
      StatisticsState(
        pageList: pageList ?? this.pageList,
        searchList: searchList ?? this.searchList,
      );
}
