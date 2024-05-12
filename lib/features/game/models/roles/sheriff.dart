part of game;

@JsonSerializable()
class Sheriff extends Role with EquatableMixin {
  const Sheriff({
    required super.name,
    required super.roleId,
  });

  const Sheriff.empty()
      : this(
          name: 'Sheriff',
          roleId: 4,
        );

  @override
  Sheriff copyWith({
    String? name,
    int? roleId,
  }) =>
      Sheriff(
        name: name ?? this.name,
        roleId: roleId ?? this.roleId,
      );

  factory Sheriff.fromJson(Map<String, dynamic> json) =>
      _$SheriffFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SheriffToJson(this);

  @override
  List<Object?> get props => <Object?>[
        name,
        roleId,
      ];

  @override
  bool get stringify => true;
}
