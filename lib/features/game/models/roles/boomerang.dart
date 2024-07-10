part of game;

@JsonSerializable()
class Boomerang extends Role with EquatableMixin {
  const Boomerang({
    required super.name,
    required super.roleId,
    required super.points,
  });

  const Boomerang.empty()
      : this(
          name: 'Boomerang',
          roleId: 14,
          points: const <String, int>{
            AppStrings.votedAgainstMafia: 0,
            AppStrings.votedAgainstMainCharacters: 0,
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
    int? roleId,
    Map<String, int>? points,
  }) =>
      Boomerang(
        name: name ?? this.name,
        roleId: roleId ?? this.roleId,
        points: points ?? this.points,
      );

  factory Boomerang.fromJson(Map<String, dynamic> json) =>
      _$BoomerangFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BoomerangToJson(this);

  @override
  List<Object?> get props => <Object?>[
        name,
        roleId,
        points,
      ];

  @override
  bool get stringify => true;
}
