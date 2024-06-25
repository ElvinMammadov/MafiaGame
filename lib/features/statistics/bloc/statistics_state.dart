part of 'bloc.dart';

class StatisticsState {
  final List<Gamer> gamerList;
  const StatisticsState({required this.gamerList});

  const StatisticsState.empty()
      : this(
          gamerList: const <Gamer>[],
        );
        
  StatisticsState copyWith({List<Gamer>? gamerList}) {
    return StatisticsState(
      gamerList: gamerList ?? this.gamerList,
    );
  }
}
