part of game;

@JsonSerializable()
class Chameleon extends Role with EquatableMixin {

  const Chameleon({
    required super.name,
    required super.roleId,
    required super.points,
  });

  const Chameleon.empty()
      : this(
          name: 'Chameleon',
          roleId: 13,
          points: const <String, int>{
            AppStrings.votedAgainstMafia: 0,
            AppStrings.votedAgainstMainRoles: 0,
            AppStrings.playsForMainCharacters: 0,
            AppStrings.playsForMafia: 0,
            AppStrings.playsForKiller: 0,
            AppStrings.playsForDoctor: 0,
            AppStrings.playsForSheriff: 0,
            AppStrings.playsForAdvocat: 0,
            AppStrings.playsForMadam: 0,
            AppStrings.alivePoints: 0,
            AppStrings.pointsFromPresenter: 0,
            AppStrings.totalPoints: 0,
          },
        );

  @override
  Chameleon copyWith({
    String? name,
    int? roleId,
    Map<String, int>? points,
  }) =>
      Chameleon(
        name: name ?? this.name,
        roleId: roleId ?? this.roleId,
        points: points ?? this.points,
      );

  factory Chameleon.fromJson(Map<String, dynamic> json) =>
      _$ChameleonFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ChameleonToJson(this);

  @override
  List<Object?> get props => <Object?>[
        name,
        roleId,
        points,
      ];

  @override
  bool get stringify => true;
}
