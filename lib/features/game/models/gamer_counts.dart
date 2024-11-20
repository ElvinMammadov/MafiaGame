part of game;

@JsonSerializable()
class GamerCounts extends Equatable {
  final int winnerCount;
  final int citizenCount;
  final int losingCount;
  final int mafiaCount;
  final int othersCount;
  final int totalPlayedGames;
  final int totalPoints;
  final List<Map<String, Object>> pointsHistory;

  const GamerCounts({
    this.winnerCount = 0,
    this.citizenCount = 0,
    this.losingCount = 0,
    this.mafiaCount = 0,
    this.othersCount = 0,
    this.totalPlayedGames = 0,
    this.totalPoints = 0,
    this.pointsHistory = const <Map<String, Object>>[],
  });

  GamerCounts copyWith({
    int? winnerCount,
    int? citizenCount,
    int? losingCount,
    int? mafiaCount,
    int? othersCount,
    int? totalPlayedGames,
    int? totalPoints,
    List<Map<String, Object>>? pointsHistory,
  }) =>
      GamerCounts(
        winnerCount: winnerCount ?? this.winnerCount,
        citizenCount: citizenCount ?? this.citizenCount,
        losingCount: losingCount ?? this.losingCount,
        mafiaCount: mafiaCount ?? this.mafiaCount,
        othersCount: othersCount ?? this.othersCount,
        totalPlayedGames: totalPlayedGames ?? this.totalPlayedGames,
        totalPoints: totalPoints ?? this.totalPoints,
        pointsHistory: pointsHistory ?? this.pointsHistory,
      );

  factory GamerCounts.fromJson(Map<String, dynamic> json) =>
      _$GamerCountsFromJson(json);

  Map<String, dynamic> toJson() => _$GamerCountsToJson(this);

  @override
  List<Object?> get props => <Object?>[
        winnerCount,
        citizenCount,
        losingCount,
        mafiaCount,
        othersCount,
        totalPlayedGames,
        totalPoints,
        pointsHistory,
      ];

  @override
  String toString() => 'GamerCounts'
      '{winnerCount: $winnerCount, citizenCount: $citizenCount, losingCount: '
      '$losingCount, mafiaCount: $mafiaCount, othersCount: $othersCount, '
      'totalPlayedGames: $totalPlayedGames, totalPoints: $totalPoints,'
      ' pointsHistory: $pointsHistory}';
}
