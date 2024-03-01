import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mafia_game/features/app/app.dart';
import 'package:mafia_game/features/game/game.dart';
import 'package:mafia_game/presentation/pages/game/circle_avatar.dart';
import 'package:mafia_game/presentation/widgets/app_bar.dart';
import 'package:mafia_game/utils/app_strings.dart';

class GameTableScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => BlocBuilder<GameBloc, AppState>(
        builder: (BuildContext context, AppState state) {
          print('state 2 is $state');
          final int numberOfGamers = state.game.numberOfGamers;
          return Scaffold(
            appBar: const DefaultAppBar(
              title: AppStrings.title,
              showBackButton: true,
            ),
            body: ColoredBox(
              color: Colors.grey,
              child: Center(
                child: SizedBox.expand(
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: ClipOval(
                          child: Container(
                            width: 400.0,
                            height: 730.0,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/table.jpeg'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ),
                      CircleAvatarWidget(
                        numberOfGamers: numberOfGamers,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
}
