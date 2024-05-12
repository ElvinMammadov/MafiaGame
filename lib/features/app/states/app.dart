part of app;

@JsonSerializable()
class AppState extends Equatable {
  final UserState user;
  final GameState game;
  final GamersState gamersState;
  final List<GameState> games;

  const AppState({
    UserState? user,
    GameState? game,
    GamersState? gamers,
    List<GameState>? games,
  })  : user = user ?? const UserState.empty(),
        game = game ?? const GameState.empty(),
        gamersState = gamers ?? const GamersState.empty(),
        games = games ?? const <GameState>[];

  const AppState.empty() : this();

  AppState copyWith({
    UserState? user,
    GameState? game,
    GamersState? gamers,
    List<GameState>? games,
  }) =>
      AppState(
        user: user ?? this.user,
        game: game ?? this.game,
        gamers: gamers ?? gamersState,
        games: games ?? this.games,
      );

  factory AppState.fromJson(Map<String, dynamic> json) =>
      _$AppStateFromJson(json);

  Map<String, dynamic> toJson() => _$AppStateToJson(this);

  @override
  List<Object?> get props => <Object?>[
        user,
        game,
        gamersState,
        games,
      ];

  @override
  String toString() => 'AppState'
      '{user: $user, game: $game, gamers: $gamersState, games: $games}';
}
