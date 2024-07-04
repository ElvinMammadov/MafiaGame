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
  final bool isDay;

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
    required this.isDay,
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

    if (!widget.isGameStarted && widget.isGameCouldStart) {
      _controller.repeat(reverse: true);
    }
  }

  void animateGamer(Gamer gamer) {
    final int roleIndex =
        BlocProvider.of<GameBloc>(context).state.game.roleIndex;
    final int roleId = widget.roles.roles[roleIndex].roleId;
    final int gamerRoleIndex = widget.gamers[widget.index].role?.roleId ?? 0;
    // print('roleId: $roleId, gamerRoleIndex: $gamerRoleIndex');
    if (roleId == gamerRoleIndex) {
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
              style: TextStyle(color: Colors.white, fontSize: 18.0),
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

  void killGamerByMafia(String gamerName, int gamerId) {
    for (final Gamer gamer in widget.gamers) {
      if (gamer.name == gamerName) {
        BlocProvider.of<GameBloc>(context).add(
          KillGamerByMafia(
            targetedGamer: gamer,
            gamerId: gamerId,
          ),
        );
        break;
      }
    }
  }

  void killGamerByKiller(String gamerName, int gamerId) {
    for (final Gamer gamer in widget.gamers) {
      if (gamer.name == gamerName) {
        BlocProvider.of<GameBloc>(context).add(
          KillGamerByKiller(
            targetedGamer: gamer,
            gamerId: gamerId,
          ),
        );
        break;
      }
    }
  }

  void killGamerBySheriff(String gamerName, int gamerId) {
    for (final Gamer gamer in widget.gamers) {
      if (gamer.name == gamerName) {
        BlocProvider.of<GameBloc>(context).add(
          KillGamerBySheriff(
            targetedGamer: gamer,
            gamerId: gamerId,
          ),
        );
        break;
      }
    }
  }

  void healGamer(String gamerName, int gamerId) {
    for (final Gamer gamer in widget.gamers) {
      if (gamer.name == gamerName) {
        BlocProvider.of<GameBloc>(context).add(
          HealGamer(
            targetedGamer: gamer,
            gamerId: gamerId,
          ),
        );
        break;
      }
    }
  }

  void giveAlibi(String gamerName, int gamerId) {
    for (final Gamer gamer in widget.gamers) {
      if (gamer.name == gamerName) {
        BlocProvider.of<GameBloc>(context).add(
          GiveAlibi(
            targetedGamer: gamer,
            gamerId: gamerId,
          ),
        );
        break;
      }
    }
  }

  void secureGamer(String gamerName, int gamerId) {
    for (final Gamer gamer in widget.gamers) {
      if (gamer.name == gamerName) {
        BlocProvider.of<GameBloc>(context).add(
          SecureGamer(
            targetedGamer: gamer,
            gamerId: gamerId,
          ),
        );
        break;
      }
    }
  }

  void takeAbilityFromGamer(String gamerName, int gamerId) {
    for (final Gamer gamer in widget.gamers) {
      if (gamer.name == gamerName) {
        BlocProvider.of<GameBloc>(context).add(
          TakeAbilityFromGamer(
            targetedGamer: gamer,
            gamerId: gamerId,
          ),
        );
        break;
      }
    }
  }

  void boomerangGamer(String gamerName, int gamerId) {
    for (final Gamer gamer in widget.gamers) {
      if (gamer.name == gamerName) {
        BlocProvider.of<GameBloc>(context).add(
          BoomerangGamer(
            targetedGamer: gamer,
            gamerId: gamerId,
          ),
        );
        break;
      }
    }
  }

  void infectGamer(String gamerName, int gamerId) {
    for (final Gamer gamer in widget.gamers) {
      if (gamer.name == gamerName) {
        BlocProvider.of<GameBloc>(context).add(
          InfectGamer(
            targetedGamer: gamer,
            infect: true,
          ),
        );
        break;
      }
    }
  }

  void _handleHitting() {
    final int roleIndex =
        BlocProvider.of<GameBloc>(context).state.game.roleIndex;
    final int roleId = widget.roles.roles[roleIndex].roleId;

    final Gamer gamer =
        widget.gamers.firstWhere((Gamer gamer) => gamer.role?.roleId == roleId);
    print('roleId: $roleId');
    switch (roleId) {
      case 1:
        healGamer(widget.gamers[widget.index].name!, gamer.id!);
        break;
      case 2:
      case 3:
        killGamerByMafia(widget.gamers[widget.index].name!, gamer.id!);
        break;
      case 4:
        killGamerBySheriff(widget.gamers[widget.index].name!, gamer.id!);
        break;
      case 5:
        takeAbilityFromGamer(widget.gamers[widget.index].name!, gamer.id!);
        break;
      case 6:
        killGamerByKiller(widget.gamers[widget.index].name!, gamer.id!);
        break;
      case 8:
        if (BlocProvider.of<GameBloc>(context).state.game.infectedCount > 0) {
          infectGamer(widget.gamers[widget.index].name!, gamer.id!);
          BlocProvider.of<GameBloc>(context).add(
            InfectedCount(
              infectedCount:
                  BlocProvider.of<GameBloc>(context).state.game.infectedCount -
                      1,
            ),
          );
        }

        break;
      case 9:
        giveAlibi(widget.gamers[widget.index].name!, gamer.id!);
        break;

      case 10:
        secureGamer(widget.gamers[widget.index].name!, gamer.id!);
        break;
      case 14:
        boomerangGamer(widget.gamers[widget.index].name!, gamer.id!);
        break;
      default:
        break;
    }

    if (roleId != 8) {
      BlocProvider.of<GameBloc>(context).add(
        ChangeRoleIndex(
          roleIndex: roleIndex + 1,
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
        // print('is animating 3: ${widget.gamers[widget.index].isAnimated}');
        if (!isDay) {
          animateGamer(widget.gamers[widget.index]);
        }
        return AnimatedBuilder(
          animation: _animation,
          builder: (BuildContext context, Widget? child) => DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: (!widget.isGameCouldStart && !widget.isGameStarted) ||
                        !widget.gamers[widget.index].isAnimated ||
                        isDiscussionStarted ||
                        (!isDay && !widget.gamers[widget.index].isAnimated)
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
                  } else if (!isDay) {
                    _handleHitting();
                  } else if (!widget.isGameCouldStart &&
                      !widget.isGameStarted) {
                    DialogBuilder().showAddUserModal(
                      context,
                      widget.gamers[widget.index].id ?? 0,
                      const Mirniy.empty(),
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
