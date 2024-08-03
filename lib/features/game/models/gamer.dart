part of game;

@JsonSerializable()
class Gamer extends Equatable {
  final String? name;
  final Role? role;
  final String? imageUrl;
  final int? id;
  final String? documentId;
  final String? gamerId;
  final String gamerCreated;
  final bool? isNameChanged;
  final bool? isRoleGiven;
  final int foulCount;
  final int votesCount;
  final bool wasKilled;
  final DateTime? gamerCreatedDate;
  final int positionOnTable;
  final int? selectedNumber;
  final bool wasHealed;
  final bool hasAlibi;
  final bool wasKilledByKiller;
  final bool wasKilledByMafia;
  final bool wasKilledBySheriff;
  final bool wasKilledByWerewolf;
  final bool wasCheckedByMadam;
  final bool wasCheckedBySheriff;
  final bool wasCheckedByMedium;
  final bool wasBoomeranged;
  final bool wasSecured;
  final int? targetId;
  final bool canTarget;
  final bool killSecurity;
  final Map<String, int> roleCounts;
  final bool isAnimated;
  final bool playsAsCitizen;
  final bool beforeChange;
  final int healCount;
  final bool wasVoted;
  final bool wasInfected;
  final int chameleonId;
  final bool werewolfChanged;
  final GamerCounts gamerCounts;

  const Gamer({
    this.name = '',
    this.role = const Role.empty(),
    this.imageUrl = '',
    this.id = 0,
    this.documentId = '',
    this.gamerId = '',
    this.gamerCreated = '',
    this.isNameChanged = false,
    this.isRoleGiven = false,
    this.foulCount = 0,
    this.votesCount = 0,
    this.wasKilled = false,
    this.gamerCreatedDate,
    this.positionOnTable = 0,
    this.selectedNumber,
    this.wasHealed = false,
    this.hasAlibi = false,
    this.wasKilledByKiller = false,
    this.wasKilledByMafia = false,
    this.wasKilledBySheriff = false,
    this.wasKilledByWerewolf = false,
    this.wasCheckedByMadam = false,
    this.wasCheckedBySheriff = false,
    this.wasBoomeranged = false,
    this.wasCheckedByMedium = false,
    this.wasSecured = false,
    this.targetId = 0,
    this.canTarget = true,
    this.killSecurity = false,
    this.isAnimated = true,
    this.playsAsCitizen = true,
    this.beforeChange = true,
    this.healCount = 2,
    this.wasVoted = false,
    this.wasInfected = false,
    this.chameleonId = 0,
    this.werewolfChanged = false,
    this.gamerCounts = const GamerCounts(),
    this.roleCounts = const <String, int>{
      '1': 0,
      '2': 0,
      '3': 0,
      '4': 0,
      '5': 0,
      '6': 0,
      '7': 0,
      '8': 0,
      '9': 0,
      '10': 0,
      '11': 0,
      '12': 0,
      '13': 0,
      '14': 0,
    },
  });

  const Gamer.empty()
      : name = '',
        role = const Role.empty(),
        imageUrl = '',
        id = 0,
        documentId = '',
        gamerCreated = '',
        gamerId = '',
        isNameChanged = false,
        isRoleGiven = false,
        foulCount = 0,
        votesCount = 0,
        wasKilled = false,
        gamerCreatedDate = null,
        positionOnTable = 0,
        selectedNumber = 0,
        wasHealed = false,
        hasAlibi = false,
        wasKilledByKiller = false,
        wasKilledByMafia = false,
        wasKilledBySheriff = false,
        wasKilledByWerewolf = false,
        wasCheckedByMadam = false,
        wasCheckedBySheriff = false,
        wasBoomeranged = false,
        wasCheckedByMedium = false,
        wasSecured = false,
        targetId = 0,
        canTarget = true,
        killSecurity = false,
        isAnimated = true,
        playsAsCitizen = true,
        beforeChange = true,
        healCount = 2,
        wasVoted = false,
        wasInfected = false,
        chameleonId = 0,
        werewolfChanged = false,
        gamerCounts = const GamerCounts(),
        roleCounts = const <String, int>{
          '1': 0,
          '2': 0,
          '3': 0,
          '4': 0,
          '5': 0,
          '6': 0,
          '7': 0,
          '8': 0,
          '9': 0,
          '10': 0,
          '11': 0,
          '12': 0,
          '13': 0,
          '14': 0,
        };

