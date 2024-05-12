part of game;

@JsonSerializable()
class Killer extends Role with EquatableMixin {
  const Killer({
    required super.name,
    required super.roleId,
  });

  const Killer.empty() : this(name: 'Killer', roleId: 6);

  @override
  Killer copyWith({
    String? name,
    int? roleId,
  }) =>
      Killer(
        name: name ?? this.name,
        roleId: roleId?? this.roleId,
      );

  factory Killer.fromJson(Map<String, dynamic> json) => _$KillerFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$KillerToJson(this);

  @override
  List<Object?> get props => <Object?>[
    name,
    roleId,
  ];

  @override
  bool get stringify => true;
}
