library game;

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mafia_game/features/app/app.dart';
import 'package:mafia_game/features/game/models/gamer.dart';
import 'package:mafia_game/features/game/states/gamers_state.dart';

part 'bloc/game_bloc.dart';
part 'events/game_events.dart';
part 'game_repository.dart';
