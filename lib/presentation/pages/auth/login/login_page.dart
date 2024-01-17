import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:mafia_game/presentation/widgets/app_bar.dart';
import 'package:mafia_game/presentation/pages/auth/login/login_form.dart';
import 'package:mafia_game/presentation/pages/auth/login/facebook_sign_in_button.dart';
import 'package:mafia_game/utils/navigator.dart';
import 'package:mafia_game/utils/app_strings.dart';
import 'package:mafia_game/presentation/widgets/resource.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  Future<void> _signInWithEmailAndPassword() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        final UserCredential userCredential =
        await _auth.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );

        final User? user = userCredential.user;

        if (user != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(AppStrings.loginSuccessful),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.green,
            ),
          );

          // Navigate to the HomeScreen upon successful login
          AppNavigator.navigateToHomeScreen(context);
          print('User signed in: ${user.uid}');
        } else {
          print('User does not exist');
        }
      } on FirebaseAuthException catch (e) {
        // Handle login errors
        print("Error during login: $e");

        if (e.code == 'user-not-found') {
          print('User does not exist');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(AppStrings.userDoesNotExist),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.red,
            ),
          );
        } else if (e.code == 'wrong-password') {
          // Password is incorrect
          print('Wrong password');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(AppStrings.wrongPassword),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.red,
            ),
          );
        } else {
          // Handle other FirebaseAuthExceptions as needed
          print('Other login error: $e');
        }
      } catch (e) {
        // Handle other exceptions
        print('General login error: $e');
      }
    } else {
      print('Form is not valid');
    }
  }

  Future<Resource?> _signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      switch (result.status) {
        case LoginStatus.success:
          final AuthCredential facebookCredential =
          FacebookAuthProvider.credential(result.accessToken!.token);
          final UserCredential userCredential =
          await _auth.signInWithCredential(facebookCredential);
          return Resource(status: Status.Success);
        case LoginStatus.cancelled:
          return Resource(status: Status.Cancelled);
        case LoginStatus.failed:
          return Resource(status: Status.Error);
        default:
          return null;
      }
    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: const DefaultAppBar(
      title: AppStrings.title,
      showBackButton: false,
    ),
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 450.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                LoginForm(
                  formKey: _formKey,
                  emailController: _emailController,
                  passwordController: _passwordController,
                  isPasswordVisible: _isPasswordVisible,
                  onSignIn: _signInWithEmailAndPassword,
                  onTogglePasswordVisibility: _togglePasswordVisibility,
                ),
                const SizedBox(height: 16),
                const Text(
                  AppStrings.or,
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 16),
                FacebookSignInButton(onSignIn: _signInWithFacebook),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    AppNavigator.navigateToSignupPage(context);
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.blue,
                  ),
                  child: const Text(
                    AppStrings.noAccount,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
