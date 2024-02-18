import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String? id;
  final String? email;
  final String? displayName;
  final int? token;
  final String accessToken;
  final String? password;

  const UserModel({
    this.id,
    this.email,
    this.displayName,
    this.token,
    this.password,
    this.accessToken = '',
  });

  Map<String, dynamic> toMap() => <String, dynamic>{
        'email': email,
        'displayName': displayName,
        'token': token,
        'password': password,
        'accessToken': accessToken,
      };

  UserModel copyWith({
    bool? isVerified,
    String? uid,
    String? email,
    String? password,
    int? token,
    String? accessToken,
    String? displayName,
    int? age,
  }) =>
      UserModel(
        id: uid ?? id,
        email: email ?? this.email,
        password: password ?? this.password,
        displayName: displayName ?? this.displayName,
        token: token ?? this.token,
        accessToken: accessToken ?? this.accessToken,
        // isVerified: isVerified ?? this.isVerified
      );

  @override
  List<Object?> get props => <Object?>[
        id,
        email,
        displayName,
        token,
        password,
        accessToken,
      ];
}
