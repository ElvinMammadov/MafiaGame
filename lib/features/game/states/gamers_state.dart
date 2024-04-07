part of game;

@JsonSerializable()
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

  factory GamersState.fromMap(Map<String, dynamic> json) =>
      _$GamersStateFromJson(json);

  Map<String, dynamic> toMap() => _$GamersStateToJson(this);

  @override
  List<Object?> get props => <Object?>[
        gamers,
        roles,
      ];

  @override
  String toString() => 'GamersState'
      '{gamers: $gamers, roles: $roles}';
}
