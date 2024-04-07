part of app;

@JsonSerializable()
class UserState extends Equatable {
  final String? id;
  final String? email;
  final String? displayName;
  final int? token;
  final String accessToken;
  final String? password;

  const UserState({
    this.id,
    this.email,
    this.displayName,
    this.token,
    this.password,
    this.accessToken = '',
  });

  const UserState.empty() : this();

  UserState copyWith({
    bool? isVerified,
    String? uid,
    String? email,
    String? password,
    int? token,
    String? accessToken,
    String? displayName,
    int? age,
  }) =>
      UserState(
        id: uid ?? id,
        email: email ?? this.email,
        password: password ?? this.password,
        displayName: displayName ?? this.displayName,
        token: token ?? this.token,
        accessToken: accessToken ?? this.accessToken,
        // isVerified: isVerified ?? this.isVerified
      );

  factory UserState.fromMap(Map<String, dynamic> json) =>
      _$UserStateFromJson(json);

  Map<String, dynamic> toMap() => _$UserStateToJson(this);

  @override
  List<Object?> get props => <Object?>[
        id,
        email,
        displayName,
        token,
        password,
        accessToken,
      ];

  @override
  String toString() =>
      'UserState { id: $id, email: $email, displayName: $displayName,'
      ' token: $token, password: $password, accessToken: $accessToken,}';
}