  Gamer copyWith({
    String? name,
    Role? role,
    String? imageUrl,
    int? id,
    String? documentId,
    String? gamerId,
    String? gamerCreated,
    bool? isNameChanged,
    bool? isRoleGiven,
    int? foulCount,
    int? votesCount,
    bool? wasKilled,
    DateTime? gamerCreatedDate,
    int? roleId,
    int? positionOnTable,
    int? selectedNumber,
    bool? wasHealed,
    bool? hasAlibi,
    bool? wasKilledByKiller,
    bool? wasKilledByMafia,
    bool? wasKilledBySheriff,
    bool? wasKilledByWerewolf,
    bool? wasCheckedByMadam,
    bool? wasCheckedBySheriff,
    bool? wasBoomeranged,
    bool? wasSecured,
    bool? wasCheckedByMedium,
    int? targetId,
    bool? canTarget,
    bool? killSecurity,
    Map<String, int>? roleCounts,
    bool? isAnimated,
    bool? playsAsCitizen,
    bool? beforeChange,
    int? healCount,
    bool? wasVoted,
    bool? wasInfected,
    int? chameleonId,
    bool? werewolfChanged,
    GamerCounts? gamerCounts,
  }) =>
      Gamer(
        name: name ?? this.name,
        role: role ?? this.role,
        imageUrl: imageUrl ?? this.imageUrl,
        id: id ?? this.id,
        documentId: documentId ?? this.documentId,
        gamerId: gamerId ?? this.gamerId,
        gamerCreated: gamerCreated ?? this.gamerCreated,
        isNameChanged: isNameChanged ?? this.isNameChanged,
        foulCount: foulCount ?? this.foulCount,
        votesCount: votesCount ?? this.votesCount,
        wasKilled: wasKilled ?? this.wasKilled,
        gamerCreatedDate: gamerCreatedDate ?? this.gamerCreatedDate,
        positionOnTable: positionOnTable ?? this.positionOnTable,
        selectedNumber: selectedNumber ?? this.selectedNumber,
        wasHealed: wasHealed ?? this.wasHealed,
        hasAlibi: hasAlibi ?? this.hasAlibi,
        wasKilledByKiller: wasKilledByKiller ?? this.wasKilledByKiller,
        wasKilledByMafia: wasKilledByMafia ?? this.wasKilledByMafia,
        wasKilledBySheriff: wasKilledBySheriff ?? this.wasKilledBySheriff,
        wasKilledByWerewolf: wasKilledByWerewolf ?? this.wasKilledByWerewolf,
        wasCheckedByMadam: wasCheckedByMadam ?? this.wasCheckedByMadam,
        wasCheckedBySheriff: wasCheckedBySheriff ?? this.wasCheckedBySheriff,
        wasBoomeranged: wasBoomeranged ?? this.wasBoomeranged,
        wasCheckedByMedium: wasCheckedByMedium ?? this.wasCheckedByMedium,
        wasSecured: wasSecured ?? this.wasSecured,
        targetId: targetId ?? this.targetId,
        canTarget: canTarget ?? this.canTarget,
        killSecurity: killSecurity ?? this.killSecurity,
        roleCounts: roleCounts ?? this.roleCounts,
        isRoleGiven: isRoleGiven ?? this.isRoleGiven,
        isAnimated: isAnimated ?? this.isAnimated,
        playsAsCitizen: playsAsCitizen ?? this.playsAsCitizen,
        beforeChange: beforeChange ?? this.beforeChange,
        healCount: healCount ?? this.healCount,
        wasVoted: wasVoted ?? this.wasVoted,
        wasInfected: wasInfected ?? this.wasInfected,
        chameleonId: chameleonId ?? this.chameleonId,
        werewolfChanged: werewolfChanged ?? this.werewolfChanged,
        gamerCounts: gamerCounts ?? this.gamerCounts,
      );

  factory Gamer.fromJson(Map<String, dynamic> json) => _$GamerFromJson(json);

  Map<String, dynamic> toJson() => _$GamerToJson(this);

  @override
  List<Object?> get props => <Object?>[
        name,
        role,
        imageUrl,
        id,
        documentId,
        gamerId,
        gamerCreated,
        isNameChanged,
        foulCount,
        votesCount,
        wasKilled,
        gamerCreatedDate,
        positionOnTable,
        selectedNumber,
        wasHealed,
        hasAlibi,
        wasKilledByKiller,
        wasKilledByMafia,
        wasKilledBySheriff,
        wasKilledByWerewolf,
        wasCheckedByMadam,
        wasCheckedBySheriff,
        wasBoomeranged,
        wasCheckedByMedium,
        wasSecured,
        targetId,
        canTarget,
        killSecurity,
        roleCounts,
        isRoleGiven,
        isAnimated,
        playsAsCitizen,
        beforeChange,
        healCount,
        wasVoted,
        wasInfected,
        chameleonId,
        werewolfChanged,
        gamerCounts,
      ];

  @override
  String toString() => 'Gamer'
      '{name: $name, role: $role,'
      ' id: $id, documentId: $documentId'
      ' gamerId: $gamerId,gamerCreated: $gamerCreated, '
      'isNameChanged: $isNameChanged,'
      ' foulCount: $foulCount, votesCount:'
      ' $votesCount, wasKilled: $wasKilled, '
      'gamerCreatedDate: $gamerCreatedDate, '
      'positionOnTable: $positionOnTable, selectedNumber: $selectedNumber,'
      ' wasHealed: $wasHealed, hasAlibi: $hasAlibi'
      ' wasKilledByKiller: $wasKilledByKiller,'
      ' wasKilledByMafia: $wasKilledByMafia, '
      'wasKilledBySheriff: $wasKilledBySheriff, wasKilledByWerewolf:'
      ' $wasKilledByWerewolf, wasCheckedByMadam: $wasCheckedByMadam,'
      ' wasCheckedByMedium: $wasCheckedByMedium,'
      ' wasCheckedBySheriff: $wasCheckedBySheriff,'
      ' wasBumeranged: $wasBoomeranged, wasSecured: $wasSecured, '
      'targetId: $targetId, canTarget: $canTarget, killSecurity: $killSecurity'
      ' roleCounts: $roleCounts, isRoleGiven: '
      '$isRoleGiven, isAnimated: $isAnimated, playsAsCitizen: $playsAsCitizen,'
      ' beforeChange: $beforeChange, '
      'healCount: $healCount, wasVoted: $wasVoted, wasInfected: $wasInfected,'
      ' chameleonId: $chameleonId, werewolfChanged: $werewolfChanged}';
}
