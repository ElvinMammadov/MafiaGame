part of app;

class AppState extends Equatable {
  final UserState user;
  final GameState game;

  const AppState({
    UserState? user,
    GameState? game,
  })
      : user = user ?? const UserState.empty(),
        game = game ?? const GameState.empty();

  const AppState.empty() : this();

  AppState copyWith({
    UserState? user,
    GameState? game,
  }) =>
      AppState(
        user: user ?? this.user,
        game: game ?? this.game,
      );

  @override
  List<Object?> get props =>
      <Object?>[
        user,
        game,
      ];
}
