import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mafia_game/features/app/app.dart';
import 'package:mafia_game/features/game/game.dart';
import 'package:mafia_game/features/game/models/gamer.dart';
import 'package:mafia_game/presentation/pages/game/add_user.dart';
import 'package:mafia_game/utils/app_strings.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class CircleAvatarWidget extends StatefulWidget {
  final int numberOfGamers;

  const CircleAvatarWidget({required this.numberOfGamers});

  @override
  _CircleAvatarWidgetState createState() => _CircleAvatarWidgetState();
}

class _CircleAvatarWidgetState extends State<CircleAvatarWidget> {
  List<Widget> _positionedAvatars = <Widget>[];

  @override
  void initState() {
    super.initState();
    _positionedAvatars = _buildCircleAvatars(widget.numberOfGamers);
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<GameBloc, AppState>(
        builder: (BuildContext context, AppState state) => Stack(
          children: _positionedAvatars,
        ),
      );

  List<Widget> _buildCircleAvatars(int count) {
    final List<Widget> positionedAvatars = <Widget>[];
    const double ovalWidth = 450.0;
    const double ovalRadius = ovalWidth / 1.8;
    const double radius = 45.0;
    final double angleStep = (2 * pi) / count;
    ///Below is for moving left , right, up and down
    const double centerX = 500;
    const double centerY = 630;

    for (int i = 0; i < count; i++) {
      final double angle = (3 * pi / 2) + i * angleStep;
      ///Below is for resizing the avatars
      final double avatarX = centerX + (ovalRadius + 60 + radius) * cos(angle);
      final double avatarY = centerY + (ovalRadius + 220 + radius) * sin(angle);

      positionedAvatars.add(
        Positioned(
          top: avatarY - radius,
          left: avatarX - radius,
          child: Column(
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.red,
                radius: radius,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      BlocProvider.of<GameBloc>(context).add(
                        AddGamer(
                          gamer: Gamer(
                            name: 'User ${i + 1}',
                            role: 'Role ${i + 1}',
                          ),
                        ),
                      );
                      WoltModalSheet.show<void>(
                        context: context,
                        pageListBuilder: (BuildContext modalSheetContext) => [
                          AddUser.build(
                            onClosed: () {
                              Navigator.of(context).pop();
                            },
                            context: context,
                          ),
                        ],
                        modalTypeBuilder: (BuildContext context) =>
                            WoltModalType.dialog,
                        maxDialogWidth: 560,
                        minDialogWidth: 400,
                      );
                    });
                  },
                  child: const Icon(
                    Icons.add,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                '${AppStrings.gamer} ${i + 1}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return positionedAvatars;
  }
}
