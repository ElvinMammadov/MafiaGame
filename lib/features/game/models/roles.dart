part of game;

@JsonSerializable()
class Roles extends Equatable {
  final List<Role> roles;

  const Roles({required this.roles});

  const Roles.empty()
      : this(
          roles: const <Role>[
            Role('Werewolf', roleId: 1),
            Role('Virus', roleId: 2),
            Role('Sheriff', roleId: 3),
            Role('Security', roleId: 4),
            Role('Mirniy', roleId: 5),
            Role('Medium', roleId: 6),
            Role('Doktor', roleId: 7),
            Role('Mafia', roleId: 8),
            Role('Madam', roleId: 9),
            Role('Killer', roleId: 10),
            Role('Don', roleId: 11),
            Role('Chameleon', roleId: 12),
            Role('Boomerang', roleId: 13),
            Role('Advokat', roleId: 14),
          ],
        );

  Roles copyWith({
    List<Role>? roles,
  }) =>
      Roles(
        roles: roles ?? this.roles,
      );

  factory Roles.fromJson(Map<String, dynamic> json) =>_$RolesFromJson(json);

  Map<String, dynamic> toJson() => _$RolesToJson(this);

  bool hasRole(String roleName) => roles.any(
        (Role role) => role.name == roleName,
      );

  @override
  List<Object?> get props => <Object?>[roles];
}
