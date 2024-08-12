part of game;

@JsonSerializable()
class Madam extends Role with EquatableMixin {
  const Madam({
    required super.name,
    required super.points,
    required super.roleType,
  });

  const Madam.empty()
      : this(
          name: 'Madam',
          roleType: RoleType.Madam,
          points: const <String, int>{
            AppStrings.votedAgainstMafia: 0,
            AppStrings.votedAgainstMainRoles: 0,
            AppStrings.entersToMafia: 0,
            AppStrings.entersToAnother: 0,
            AppStrings.mafiaKilledAfterMadamChecked: 0,
            AppStrings.alivePoints: 0,
            AppStrings.pointsFromPresenter: 0,
            AppStrings.totalPoints: 0,
          },
        );

  @override
  Madam copyWith({
    String? name,
    Map<String, int>? points,
    RoleType? roleType,
  }) =>
      Madam(
        name: name ?? this.name,
        points: points ?? this.points,
        roleType: roleType ?? this.roleType,
      );

  factory Madam.fromJson(Map<String, dynamic> json) => _$MadamFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MadamToJson(this);

  @override
  List<Object?> get props => <Object?>[
        name,
        points,
        roleType,
      ];

  @override
  bool get stringify => true;
}
