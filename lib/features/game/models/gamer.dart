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

  const Gamer({
    this.name,
    this.role,
    this.imageUrl,
    this.id,
    this.documentId,
    this.gamerId,
    this.gamerCreated,
    this.isNameChanged,
  });


  const Gamer.empty()
      : name = '',
        role = '',
        imageUrl = '',
        id = 0,
        documentId = '',
        gamerCreated = '',
        gamerId = '',
        isNameChanged = false;

  Gamer copyWith({
    String? name,
    String? role,
    String? imageUrl,
    int? id,
    String? documentId,
    String? gamerId,
    String? gamerCreated,
    bool? isNameChanged,
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
      );

  factory Gamer.fromFireStore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final Map<String, dynamic> data = snapshot.data()!;
    final Gamer gamer = Gamer(
      name: data['name'] as String,
      role: data['role'] as String,
      imageUrl: data['imageUrl'] as String,
      documentId: data['documentId'] as String,
      gamerId: data['gamerId'] as String,
    );
    return gamer;
  }

  Map<String, dynamic> toFireStore() => <String, dynamic>{
        if (name != null) "name": name,
        if (role != null) "role": role,
        if (imageUrl != null) "imageUrl": imageUrl,
        if (documentId != null) "id": documentId,
        if (gamerId != null) "gamerId": gamerId,
      };

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
      ];

  @override
  String toString() => 'Gamer'
      '{name: $name, role: $role,'
      ' imageUrl: $imageUrl}, id: $id, documentId: $documentId}'
      ' gamerId: $gamerId'
      'gamerCreated: $gamerCreated, isNameChanged: $isNameChanged}';
}
