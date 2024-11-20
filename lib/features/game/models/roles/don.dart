part of game;

@JsonSerializable()
class Don extends Role with EquatableMixin {
  const Don({
    required super.name,
    required super.points,
    required super.roleType,
  });

  const Don.empty()
      : this(
          name: 'Don',
          roleType: RoleType.Don,
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
  Don copyWith({
    String? name,
    Map<String, int>? points,
    RoleType? roleType,
  }) =>
      Don(
        name: name ?? this.name,
        points: points ?? this.points,
        roleType: roleType ?? this.roleType,
      );

  factory Don.fromJson(Map<String, dynamic> json) => _$DonFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DonToJson(this);

  @override
  List<Object?> get props => <Object?>[
        name,
        points,
        roleType,
      ];

  @override
  bool get stringify => true;
}
