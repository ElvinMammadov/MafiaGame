import 'package:flutter/material.dart';
import 'package:mafia_game/presentation/pages/home/home_screen_form.dart';
import 'package:mafia_game/presentation/widgets/app_bar.dart';
import 'package:mafia_game/utils/app_strings.dart';
import 'package:mafia_game/utils/theme/theme.dart';
import 'package:styled_widget/styled_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final bool _isLoading = false;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const DefaultAppBar(
          title: AppStrings.title,
        ),
        body: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 450.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  HomeScreenForm(),
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _loginButtonPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            MafiaTheme.themeData.colorScheme.secondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      child: _isLoading
                          ? CircularProgressIndicator(
                              color: MafiaTheme.themeData.colorScheme.surface,
                            )
                          : Text(
                              AppStrings.start,
                              style:
                                  MafiaTheme.themeData.textTheme.headlineMedium,
                            ),
                    ).padding(top: 16.0),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Future<void> _loginButtonPressed() async {
    // setState(() {
    //   _isLoading = true;
    // });
    // await widget._onSignIn();
    // setState(() {
    //   _isLoading = false;
    // });
  }
}
