part of game;

@JsonSerializable()
class Roles extends Equatable {
  final List<Role> roles;

  const Roles({required this.roles});

  const Roles.empty()
      : this(
          roles: const <Role>[
            Chameleon.empty(),
            Don.empty(),
            Mafia.empty(),
            Madam.empty(),
            Sheriff.empty(),
            Doctor.empty(),
            Advocate.empty(),
            Killer.empty(),
            Boomerang.empty(),
            Werewolf.empty(),
            Medium.empty(),
            Security.empty(),
            Virus.empty(),
            // Mirniy.empty(),
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
  String toString() => 'Roles { roles: $roles }';

  @override
  List<Object?> get props => <Object?>[roles];
}
