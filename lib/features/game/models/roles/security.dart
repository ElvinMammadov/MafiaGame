part of game;

@JsonSerializable()
class Security extends Role with EquatableMixin {
  const Security({
    required super.name,
    required super.roleId,
    required super.points,
  });

  const Security.empty()
      : this(
          name: 'Security',
          roleId: 10,
          points: const <String, int>{
            AppStrings.votedAgainstMafia: 0,
            AppStrings.votedAgainstMainRoles: 0,
            AppStrings.securedCitizen: 0,
            AppStrings.securedMafia: 0,
            AppStrings.alivePoints: 0,
            AppStrings.pointsFromPresenter: 0,
            AppStrings.totalPoints: 0,
          },
        );

  @override
  Security copyWith({
    String? name,
    int? roleId,
    Map<String, int>? points,
  }) =>
      Security(
        name: name ?? this.name,
        roleId: roleId ?? this.roleId,
        points: points ?? this.points,
      );

  factory Security.fromJson(Map<String, dynamic> json) =>
      _$SecurityFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SecurityToJson(this);

  @override
  List<Object?> get props => <Object?>[
        name,
        roleId,
        points,
      ];

  @override
  bool get stringify => true;
}
