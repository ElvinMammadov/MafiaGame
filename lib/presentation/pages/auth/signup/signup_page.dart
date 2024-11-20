import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mafia_game/presentation/pages/auth/signup/signup_form.dart';
import 'package:mafia_game/presentation/widgets/app_bar.dart';
import 'package:mafia_game/utils/app_strings.dart';
import 'package:mafia_game/utils/theme/theme.dart';
import 'package:styled_widget/styled_widget.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const DefaultAppBar(
          title: AppStrings.title,
          showBackButton: true,
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
                SignUpForm(
                  formKey: _formKey,
                  emailController: _emailController,
                  passwordController: _passwordController,
                  isPasswordVisible: _isPasswordVisible,
                  onSignIn: _signUpWithEmailAndPassword,
                  onTogglePasswordVisibility: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    // Navigate to the login page
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    foregroundColor:
                    MafiaTheme.themeData.colorScheme.secondary,
                  ),
                  child: const Text(
                    AppStrings.haveAccount,
                  ),
                ),
              ],
            ).padding(
              top: 16.0,
              bottom: 400.0,
            ),
          ),
        ),
      );

  Future<void> _signUpWithEmailAndPassword() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        setState(() {
          isLoading = true;
        });

        await _auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(AppStrings.youRegisteredSuccessfully),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.green,
          ),
        );

        // Navigate to the next screen upon successful signup
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        print("Error during signup: $e");

        // Handle signup errors (show a snackbar, etc.)
        if (e.code == 'email-already-in-use') {
          // Email is already registered
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(AppStrings.emailAlreadyInUse),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.red,
            ),
          );
        } else {
          // Handle other FirebaseAuthExceptions as needed
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(AppStrings.errorDuringSignup),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        // Handle other exceptions
        print('General signup error: $e');

        // Show a generic error message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(AppStrings.errorDuringSignup),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        // Set the loading state to false after signup
        setState(() {
          isLoading = false;
        });
      }
    } else {
      print('Form is not valid');
    }
  }
}
