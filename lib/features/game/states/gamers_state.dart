import 'package:equatable/equatable.dart';
import 'package:mafia_game/features/game/models/gamer.dart';

class GamersState extends Equatable {
  final List<Gamer> gamers;

  const GamersState({required this.gamers});

  const GamersState.empty() : this(gamers: const <Gamer>[]);

  GamersState copyWith({
    List<Gamer>? gamers,
  }) =>
      GamersState(
        gamers: gamers ?? this.gamers,
      );

  @override
  List<Object?> get props => <Object?>[gamers];

  @override
  String toString() => 'GamersState'
      '{gamers: $gamers}';
}
