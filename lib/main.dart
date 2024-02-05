import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mafia_game/firebase_options.dart';
import 'package:mafia_game/utils/navigator.dart';
import 'package:mafia_game/utils/theme/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => const MafiaTheme(
    child: MaterialApp(
        title: 'M Legends',
        onGenerateRoute: AppNavigator.generateRoute,
        initialRoute: AppNavigator.loginPage,
      ),
  );
}
