import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mafia_game/utils/app_strings.dart';
import 'package:mafia_game/presentation/widgets/app_bar.dart';
import 'package:mafia_game/presentation/validators/validators.dart'; // Import Validators

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Add GlobalKey for the Form

  Future<void> _signUpWithEmailAndPassword() async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      // Navigate to the next screen upon successful signup
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NextScreen()));
    } catch (e) {
      print("Error during signup: $e");
      // Handle signup errors (show a snackbar, etc.)
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
              key: _formKey, // Assign the key to the Form
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: AppStrings.email,
                      icon: Icon(Icons.email),
                    ),
                    validator: Validators.validateEmail, // Use the email validator
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: AppStrings.password,
                      icon: Icon(Icons.lock),
                    ),
                    obscureText: true,
                    validator: Validators.validatePassword, // Use the password validator
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        // Validate the form before signing up
                        if (_formKey.currentState!.validate()) {
                          _signUpWithEmailAndPassword();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        // Change the button color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Text(
                        AppStrings.signUpButton,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      // Navigate to the login page
                      Navigator.pop(context);
                    },
                    child: const Text(
                      AppStrings.haveAccount,
                    ),
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
