import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mafia_game/features/auth/auth.dart';
import 'package:mafia_game/features/bloc/multibloc_provider.dart';
import 'package:mafia_game/firebase_options.dart';
import 'package:mafia_game/mains/config.dart';
import 'package:mafia_game/presentation/pages/auth/login/login_page.dart';
import 'package:mafia_game/presentation/pages/home/home.dart';
import 'package:mafia_game/presentation/pages/splash_screen.dart';
import 'package:mafia_game/utils/navigator.dart';
import 'package:mafia_game/utils/theme/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  AppConfig.create(
    gameFirebase: 'game',
    gamerFirebase: 'gamers',
    flavor: Flavor.prod,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) => MultiBlocProviderWidget(
        child: MaterialApp(
          title: 'M Legends',
          theme: MafiaTheme.themeData,
          onGenerateRoute: AppNavigator.generateRoute,
          localizationsDelegates: const <LocalizationsDelegate<Object>>[
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const <Locale>[
            Locale('en', 'GB'), // English, UK
            Locale('ru', 'RU'), // Arabic, UAE
          ],
          home: const AuthenticationChecker(),
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
