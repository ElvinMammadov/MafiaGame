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
    final RoleType roleType = roles.roles[roleIndex].roleType;

    final Gamer gamer =
        gamers.firstWhere((Gamer gamer) => gamer.role.roleType == roleType);
    print(
        'gamers[index].name!: ${gamers[index].name!}, '
            'gamer.name: ${gamer.name}');
    print('roleType: $roleType');
    switch (roleType) {
      case RoleType.Doctor:
        healGamer(gamers[index].name!, gamer, context, gamers);
        break;
      case RoleType.Mafia:
      case RoleType.Don:
        killGamerByMafia(gamers[index].name!, gamer, context, gamers);
        break;
      case RoleType.Sheriff:
        killGamerBySheriff(gamers[index].name!, gamer, context, gamers);
        break;
      case RoleType.Madam:
        takeAbilityFromGamer(gamers[index].name!, gamer, context, gamers);
        break;
      case RoleType.Killer:
        killGamerByKiller(gamers[index].name!, gamer, context, gamers);
        break;
      case RoleType.Werewolf:
        if (!gamer.beforeChange) {
          killGamerByMafia(gamers[index].name!, gamer, context, gamers);
          break;
        } else {
          break;
        }
      case RoleType.Virus:
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
      case RoleType.Advocate:
        giveAlibi(gamers[index].name!, gamer, context, gamers);
        break;
      case RoleType.Security:
        secureGamer(gamers[index].name!, gamer.id!, context, gamers);
        break;
      case RoleType.Medium:
        mediumChecked(gamers[index].name!, gamer.id!, context, gamers);
        break;
      case RoleType.Chameleon:
        chameleonChanges(context, index, gamer, gamers);
        break;
      case RoleType.Boomerang:
        boomerangGamer(gamers[index].name!, gamer, context, gamers);
        break;
      default:
        break;
    }

    if (roleType != RoleType.Virus) {
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
    final RoleType roleType = gamer.chameleonRoleType;
    print('roleType: $roleType, gamerId: ${gamer.id}');
    switch (roleType) {
      case RoleType.Doctor:
        healGamer(gamers[index].name!, gamer, context, gamers);
        break;
      case RoleType.Mafia:
      case RoleType.Don:
        killGamerByMafia(gamers[index].name!, gamer, context, gamers);
        break;
      case RoleType.Sheriff:
        killGamerBySheriff(gamers[index].name!, gamer, context, gamers);
        break;
      case RoleType.Madam:
        takeAbilityFromGamer(gamers[index].name!, gamer, context, gamers);
        break;
      case RoleType.Killer:
        killGamerByKiller(gamers[index].name!, gamer, context, gamers);
        break;
      case RoleType.Werewolf:
        killGamerByMafia(gamers[index].name!, gamer, context, gamers);
        break;
      case RoleType.Advocate:
        giveAlibi(gamers[index].name!, gamer, context, gamers);
        break;
      case RoleType.Medium:
        mediumChecked(gamers[index].name!, gamer.id!, context, gamers);
        break;
      default:
        break;
    }
    if (roleType != RoleType.Mafia) {
      BlocProvider.of<GameBloc>(context).add(
        const ChameleonChangeRole(chameleonRoleType: RoleType.Civilian),
      );
    }
  }
}
