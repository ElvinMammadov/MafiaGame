part of game;

@JsonSerializable()
class Virus extends Role with EquatableMixin {
  const Virus({
    required super.name,
    required super.points,
    required super.roleType,
  });

  const Virus.empty()
      : this(
          name: 'Virus',
          roleType: RoleType.Virus,
          points: const <String, int>{
            AppStrings.votedAgainstMafia: 0,
            AppStrings.votedAgainstMainRoles: 0,
            AppStrings.infectedCitizens: 0,
            AppStrings.infectedMafia: 0,
            AppStrings.alivePoints: 0,
            AppStrings.pointsFromPresenter: 0,
            AppStrings.totalPoints: 0,
          },
        );

  @override
  Virus copyWith({
    String? name,
    Map<String, int>? points,
    RoleType? roleType,
  }) =>
      Virus(
        name: name ?? this.name,
        points: points ?? this.points,
        roleType: roleType ?? this.roleType,
      );

  factory Virus.fromJson(Map<String, dynamic> json) => _$VirusFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$VirusToJson(this);

  @override
  List<Object?> get props => <Object?>[
        name,
        points,
        roleType,
      ];

  @override
  bool get stringify => true;
}
