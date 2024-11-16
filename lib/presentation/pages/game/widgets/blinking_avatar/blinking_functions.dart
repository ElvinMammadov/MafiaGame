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
    final int infectedCount =
        BlocProvider.of<GameBloc>(context).state.game.infectedCount;
    final int nightNumber =
        BlocProvider.of<GameBloc>(context).state.game.nightNumber;
    switch (roleType) {
      case RoleType.Doctor:
        if (gamers[index].role.roleType == RoleType.Doctor) {
          if (gamers[index].healCount == 0) {
            showCantDoHimself(
              context,
              AppStrings.doctorCantHealAnymore,
            );
            return;
          }
        }
        healGamer(gamers[index].name!, gamer, context, gamers);
        break;
      case RoleType.Mafia:
      case RoleType.Don:
        if (gamers[index].role.roleType == RoleType.Mafia ||
            gamers[index].role.roleType == RoleType.Don) {
          showCantDoHimself(context, AppStrings.mafiaCantKillThemself);
          return;
        }
        killGamerByMafia(gamers[index].name!, gamer, context, gamers);
        break;
      case RoleType.Sheriff:
        if (gamers[index].role.roleType == RoleType.Sheriff) {
          showCantDoHimself(context, AppStrings.cantDoSomethingAgainstYourself);
          return;
        }
        killGamerBySheriff(gamers[index].name!, gamer, context, gamers);
        break;
      case RoleType.Madam:
        if (gamers[index].role.roleType == RoleType.Madam) {
          showCantDoHimself(context, AppStrings.cantDoSomethingAgainstYourself);
          return;
        }
        takeAbilityFromGamer(gamers[index].name!, gamer, context, gamers);
        break;
      case RoleType.Killer:
        if (gamers[index].role.roleType == RoleType.Killer) {
          showCantDoHimself(context, AppStrings.cantDoSomethingAgainstYourself);
          return;
        }
        killGamerByKiller(gamers[index].name!, gamer, context, gamers);
        break;
      case RoleType.Werewolf:
        if (!gamer.beforeChange) {
          if (gamers[index].role.roleType == RoleType.Werewolf) {
            showCantDoHimself(
              context,
              AppStrings.cantDoSomethingAgainstYourself,
            );
            return;
          }
          killGamerByMafia(gamers[index].name!, gamer, context, gamers);
          break;
        } else {
          break;
        }
      case RoleType.Virus:
        if (gamers[index].role.roleType == RoleType.Virus) {
          showCantDoHimself(context, AppStrings.cantDoSomethingAgainstYourself);
          return;
        }
        if(infectedCount == 0 || nightNumber >= 3) {
          showErrorSnackBar(
            context: context,
            message: AppStrings.virusCantInfectAnymore,
          );
          return;
        }
        if (infectedCount > 0) {
          infectGamer(
            gamers[index].name!,
            gamer,
            context,
            gamers,
          );
          BlocProvider.of<GameBloc>(context).add(
            InfectedCount(
              infectedCount:
              infectedCount -
                      1,
            ),
          );
          if(infectedCount == 1) {
            final List<Gamer> newlyInfectedGamers = gamers
                .where(
                  (Gamer gamer) => gamer.newlyInfected && !gamer.wasKilled,
            )
                .toList();
            final List<Gamer> infectedGamers = gamers
                .where(
                  (Gamer gamer) => gamer.wasInfected && !gamer.wasKilled,
            )
                .toList();

            if (newlyInfectedGamers.isNotEmpty) {
              for(final Gamer newGamer in infectedGamers) {
                BlocProvider.of<GameBloc>(context).add(
                  InfectGamer(
                    targetedGamer: newGamer,
                    infect: false,
                    changeInfected: true,
                  ),
                );
              }
              for(final Gamer newGamer in newlyInfectedGamers) {
                BlocProvider.of<GameBloc>(context).add(
                  InfectGamer(
                    targetedGamer: newGamer,
                    infect: false,
                    changeInfected: true,
                  ),
                );
              }
            }
            BlocProvider.of<GameBloc>(context).add(
              InfectGamer(
                targetedGamer: gamers[index],
                infect: false,
                changeInfected: true,
              ),
            );
          }
        }
        break;
      case RoleType.Advocate:
        if (gamers[index].role.roleType == RoleType.Advocate) {
          showCantDoHimself(context, AppStrings.cantDoSomethingAgainstYourself);
          return;
        }
        giveAlibi(gamers[index].name!, gamer, context, gamers);
        break;
      case RoleType.Security:
        if (gamers[index].role.roleType == RoleType.Security) {
          showCantDoHimself(context, AppStrings.cantDoSomethingAgainstYourself);
          return;
        }
        secureGamer(gamers[index].name!, gamer.id!, context, gamers);
        break;
      case RoleType.Medium:
        if (gamers[index].role.roleType == RoleType.Medium) {
          showCantDoHimself(context, AppStrings.cantDoSomethingAgainstYourself);
          return;
        }
        mediumChecked(gamers[index].name!, gamer.id!, context, gamers);
        break;
      case RoleType.Chameleon:
        chameleonChanges(context, index, gamer, gamers);
        break;
      case RoleType.Boomerang:
        if (gamers[index].role.roleType == RoleType.Boomerang) {
          showCantDoHimself(context, AppStrings.cantDoSomethingAgainstYourself);
          return;
        }
        boomerangGamer(gamers[index].name!, gamer, context, gamers);
        break;
      default:
        break;
    }

    if (roleType != RoleType.Virus && roleIndex < roles.roles.length - 1) {
      BlocProvider.of<GameBloc>(context).add(
        ChangeRoleIndex(
          roleIndex: roleIndex + 1,
        ),
      );
    }
  }

  void showCantDoHimself(BuildContext context, String message) {
    showErrorSnackBar(
      context: context,
      message: message,
    );
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
