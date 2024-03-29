import 'package:equatable/equatable.dart';

class Role extends Equatable {
  final String name;

  const Role(this.name);

  @override
  List<Object?> get props => <Object?>[name];

  @override
  bool get stringify => true;
}
