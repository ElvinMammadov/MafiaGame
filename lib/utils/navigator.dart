import 'package:flutter/material.dart';
import 'package:mafia_game/features/auth/auth.dart';
import 'package:mafia_game/presentation/pages/auth/login/login_page.dart';
import 'package:mafia_game/presentation/pages/auth/signup/signup_page.dart';
import 'package:mafia_game/presentation/pages/game/game.dart';
import 'package:mafia_game/presentation/pages/home/home.dart';

class AppNavigator {
  static const String loginPage = '/login';
  static const String signupPage = '/signup';
  static const String homeScreen = '/home';
  static const String tableScreen = '/table';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginPage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const LoginPage(),
          settings: const RouteSettings(name: loginPage),
        );
      case signupPage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const SignupPage(),
          settings: const RouteSettings(name: signupPage),
        );
      case homeScreen:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const HomeScreen(),
          settings: const RouteSettings(name: homeScreen),
        );

      case tableScreen:
        return MaterialPageRoute<dynamic>(
          builder: (_) => GameTableScreen(),
          settings: const RouteSettings(name: tableScreen),
        );
      default:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const LoginPage(),
          settings: const RouteSettings(name: loginPage),
        );
    }
  }

  void navigateToLoginPage(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      loginPage,
      (Route<dynamic> route) => false,
    );
  }

  static void navigateToTablePage(BuildContext context) {
    Navigator.pushNamed(
      context,
      tableScreen,
    );
  }

  static void navigateToSignupPage(BuildContext context) {
    Navigator.pushNamed(context, signupPage);
  }

  static void navigateToHomeScreen(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      homeScreen,
      (Route<dynamic> route) => false,
    );
  }

  void navigateBasedOnAuthenticationState(
    BuildContext context,
    AuthenticationState state,
  ) {
    if (state is AuthenticatedState) {
      navigateToHomeScreen(context);
    } else {
      navigateToLoginPage(context);
    }
  }
}
