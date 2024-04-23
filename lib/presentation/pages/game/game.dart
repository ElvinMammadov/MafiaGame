library game;

import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mafia_game/features/app/app.dart';
import 'package:mafia_game/features/game/game.dart';
import 'package:mafia_game/presentation/pages/game/widgets/round_button.dart';
import 'package:mafia_game/presentation/validators/validators.dart';
import 'package:mafia_game/presentation/widgets/app_bar.dart';
import 'package:mafia_game/presentation/widgets/base_button.dart';
import 'package:mafia_game/presentation/widgets/rounded_icon_button.dart';
import 'package:mafia_game/utils/app_strings.dart';
import 'package:mafia_game/utils/dimensions.dart';
import 'package:mafia_game/utils/services/cloud_firestore_service.dart';
import 'package:mafia_game/utils/theme/theme.dart';
import 'package:path_provider/path_provider.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';


part 'add_user.dart';
part 'circle_avatar.dart';
part 'game_table.dart';
part 'widgets/dialog_builder.dart';
part 'widgets/image_picker_sheet.dart';
part 'widgets/count_down_timer.dart';
part 'widgets/gamers_avatars.dart';
part 'widgets/number_picker.dart';
part 'widgets/dialogs/pick_number_dialog.dart';
part 'widgets/number_buttons.dart';
part 'widgets/dialogs/add_functionality_dialog.dart';
part 'widgets/dialogs/killed_gamer_dialog.dart';
part 'widgets/killed_gamer_screen.dart';
