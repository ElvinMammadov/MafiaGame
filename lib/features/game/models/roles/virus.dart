part of game;

@JsonSerializable()
class Virus extends Role with EquatableMixin {
  final Map<String, int>? points;

  const Virus({
    required super.name,
    required super.roleId,
    this.points,
  });

  const Virus.empty()
      : this(
          name: 'Virus',
          roleId: 8,
          points: const <String, int>{
            AppStrings.totalPoints: 0,
            AppStrings.alivePoints: 0,
            AppStrings.votesForMafia: 0,
            AppStrings.votesForCitizen: 0,
            AppStrings.infectedCitizens: 0,
            AppStrings.infectedMafia: 0,
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
