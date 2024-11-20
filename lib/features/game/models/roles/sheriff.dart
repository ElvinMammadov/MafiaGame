part of game;

@JsonSerializable()
class Sheriff extends Role with EquatableMixin {
  const Sheriff({
    required super.name,
    required super.points,
    required super.roleType,
  });

  const Sheriff.empty()
      : this(
          name: 'Sheriff',
          roleType: RoleType.Sheriff,
          points: const <String, int>{
            AppStrings.votedAgainstMafia: 0,
            AppStrings.votedAgainstMainRoles: 0,
            AppStrings.cityKillsMafia: 0,
            AppStrings.killedMafias: 0,
            AppStrings.entersToMafia: 0,
            AppStrings.alivePoints: 0,
            AppStrings.pointsFromPresenter: 0,
            AppStrings.totalPoints: 0,
          },
        );

  @override
  Sheriff copyWith({
    String? name,
    Map<String, int>? points,
    RoleType? roleType,
  }) =>
      Sheriff(
        name: name ?? this.name,
        points: points ?? this.points,
        roleType: roleType ?? this.roleType,
      );

  factory Sheriff.fromJson(Map<String, dynamic> json) =>
      _$SheriffFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SheriffToJson(this);

  @override
  List<Object?> get props => <Object?>[
        name,
        points,
      ];

  @override
  bool get stringify => true;
}
