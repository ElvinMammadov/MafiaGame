part of game;

@JsonSerializable()
class Role extends Equatable {
  final String name;

  const Role(this.name);

  const Role.empty() : this('');

  Role copyWith({
    String? name,
  }) =>
      Role(
        name ?? this.name,
      );

  factory Role.fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);

  Map<String, dynamic> toJson() => _$RoleToJson(this);

  @override
  List<Object?> get props => <Object?>[name];

  @override
  bool get stringify => true;
}
