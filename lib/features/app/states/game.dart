part of app;

@JsonSerializable()
class GameState extends Equatable {
  final String gameName;
  final String typeOfGame;
  final String typeOfController;
  final int numberOfGamers;
  final String gameId;
  final List<Gamer> gamers;
  final int discussionTime;
  final int votingTime;
  final DateTime? gameStartTime;
  final int dayNumber;
  final int nightNumber;
  final int mafiaCount;
  final int civilianCount;
  final bool isMafiaWin;
  final int roleIndex;
  final Gamer currentVoter;
  final List<Gamer> votedGamers;
  final int infectedCount;
  final GamePhase gamePhase;
  final GamePeriod gamePeriod;
  final bool victoryByWerewolf;
  final bool werewolfWasDead;
  final FirebaseSaveStatus saveStatus;
  final VoteDirection voteDirection;
  final String starterId;

  const GameState({
    this.gameId = '',
    this.gameName = '',
    this.typeOfGame = '',
    this.typeOfController = '',
    this.numberOfGamers = 0,
    this.gamers = const <Gamer>[],
    this.discussionTime = 30,
    this.votingTime = 30,
    this.gameStartTime,
    this.dayNumber = 1,
    this.nightNumber = 1,
    this.mafiaCount = 0,
    this.civilianCount = 0,
    this.isMafiaWin = false,
    this.roleIndex = 0,
    this.currentVoter = const Gamer.empty(),
    this.votedGamers = const <Gamer>[],
    this.infectedCount = 0,
    this.gamePhase = GamePhase.IsReady,
    this.gamePeriod = GamePeriod.Day,
    this.victoryByWerewolf = false,
    this.werewolfWasDead = false,
    this.saveStatus = FirebaseSaveStatus.Initial,
    this.voteDirection = VoteDirection.NotSet,
    this.starterId = '',
  });

  const GameState.empty()
      : gameName = '',
        typeOfGame = '',
        typeOfController = '',
        numberOfGamers = 0,
        gameId = '',
        gamers = const <Gamer>[],
        discussionTime = 30,
        votingTime = 30,
        gameStartTime = null,
        dayNumber = 1,
        nightNumber = 1,
        mafiaCount = 0,
        civilianCount = 0,
        isMafiaWin = false,
        roleIndex = 0,
        infectedCount = 0,
        currentVoter = const Gamer.empty(),
        votedGamers = const <Gamer>[],
        gamePhase = GamePhase.IsReady,
        gamePeriod = GamePeriod.Day,
        victoryByWerewolf = false,
        werewolfWasDead = false,
        saveStatus = FirebaseSaveStatus.Initial,
        voteDirection = VoteDirection.NotSet,
        starterId = '';

  GameState copyWith({
    String? gameName,
    String? typeOfGame,
    String? typeOfController,
    int? numberOfGamers,
    String? gameId,
    List<Gamer>? gamers,
    int? discussionTime,
    int? votingTime,
    DateTime? gameStartTime,
    int? dayNumber,
    int? nightNumber,
    int? mafiaCount,
    int? civilianCount,
    bool? isMafiaWin,
    int? roleIndex,
    Gamer? currentVoter,
    List<Gamer>? votedGamers,
    int? infectedCount,
    GamePhase? gamePhase,
    GamePeriod? gamePeriod,
    bool? victoryByWerewolf,
    bool? werewolfWasDead,
    FirebaseSaveStatus? saveStatus,
    VoteDirection? voteDirection,
    String? starterId,
  }) =>
      GameState(
        gameName: gameName ?? this.gameName,
        typeOfGame: typeOfGame ?? this.typeOfGame,
        typeOfController: typeOfController ?? this.typeOfController,
        numberOfGamers: numberOfGamers ?? this.numberOfGamers,
        gameId: gameId ?? this.gameId,
        gamers: gamers ?? this.gamers,
        discussionTime: discussionTime ?? this.discussionTime,
        votingTime: votingTime ?? this.votingTime,
        gameStartTime: gameStartTime ?? this.gameStartTime,
        dayNumber: dayNumber ?? this.dayNumber,
        nightNumber: nightNumber ?? this.nightNumber,
        mafiaCount: mafiaCount ?? this.mafiaCount,
        civilianCount: civilianCount ?? this.civilianCount,
        isMafiaWin: isMafiaWin ?? this.isMafiaWin,
        roleIndex: roleIndex ?? this.roleIndex,
        currentVoter: currentVoter ?? this.currentVoter,
        votedGamers: votedGamers ?? this.votedGamers,
        infectedCount: infectedCount ?? this.infectedCount,
        gamePhase: gamePhase ?? this.gamePhase,
        gamePeriod: gamePeriod ?? this.gamePeriod,
        victoryByWerewolf: victoryByWerewolf ?? this.victoryByWerewolf,
        werewolfWasDead: werewolfWasDead ?? this.werewolfWasDead,
        saveStatus: saveStatus ?? this.saveStatus,
        voteDirection: voteDirection ?? this.voteDirection,
        starterId: starterId ?? this.starterId,
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
        discussionTime,
        votingTime,
        gameStartTime,
        dayNumber,
        nightNumber,
        mafiaCount,
        civilianCount,
        roleIndex,
        currentVoter,
        votedGamers,
        infectedCount,
        gamePhase,
        gamePeriod,
        victoryByWerewolf,
        werewolfWasDead,
        saveStatus,
        voteDirection,
        starterId,
      ];

  @override
  String toString() => 'GameState'
      '{gameName: $gameName, typeOfGame: $typeOfGame,'
      ' typeOfController: $typeOfController, numberOfGamers: $numberOfGamers,'
      ' gamerId: $gameId, gamers: $gamers, discussionTime: $discussionTime,'
      ' votingTime: $votingTime, gameStartTime: $gameStartTime, '
      'dayNumber: $dayNumber, nightNumber: $nightNumber, '
      'mafiaCount: $mafiaCount, civilianCount: $civilianCount}, '
      'isMafiaWin: $isMafiaWin, roleIndex: $roleIndex,'
      ' infectedCount: $infectedCount, '
      'gamePhase: $gamePhase, gamePeriod: $gamePeriod, '
      'voteDirection: $voteDirection,}';
}

enum VoteDirection {
  NotSet,
  Left,
  Right,
}

enum GamePhase {
  Discussion,
  Voting,
  CouldStart,
  IsReady,
  Started,
  Finished,
}

enum GamePeriod {
  Day,
  Night,
}

enum FirebaseSaveStatus {
  Initial,
  Saving,
  Saved,
  Error,
}
