part of game;

@JsonSerializable()
class Medium extends Role with EquatableMixin {
  const Medium({
    required super.name,
    required super.points,
    required super.roleType,
  });

  const Medium.empty()
      : this(
          name: 'Medium',
          roleType: RoleType.Medium,
          points: const <String, int>{
            AppStrings.votedAgainstMafia: 0,
            AppStrings.votedAgainstMainRoles: 0,
            AppStrings.pointsIfCheckerDead: 0,
            AppStrings.alivePoints: 0,
            AppStrings.pointsFromPresenter: 0,
            AppStrings.totalPoints: 0,
          },
        );

  @override
  Medium copyWith({
    String? name,
    Map<String, int>? points,
    RoleType? roleType,
  }) =>
      Medium(
        name: name ?? this.name,
        points: points ?? this.points,
        roleType: roleType ?? this.roleType,
      );

  factory Medium.fromJson(Map<String, dynamic> json) => _$MediumFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MediumToJson(this);

  @override
  List<Object?> get props => <Object?>[
        name,
        points,
        roleType,
      ];

  @override
  bool get stringify => true;
}
