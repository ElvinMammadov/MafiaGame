part of game;

@JsonSerializable()
class Virus extends Role with EquatableMixin {
  const Virus({
    required String name,
    required int roleId,
  }) : super(name, roleId: roleId);

  const Virus.empty() : this(name: 'Virus', roleId: 8);

  @override
  Virus copyWith({
    String? name,
    int? roleId,
  }) =>
      Virus(
        name: name ?? this.name,
        roleId: roleId?? this.roleId,
      );

  factory Virus.fromJson(Map<String, dynamic> json) => _$VirusFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$VirusToJson(this);

  @override
  List<Object?> get props => <Object?>[
    name,
    roleId,
  ];

  @override
  bool get stringify => true;
}
