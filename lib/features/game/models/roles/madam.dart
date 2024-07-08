part of game;

@JsonSerializable()
class Madam extends Role with EquatableMixin {
  final Map<String, int>? points;

  const Madam({
    required super.name,
    required super.roleId,
    this.points,
  });

  const Madam.empty()
      : this(
          name: 'Madam',
          roleId: 5,
          points: const <String, int>{
            AppStrings.totalPoints: 0,
            AppStrings.alivePoints: 0,
            AppStrings.votesForMafia: 0,
            AppStrings.votesForCitizen: 0,
            AppStrings.entersToMafia: 0,
            AppStrings.entersToAnother: 0,
          },
        );

  @override
  Madam copyWith({
    String? name,
    int? roleId,
    Map<String, int>? points,
  }) =>
      Madam(
        name: name ?? this.name,
        roleId: roleId ?? this.roleId,
        points: points ?? this.points,
      );

  factory Madam.fromJson(Map<String, dynamic> json) => _$MadamFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MadamToJson(this);

  @override
  List<Object?> get props => <Object?>[
        name,
        roleId,
        points,
      ];

  @override
  bool get stringify => true;
}
