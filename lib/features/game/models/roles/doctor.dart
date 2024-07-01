part of game;

@JsonSerializable()
class Doctor extends Role with EquatableMixin {
  final int healCount;
  final Map<String, int>? points;

  const Doctor({
    required super.name,
    required super.roleId,
    required this.healCount,
    this.points,
  });

  const Doctor.empty()
      : this(
          name: 'Doktor',
          healCount: 2,
          roleId: 1,
          points: const <String, int>{
            AppStrings.totalPoints: 0,
            AppStrings.alivePoints: 0,
            AppStrings.votesForMafia: 0,
            AppStrings.votesForCitizen: 0,
            AppStrings.pointsIfCheckerDead: 0,
            AppStrings.healedCitizen: 0,
            AppStrings.healedMafia: 0,
          },
        );

  @override
  Doctor copyWith({
    String? name,
    int? healCount,
    int? roleId,
    Map<String, int>? points,
  }) =>
      Doctor(
        name: name ?? this.name,
        roleId: roleId ?? this.roleId,
        healCount: healCount ?? this.healCount,
        points: points ?? this.points,
      );

  factory Doctor.fromJson(Map<String, dynamic> json) => _$DoctorFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DoctorToJson(this);

  @override
  List<Object?> get props => <Object?>[
        name,
        roleId,
        healCount,
        points,
      ];

  @override
  bool get stringify => true;
}
