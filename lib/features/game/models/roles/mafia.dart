part of game;

@JsonSerializable()
class Mafia extends Role with EquatableMixin {
  const Mafia({
    required super.name,
    required super.points,
    required super.roleType,
  });

  const Mafia.empty()
      : this(
          name: 'Mafia',
          roleType: RoleType.Mafia,
          points: const <String, int>{
            AppStrings.votedAgainstMafia: 0,
            AppStrings.votedAgainstMainRoles: 0,
            AppStrings.votedAgainstOthers: 0,
            AppStrings.deadMafiaPoints: 0,
            AppStrings.alivePoints: 0,
            AppStrings.pointsFromPresenter: 0,
            AppStrings.totalPoints: 0,
          },
        );

  @override
  Mafia copyWith({
    String? name,
    Map<String, int>? points,
    RoleType? roleType,
  }) =>
      Mafia(
        name: name ?? this.name,
        points: points ?? this.points,
        roleType: roleType ?? this.roleType,
      );

  factory Mafia.fromJson(Map<String, dynamic> json) => _$MafiaFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MafiaToJson(this);

  @override
  List<Object?> get props => <Object?>[
        name,
        points,
        roleType,
      ];

  @override
  bool get stringify => true;
}
