import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mafia_game/features/auth/auth.dart';
import 'package:mafia_game/features/game/game.dart';

class MultiBlocProviderWidget extends StatelessWidget {
  final Widget child;

  const MultiBlocProviderWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final UserRepository userRepository = UserRepository();
    final AuthenticationBloc authenticationBloc =
        AuthenticationBloc(userRepository);
    authenticationBloc.add(AppStarted());

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (BuildContext context) => authenticationBloc,
        ),
        BlocProvider<GameBloc>(
          create: (BuildContext context) => GameBloc(),
        ),
      ],
      child: child,
    );
  }
}
