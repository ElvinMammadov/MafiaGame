part of game;

@JsonSerializable()
class Advokat extends Role with EquatableMixin {
  const Advokat({
    required super.name,
    required super.roleId,
  });

  const Advokat.empty() : this(name: 'Advokat', roleId: 9);

  @override
  Advokat copyWith({
    String? name,
    int? roleId,
  }) =>
      Advokat(
        name: name ?? this.name,
        roleId: roleId?? this.roleId,
      );

  factory Advokat.fromJson(Map<String, dynamic> json) =>
      _$AdvokatFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AdvokatToJson(this);

  @override
  List<Object?> get props => <Object?>[
        name,
        roleId,
      ];

  @override
  bool get stringify => true;
}
