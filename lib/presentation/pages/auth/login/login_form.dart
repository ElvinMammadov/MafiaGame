import 'package:flutter/material.dart';
import 'package:mafia_game/presentation/validators/validators.dart';
import 'package:mafia_game/utils/app_strings.dart';
import 'package:mafia_game/utils/theme/theme.dart';

class LoginForm extends StatefulWidget {
  LoginForm({
    super.key,
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
        _isPasswordVisible = isPasswordVisible;

  final GlobalKey<FormState> _formKey;
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
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
  Widget build(BuildContext context) => SizedBox(
        width: 550,
        child: Card(
          color: Colors.transparent,
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
                    style: MafiaTheme.themeData.textTheme.headlineSmall,
                    keyboardType: TextInputType.emailAddress,
                    focusNode: widget._emailFocusNode,
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: AppStrings.email,
                      labelStyle: MafiaTheme.themeData.textTheme.headlineSmall,
                      icon: Icon(
                        Icons.email,
                        color: MafiaTheme.themeData.colorScheme.secondary,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: MafiaTheme.themeData.colorScheme.secondary,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: MafiaTheme.themeData.colorScheme.secondary,
                        ),
                      ),
                      errorStyle: MafiaTheme.themeData.textTheme.labelLarge,
                    ),
                    onFieldSubmitted: (_) {
                      FocusScope.of(context)
                          .requestFocus(widget._passwordFocusNode);
                    },
                    validator: Validator.validateEmail,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: widget._passwordController,
                    style: MafiaTheme.themeData.textTheme.headlineSmall,
                    focusNode: widget._passwordFocusNode,
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: AppStrings.password,
                      labelStyle: MafiaTheme.themeData.textTheme.headlineSmall,
                      icon: Icon(
                        Icons.lock,
                        color: MafiaTheme.themeData.colorScheme.secondary,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: MafiaTheme.themeData.colorScheme.secondary,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: MafiaTheme.themeData.colorScheme.secondary,
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          widget._isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: MafiaTheme.themeData.colorScheme.secondary,
                        ),
                        onPressed: widget.onTogglePasswordVisibility,
                      ),
                      errorStyle: MafiaTheme.themeData.textTheme.labelLarge,
                    ),
                    obscureText: !widget._isPasswordVisible,
                    validator: Validator.validatePassword,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 300,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _loginButtonPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MafiaTheme
                            .themeData.colorScheme.secondary
                            .withOpacity(0.8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                      ),
                      child: _isLoading
                          ? CircularProgressIndicator(
                              color: MafiaTheme.themeData.colorScheme.surface,
                            )
                          : Text(
                              AppStrings.loginButton,
                              style:
                                  MafiaTheme.themeData.textTheme.headlineSmall,
                            ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
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
