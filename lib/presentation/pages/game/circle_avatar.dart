import 'dart:math';

import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) => Stack(
      children: _positionedAvatars,
    );

  List<Widget> _buildCircleAvatars(int count) {
    final List<Widget> positionedAvatars = <Widget>[];
    const double ovalWidth = 450.0;
    const double ovalRadius = ovalWidth / 1.8;
    const double radius = 35.0;
    final double angleStep = (2 * pi) / count;
    const double centerX = 390;
    const double centerY = 560;

    for (int i = 0; i < count; i++) {
      final double angle = (3 * pi / 2) + i * angleStep;
      final double avatarX = centerX + (ovalRadius + 10 + radius) * cos(angle);
      final double avatarY = centerY + (ovalRadius + 110 + radius) * sin(angle);

      positionedAvatars.add(
        Positioned(
          top: avatarY - radius,
          left: avatarX - radius,
          child: Column(
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.red, // Change as needed
                radius: radius,
                child: GestureDetector(
                  onTap: () {
                    // Handle onTap action
                  },
                  child: const Icon(
                    Icons.add,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                'User ${i + 1}',
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      );
    }

    return positionedAvatars;
  }
}
