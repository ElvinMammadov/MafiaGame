part of game;

@JsonSerializable()
class Virus extends Role with EquatableMixin {
  const Virus({
    required super.name,
    required super.roleId,
    required super.points,
  });

  const Virus.empty()
      : this(
          name: 'Virus',
          roleId: 8,
          points: const <String, int>{
            AppStrings.votedAgainstMafia: 0,
            AppStrings.votedAgainstMainCharacters: 0,
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
    int? roleId,
    Map<String, int>? points,
  }) =>
      Virus(
        name: name ?? this.name,
        roleId: roleId ?? this.roleId,
        points: points ?? this.points,
      );

  factory Virus.fromJson(Map<String, dynamic> json) => _$VirusFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$VirusToJson(this);

  @override
  List<Object?> get props => <Object?>[
        name,
        roleId,
        points,
      ];

  @override
  bool get stringify => true;
}
