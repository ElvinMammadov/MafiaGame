part of auth;

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class AppStarted extends AuthenticationEvent {
  @override
  List<Object?> get props => <Object?>[];
}

class UserLoggedIn extends AuthenticationEvent {
  final AppState appState;

  const UserLoggedIn(this.appState);

  @override
  List<Object?> get props => <Object?>[appState];
}

class UserLoggedOut extends AuthenticationEvent {
  @override
  List<Object?> get props => <Object?>[];
}

class SignUpRequested extends AuthenticationEvent {
  final String email;
  final String password;

  const SignUpRequested(this.email, this.password);

  @override
  List<Object?> get props => <Object?>[email, password];
}

class SignInRequested extends AuthenticationEvent {
  final String email;
  final String password;

  const SignInRequested(this.email, this.password);

  @override
  List<Object?> get props => <Object?>[email, password];
}

class SignOutRequested extends AuthenticationEvent {
  @override
  List<Object?> get props => <Object?>[];
}
