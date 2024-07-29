part of game;

@JsonSerializable()
class Madam extends Role with EquatableMixin {
  const Madam({
    required super.name,
    required super.roleId,
    required super.points,
  });

  const Madam.empty()
      : this(
          name: 'Madam',
          roleId: 5,
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
    int? roleId,
    Map<String, int>? points,
  }) =>
      Madam(
        name: name ?? this.name,
        roleId: roleId ?? this.roleId,
        points: points ?? this.points,
      );

  factory Madam.fromJson(Map<String, dynamic> json) => _$MadamFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MadamToJson(this);

  @override
  List<Object?> get props => <Object?>[
        name,
        roleId,
        points,
      ];

  @override
  bool get stringify => true;
}
