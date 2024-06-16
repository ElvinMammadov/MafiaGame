import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mafia_game/features/auth/auth.dart';
import 'package:mafia_game/presentation/pages/auth/login/login_form.dart';
import 'package:mafia_game/presentation/widgets/app_bar.dart';
import 'package:mafia_game/utils/app_strings.dart';
import 'package:mafia_game/utils/navigator.dart';
import 'package:mafia_game/utils/theme/theme.dart';
import 'package:styled_widget/styled_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: const DefaultAppBar(
      title: AppStrings.title,
    ),
    body: DecoratedBox(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: SizedBox.expand(
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
            TextButton(
              onPressed: () {
                AppNavigator.navigateToSignupPage(context);
              },
              style: TextButton.styleFrom(
                foregroundColor:
                    MafiaTheme.themeData.colorScheme.secondary,
              ),
              child: const Text(
                AppStrings.noAccount,
              ),
            ),
          ],
        ).padding(
          top: 16.0,
          bottom: 300.0,
        ),
      ),
    ),
  );

  Future<void> _signInWithEmailAndPassword() async {
    if (_formKey.currentState?.validate() ?? false) {
      // try {
      BlocProvider.of<AuthenticationBloc>(context).add(
        SignInRequested(
          _emailController.text.trim(),
          _passwordController.text,
        ),
      );
      //     final UserCredential userCredential =
      //         await _auth.signInWithEmailAndPassword(
      //       email: _emailController.text.trim(),
      //       password: _passwordController.text,
      //     );
      //
      //     final User? user = userCredential.user;
      //
      //     if (user != null) {
      //       ScaffoldMessenger.of(context).showSnackBar(
      //         const SnackBar(
      //           content: Text(AppStrings.loginSuccessful),
      //           duration: Duration(seconds: 2),
      //           backgroundColor: Colors.green,
      //         ),
      //       );
      //
      //       AppNavigator.navigateToHomeScreen(context);
      //       print('User signed in: ${user.uid}');
      //       print('User signed in: ${user}');
      //     } else {
      //       print('User does not exist');
      //     }
      //   } on FirebaseAuthException catch (e) {
      //     // Handle login errors
      //     print("Error during login: $e");
      //
      //     if (e.code == 'user-not-found') {
      //       print('User does not exist');
      //       ScaffoldMessenger.of(context).showSnackBar(
      //         const SnackBar(
      //           content: Text(AppStrings.userDoesNotExist),
      //           duration: Duration(seconds: 2),
      //           backgroundColor: Colors.red,
      //         ),
      //       );
      //     } else if (e.code == 'wrong-password') {
      //       // Password is incorrect
      //       print('Wrong password');
      //       ScaffoldMessenger.of(context).showSnackBar(
      //         const SnackBar(
      //           content: Text(AppStrings.wrongPassword),
      //           duration: Duration(seconds: 2),
      //           backgroundColor: Colors.red,
      //         ),
      //       );
      //     } else {
      //       // Handle other FirebaseAuthExceptions as needed
      //       print('Other login error: $e');
      //     }
      //   } catch (e) {
      //     // Handle other exceptions
      //     print('General login error: $e');
      //   }
      // } else {
      //   print('Form is not valid');
      // }
    }
  }
}
