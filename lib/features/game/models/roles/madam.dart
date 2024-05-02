part of game;

@JsonSerializable()
class Madam extends Role with EquatableMixin {
  const Madam({
    required String name,
    required int roleId,
  }) : super(name, roleId: roleId);

  const Madam.empty() : this(name: 'Madam', roleId: 5);

  @override
  Madam copyWith({
    String? name,
    int? roleId,
  }) =>
      Madam(
        name: name ?? this.name,
        roleId: roleId?? this.roleId,
      );

  factory Madam.fromJson(Map<String, dynamic> json) => _$MadamFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MadamToJson(this);

  @override
  List<Object?> get props => <Object?>[
    name,
    roleId,
  ];

  @override
  bool get stringify => true;
}
