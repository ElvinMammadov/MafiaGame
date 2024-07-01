part of game;

@JsonSerializable()
class Advokat extends Role with EquatableMixin {
  final Map<String, int>? points;

  const Advokat({
    required super.name,
    required super.roleId,
    this.points,
  });

  const Advokat.empty()
      : this(
          name: 'Advokat',
          roleId: 9,
          points: const <String, int>{
            AppStrings.totalPoints: 0,
            AppStrings.alivePoints: 0,
            AppStrings.votesForMafia: 0,
            AppStrings.votesForCitizen: 0,
            AppStrings.gaveAlibiToCitizen: 0,
            AppStrings.gaveAlibiToMafia: 0,
            AppStrings.citizenAlibiWorked: 0,
            AppStrings.mafiaAlibiWorked: 0,
          },
        );

  @override
  Advokat copyWith({
    String? name,
    int? roleId,
    Map<String, int>? points,
  }) =>
      Advokat(
        name: name ?? this.name,
        roleId: roleId ?? this.roleId,
        points: points ?? this.points,
      );

  factory Advokat.fromJson(Map<String, dynamic> json) =>
      _$AdvokatFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AdvokatToJson(this);

  @override
  List<Object?> get props => <Object?>[
        name,
        roleId,
        points,
      ];

  @override
  bool get stringify => true;
}
