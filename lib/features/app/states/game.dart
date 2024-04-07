part of app;

@JsonSerializable()
class GameState extends Equatable {
  final String gameName;
  final String typeOfGame;
  final String typeOfController;
  final int numberOfGamers;
  final int gameId;
  final List<Gamer>? gamers;
  final bool? isGameCouldStart;
  final bool isGameStarted;

  const GameState({
    required this.gameName,
    required this.typeOfGame,
    required this.typeOfController,
    required this.numberOfGamers,
    required this.gameId,
    this.gamers,
    this.isGameCouldStart,
    this.isGameStarted = false,
  });

  const GameState.empty()
      : gameName = '',
        typeOfGame = '',
        typeOfController = '',
        numberOfGamers = 0,
        gameId = 0,
        gamers = const <Gamer>[],
        isGameCouldStart = false,
        isGameStarted = false;

  GameState copyWith({
    String? gameName,
    String? typeOfGame,
    String? typeOfController,
    int? numberOfGamers,
    int? gameId,
    List<Gamer>? gamers,
    bool? isGameCouldStart,
    bool? isGameStarted,
  }) =>
      GameState(
        gameName: gameName ?? this.gameName,
        typeOfGame: typeOfGame ?? this.typeOfGame,
        typeOfController: typeOfController ?? this.typeOfController,
        numberOfGamers: numberOfGamers ?? this.numberOfGamers,
        gameId: gameId ?? this.gameId,
        gamers: gamers ?? this.gamers,
        isGameCouldStart: isGameCouldStart ?? this.isGameCouldStart,
        isGameStarted: isGameStarted ?? this.isGameStarted,
      );

  factory GameState.fromJson(Map<String, dynamic> json) =>
      _$GameStateFromJson(json);

  Map<String, dynamic> toJson() => _$GameStateToJson(this);

  @override
  List<Object?> get props => <Object?>[
        gameName,
        typeOfGame,
        typeOfController,
        numberOfGamers,
        gameId,
        gamers,
        isGameCouldStart,
        isGameStarted,
      ];

  @override
  String toString() => 'GameState'
      '{gameName: $gameName, typeOfGame: $typeOfGame,'
      ' typeOfController: $typeOfController, numberOfGamers: $numberOfGamers,'
      ' gamerId: $gameId}, gamers: $gamers}, isGameStarted: $isGameCouldStart}'
      ' isGameStarted: $isGameStarted}';
}
