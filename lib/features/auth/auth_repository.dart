part of auth;

class UserRepository implements AuthenticationRepository {
  final AuthenticationService service = AuthenticationService();

  @override
  Stream<UserModel> getCurrentUser() {
    try {
      return service.retrieveCurrentUser();
    } catch (e) {
      // Handle error gracefully, e.g., log the error
      print('Error retrieving current user: $e');
      rethrow;
    }
  }

  @override
  Future<UserModel?> signUp(UserModel user) async {
    try {
      return await service.signUp(user);
    } on FirebaseAuthException catch (e) {
      // Handle FirebaseAuthException
      print('FirebaseAuthException during sign up: ${e.code}, ${e.message}');
      rethrow;
    } catch (e) {
      // Handle other exceptions
      print('Error during sign up: $e');
      rethrow;
    }
  }

  @override
  Future<UserModel?> signIn(UserModel user) async {
    try {
      return await service.signIn(user);
    } on FirebaseAuthException catch (e) {
      // Handle FirebaseAuthException
      print('FirebaseAuthException during sign in: ${e.code}, ${e.message}');
      rethrow;
    } catch (e) {
      // Handle other exceptions
      print('Error during sign in: $e');
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await service.signOut();
    } catch (e) {
      // Handle error gracefully, e.g., log the error
      print('Error during sign out: $e');
      rethrow;
    }
  }

  @override
  Future<String?> retrieveUserName(UserModel user) {
    // You can implement this method if needed
    throw UnimplementedError();
  }

  @override
  Future<bool> isSignedIn() async {
    final User? currentUser = service.auth.currentUser;
    return currentUser != null;
  }
}

abstract class AuthenticationRepository {
  Stream<UserModel> getCurrentUser();

  Future<UserModel?> signUp(UserModel user);

  Future<UserModel?> signIn(UserModel user);

  Future<void> signOut();

  Future<String?> retrieveUserName(UserModel user);

  Future<bool> isSignedIn();
}
