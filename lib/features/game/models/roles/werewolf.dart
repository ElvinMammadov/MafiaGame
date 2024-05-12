part of game;

@JsonSerializable()
class Werewolf extends Role with EquatableMixin {
  const Werewolf({
    required super.name,
    required super.roleId,
  });

  const Werewolf.empty()
      : this(
          name: 'Werewolf',
          roleId: 7,
        );

  @override
  Werewolf copyWith({
    String? name,
    int? roleId,
  }) =>
      Werewolf(
        name: name ?? this.name,
        roleId: roleId?? this.roleId,
      );

  factory Werewolf.fromJson(Map<String, dynamic> json) =>
      _$WerewolfFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$WerewolfToJson(this);

  @override
  List<Object?> get props => <Object?>[
        name,
        roleId,
      ];

  @override
  bool get stringify => true;
}
