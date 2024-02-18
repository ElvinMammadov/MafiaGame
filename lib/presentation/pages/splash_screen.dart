import 'package:flutter/material.dart';
import 'package:mafia_game/presentation/widgets/app_bar.dart';
import 'package:mafia_game/utils/app_strings.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const Scaffold(
        appBar: DefaultAppBar(
          title: AppStrings.title,
        ),
        body: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background.png'),
              fit: BoxFit.fill,
            ),
          ),
        ),
      );
}
