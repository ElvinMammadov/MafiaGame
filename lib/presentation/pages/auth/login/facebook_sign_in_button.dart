import 'package:flutter/material.dart';

class FacebookSignInButton extends StatelessWidget {
  const FacebookSignInButton({Key? key, required this.onSignIn})
      : super(key: key);

  final VoidCallback onSignIn;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 250,
    height: 40,
    child: ElevatedButton.icon(
      onPressed: onSignIn,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      icon: const Icon(Icons.facebook),
      label: const Text(
        'Sign in with Facebook',
        style: TextStyle(fontSize: 18),
      ),
    ),
  );
}

