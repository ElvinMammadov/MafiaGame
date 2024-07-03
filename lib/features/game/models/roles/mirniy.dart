part of game;

@JsonSerializable()
class Mirniy extends Role with EquatableMixin {
  const Mirniy({
    required super.name,
    required super.roleId,
    required super.points,
  });

  const Mirniy.empty()
      : this(
          name: 'Mirniy',
          roleId: 11,
          points: const <String, int>{
            AppStrings.votedAgainstMafia: 0,
            AppStrings.votedAgainstMainCharacters: 0,
            AppStrings.votesForDon: 0,
            AppStrings.pointIfDeadByWin: 0,
            AppStrings.alivePoints: 0,
            AppStrings.totalPoints: 0,
          },
        );

  @override
  Mirniy copyWith({
    String? name,
    int? roleId,
    Map<String, int>? points,
  }) =>
      Mirniy(
        name: name ?? this.name,
        roleId: roleId ?? this.roleId,
        points: points ?? this.points,
      );

  factory Mirniy.fromJson(Map<String, dynamic> json) => _$MirniyFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MirniyToJson(this);

  @override
  List<Object?> get props => <Object?>[
        name,
        roleId,
        points,
      ];

  @override
  bool get stringify => true;
}
