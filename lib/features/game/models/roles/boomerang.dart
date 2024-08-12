part of game;

@JsonSerializable()
class Boomerang extends Role with EquatableMixin {
  const Boomerang({
    required super.name,
    required super.points,
    required super.roleType,
  });

  const Boomerang.empty()
      : this(
          name: 'Boomerang',
          roleType: RoleType.Boomerang,
          points: const <String, int>{
            AppStrings.votedAgainstMafia: 0,
            AppStrings.votedAgainstMainRoles: 0,
            AppStrings.killedCitizens: 0,
            AppStrings.killedMafias: 0,
            AppStrings.alivePoints: 0,
            AppStrings.pointsFromPresenter: 0,
            AppStrings.totalPoints: 0,
          },
        );

  @override
  Boomerang copyWith({
    String? name,
    Map<String, int>? points,
    RoleType? roleType,
  }) =>
      Boomerang(
        name: name ?? this.name,
        points: points ?? this.points,
        roleType: roleType ?? this.roleType,
      );

  factory Boomerang.fromJson(Map<String, dynamic> json) =>
      _$BoomerangFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BoomerangToJson(this);

  @override
  List<Object?> get props => <Object?>[
        name,
        points,
        roleType,
      ];

  @override
  bool get stringify => true;
}
