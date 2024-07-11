part of game;

class BlinkingFunctions {
  void _handleHitting(
    BuildContext context,
    List<Gamer> gamers,
    Roles roles,
    int index,
  ) {
    final int roleIndex =
        BlocProvider.of<GameBloc>(context).state.game.roleIndex;
    final int roleId = roles.roles[roleIndex].roleId;

    final Gamer gamer =
        gamers.firstWhere((Gamer gamer) => gamer.role?.roleId == roleId);
    print('roleId: $roleId');
    switch (roleId) {
      case 1:
        healGamer(
          gamers[index].name!,
          gamer.id!,
          context,
          gamers,
        );
        break;
      case 2:
      case 3:
        killGamerByMafia(
          gamers[index].name!,
          gamer.id!,
          context,
          gamers,
        );
        break;
      case 4:
        killGamerBySheriff(
          gamers[index].name!,
          gamer.id!,
          context,
          gamers,
        );
        break;
      case 5:
        takeAbilityFromGamer(
          gamers[index].name!,
          gamer.id!,
          context,
          gamers,
        );
        break;
      case 6:
        killGamerByKiller(
          gamers[index].name!,
          gamer.id!,
          context,
          gamers,
        );
        break;
      case 8:
        if (BlocProvider.of<GameBloc>(context).state.game.infectedCount > 0) {
          infectGamer(
           gamers[index].name!,
            gamer.id!,
            context,
            gamers,
          );
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
        giveAlibi(
          gamers[index].name!,
          gamer.id!,
          context,
          gamers,
        );
        break;

      case 10:
        secureGamer(
          gamers[index].name!,
          gamer.id!,
          context,
         gamers,
        );
        break;
      case 14:
        boomerangGamer(
         gamers[index].name!,
          gamer.id!,
          context,
          gamers,
        );
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

  void killGamerByMafia(
    String gamerName,
    int gamerId,
    BuildContext context,
    List<Gamer> gamers,
  ) {
    for (final Gamer gamer in gamers) {
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

  void killGamerByKiller(
    String gamerName,
    int gamerId,
    BuildContext context,
    List<Gamer> gamers,
  ) {
    for (final Gamer gamer in gamers) {
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

  void killGamerBySheriff(
    String gamerName,
    int gamerId,
    BuildContext context,
    List<Gamer> gamers,
  ) {
    for (final Gamer gamer in gamers) {
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

  void healGamer(
    String gamerName,
    int gamerId,
    BuildContext context,
    List<Gamer> gamers,
  ) {
    for (final Gamer gamer in gamers) {
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

  void giveAlibi(
    String gamerName,
    int gamerId,
    BuildContext context,
    List<Gamer> gamers,
  ) {
    for (final Gamer gamer in gamers) {
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

  void secureGamer(
    String gamerName,
    int gamerId,
    BuildContext context,
    List<Gamer> gamers,
  ) {
    for (final Gamer gamer in gamers) {
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

  void takeAbilityFromGamer(
    String gamerName,
    int gamerId,
    BuildContext context,
    List<Gamer> gamers,
  ) {
    for (final Gamer gamer in gamers) {
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

  void boomerangGamer(
    String gamerName,
    int gamerId,
    BuildContext context,
    List<Gamer> gamers,
  ) {
    for (final Gamer gamer in gamers) {
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

  void infectGamer(
    String gamerName,
    int gamerId,
    BuildContext context,
    List<Gamer> gamers,
  ) {
    for (final Gamer gamer in gamers) {
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
}
