part of auth;

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

class InitialAuthenticationState extends AuthenticationState {
  @override
  List<Object?> get props => <Object?>[];
}

class AuthenticatedState extends AuthenticationState {
  final AppState appState;

  const AuthenticatedState(this.appState);

  @override
  List<Object?> get props => <Object?>[appState];
}

class UnauthenticatedState extends AuthenticationState {
  @override
  List<Object?> get props => <Object?>[];
}

class LoadingState extends AuthenticationState {
  @override
  List<Object?> get props => <Object?>[];
}

class ErrorState extends AuthenticationState {
  final String errorMessage;

  const ErrorState(this.errorMessage);

  @override
  List<Object?> get props => <Object?>[errorMessage];
}
