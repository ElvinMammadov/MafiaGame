part of game;

@JsonSerializable()
class Gamer extends Equatable {
  final String? name;
  final Role? role;
  final String? imageUrl;
  final int? id;
  final String? documentId;
  final String? gamerId;
  final String? gamerCreated;
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
  final bool wasBoomeranged;
  final bool wasSecured;
  final int? targetId;
  final bool canTarget;
  final bool killSecurity;
  final Map<String, int> roleCounts;
  final bool isAnimated;

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
    this.wasBoomeranged = false,
    this.wasSecured = false,
    this.targetId = 0,
    this.canTarget = true,
    this.killSecurity = false,
    this.isAnimated = true,
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
        wasBoomeranged = false,
        wasSecured = false,
        targetId = 0,
        canTarget = true,
        killSecurity = false,
        isAnimated = true,
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
    bool? wasBoomeranged,
    bool? wasSecured,
    int? targetId,
    bool? canTarget,
    bool? killSecurity,
    Map<String, int>? roleCounts,
    bool? isAnimated,
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
        wasBoomeranged: wasBoomeranged ?? this.wasBoomeranged,
        wasSecured: wasSecured ?? this.wasSecured,
        targetId: targetId ?? this.targetId,
        canTarget: canTarget ?? this.canTarget,
        killSecurity: killSecurity ?? this.killSecurity,
        roleCounts: roleCounts ?? this.roleCounts,
        isRoleGiven: isRoleGiven ?? this.isRoleGiven,
        isAnimated: isAnimated ?? this.isAnimated,
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
        wasBoomeranged,
        wasSecured,
        targetId,
        canTarget,
        killSecurity,
        roleCounts,
        isRoleGiven,
        isAnimated,
      ];

  @override
  String toString() => 'Gamer'
      '{name: $name, role: $role,'
      // ' imageUrl: $imageUrl,'
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
      'wasKilledBySheriff: $wasKilledBySheriff,'
      ' wasBumeranged: $wasBoomeranged, wasSecured: $wasSecured, '
      'targetId: $targetId, canTarget: $canTarget, killSecurity: $killSecurity'
      ' roleCounts: $roleCounts, isRoleGiven: '
      '$isRoleGiven, isAnimated: $isAnimated}';
}
