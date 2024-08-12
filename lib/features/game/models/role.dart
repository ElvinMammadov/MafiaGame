part of game;

@JsonSerializable()
class Role extends Equatable {
  final String name;
  // final int roleId;
  final Map<String, int>? points;
  final RoleType roleType;

  const Role({
    this.name = '',
    // this.roleId = 0,
    this.points,
    this.roleType = RoleType.Civilian,
  });

  const Role.empty() : this();

  Role copyWith({
    String? name,
    // int? roleId,
    Map<String, int>? points,
    RoleType? roleType,
  }) =>
      Role(
        name: name ?? this.name,
        // roleId: roleId ?? this.roleId,
        points: points ?? this.points,
        roleType: roleType ?? this.roleType,
      );

  factory Role.fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);

  Map<String, dynamic> toJson() => _$RoleToJson(this);

  @override
  List<Object?> get props => <Object?>[
        name,
        // roleId,
        points,
        roleType,
      ];
}

enum RoleType {
  Chameleon,
  Don,
  Mafia,
  Madam,
  Sheriff,
  Doctor,
  Advocate,
  Killer,
  Boomerang,
  Werewolf,
  Medium,
  Security,
  Virus,
  Civilian,
}
