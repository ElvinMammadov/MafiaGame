part of app;

class AppState extends Equatable {
  final UserState user;
  final GameState game;
  final GamersState gamers;

  const AppState({
    UserState? user,
    GameState? game,
    GamersState? gamers,
  })
      : user = user ?? const UserState.empty(),
        game = game ?? const GameState.empty(),
        gamers = gamers ?? const GamersState.empty();

    const AppState.empty() : this();

  AppState copyWith({
    UserState? user,
    GameState? game,
    GamersState? gamers,
  }) => AppState(
        user: user ?? this.user,
        game: game ?? this.game,
        gamers: gamers?? this.gamers,
      );

  @override
  List<Object?> get props =>
      <Object?>[
        user,
        game,
        gamers,
      ];

  @override
  String toString() => 'AppState'
      '{user: $user, game: $game, gamers: $gamers}';
}
