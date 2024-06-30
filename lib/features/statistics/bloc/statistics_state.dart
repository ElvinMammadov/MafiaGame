part of 'bloc.dart';

class StatisticsState {
  final List<Gamer> pageList;
  final PageStatus pageStatus;

  StatisticsState({
    this.pageList = const [],
    this.pageStatus = const Initial(),
  });

  StatisticsState copyWith({
    List<Gamer>? pageList,
    PageStatus? pageStatus,
  }) =>
      StatisticsState(
        pageList: pageList ?? this.pageList,
        pageStatus: pageStatus ?? this.pageStatus,
      );
}
