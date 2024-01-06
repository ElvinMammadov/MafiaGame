import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mafia_game/utils/app_strings.dart';
import 'package:mafia_game/utils/navigator.dart';
import 'package:mafia_game/presentation/widgets/app_bar.dart';
import 'package:mafia_game/presentation/validators/validators.dart'; // Import Validators

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Add GlobalKey for the Form

  Future<void> _signInWithEmailAndPassword() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      // Navigate to the next screen upon successful login
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NextScreen()));
    } catch (e) {
      print("Error during login: $e");
      // Handle login errors (show a snackbar, etc.)
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: const DefaultAppBar(
      title: AppStrings.title,
      showBackButton: false,
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Card(
          elevation: 8.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: AppStrings.email,
                      icon: Icon(Icons.email),
                    ),
                    validator: Validators.validateEmail,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: AppStrings.password,
                      icon: Icon(Icons.lock),
                    ),
                    obscureText: true,
                    validator: Validators.validatePassword,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _signInWithEmailAndPassword();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Text(
                        AppStrings.loginButton,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      AppNavigator.navigateToSignupPage(context);
                    },
                    child: const Text(AppStrings.noAccount),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
