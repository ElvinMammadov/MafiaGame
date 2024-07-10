part of game;

@JsonSerializable()
class Role extends Equatable {
  final String name;
  final int roleId;
  final Map<String, int>? points;

  const Role({
    this.name = '',
    this.roleId = 0,
    this.points,
  });

  const Role.empty() : this();

  Role copyWith({
    String? name,
    int? roleId,
    Map<String, int>? points,
  }) =>
      Role(
        name: name ?? this.name,
        roleId: roleId ?? this.roleId,
        points: points ?? this.points,
      );

  factory Role.fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);

  Map<String, dynamic> toJson() => _$RoleToJson(this);

  @override
  List<Object?> get props => <Object?>[
        name,
        roleId,
        points,
      ];
}
