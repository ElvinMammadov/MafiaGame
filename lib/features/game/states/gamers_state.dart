import 'package:equatable/equatable.dart';
import 'package:mafia_game/features/game/models/gamer.dart';
import 'package:mafia_game/features/game/models/roles.dart';

class GamersState extends Equatable {
  final List<Gamer> gamers;
  final Roles roles;

  const GamersState({required this.gamers, required this.roles});

  const GamersState.empty()
      : this(
          gamers: const <Gamer>[],
          roles: const Roles.empty(),
        );

  GamersState copyWith({
    List<Gamer>? gamers,
    Roles? roles,
  }) =>
      GamersState(
        gamers: gamers ?? this.gamers,
        roles: roles ?? this.roles,
      );

  @override
  List<Object?> get props => <Object?>[
        gamers,
        roles,
      ];

  @override
  String toString() => 'GamersState'
      '{gamers: $gamers, roles: $roles}';
}
