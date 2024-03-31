part of game;

class CircleAvatarWidget extends StatefulWidget {
  final int numberOfGamers;
  final List<Gamer> gamers;

  const CircleAvatarWidget({
    required this.numberOfGamers,
    required this.gamers,
  });

  @override
  _CircleAvatarWidgetState createState() => _CircleAvatarWidgetState();
}

class _CircleAvatarWidgetState extends State<CircleAvatarWidget> {
  late List<Widget> positionedAvatars = <Widget>[];
  bool allNamesChanged = false;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.numberOfGamers; i++) {
      BlocProvider.of<GameBloc>(context).add(
        AddGamer(
          gamer: Gamer(
            name: '${AppStrings.gamer} ${i + 1}',
            id: i + 1,
          ),
        ),
      );
    }
  }

  void isAllGamersNameChanged(List<Gamer> gamers) {
    if (gamers.isNotEmpty) {
      allNamesChanged = gamers.every(
        (Gamer gamer) => gamer.isNameChanged == true,
      );
      print("allNamesChanged is $allNamesChanged");
      if (allNamesChanged) {
        BlocProvider.of<GameBloc>(context).add(
          const ChangeGameStartValue(
            isGameStarted: true,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<GameBloc, AppState>(
        builder: (BuildContext context, AppState state) {
          final Roles roles = state.gamersState.roles;
          isAllGamersNameChanged(state.gamersState.gamers);
          if (widget.gamers.isNotEmpty) {
            return SizedBox.expand(
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) =>
                    Stack(
                  children: _buildCircleAvatars(constraints, roles),
                ),
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      );

  List<Widget> _buildCircleAvatars(
    BoxConstraints constraints,
    Roles roles,
  ) {
    final List<Widget> positionedAvatars = <Widget>[];
    final double ovalRadius = constraints.maxWidth / 2.6;

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    const double minAvatarRadius = 20.0;
    const double maxAvatarRadius = 100.0;
    const double defaultAvatarRadiusPercentage = 0.05;

    final double radius = min(
      max(
        minAvatarRadius,
        min(screenWidth, screenHeight) * defaultAvatarRadiusPercentage,
      ),
      maxAvatarRadius,
    );
    final double angleStep = (2 * pi) / widget.numberOfGamers;

    for (int i = 0; i < widget.numberOfGamers; i++) {
      final double angle = (3 * pi / 2) + i * angleStep;
      final double avatarX =
          constraints.maxWidth / 2 + (ovalRadius + radius) * cos(angle);
      final double avatarY =
          constraints.maxHeight / 2 + (ovalRadius + radius) * sin(angle);

      positionedAvatars.add(
        Positioned(
          top: avatarY - radius,
          left: avatarX - radius,
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  SizedBox(
                    width: constraints.maxWidth / 13,
                    height: constraints.maxWidth / 13,
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(
                          color: MafiaTheme.themeData.colorScheme.secondary,
                          width: 2,
                        ),
                      ),
                      color: Colors.transparent,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            DialogBuilder().showAddUserModal(
                              context,
                              i + 1,
                            );
                          });
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: widget.gamers[i].imageUrl == null
                              ? Icon(
                                  Icons.person_add_rounded,
                                  size: constraints.maxWidth / 20,
                                  color: MafiaTheme
                                      .themeData.colorScheme.secondary,
                                )
                              : Image.network(
                                  widget.gamers[i].imageUrl!,
                                  fit: BoxFit.fill,
                                  width: constraints.maxWidth / 13,
                                  height: constraints.maxWidth / 13,
                                ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  minimumSize: const Size(60, 25),
                  side: BorderSide(
                    color: MafiaTheme.themeData.colorScheme.secondary,
                    width: 2,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  widget.gamers.isNotEmpty ? '${widget.gamers[i].name}' : '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // OutlinedButton(
              //   style: OutlinedButton.styleFrom(
              //     backgroundColor: Colors.transparent,
              //     side: BorderSide(
              //       color: MafiaTheme.themeData.colorScheme.secondary,
              //       width: 2,
              //     ),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(16),
              //     ),
              //   ),
              //   onPressed: () {},
              //   child: Text(
              //     widget.gamers[i].role != null
              //         ? '${widget.gamers[i].role}'
              //         : roles.roles[4].name,
              //     style: const TextStyle(
              //       color: Colors.white,
              //       fontSize: 14,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      );
    }

    return positionedAvatars;
  }
}
