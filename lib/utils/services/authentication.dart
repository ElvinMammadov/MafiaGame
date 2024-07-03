import 'package:firebase_auth/firebase_auth.dart';
import 'package:mafia_game/features/auth/models/user.dart';

class AuthenticationService {
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<UserModel> retrieveCurrentUser() =>
      auth.authStateChanges().map((User? user) {
        if (user != null) {
          return UserModel(id: user.uid, email: user.email);
        } else {
          return const UserModel(id: "uid");
        }
      });

  Future<UserModel?> signUp(UserModel user) async {
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user.email!,
        password: user.password!,
      );
      verifyEmail();
      return UserModel(id: userCredential.user!.uid, email: user.email);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }

  Future<UserModel?> signIn(UserModel user) async {
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: user.email!,
        password: user.password!,
      );
      return UserModel(id: userCredential.user!.uid, email: user.email);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }

  Future<void> verifyEmail() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null && !user.emailVerified) {
      return user.sendEmailVerification();
    }
  }

  Future<void> signOut() async => FirebaseAuth.instance.signOut();
}
