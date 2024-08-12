part of game;

@JsonSerializable()
class Doctor extends Role with EquatableMixin {
  const Doctor({
    required super.name,
    required super.points,
    required super.roleType,
  });

  const Doctor.empty()
      : this(
          name: 'Doktor',
          roleType: RoleType.Doctor,
          points: const <String, int>{
            AppStrings.votedAgainstMafia: 0,
            AppStrings.votedAgainstMainRoles: 0,
            AppStrings.healedCitizen: 0,
            AppStrings.healedMafia: 0,
            AppStrings.alivePoints: 0,
            AppStrings.pointsFromPresenter: 0,
            AppStrings.totalPoints: 0,
          },
        );

  @override
  Doctor copyWith({
    String? name,
    Map<String, int>? points,
    RoleType? roleType,
  }) =>
      Doctor(
        name: name ?? this.name,
        points: points ?? this.points,
        roleType: roleType ?? this.roleType,
      );

  factory Doctor.fromJson(Map<String, dynamic> json) => _$DoctorFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DoctorToJson(this);

  @override
  List<Object?> get props => <Object?>[
        name,
        points,
        roleType,
      ];

  @override
  bool get stringify => true;
}
