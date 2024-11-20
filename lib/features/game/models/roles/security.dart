part of game;

@JsonSerializable()
class Security extends Role with EquatableMixin {
  const Security({
    required super.name,
    required super.points,
    required super.roleType,
  });

  const Security.empty()
      : this(
          name: 'Security',
          roleType: RoleType.Security,
          points: const <String, int>{
            AppStrings.votedAgainstMafia: 0,
            AppStrings.votedAgainstMainRoles: 0,
            AppStrings.securedCitizen: 0,
            AppStrings.securedMafia: 0,
            AppStrings.alivePoints: 0,
            AppStrings.pointsFromPresenter: 0,
            AppStrings.totalPoints: 0,
          },
        );

  @override
  Security copyWith({
    String? name,
    Map<String, int>? points,
    RoleType? roleType,
  }) =>
      Security(
        name: name ?? this.name,
        points: points ?? this.points,
        roleType: roleType ?? this.roleType,
      );

  factory Security.fromJson(Map<String, dynamic> json) =>
      _$SecurityFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SecurityToJson(this);

  @override
  List<Object?> get props => <Object?>[
        name,
        points,
        roleType,
      ];

  @override
  bool get stringify => true;
}
