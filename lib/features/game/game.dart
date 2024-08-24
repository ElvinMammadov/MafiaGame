library game;

import 'dart:developer';
import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mafia_game/features/app/app.dart';
import 'package:mafia_game/utils/app_strings.dart';
import 'package:mafia_game/utils/services/cloud_firestore_service.dart';

part 'bloc/game_bloc.dart';
part 'events/game_events.dart';
part 'game.g.dart';
part 'game_repository.dart';
part 'models/gamer.dart';
part 'models/role.dart';
part 'models/roles.dart';
part 'states/gamers_state.dart';
part 'models/roles/doctor.dart';
part 'models/roles/mafia.dart';
part 'models/roles/don.dart';
part 'models/roles/sheriff.dart';
part 'models/roles/madam.dart';
part 'models/roles/killer.dart';
part 'models/roles/werewolf.dart';
part 'models/roles/virus.dart';
part 'models/roles/advocate.dart';
part 'models/roles/security.dart';
part 'models/roles/mirniy.dart';
part 'models/roles/medium.dart';
part 'models/roles/chameleon.dart';
part 'models/roles/boomerang.dart';
part 'models/gamer_counts.dart';
