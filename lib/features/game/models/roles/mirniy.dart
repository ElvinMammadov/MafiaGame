part of game;

@JsonSerializable()
class Mirniy extends Role with EquatableMixin {
  const Mirniy({
    required super.name,
    required super.points,
    required super.roleType,
  });

  const Mirniy.empty()
      : this(
          name: 'Mirniy',
          roleType: RoleType.Civilian,
          points: const <String, int>{
            AppStrings.votedAgainstMafia: 0,
            AppStrings.votedAgainstMainRoles: 0,
            AppStrings.votesForDon: 0,
            AppStrings.pointIfDeadByWin: 0,
            AppStrings.alivePoints: 0,
            AppStrings.pointsFromPresenter: 0,
            AppStrings.totalPoints: 0,
          },
        );

  @override
  Mirniy copyWith({
    String? name,
    Map<String, int>? points,
    RoleType? roleType,
  }) =>
      Mirniy(
        name: name ?? this.name,
        points: points ?? this.points,
        roleType: roleType ?? this.roleType,
      );

  factory Mirniy.fromJson(Map<String, dynamic> json) => _$MirniyFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MirniyToJson(this);

  @override
  List<Object?> get props => <Object?>[
        name,
        points,
        roleType,
      ];

  @override
  bool get stringify => true;
}
