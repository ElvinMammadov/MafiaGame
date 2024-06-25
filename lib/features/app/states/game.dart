part of app;

@JsonSerializable()
class GameState extends Equatable {
  final String gameName;
  final String typeOfGame;
  final String typeOfController;
  final int numberOfGamers;
  final String gameId;
  final List<Gamer> gamers;
  final bool isGameCouldStart;
  final bool isGameStarted;
  final bool isDiscussionStarted;
  final bool isVotingStarted;
  final int discussionTime;
  final int votingTime;
  final DateTime? gameStartTime;
  final bool isDay;
  final int dayNumber;
  final int nightNumber;
  final int mafiaCount;
  final int civilianCount;
  final bool isMafiaWin;
  final int roleIndex;

  const GameState({
    this.gameId = '',
    this.gameName = '',
    this.typeOfGame = '',
    this.typeOfController = '',
    this.numberOfGamers = 0,
    this.gamers = const <Gamer>[],
    this.isGameCouldStart = false,
    this.isGameStarted = false,
    this.isDiscussionStarted = false,
    this.isVotingStarted = false,
    this.discussionTime = 30,
    this.votingTime = 30,
    this.gameStartTime,
    this.isDay = true,
    this.dayNumber = 1,
    this.nightNumber = 1,
    this.mafiaCount = 0,
    this.civilianCount = 0,
    this.isMafiaWin = false,
    this.roleIndex = 0,
  });

  const GameState.empty()
      : gameName = '',
        typeOfGame = '',
        typeOfController = '',
        numberOfGamers = 0,
        gameId = '',
        gamers = const <Gamer>[],
        isGameCouldStart = false,
        isDiscussionStarted = false,
        isGameStarted = false,
        isVotingStarted = false,
        discussionTime = 30,
        votingTime = 30,
        gameStartTime = null,
        isDay = true,
        dayNumber = 1,
        nightNumber = 1,
        mafiaCount = 0,
        civilianCount = 0,
        isMafiaWin = false,
        roleIndex = 0;

  GameState copyWith({
    String? gameName,
    String? typeOfGame,
    String? typeOfController,
    int? numberOfGamers,
    String? gameId,
    List<Gamer>? gamers,
    bool? isGameCouldStart,
    bool? isGameStarted,
    bool? isDiscussionStarted,
    bool? isVotingStarted,
    int? discussionTime,
    int? votingTime,
    DateTime? gameStartTime,
    bool? isDay,
    int? dayNumber,
    int? nightNumber,
    int? mafiaCount,
    int? civilianCount,
    bool? isMafiaWin,
    int? roleIndex,
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
        isDiscussionStarted: isDiscussionStarted ?? this.isDiscussionStarted,
        isVotingStarted: isVotingStarted ?? this.isVotingStarted,
        discussionTime: discussionTime ?? this.discussionTime,
        votingTime: votingTime ?? this.votingTime,
        gameStartTime: gameStartTime ?? this.gameStartTime,
        isDay: isDay ?? this.isDay,
        dayNumber: dayNumber ?? this.dayNumber,
        nightNumber: nightNumber ?? this.nightNumber,
        mafiaCount: mafiaCount ?? this.mafiaCount,
        civilianCount: civilianCount ?? this.civilianCount,
        isMafiaWin: isMafiaWin ?? this.isMafiaWin,
        roleIndex: roleIndex ?? this.roleIndex,
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
        isDiscussionStarted,
        isVotingStarted,
        discussionTime,
        votingTime,
        gameStartTime,
        isDay,
        dayNumber,
        nightNumber,
        mafiaCount,
        civilianCount,
        roleIndex,
      ];

  @override
  String toString() => 'GameState'
      '{gameName: $gameName, typeOfGame: $typeOfGame,'
      ' typeOfController: $typeOfController, numberOfGamers: $numberOfGamers,'
      ' gamerId: $gameId, gamers: $gamers, isGameStarted: $isGameCouldStart'
      ' isGameStarted: $isGameStarted,'
      ' isDiscussionStarted: $isDiscussionStarted, '
      'isVotingStarted: $isVotingStarted, discussionTime: $discussionTime,'
      ' votingTime: $votingTime, gameStartTime: $gameStartTime, '
      'isDay: $isDay, dayNumber: $dayNumber, nightNumber: $nightNumber, '
      'mafiaCount: $mafiaCount, civilianCount: $civilianCount}, '
      'isMafiaWin: $isMafiaWin}';
}
