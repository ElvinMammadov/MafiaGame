import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mafia_game/features/auth/auth.dart';
import 'package:mafia_game/firebase_options.dart';
import 'package:mafia_game/presentation/pages/auth/login/login_page.dart';
import 'package:mafia_game/presentation/pages/home/home.dart';
import 'package:mafia_game/presentation/pages/splash_screen.dart';
import 'package:mafia_game/utils/navigator.dart';
import 'package:mafia_game/utils/theme/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AuthenticationBloc _authenticationBloc;
  final UserRepository userRepository = UserRepository();

  @override
  void initState() {
    super.initState();
    _authenticationBloc = AuthenticationBloc(userRepository);
    _authenticationBloc.add(AppStarted());
  }

  @override
  void dispose() {
    _authenticationBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      BlocProvider<AuthenticationBloc>(
        create: (BuildContext context) => _authenticationBloc,
        child: const MafiaTheme(
          child: MaterialApp(
            title: 'M Legends',
            onGenerateRoute: AppNavigator.generateRoute,
            home: AuthenticationChecker(),
          ),
        ),
      );
}

class AuthenticationChecker extends StatelessWidget {
  const AuthenticationChecker({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (BuildContext context, AuthenticationState state) {
          if (state is AuthenticatedState) {
            return const HomeScreen();
          } else if (state is UnauthenticatedState) {
            return const LoginPage();
          } else {
            return SplashScreen();
          }
        },
      );
}
