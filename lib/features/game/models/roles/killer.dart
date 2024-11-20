part of game;

@JsonSerializable()
class Killer extends Role with EquatableMixin {
  const Killer({
    required super.name,
    required super.points,
    required super.roleType,
  });

  const Killer.empty()
      : this(
          name: 'Killer',
          roleType: RoleType.Killer,
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
  Killer copyWith({
    String? name,
    Map<String, int>? points,
    RoleType? roleType,
  }) =>
      Killer(
        name: name ?? this.name,
        points: points ?? this.points,
        roleType: roleType ?? this.roleType,
      );

  factory Killer.fromJson(Map<String, dynamic> json) => _$KillerFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$KillerToJson(this);

  @override
  List<Object?> get props => <Object?>[
        name,
        points,
        roleType,
      ];

  @override
  bool get stringify => true;
}
