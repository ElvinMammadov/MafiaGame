part of game;

class BlinkingAvatar extends StatefulWidget {
  final bool showRoles;
  final List<Gamer> gamers;
  final int index;
  final Roles roles;
  final double iconSize;
  final double sizeBoxSize;
  final Function(Gamer)? changeRole;
  final GamePeriod gamePeriod;
  final GamePhase gamePhase;

  const BlinkingAvatar({
    required this.showRoles,
    required this.gamers,
    required this.index,
    required this.roles,
    required this.iconSize,
    required this.sizeBoxSize,
    this.changeRole,
    required this.gamePeriod,
    required this.gamePhase,
    super.key,
  });

  @override
  _BlinkingAvatarState createState() => _BlinkingAvatarState();
}

class _BlinkingAvatarState extends State<BlinkingAvatar>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _animation;
  Gamer? _currentVoter;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _animation = ColorTween(
      begin: Colors.red,
      end: Colors.green,
    ).animate(_controller);

    if (widget.gamePhase != GamePhase.IsReady) {
      _controller.repeat(reverse: true);
    }
  }

  void _animateGamer(Gamer gamer) {
    final int roleIndex =
        BlocProvider.of<GameBloc>(context).state.game.roleIndex;
    final RoleType roleType = widget.roles.roles[roleIndex].roleType;
    final RoleType gamerRoleType = widget.gamers[widget.index].role.roleType;
    if (roleType == gamerRoleType) {
      BlocProvider.of<GameBloc>(context).add(
        ChangeAnimation(
          gamerId: widget.gamers[widget.index].gamerId ?? '',
          animate: true,
        ),
      );
      _controller.repeat(reverse: true);
    } else {
      BlocProvider.of<GameBloc>(context).add(
        ChangeAnimation(
          gamerId: widget.gamers[widget.index].gamerId ?? '',
          animate: false,
        ),
      );
      _controller.stop();
    }
  }

  void _handleTap() {
    _currentVoter = BlocProvider.of<GameBloc>(context).state.game.currentVoter;
    if (_currentVoter!.name!.isNotEmpty &&
        _currentVoter!.gamerId != widget.gamers[widget.index].gamerId) {
      BlocProvider.of<GameBloc>(context).add(
        AddVoteToGamer(
          gamer: widget.gamers[widget.index],
          voter: _currentVoter!,
        ),
      );
      BlocProvider.of<GameBloc>(context).add(
        ChangeAnimation(gamerId: _currentVoter?.gamerId ?? '', animate: false),
      );
      BlocProvider.of<GameBloc>(context).add(
        const ResetVoter(),
      );
    } else {
      if (widget.gamers[widget.index].wasVoted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              AppStrings.gamerAlreadyVoted,
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
          ),
        );
      } else {
        BlocProvider.of<GameBloc>(context).add(
          SetVoter(
            voter: widget.gamers[widget.index],
          ),
        );
      }
    }
  }

  void toggleAnimation() {
    setState(() {
      if (widget.gamers[widget.index].isAnimated) {
        _controller.stop();
        BlocProvider.of<GameBloc>(context).add(
          ChangeAnimation(
            gamerId: widget.gamers[widget.index].gamerId ?? '',
            animate: false,
          ),
        );
      } else {
        _controller.repeat(reverse: true);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if ((widget.gamePhase != GamePhase.IsReady &&
            widget.gamers[widget.index].isAnimated) ||
        widget.gamePhase == GamePhase.Voting) {
      _controller.repeat(reverse: true);
    } else {
      _controller.stop();
    }
    return BlocBuilder<GameBloc, AppState>(
      builder: (BuildContext context, AppState state) {
        final GamePeriod gamePeriod = state.game.gamePeriod;
        final GamePhase gamePhase = state.game.gamePhase;
        if (gamePeriod == GamePeriod.Night) {
          _animateGamer(widget.gamers[widget.index]);
        }
        return AnimatedBuilder(
          animation: _animation,
          builder: (BuildContext context, Widget? child) => DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: (widget.gamePhase == GamePhase.IsReady) ||
                        !widget.gamers[widget.index].isAnimated ||
                        gamePhase == GamePhase.Discussion &&
                            gamePeriod == GamePeriod.Day ||
                        (gamePeriod == GamePeriod.Night &&
                            !widget.gamers[widget.index].isAnimated)
                    ? Colors.transparent
                    : _animation.value!,
                width: _controller.value * 10,
              ),
            ),
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
              child: InkWell(
                onTap: () {
                  if (widget.gamePhase == GamePhase.CouldStart) {
                    toggleAnimation();
                    widget.changeRole!(widget.gamers[widget.index]);
                  } else if (widget.gamePhase == GamePhase.Voting &&
                      gamePeriod == GamePeriod.Day) {
                    _handleTap();
                  } else if (gamePeriod == GamePeriod.Night) {
                    final int roleIndex =
                        BlocProvider.of<GameBloc>(context).state.game.roleIndex;
                    final RoleType roleType =
                        widget.roles.roles[roleIndex].roleType;
                    final bool gamerExists = widget.gamers
                        .any((Gamer gamer) => gamer.role.roleType == roleType);
                    if (gamerExists) {
                      BlinkingFunctions()._handleHitting(
                        context,
                        widget.gamers,
                        widget.roles,
                        widget.index,
                      );
                    }
                  } else if (widget.gamePhase == GamePhase.IsReady) {
                    DialogBuilder().showAddUserModal(
                      context,
                      widget.gamers[widget.index].id ?? 0,
                      const Mirniy.empty(),
                      position: widget.gamers[widget.index].positionOnTable,
                    );
                  }
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: widget.showRoles
                      ? Center(
                          child: Text(
                            widget.gamers[widget.index].role.name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : widget.gamers[widget.index].imageUrl!.isEmpty
                          ? Icon(
                              Icons.person_add_rounded,
                              size: widget.iconSize,
                              color: MafiaTheme.themeData.colorScheme.secondary,
                            )
                          : Image.network(
                              widget.gamers[widget.index].imageUrl!,
                              fit: BoxFit.fill,
                              width: widget.sizeBoxSize,
                              height: widget.sizeBoxSize,
                            ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
