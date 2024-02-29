import 'package:equatable/equatable.dart';

class Gamer extends Equatable {
  final String? name;
  final String? role;
  final String? imageUrl;

  const Gamer({
     this.name,
     this.role,
     this.imageUrl,
  });

  const Gamer.empty()
      : name = '',
        role = '',
        imageUrl = '';

  Gamer copyWith({
    String? name,
    String? role,
    String? imageUrl,
  }) =>
      Gamer(
        name: name ?? this.name,
        role: role ?? this.role,
        imageUrl: imageUrl ?? this.imageUrl,
      );

  @override
  List<Object?> get props => <Object?>[name, role, imageUrl];

  @override
  String toString() => 'Gamer'
      '{name: $name, role: $role,'
      ' imageUrl: $imageUrl}';
}
