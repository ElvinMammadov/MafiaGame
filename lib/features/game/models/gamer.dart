part of game;

@JsonSerializable()
class Gamer extends Equatable {
  final String? name;
  final String? role;
  final String? imageUrl;
  final int? id;
  final String? documentId;
  final String? gamerId;
  final String? gamerCreated;
  final bool? isNameChanged;
  final int foulCount;
  final int votesCount;
  final bool wasDeleted;
  final DateTime? gamerCreatedDate;
  final int? roleId;
  final int positionOnTable;

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
    this.wasDeleted = false,
    this.gamerCreatedDate,
    this.roleId,
    this.positionOnTable = 0,
  });

  const Gamer.empty()
      : name = '',
        role = '',
        imageUrl = '',
        id = 0,
        documentId = '',
        gamerCreated = '',
        gamerId = '',
        isNameChanged = false,
        foulCount = 0,
        votesCount = 0,
        wasDeleted = false,
        gamerCreatedDate = null,
        roleId = 0,
        positionOnTable = 0;

  Gamer copyWith({
    String? name,
    String? role,
    String? imageUrl,
    int? id,
    String? documentId,
    String? gamerId,
    String? gamerCreated,
    bool? isNameChanged,
    int? foulCount,
    int? votesCount,
    bool? wasDeleted,
    DateTime? gamerCreatedDate,
    int? roleId,
    int? positionOnTable,
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
        wasDeleted: wasDeleted ?? this.wasDeleted,
        gamerCreatedDate: gamerCreatedDate ?? this.gamerCreatedDate,
        roleId: roleId ?? this.roleId,
        positionOnTable: positionOnTable ?? this.positionOnTable,
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
        wasDeleted,
        gamerCreatedDate,
        roleId,
        positionOnTable,
      ];

  @override
  String toString() => 'Gamer'
      '{name: $name, role: $role,'
      ' imageUrl: $imageUrl, id: $id, documentId: $documentId'
      ' gamerId: $gamerId'
      'gamerCreated: $gamerCreated, isNameChanged: $isNameChanged,'
      ' foulCount: $foulCount, votesCount:'
      ' $votesCount, isDeleted: '
      '$wasDeleted, gamerCreatedDate: $gamerCreatedDate, roleId: $roleId, '
      'positionOnTable: $positionOnTable,}';
}
