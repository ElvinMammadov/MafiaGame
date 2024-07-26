part of game;

@JsonSerializable()
class Medium extends Role with EquatableMixin {
  const Medium({
    required super.name,
    required super.roleId,
    required super.points,
  });

  const Medium.empty()
      : this(
          name: 'Medium',
          roleId: 12,
          points: const <String, int>{
            AppStrings.votedAgainstMafia: 0,
            AppStrings.votedAgainstMainRoles: 0,
            AppStrings.pointsIfCheckerDead: 0,
            AppStrings.alivePoints: 0,
            AppStrings.pointsFromPresenter: 0,
            AppStrings.totalPoints: 0,
          },
        );

  @override
  Medium copyWith({
    String? name,
    int? roleId,
    Map<String, int>? points,
  }) =>
      Medium(
        name: name ?? this.name,
        roleId: roleId ?? this.roleId,
        points: points ?? this.points,
      );

  factory Medium.fromJson(Map<String, dynamic> json) => _$MediumFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MediumToJson(this);

  @override
  List<Object?> get props => <Object?>[
        name,
        roleId,
        points,
      ];

  @override
  bool get stringify => true;
}
