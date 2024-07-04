part of game;

@JsonSerializable()
class Don extends Role with EquatableMixin {
  const Don({
    required super.name,
    required super.roleId,
    required super.points,
  });

  const Don.empty()
      : this(
          name: 'Don',
          roleId: 3,
          points: const <String, int>{
            AppStrings.votedAgainstMafia: 0,
            AppStrings.votedAgainstMainCharacters: 0,
            AppStrings.votedAgainstOthers: 0,
            AppStrings.deadMafiaPoints: 0,
            AppStrings.alivePoints: 0,
            AppStrings.pointsFromPresenter: 0,
            AppStrings.totalPoints: 0,
          },
        );

  @override
  Don copyWith({
    String? name,
    int? roleId,
    Map<String, int>? points,
  }) =>
      Don(
        name: name ?? this.name,
        roleId: roleId ?? this.roleId,
        points: points ?? this.points,
      );

  factory Don.fromJson(Map<String, dynamic> json) => _$DonFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DonToJson(this);

  @override
  List<Object?> get props => <Object?>[
        name,
        roleId,
        points,
      ];

  @override
  bool get stringify => true;
}
