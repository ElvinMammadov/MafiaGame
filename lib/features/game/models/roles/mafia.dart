part of game;

@JsonSerializable()
class Mafia extends Role with EquatableMixin {
  final Map<String, int>? points;

  const Mafia({
    required super.name,
    required super.roleId,
    this.points,
  });

  const Mafia.empty()
      : this(
          name: 'Mafia',
          roleId: 2,
    points: const <String, int>{
      AppStrings.totalPoints: 0,
      AppStrings.alivePoints: 0,
      AppStrings.votedAgainstMafia: 0,
      AppStrings.votedAgainstMainCharacters: 0,
      AppStrings.votedAgainstOthers: 0,
      AppStrings.deadMafiaPoints: 0,
    },
        );

  @override
  Mafia copyWith({
    String? name,
    int? roleId,
    Map<String, int>? points,
  }) =>
      Mafia(
        name: name ?? this.name,
        roleId: roleId ?? this.roleId,
        points: points ?? this.points,
      );

  factory Mafia.fromJson(Map<String, dynamic> json) => _$MafiaFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MafiaToJson(this);

  @override
  List<Object?> get props => <Object?>[
        name,
        roleId,
        points,
      ];

  @override
  bool get stringify => true;
}
