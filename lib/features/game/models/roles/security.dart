part of game;

@JsonSerializable()
class Security extends Role with EquatableMixin {
  const Security({
    required super.name,
    required super.roleId,
  });

  const Security.empty()
      : this(
          name: 'Security',
          roleId: 10,
        );

  @override
  Security copyWith({
    String? name,
    int? roleId,
  }) =>
      Security(
        name: name ?? this.name,
        roleId: roleId?? this.roleId,
      );

  factory Security.fromJson(Map<String, dynamic> json) =>
      _$SecurityFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SecurityToJson(this);

  @override
  List<Object?> get props => <Object?>[
        name,
        roleId,
      ];

  @override
  bool get stringify => true;
}
