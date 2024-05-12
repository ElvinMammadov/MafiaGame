part of game;

@JsonSerializable()
class Mirniy extends Role with EquatableMixin {
  const Mirniy({
    required super.name,
    required super.roleId,
  });

  const Mirniy.empty() : this(name: 'Mirniy', roleId: 11);

  @override
  Mirniy copyWith({
    String? name,
    int? roleId,
  }) =>
      Mirniy(
        name: name ?? this.name,
        roleId: roleId?? this.roleId,
      );

  factory Mirniy.fromJson(Map<String, dynamic> json) => _$MirniyFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MirniyToJson(this);

  @override
  List<Object?> get props => <Object?>[
        name,
        roleId,
      ];

  @override
  bool get stringify => true;
}
