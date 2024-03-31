import 'package:equatable/equatable.dart';
import 'package:mafia_game/features/game/models/role.dart';

class Roles extends Equatable {
  final List<Role> roles;

  const Roles({required this.roles});

  const Roles.empty()
      : this(
          roles: const <Role>[
            Role('Werewolf'),
            Role('Virus'),
            Role('Sheriff'),
            Role('Security'),
            Role('Mirniy'),
            Role('Medium'),
            Role('Doktor'),
            Role('Mafia'),
            Role('Madam'),
            Role('Killer'),
            Role('Don'),
            Role('Chameleon'),
            Role('Boomerang'),
            Role('Advokat'),
          ],
        );

  Roles copyWith({
    List<Role>? roles,
  }) =>
      Roles(
        roles: roles ?? this.roles,
      );

  bool hasRole(String roleName) => roles.any(
        (Role role) => role.name == roleName,
      );

  @override
  List<Object?> get props => <Object?>[roles];
}
