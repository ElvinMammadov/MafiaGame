part of game;

@JsonSerializable()
class Doctor extends Role with EquatableMixin {
  final int healCount;

  const Doctor({
    required super.name,
    required super.roleId,
    required this.healCount,
  });

  const Doctor.empty() : this(name: 'Doktor', healCount: 2, roleId: 1);

  @override
  Doctor copyWith({
    String? name,
    int? healCount,
    int? roleId,
  }) =>
      Doctor(
        name: name ?? this.name,
        roleId: roleId ?? this.roleId,
        healCount: healCount ?? this.healCount,
      );

  factory Doctor.fromJson(Map<String, dynamic> json) => _$DoctorFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DoctorToJson(this);

  @override
  List<Object?> get props => <Object?>[
        name,
        roleId,
        healCount,
      ];

  @override
  bool get stringify => true;
}
