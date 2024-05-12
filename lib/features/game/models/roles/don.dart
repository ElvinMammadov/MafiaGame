part of game;

@JsonSerializable()
class Don extends Role with EquatableMixin {
  const Don({
    required super.name,
    required super.roleId,
  });

  const Don.empty() : this(name: 'Don', roleId: 3);

  @override
  Don copyWith({
    String? name,
    int? roleId,
  }) =>
      Don(
        name: name ?? this.name,
        roleId: roleId ?? this.roleId,
      );

  factory Don.fromJson(Map<String, dynamic> json) => _$DonFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DonToJson(this);

  @override
  List<Object?> get props => <Object?>[
    name,
    roleId,
  ];

  @override
  bool get stringify => true;
}
