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
    print('index: $index, gamer.id: ${gamer.id}');
    print('roleId: $roleId');
    switch (roleId) {
      case 1:
        healGamer(gamers[index].name!, gamer, context, gamers);
        break;
      case 2:
      case 3:
        killGamerByMafia(gamers[index].name!, gamer, context, gamers);
        break;
      case 4:
        killGamerBySheriff(gamers[index].name!, gamer, context, gamers);
        break;
      case 5:
        takeAbilityFromGamer(gamers[index].name!, gamer, context, gamers);
        break;
      case 6:
        killGamerByKiller(gamers[index].name!, gamer, context, gamers);
        break;
      case 7:
        if (!gamer.beforeChange) {
          killGamerByMafia(gamers[index].name!, gamer, context, gamers);
          break;
        } else {
          break;
        }
      case 8:
        if (BlocProvider.of<GameBloc>(context).state.game.infectedCount > 0) {
          infectGamer(
            gamers[index].name!,
            gamer,
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
        giveAlibi(gamers[index].name!, gamer, context, gamers);
        break;
      case 10:
        secureGamer(gamers[index].name!, gamer.id!, context, gamers);
        break;
      case 12:
        mediumChecked(gamers[index].name!, gamer.id!, context, gamers);
        break;
      case 13:
        chameleonChanges(context, index, gamer, gamers);
        break;
      case 14:
        boomerangGamer(gamers[index].name!, gamer, context, gamers);
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
    Gamer mafiaGamer,
    BuildContext context,
    List<Gamer> gamers,
  ) {
    for (final Gamer gamer in gamers) {
      if (gamer.name == gamerName) {
        BlocProvider.of<GameBloc>(context).add(
          KillGamerByMafia(targetedGamer: gamer, mafiaGamer: mafiaGamer),
        );
        break;
      }
    }
  }

  void killGamerByKiller(
    String gamerName,
    Gamer killer,
    BuildContext context,
    List<Gamer> gamers,
  ) {
    for (final Gamer gamer in gamers) {
      if (gamer.name == gamerName) {
        BlocProvider.of<GameBloc>(context).add(
          KillGamerByKiller(targetedGamer: gamer, killer: killer),
        );
        break;
      }
    }
  }

  void killGamerBySheriff(
    String gamerName,
    Gamer sheriff,
    BuildContext context,
    List<Gamer> gamers,
  ) {
    for (final Gamer gamer in gamers) {
      if (gamer.name == gamerName) {
        BlocProvider.of<GameBloc>(context).add(
          KillGamerBySheriff(targetedGamer: gamer, sheriff: sheriff),
        );
        break;
      }
    }
  }

  void healGamer(
    String gamerName,
    Gamer doctor,
    BuildContext context,
    List<Gamer> gamers,
  ) {
    for (final Gamer gamer in gamers) {
      if (gamer.name == gamerName) {
        BlocProvider.of<GameBloc>(context).add(
          HealGamer(targetedGamer: gamer, doctor: doctor),
        );
        break;
      }
    }
  }

  void giveAlibi(
    String gamerName,
    Gamer advocate,
    BuildContext context,
    List<Gamer> gamers,
  ) {
    for (final Gamer gamer in gamers) {
      if (gamer.name == gamerName) {
        BlocProvider.of<GameBloc>(context).add(
          GiveAlibi(targetedGamer: gamer, advocate: advocate),
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
          SecureGamer(targetedGamer: gamer, gamerId: gamerId),
        );
        break;
      }
    }
  }

  void takeAbilityFromGamer(
    String gamerName,
    Gamer madam,
    BuildContext context,
    List<Gamer> gamers,
  ) {
    for (final Gamer gamer in gamers) {
      if (gamer.name == gamerName) {
        BlocProvider.of<GameBloc>(context).add(
          TakeAbilityFromGamer(targetedGamer: gamer, madam: madam),
        );
        break;
      }
    }
  }

  void mediumChecked(
    String gamerName,
    int gamerId,
    BuildContext context,
    List<Gamer> gamers,
  ) {
    for (final Gamer gamer in gamers) {
      if (gamer.name == gamerName) {
        BlocProvider.of<GameBloc>(context).add(
          MediumChecked(targetedGamer: gamer, gamerId: gamerId),
        );
        break;
      }
    }
  }

  void boomerangGamer(
    String gamerName,
    Gamer boomerang,
    BuildContext context,
    List<Gamer> gamers,
  ) {
    for (final Gamer gamer in gamers) {
      if (gamer.name == gamerName) {
        BlocProvider.of<GameBloc>(context).add(
          BoomerangGamer(targetedGamer: gamer, boomerang: boomerang),
        );
        break;
      }
    }
  }

  void infectGamer(
    String gamerName,
    Gamer virus,
    BuildContext context,
    List<Gamer> gamers,
  ) {
    for (final Gamer gamer in gamers) {
      if (gamer.name == gamerName) {
        BlocProvider.of<GameBloc>(context).add(
          InfectGamer(targetedGamer: gamer, infect: true),
        );
        break;
      }
    }
  }

  void chameleonChanges(
    BuildContext context,
    int index,
    Gamer gamer,
    List<Gamer> gamers,
  ) {
    final int roleId = gamer.chameleonId;
    print('roleId: $roleId, gamerId: ${gamer.id}');
    switch (roleId) {
      case 1:
        healGamer(gamers[index].name!, gamer, context, gamers);
        break;
      case 2:
      case 3:
        killGamerByMafia(gamers[index].name!, gamer, context, gamers);
        break;
      case 4:
        killGamerBySheriff(gamers[index].name!, gamer, context, gamers);
        break;
      case 5:
        takeAbilityFromGamer(gamers[index].name!, gamer, context, gamers);
        break;
      case 6:
        killGamerByKiller(gamers[index].name!, gamer, context, gamers);
        break;
      case 7:
        killGamerByMafia(gamers[index].name!, gamer, context, gamers);
        break;
      case 9:
        giveAlibi(gamers[index].name!, gamer, context, gamers);
        break;
      case 12:
        mediumChecked(gamers[index].name!, gamer.id!, context, gamers);
        break;
    }
    if (roleId != 2) {
      BlocProvider.of<GameBloc>(context).add(
        const ChameleonChangeRole(chameleonId: 0),
      );
    }
  }
}
