import 'package:flutter/material.dart';
import 'package:mafia_game/presentation/pages/auth/login/login_page.dart';
import 'package:mafia_game/presentation/pages/auth/signup_page.dart';

class AppNavigator {
  static const String loginPage = '/login';
  static const String signupPage = '/signup';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginPage:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
          settings: const RouteSettings(name: loginPage),
        );
      case signupPage:
        return MaterialPageRoute(
          builder: (_) => const SignupPage(),
          settings: const RouteSettings(name: signupPage),
        );
      // Add more routes as needed
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }

  static void navigateToLoginPage(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
        context, loginPage, (Route route) => false);
  }

  static void navigateToSignupPage(BuildContext context) {
    Navigator.pushNamed(context, signupPage);
  }
}
