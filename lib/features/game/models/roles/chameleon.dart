part of game;

@JsonSerializable()
class Chameleon extends Role with EquatableMixin {

  const Chameleon({
    required super.name,
    required super.points,
    required super.roleType,
  });

  const Chameleon.empty()
      : this(
          name: 'Chameleon',
          roleType: RoleType.Chameleon,
          points: const <String, int>{
            AppStrings.votedAgainstMafia: 0,
            AppStrings.votedAgainstMainRoles: 0,
            AppStrings.playsForMafia: 0,
            AppStrings.playsForDoctor: 0,
            AppStrings.playsForSheriff: 0,
            AppStrings.playsForAdvocate: 0,
            AppStrings.playsForMadam: 0,
            AppStrings.playsForMedium: 0,
            AppStrings.playsForKiller: 0,
            AppStrings.alivePoints: 0,
            AppStrings.pointsFromPresenter: 0,
            AppStrings.totalPoints: 0,
          },
        );

  @override
  Chameleon copyWith({
    String? name,
    Map<String, int>? points,
    RoleType? roleType,
  }) =>
      Chameleon(
        name: name ?? this.name,
        points: points ?? this.points,
        roleType: roleType ?? this.roleType,
      );

  factory Chameleon.fromJson(Map<String, dynamic> json) =>
      _$ChameleonFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ChameleonToJson(this);

  @override
  List<Object?> get props => <Object?>[
        name,
        points,
        roleType,
      ];

  @override
  bool get stringify => true;
}
