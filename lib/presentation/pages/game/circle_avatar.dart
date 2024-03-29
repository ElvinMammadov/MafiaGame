part of game;

class CircleAvatarWidget extends StatefulWidget {
  final int numberOfGamers;
  late List<Gamer> gamers = <Gamer>[];

  CircleAvatarWidget({
    required this.numberOfGamers,
    required this.gamers,
  });

  @override
  _CircleAvatarWidgetState createState() => _CircleAvatarWidgetState();
}

class _CircleAvatarWidgetState extends State<CircleAvatarWidget> {
  late List<Widget> positionedAvatars = <Widget>[];

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

  @override
  Widget build(BuildContext context) => BlocBuilder<GameBloc, AppState>(
        builder: (BuildContext context, AppState state) {
          if (widget.gamers.isNotEmpty) {
            return Stack(
              children: positionedAvatars = _buildCircleAvatars(
                widget.numberOfGamers,
                widget.gamers,
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      );

  List<Widget> _buildCircleAvatars(
    int count,
    List<Gamer> gamers,
  ) {
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
      final double avatarX = centerX + (ovalRadius + 80 + radius) * cos(angle);
      final double avatarY = centerY + (ovalRadius + 250 + radius) * sin(angle);

      positionedAvatars.add(
        Positioned(
          top: avatarY - radius,
          left: avatarX - radius,
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  SizedBox(
                    width: 100,
                    height: 100,
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
                        child: gamers[i].imageUrl == null
                            ? Icon(
                                Icons.person_add_rounded,
                                size: 75,
                                color:
                                    MafiaTheme.themeData.colorScheme.secondary,
                              )
                            : Image.network(
                                gamers[i].imageUrl!,
                                fit: BoxFit.fill,
                                width: 100,
                                height: 100,
                              ),
                      ),
                    ),
                  ),
                ],
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.transparent,
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
                  gamers.isNotEmpty ? '${gamers[i].name}' : '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
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
