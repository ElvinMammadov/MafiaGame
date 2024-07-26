part of game;

@JsonSerializable()
class Killer extends Role with EquatableMixin {
  const Killer({
    required super.name,
    required super.roleId,
    required super.points,
  });

  const Killer.empty()
      : this(
          name: 'Killer',
          roleId: 6,
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
    int? roleId,
    Map<String, int>? points,
  }) =>
      Killer(
        name: name ?? this.name,
        roleId: roleId ?? this.roleId,
        points: points ?? this.points,
      );

  factory Killer.fromJson(Map<String, dynamic> json) => _$KillerFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$KillerToJson(this);

  @override
  List<Object?> get props => <Object?>[
        name,
        roleId,
        points,
      ];

  @override
  bool get stringify => true;
}
