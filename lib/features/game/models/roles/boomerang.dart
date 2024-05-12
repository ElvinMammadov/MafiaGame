part of game;

@JsonSerializable()
class Boomerang extends Role with EquatableMixin {
  const Boomerang({
    required super.name,
    required super.roleId,
  });

  const Boomerang.empty() : this(name: 'Boomerang', roleId: 14);

  @override
  Boomerang copyWith({
    String? name,
    int? roleId,
  }) =>
      Boomerang(
        name: name ?? this.name,
        roleId: roleId?? this.roleId,
      );

  factory Boomerang.fromJson(Map<String, dynamic> json) => _$BoomerangFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BoomerangToJson(this);

  @override
  List<Object?> get props => <Object?>[
    name,
    roleId,
  ];

  @override
  bool get stringify => true;
}