part of game;

@JsonSerializable()
class Role extends Equatable {
  final String name;
  final int roleId;

  const Role(
    this.name, {
    this.roleId = 0,
  });

  const Role.empty() : this('');

  Role copyWith({
    String? name,
  }) =>
      Role(
        name ?? this.name,
        roleId: roleId,
      );

  factory Role.fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);

  Map<String, dynamic> toJson() => _$RoleToJson(this);

  @override
  List<Object?> get props => <Object?>[
        name,
        roleId,
      ];

}
