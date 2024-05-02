part of game;

@JsonSerializable()
class Medium extends Role with EquatableMixin {
  const Medium({
    required String name,
    required int roleId,
  }) : super(name, roleId: roleId);

  const Medium.empty() : this(name: 'Medium', roleId: 12);

  @override
  Medium copyWith({
    String? name,
    int? roleId,
  }) =>
      Medium(
        name: name ?? this.name,
        roleId: roleId?? this.roleId,
      );

  factory Medium.fromJson(Map<String, dynamic> json) => _$MediumFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MediumToJson(this);

  @override
  List<Object?> get props => <Object?>[
    name,
    roleId,
  ];

  @override
  bool get stringify => true;
}
