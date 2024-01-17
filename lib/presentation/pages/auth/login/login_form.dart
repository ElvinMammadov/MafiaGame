import 'package:flutter/material.dart';
import 'package:mafia_game/presentation/validators/validators.dart';
import 'package:mafia_game/utils/app_strings.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
    required GlobalKey<FormState> formKey,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required bool isPasswordVisible,
    required Future<void> Function() onSignIn,
    required this.onTogglePasswordVisibility,
  })  : _onSignIn = onSignIn,
        _formKey = formKey,
        _emailController = emailController,
        _passwordController = passwordController,
        _isPasswordVisible = isPasswordVisible,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;
  final bool _isPasswordVisible;
  final Future<void> Function() _onSignIn;
  final VoidCallback onTogglePasswordVisibility;

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) => Card(
        elevation: 8.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: widget._formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  controller: widget._emailController,
                  decoration: const InputDecoration(
                    labelText: AppStrings.email,
                    icon: Icon(Icons.email, color: Colors.blue),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                  validator: Validator.validateEmail,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: widget._passwordController,
                  decoration: InputDecoration(
                    labelText: AppStrings.password,
                    icon: const Icon(Icons.lock, color: Colors.blue),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        widget._isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.blue,
                      ),
                      onPressed: widget.onTogglePasswordVisibility,
                    ),
                  ),
                  obscureText: !widget._isPasswordVisible,
                  validator: Validator.validatePassword,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _loginButtonPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            AppStrings.loginButton,
                            style: TextStyle(fontSize: 18),
                          ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      );

  Future<void> _loginButtonPressed() async {
    setState(() {
      _isLoading = true;
    });
    await widget._onSignIn();
    setState(() {
      _isLoading = false;
    });
  }
}
