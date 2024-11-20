part of game;

@JsonSerializable()
class Werewolf extends Role with EquatableMixin {
  const Werewolf({
    required super.name,
    required super.points,
    required super.roleType,
  });

  const Werewolf.empty()
      : this(
          name: 'Werewolf',
          roleType: RoleType.Werewolf,
          points: const <String, int>{
            AppStrings.votedAgainstMafia: 0,
            AppStrings.votedAgainstMainRoles: 0,
            AppStrings.killedCitizensAfterChange: 0,
            AppStrings.killedMainCharactersAfterChange: 0,
            AppStrings.mafiaTriedToKillBeforeChange: 0,
            AppStrings.killerTriedToKillBeforeChange: 0,
            AppStrings.aliveUntilChange: 0,
            AppStrings.pointsIfWonGame: 0,
            AppStrings.alivePoints: 0,
            AppStrings.pointsFromPresenter: 0,
            AppStrings.totalPoints: 0,
          },
        );

  @override
  Werewolf copyWith({
    String? name,
    Map<String, int>? points,
    RoleType? roleType,
  }) =>
      Werewolf(
        name: name ?? this.name,
        points: points ?? this.points,
        roleType: roleType ?? this.roleType,
      );

  factory Werewolf.fromJson(Map<String, dynamic> json) =>
      _$WerewolfFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$WerewolfToJson(this);

  @override
  List<Object?> get props => <Object?>[
        name,
        points,
        roleType,
      ];

  @override
  bool get stringify => true;
}
