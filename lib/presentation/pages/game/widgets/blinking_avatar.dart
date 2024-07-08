part of game;

class BlinkingAvatar extends StatefulWidget {
  final bool showRoles;
  final List<Gamer> gamers;
  final int index;
  final Roles roles;
  final double iconSize;
  final double sizeBoxSize;
  final bool isGameCouldStart;
  final Function(Gamer)? changeRole;
  final bool isGameStarted;
  final bool isVotingStarted;

  const BlinkingAvatar({
    required this.showRoles,
    required this.gamers,
    required this.index,
    required this.roles,
    required this.iconSize,
    required this.sizeBoxSize,
    required this.isGameCouldStart,
    this.changeRole,
    required this.isGameStarted,
    required this.isVotingStarted,
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

    // print('isGameStarted: ${!widget.isGameStarted},'
    //     ' isGameCouldStart: ${widget.isGameCouldStart}');
    if (!widget.isGameStarted && widget.isGameCouldStart) {
      _controller.repeat(reverse: true);
    }
  }

  void _handleTap() {
    _currentVoter = BlocProvider.of<GameBloc>(context).state.game.currentVoter;
    // print('currentVoter: $_currentVoter');
    if (_currentVoter!.name!.isNotEmpty &&
        _currentVoter!.gamerId != widget.gamers[widget.index].gamerId) {
      BlocProvider.of<GameBloc>(context).add(
        AddVoteToGamer(
          gamer: widget.gamers[widget.index],
        ),
      );
      BlocProvider.of<GameBloc>(context).add(
        ChangeAnimation(gamerId: _currentVoter?.gamerId ?? ''),
      );
      BlocProvider.of<GameBloc>(context).add(
        const ResetVoter(),
      );
    } else {
      BlocProvider.of<GameBloc>(context).add(
        SetVoter(
          voter: widget.gamers[widget.index],
        ),
      );
    }
  }

  void toggleAnimation() {
    setState(() {
      print('isAnimating 2: ${widget.gamers[widget.index].isAnimated}');
      if (widget.gamers[widget.index].isAnimated) {
        _controller.stop();
        BlocProvider.of<GameBloc>(context).add(
          ChangeAnimation(
            gamerId: widget.gamers[widget.index].gamerId ?? '',
          ),
        );
      } else {
        _controller.repeat(reverse: true);
      }
    });
  }

  void killGamerByMafia(String gamerName) {
    for (final Gamer gamer in widget.gamers) {
      if (gamer.name == gamerName) {
        BlocProvider.of<GameBloc>(context).add(
          KillGamerByMafia(
            targetedGamer: gamer,
            gamerId: widget.gamers[widget.index].id ?? 0,
          ),
        );
        break;
      }
    }
  }

  void killGamerByKiller(String gamerName) {
    for (final Gamer gamer in widget.gamers) {
      if (gamer.name == gamerName) {
        BlocProvider.of<GameBloc>(context).add(
          KillGamerByKiller(
            targetedGamer: gamer,
            gamerId: widget.gamers[widget.index].id ?? 0,
          ),
        );
        break;
      }
    }
  }

  void killGamerBySheriff(String gamerName) {
    for (final Gamer gamer in widget.gamers) {
      if (gamer.name == gamerName) {
        BlocProvider.of<GameBloc>(context).add(
          KillGamerBySheriff(
            targetedGamer: gamer,
            gamerId: widget.gamers[widget.index].id ?? 0,
          ),
        );
        break;
      }
    }
  }

  void healGamer(String gamerName) {
    for (final Gamer gamer in widget.gamers) {
      if (gamer.name == gamerName) {
        BlocProvider.of<GameBloc>(context).add(
          HealGamer(
            targetedGamer: gamer,
            gamerId: widget.gamers[widget.index].id ?? 0,
          ),
        );
        break;
      }
    }
  }

  void giveAlibi(String gamerName) {
    for (final Gamer gamer in widget.gamers) {
      if (gamer.name == gamerName) {
        BlocProvider.of<GameBloc>(context).add(
          GiveAlibi(
            targetedGamer: gamer,
            gamerId: widget.gamers[widget.index].id ?? 0,
          ),
        );
        break;
      }
    }
  }

  void secureGamer(String gamerName) {
    for (final Gamer gamer in widget.gamers) {
      if (gamer.name == gamerName) {
        BlocProvider.of<GameBloc>(context).add(
          SecureGamer(
            targetedGamer: gamer,
            gamerId: widget.gamers[widget.index].id ?? 0,
          ),
        );
        break;
      }
    }
  }

  void takeAbilityFromGamer(String gamerName) {
    for (final Gamer gamer in widget.gamers) {
      if (gamer.name == gamerName) {
        BlocProvider.of<GameBloc>(context).add(
          TakeAbilityFromGamer(
            targetedGamer: gamer,
            gamerId: widget.gamers[widget.index].id ?? 0,
          ),
        );
        break;
      }
    }
  }

  void boomerangGamer(String gamerName){
    for (final Gamer gamer in widget.gamers) {
      if (gamer.name == gamerName) {
        BlocProvider.of<GameBloc>(context).add(
          BoomerangGamer(
            targetedGamer: gamer,
            gamerId: widget.gamers[widget.index].id ?? 0,
          ),
        );
        break;
      }
    }
  }

  void _handleHitting() {
    _currentVoter = BlocProvider.of<GameBloc>(context).state.game.currentVoter;
    print('currentVoter hitter: ${_currentVoter?.role?.roleId}');
    // print('currentVoter hitter name: ${_currentVoter?.name?.isNotEmpty}');
    if (_currentVoter!.name!.isNotEmpty &&
        _currentVoter!.gamerId != widget.gamers[widget.index].gamerId) {
      switch (_currentVoter!.role?.roleId) {
        case 1:
          healGamer(widget.gamers[widget.index].name!);
          break;
        case 2:
        case 3:
          killGamerByMafia(widget.gamers[widget.index].name!);
          break;
        case 4:
          killGamerBySheriff(widget.gamers[widget.index].name!);
          break;
        case 5:
          takeAbilityFromGamer(widget.gamers[widget.index].name!);
          break;
        case 6:
          killGamerByKiller(widget.gamers[widget.index].name!);
          break;
        case 9:
          giveAlibi(widget.gamers[widget.index].name!);
          break;
        case 10:
          secureGamer(widget.gamers[widget.index].name!);
          break;
        case 14:
          boomerangGamer(widget.gamers[widget.index].name!);
          break;
        default:
          break;
      }
      BlocProvider.of<GameBloc>(context).add(
        const ResetVoter(),
      );
    } else {
      BlocProvider.of<GameBloc>(context).add(
        SetVoter(
          voter: widget.gamers[widget.index],
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print('isAnimating: ${widget.gamers[widget.index].isAnimated}');
    // print('isGameStarted: ${widget.isGameStarted},'
    //     ' isGameCouldStart: ${widget.isGameCouldStart} '
    //     'is Voting Started: ${widget.isVotingStarted}');
    // print(
    //     'is condition: ${!widget.isGameStarted && widget.isGameCouldStart && widget.gamers[widget.index].isAnimated}');
    // // _currentVoter = BlocProvider.of<GameBloc>(context).state.game.currentVoter;
    if ((!widget.isGameStarted &&
            widget.isGameCouldStart &&
            widget.gamers[widget.index].isAnimated) ||
        widget.isVotingStarted) {
      _controller.repeat(reverse: true);
    } else {
      _controller.stop();
    }
    return BlocBuilder<GameBloc, AppState>(
      builder: (BuildContext context, AppState state) {
        final bool isDay = state.game.isDay;
        final bool isDiscussionStarted = state.game.isDiscussionStarted;
        return AnimatedBuilder(
          animation: _animation,
          builder: (BuildContext context, Widget? child) => DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: (!widget.isGameCouldStart && !widget.isGameStarted) ||
                        !widget.gamers[widget.index].isAnimated ||
                        isDiscussionStarted || !isDay
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
              child: GestureDetector(
                onTap: () {
                  if (widget.isGameCouldStart && !widget.isGameStarted) {
                    toggleAnimation();
                    widget.changeRole!(widget.gamers[widget.index]);
                  } else if (widget.isVotingStarted && isDay) {
                    _handleTap();
                    // showAddFunctionality(
                    //   context,
                    //   isVotingStarted: widget.isVotingStarted,
                    //   gamerId: widget.gamers[widget.index].id ?? 0,
                    //   roleId: widget.gamers[widget.index].role
                    //       ?.roleId ??
                    //       0,
                    //   nightNumber:
                    //   BlocProvider
                    //       .of<GameBloc>(context)
                    //       .state
                    //       .game
                    //       .nightNumber,
                    // );
                  } else if (!isDay) {
                    _handleHitting();
                  } else if (!widget.isGameCouldStart && !widget.isGameStarted){
                    DialogBuilder().showAddUserModal(
                      context,
                      widget.gamers[widget.index].id ?? 0,
                      widget.roles.roles[13],
                    );
                  }
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: widget.showRoles
                      ? Center(
                          child: Text(
                            widget.gamers[widget.index].role != null
                                ? '${widget.gamers[widget.index].role?.name}'
                                : widget.roles.roles[13].name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
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
