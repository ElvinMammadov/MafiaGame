part of game;

@JsonSerializable()
class Werewolf extends Role with EquatableMixin {
  const Werewolf({
    required super.name,
    required super.roleId,
    required super.points,
  });

  const Werewolf.empty()
      : this(
          name: 'Werewolf',
          roleId: 7,
          points: const <String, int>{
            AppStrings.votedAgainstMafia: 0,
            AppStrings.votedAgainstMainCharacters: 0,
            AppStrings.killedCitizens: 0,
            AppStrings.killedMafias: 0,
            AppStrings.aliveUntilChange: 0,
            AppStrings.killedCitizensAfterChange: 0,
            AppStrings.rolePoints: 0,
            AppStrings.killedMafiasBeforeChange: 0,
            AppStrings.killedKillerBeforeChange: 0,
            AppStrings.pointsIfWonGame: 0,
            AppStrings.alivePoints: 0,
            AppStrings.pointsFromPresenter: 0,
            AppStrings.totalPoints: 0,
          },
        );

  @override
  Werewolf copyWith({
    String? name,
    int? roleId,
    Map<String, int>? points,
  }) =>
      Werewolf(
        name: name ?? this.name,
        roleId: roleId ?? this.roleId,
        points: points ?? this.points,
      );

  factory Werewolf.fromJson(Map<String, dynamic> json) =>
      _$WerewolfFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$WerewolfToJson(this);

  @override
  List<Object?> get props => <Object?>[
        name,
        roleId,
        points,
      ];

  @override
  bool get stringify => true;
}
