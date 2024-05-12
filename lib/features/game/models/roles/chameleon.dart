part of game;

@JsonSerializable()
class Chameleon extends Role with EquatableMixin {
  const Chameleon({
    required super.name,
    required super.roleId,
  });

  const Chameleon.empty() : this(name: 'Chameleon', roleId: 13);

  @override
  Chameleon copyWith({
    String? name,
    int? roleId,
  }) =>
      Chameleon(
        name: name ?? this.name,
        roleId: roleId?? this.roleId,
      );

  factory Chameleon.fromJson(Map<String, dynamic> json) => _$ChameleonFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ChameleonToJson(this);

  @override
  List<Object?> get props => <Object?>[
    name,
    roleId,
  ];

  @override
  bool get stringify => true;
}
