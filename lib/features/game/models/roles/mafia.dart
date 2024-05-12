part of game;

@JsonSerializable()
class Mafia extends Role with EquatableMixin {
  const Mafia({
    required super.name,
    required super.roleId,
  });

  const Mafia.empty() : this(name: 'Mafia' , roleId: 2);

  @override
  Mafia copyWith({
    String? name,
    int? roleId,
  }) =>
      Mafia(
        name: name ?? this.name,
        roleId: roleId ?? this.roleId,
      );

  factory Mafia.fromJson(Map<String, dynamic> json) => _$MafiaFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MafiaToJson(this);

  @override
  List<Object?> get props => <Object?>[
    name,
    roleId,
  ];

  @override
  bool get stringify => true;
}
