part of game;

@JsonSerializable()
class Roles extends Equatable {
  final List<Role> roles;

  const Roles({required this.roles});

  const Roles.empty()
      : this(
          roles: const <Role>[
            Role('Doktor', roleId: 1),
            Role('Mafia', roleId: 2),
            Role('Don', roleId: 3),
            Role('Sheriff', roleId: 4),
            Role('Madam', roleId: 5),
            Role('Killer', roleId: 6),
            Role('Werewolf', roleId: 7),
            Role('Virus', roleId: 8),
            Role('Advokat', roleId: 9),
            Role('Security', roleId: 10),
            Role('Mirniy', roleId: 11),
            Role('Medium', roleId: 12),
            Role('Chameleon', roleId: 13),
            Role('Boomerang', roleId: 14),
          ],
        );

  Roles copyWith({
    List<Role>? roles,
  }) =>
      Roles(
        roles: roles ?? this.roles,
      );

  factory Roles.fromJson(Map<String, dynamic> json) => _$RolesFromJson(json);

  Map<String, dynamic> toJson() => _$RolesToJson(this);

  bool hasRole(String roleName) => roles.any(
        (Role role) => role.name == roleName,
      );

  @override
  List<Object?> get props => <Object?>[roles];
}
