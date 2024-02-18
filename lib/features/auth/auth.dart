library auth;

import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mafia_game/features/app/app.dart';
import 'package:mafia_game/features/auth/models/user.dart';
import 'package:mafia_game/utils/services/authentication.dart';

part 'bloc/authentication_bloc.dart';
part 'events/authentication_event.dart';
part 'auth_repository.dart';
part 'states/authentication_state.dart';
