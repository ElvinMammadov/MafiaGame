library game;

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mafia_game/features/app/app.dart';
import 'package:mafia_game/utils/services/cloud_firestore_service.dart';

part 'bloc/game_bloc.dart';
part 'events/game_events.dart';
part 'game.g.dart';
part 'game_repository.dart';
part 'models/gamer.dart';
part 'models/role.dart';
part 'models/roles.dart';
part 'states/gamers_state.dart';
part 'models/doctor.dart';
