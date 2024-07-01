part of game;

@JsonSerializable()
class Boomerang extends Role with EquatableMixin {
  final Map<String, int>? points;

  const Boomerang({
    required super.name,
    required super.roleId,
    this.points,
  });

  const Boomerang.empty()
      : this(
          name: 'Boomerang',
          roleId: 14,
          points: const <String, int>{
            AppStrings.totalPoints: 0,
            AppStrings.alivePoints: 0,
            AppStrings.votesForMafia: 0,
            AppStrings.votesForCitizen: 0,
            AppStrings.killedCitizens: 0,
            AppStrings.killedMafias: 0,
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
