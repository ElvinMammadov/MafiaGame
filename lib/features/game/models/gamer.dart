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
  final int foulCount;
  final int votesCount;
  final bool wasKilled;
  final DateTime? gamerCreatedDate;
  final int positionOnTable;
  final int? selectedNumber;

  const Gamer({
    this.name,
    this.role,
    this.imageUrl,
    this.id,
    this.documentId,
    this.gamerId,
    this.gamerCreated,
    this.isNameChanged,
    this.foulCount = 0,
    this.votesCount = 0,
    this.wasKilled = false,
    this.gamerCreatedDate,
    this.positionOnTable = 0,
    this.selectedNumber,
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
        foulCount = 0,
        votesCount = 0,
        wasKilled = false,
        gamerCreatedDate = null,
        positionOnTable = 0,
        selectedNumber = 0;

  Gamer copyWith({
    String? name,
    Role? role,
    String? imageUrl,
    int? id,
    String? documentId,
    String? gamerId,
    String? gamerCreated,
    bool? isNameChanged,
    int? foulCount,
    int? votesCount,
    bool? wasKilled,
    DateTime? gamerCreatedDate,
    int? roleId,
    int? positionOnTable,
    int? selectedNumber,
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
      ];

  @override
  String toString() => 'Gamer'
      '{name: $name, role: $role,'
      ' imageUrl: $imageUrl, id: $id, documentId: $documentId'
      ' gamerId: $gamerId'
      'gamerCreated: $gamerCreated, isNameChanged: $isNameChanged,'
      ' foulCount: $foulCount, votesCount:'
      ' $votesCount, isDeleted: '
      '$wasKilled, gamerCreatedDate: $gamerCreatedDate, '
      'positionOnTable: $positionOnTable, selectedNumber: $selectedNumber}';
}
