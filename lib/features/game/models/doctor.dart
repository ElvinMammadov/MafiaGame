part of game;

@JsonSerializable()
class Doctor extends Role with EquatableMixin {
  final int healCount;

  const Doctor({
    required String name,
    int roleId = 0,
    this.healCount = 2,
  }) : super(name, roleId: roleId);

  const Doctor.empty() : this(name: '', healCount: 0);

  @override
  Doctor copyWith({
    String? name,
    int? healCount,
  }) =>
      Doctor(
        name: name ?? this.name,
        roleId: roleId,
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
