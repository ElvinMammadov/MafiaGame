part of auth;

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;

  AuthenticationBloc(this._authenticationRepository)
      : super(InitialAuthenticationState()) {
    on<AppStarted>((AppStarted event, Emitter<AuthenticationState> emit) async {
      try {
        final bool isSignedIn = await _authenticationRepository.isSignedIn();
        if (isSignedIn) {
          final Stream<UserModel> userStream =
              _authenticationRepository.getCurrentUser();
          final UserModel user = await userStream.first;
          final AppState appState = AppState(
            user: UserState(
              id: user.id,
              email: user.email,
              displayName: user.displayName,
              token: user.token,
              password: user.password,
              accessToken: user.accessToken,
            ),
          );
          emit( AuthenticatedState(appState));
        } else {
          emit(UnauthenticatedState());
        }
      } catch (e) {
        emit(ErrorState('Error checking sign-in status: $e'));
      }
    });

    on<SignInRequested>(
        (SignInRequested event, Emitter<AuthenticationState> emit) async {
      // emit(LoadingState());
      try {
        final UserModel? user = await _authenticationRepository.signIn(
          UserModel(
            email: event.email,
            password: event.password,
          ),
        );
        if (user != null) {
          final AppState appState = AppState(
            user: UserState(
              id: user.id,
              email: user.email,
              displayName: user.displayName,
              token: user.token,
              password: user.password,
              accessToken: user.accessToken,
            ),
          );
          emit( AuthenticatedState(appState));
        } else {
          emit(UnauthenticatedState());
        }
      } catch (e) {
        emit(ErrorState('Error signing in: $e'));
        emit(UnauthenticatedState());
      }
    });

    on<SignOutRequested>(
        (SignOutRequested event, Emitter<AuthenticationState> emit) async {
      emit(LoadingState());
      try {
        await _authenticationRepository.signOut();
        emit(UnauthenticatedState());
      } catch (e) {
        emit(ErrorState('Error signing out: $e'));
      }
    });

    on<SignUpRequested>(
        (SignUpRequested event, Emitter<AuthenticationState> emit) async {
      emit(LoadingState());
      try {
        final UserModel? user = await _authenticationRepository.signUp(
          UserModel(
            email: event.email,
            password: event.password,
          ),
        );
        if (user != null) {
          final AppState appState = AppState(
            user: UserState(
              id: user.id,
              email: user.email,
              displayName: user.displayName,
              token: user.token,
              password: user.password,
              accessToken: user.accessToken,
            ),
          );
          emit( AuthenticatedState(appState));
        } else {
          emit(UnauthenticatedState());
        }
      } catch (e) {
        emit(ErrorState('Error signing up: $e'));
      }
    });
  }
}
