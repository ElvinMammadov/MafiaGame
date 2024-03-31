part of app;

class AppState extends Equatable {
  final UserState user;
  final GameState game;
  final GamersState gamersState;

  const AppState({
    UserState? user,
    GameState? game,
    GamersState? gamers,
  })
      : user = user ?? const UserState.empty(),
        game = game ?? const GameState.empty(),
        gamersState = gamers ?? const GamersState.empty();

    const AppState.empty() : this();

  AppState copyWith({
    UserState? user,
    GameState? game,
    GamersState? gamers,
  }) => AppState(
        user: user ?? this.user,
        game: game ?? this.game,
        gamers: gamers?? gamersState,
      );

  @override
  List<Object?> get props =>
      <Object?>[
        user,
        game,
        gamersState,
      ];

  @override
  String toString() => 'AppState'
      '{user: $user, game: $game, gamers: $gamersState}';
}
