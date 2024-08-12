part of game;

@JsonSerializable()
class Advocate extends Role with EquatableMixin {
  const Advocate({
    required super.name,
    required super.points,
    required super.roleType,
  });

  const Advocate.empty()
      : this(
          name: 'Advokat',
          roleType: RoleType.Advocate,
          points: const <String, int>{
            AppStrings.votedAgainstMafia: 0,
            AppStrings.votedAgainstMainRoles: 0,
            AppStrings.gaveAlibiToCitizen: 0,
            AppStrings.gaveAlibiToMafia: 0,
            AppStrings.citizenAlibiWorked: 0,
            AppStrings.mafiaAlibiWorked: 0,
            AppStrings.alivePoints: 0,
            AppStrings.pointsFromPresenter: 0,
            AppStrings.totalPoints: 0,
          },
        );

  @override
  Advocate copyWith({
    String? name,
    Map<String, int>? points,
    RoleType? roleType,
  }) =>
      Advocate(
        name: name ?? this.name,
        points: points ?? this.points,
        roleType: roleType ?? this.roleType,
      );

  factory Advocate.fromJson(Map<String, dynamic> json) =>
      _$AdvocateFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AdvocateToJson(this);

  @override
  List<Object?> get props => <Object?>[
        name,
        points,
        roleType,
      ];

  @override
  bool get stringify => true;
}
