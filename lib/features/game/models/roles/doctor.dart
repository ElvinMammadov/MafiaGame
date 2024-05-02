part of game;

@JsonSerializable()
class Doctor extends Role with EquatableMixin {
  final int healCount;

  const Doctor({
    required String name,
    required int roleId ,
    required this.healCount ,
  }) : super(name, roleId: roleId);

  const Doctor.empty() : this(name: 'Doktor', healCount: 2, roleId: 1);

  @override
  Doctor copyWith({
    String? name,
    int? healCount,
    int? roleId,
  }) =>
      Doctor(
        name: name ?? this.name,
        roleId: roleId?? this.roleId,
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
