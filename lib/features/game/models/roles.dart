part of game;

@JsonSerializable()
class Roles extends Equatable {
  final List<Role> roles;

  const Roles({required this.roles});

  const Roles.empty()
      : this(
          roles: const <Role>[
            Doctor.empty(),
            Mafia.empty(),
            Don.empty(),
            Sheriff.empty(),
            Madam.empty(),
            Killer.empty(),
            Werewolf.empty(),
            Virus.empty(),
            Advokat.empty(),
            Security.empty(),
            Mirniy.empty(),
            Medium.empty(),
            Chameleon.empty(),
            Boomerang.empty(),
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
