import 'package:equatable/equatable.dart';

class Gamer extends Equatable {
  final String? name;
  final String? role;
  final String? imageUrl;
  final int? id;

  const Gamer({
    this.name,
    this.role,
    this.imageUrl,
    this.id,
  });

  const Gamer.empty()
      : name = '',
        role = '',
        imageUrl = '',
        id = 0;

  Gamer copyWith({
    String? name,
    String? role,
    String? imageUrl,
    int? id,
  }) =>
      Gamer(
        name: name ?? this.name,
        role: role ?? this.role,
        imageUrl: imageUrl ?? this.imageUrl,
        id: id ?? this.id,
      );

  @override
  List<Object?> get props => <Object?>[
        name,
        role,
        imageUrl,
        id,
      ];

  @override
  String toString() => 'Gamer'
      '{name: $name, role: $role,'
      ' imageUrl: $imageUrl}, id: $id}';
}
