part of game;

@JsonSerializable()
class Sheriff extends Role with EquatableMixin {
  const Sheriff({
    required super.name,
    required super.roleId,
    required super.points,
  });

  const Sheriff.empty()
      : this(
          name: 'Sheriff',
          roleId: 4,
          points: const <String, int>{
            AppStrings.votedAgainstMafia: 0,
            AppStrings.votedAgainstMainCharacters: 0,
            AppStrings.cityKillsMafia: 0,
            AppStrings.killedMafias: 0,
            AppStrings.entersToMafia: 0,
            AppStrings.alivePoints: 0,
            AppStrings.totalPoints: 0,
          },
        );

  @override
  Sheriff copyWith({
    String? name,
    int? roleId,
    Map<String, int>? points,
  }) =>
      Sheriff(
        name: name ?? this.name,
        roleId: roleId ?? this.roleId,
        points: points ?? this.points,
      );

  factory Sheriff.fromJson(Map<String, dynamic> json) =>
      _$SheriffFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SheriffToJson(this);

  @override
  List<Object?> get props => <Object?>[
        name,
        roleId,
        points,
      ];

  @override
  bool get stringify => true;
}
