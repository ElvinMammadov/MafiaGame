part of app;

class GameState extends Equatable {
  final String gameName;
  final String typeOfGame;
  final String typeOfController;
  final int numberOfGamers;
  final int gamerId;
  final List<Gamer>? gamers;
  final bool isGameCouldStart;

  const GameState({
    required this.gameName,
    required this.typeOfGame,
    required this.typeOfController,
    required this.numberOfGamers,
    required this.gamerId,
    this.gamers,
    this.isGameCouldStart = false,
  });

  const GameState.empty()
      : gameName = '',
        typeOfGame = '',
        typeOfController = '',
        numberOfGamers = 0,
        gamerId = 0,
        gamers = const <Gamer>[],
        isGameCouldStart = false;

  GameState copyWith({
    String? gameName,
    String? typeOfGame,
    String? typeOfController,
    int? numberOfGamers,
    int? gamerId,
    List<Gamer>? gamers,
    bool? isGameStarted,
  }) =>
      GameState(
        gameName: gameName ?? this.gameName,
        typeOfGame: typeOfGame ?? this.typeOfGame,
        typeOfController: typeOfController ?? this.typeOfController,
        numberOfGamers: numberOfGamers ?? this.numberOfGamers,
        gamerId: gamerId ?? this.gamerId,
        gamers: gamers ?? this.gamers,
        isGameCouldStart: isGameStarted ?? this.isGameCouldStart,
      );

  @override
  List<Object?> get props => <Object?>[
        gameName,
        typeOfGame,
        typeOfController,
        numberOfGamers,
        gamerId,
        gamers,
        isGameCouldStart,
      ];

  @override
  String toString() => 'GameState'
      '{gameName: $gameName, typeOfGame: $typeOfGame,'
      ' typeOfController: $typeOfController, numberOfGamers: $numberOfGamers,'
      ' gamerId: $gamerId}, gamers: $gamers}, isGameStarted: $isGameCouldStart}';
}
