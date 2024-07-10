part of game;

@JsonSerializable()
class Doctor extends Role with EquatableMixin {
  const Doctor({
    required super.name,
    required super.roleId,
    required super.points,
  });

  const Doctor.empty()
      : this(
          name: 'Doktor',
          roleId: 1,
          points: const <String, int>{
            AppStrings.votedAgainstMafia: 0,
            AppStrings.votedAgainstMainCharacters: 0,
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
    int? roleId,
    Map<String, int>? points,
  }) =>
      Doctor(
        name: name ?? this.name,
        roleId: roleId ?? this.roleId,
        points: points ?? this.points,
      );

  factory Doctor.fromJson(Map<String, dynamic> json) => _$DoctorFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DoctorToJson(this);

  @override
  List<Object?> get props => <Object?>[
        name,
        roleId,
        points,
      ];

  @override
  bool get stringify => true;
}
