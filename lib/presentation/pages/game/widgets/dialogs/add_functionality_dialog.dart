part of game;

void showAddFunctionality(
  BuildContext context, {
  required bool isVotingStarted,
  required int gamerId,
  required int roleId,
  required int nightNumber,
}) {
  final ValueNotifier<bool> isButtonEnabledNotifier =
      ValueNotifier<bool>(false);
  final TextEditingController textEditingController = TextEditingController();
  textEditingController.addListener(() {
    isButtonEnabledNotifier.value = textEditingController.text.isNotEmpty;
  });

  // final bool nightIsEven = nightNumber.isEven;
  // String buttonTitle;

  final List<Gamer> gamers =
      BlocProvider.of<GameBloc>(context).state.gamersState.gamers;
  final bool isDay = BlocProvider.of<GameBloc>(context).state.game.isDay;

  void addVoteToGamer(String gamerName) {
    for (final Gamer gamer in gamers) {
      if (gamer.name == gamerName) {
        BlocProvider.of<GameBloc>(context).add(
          AddVoteToGamer(gamer: gamer),
        );
        Navigator.of(context).pop();
        break;
      }
    }
  }

  void killGamerByMafia(String gamerName) {
    for (final Gamer gamer in gamers) {
      if (gamer.name == gamerName) {
        BlocProvider.of<GameBloc>(context).add(
          KillGamerByMafia(
            targetedGamer: gamer,
            gamerId: gamerId,
          ),
        );
        Navigator.of(context).pop();
        break;
      }
    }
  }

  void killGamerByKiller(String gamerName) {
    for (final Gamer gamer in gamers) {
      if (gamer.name == gamerName) {
        BlocProvider.of<GameBloc>(context).add(
          KillGamerByKiller(
            targetedGamer: gamer,
            gamerId: gamerId,
          ),
        );
        Navigator.of(context).pop();
        break;
      }
    }
  }

  void killGamerBySheriff(String gamerName) {
    for (final Gamer gamer in gamers) {
      if (gamer.name == gamerName) {
        BlocProvider.of<GameBloc>(context).add(
          KillGamerBySheriff(
            targetedGamer: gamer,
            gamerId: gamerId,
          ),
        );
        Navigator.of(context).pop();
        break;
      }
    }
  }

  void healGamer(String gamerName) {
    for (final Gamer gamer in gamers) {
      if (gamer.name == gamerName) {
        BlocProvider.of<GameBloc>(context).add(
          HealGamer(
            targetedGamer: gamer,
            gamerId: gamerId,
          ),
        );
        Navigator.of(context).pop();
        break;
      }
    }
  }

  void giveAlibi(String gamerName) {
    for (final Gamer gamer in gamers) {
      if (gamer.name == gamerName) {
        BlocProvider.of<GameBloc>(context).add(
          GiveAlibi(
            targetedGamer: gamer,
            gamerId: gamerId,
          ),
        );
        Navigator.of(context).pop();
        break;
      }
    }
  }

  void secureGamer(String gamerName) {
    for (final Gamer gamer in gamers) {
      if (gamer.name == gamerName) {
        BlocProvider.of<GameBloc>(context).add(
          SecureGamer(
            targetedGamer: gamer,
            gamerId: gamerId,
          ),
        );
        Navigator.of(context).pop();
        break;
      }
    }
  }

  void takeAbilityFromGamer(String gamerName) {
    for (final Gamer gamer in gamers) {
      if (gamer.name == gamerName) {
        BlocProvider.of<GameBloc>(context).add(
          TakeAbilityFromGamer(
            targetedGamer: gamer,
            gamerId: gamerId,
          ),
        );
        Navigator.of(context).pop();
        break;
      }
    }
  }

  // void createFunctionality() {
  //   switch (roleId) {
  //     case 1:
  //       buttonTitle = AppStrings.healGamer;
  //       break;
  //     case 2:
  //     case 3:
  //     case 6:
  //       buttonTitle = AppStrings.killGamer;
  //       break;
  //     case 4:
  //       buttonTitle = AppStrings.killGamer;
  //       break;
  //     case 5:
  //       buttonTitle = AppStrings.takeAwayAbility;
  //       break;
  //     case 9:
  //       buttonTitle = AppStrings.giveAlibi;
  //       break;
  //     case 10:
  //       buttonTitle = AppStrings.secureGamer;
  //       break;
  //     default:
  //       break;
  //   }
  // }

  List<String> getVotingItems(List<Gamer> gamers) => gamers
      .where((Gamer gamer) => gamer.id != gamerId && !gamer.wasKilled)
      .map((Gamer gamer) => gamer.name!)
      .toList();

  List<String> getKillingItems(List<Gamer> gamers) => gamers
      .where(
        (Gamer gamer) =>
            gamer.id != gamerId &&
            !gamer.wasKilled &&
            (gamer.role!.roleId != 2 && gamer.role!.roleId != 3),
      )
      .map((Gamer gamer) => gamer.name!)
      .toList();

  List<String> getSheriffItems(List<Gamer> gamers) => gamers
      .where(
        (Gamer gamer) =>
            gamer.id != gamerId &&
            !gamer.wasKilled &&
            (gamer.role!.roleId == 2 || gamer.role!.roleId == 3),
      )
      .map((Gamer gamer) => gamer.name!)
      .toList();

  // createFunctionality();

  Widget returnWidget() {
    switch (roleId) {
      case 1:
        return FunctionalDropDownButton(
          items: getVotingItems(gamers),
          title: AppStrings.healGamer,
          onChanged: (String gamerName) {
            healGamer(gamerName);
          },
        );
      case 2:
      case 3:
        return FunctionalDropDownButton(
          items: getKillingItems(gamers),
          title: AppStrings.killGamer,
          onChanged: (String gamerName) {
            killGamerByMafia(gamerName);
          },
        );
      case 4:
        return FunctionalDropDownButton(
          items: getSheriffItems(gamers),
          title: AppStrings.killGamer,
          onChanged: (String gamerName) {
            killGamerBySheriff(gamerName);
          },
        );
      case 5:
        return FunctionalDropDownButton(
          items: getVotingItems(gamers),
          title: AppStrings.takeAwayAbility,
          onChanged: (String gamerName) {
            takeAbilityFromGamer(gamerName);
          },
        );
      case 6:
        return FunctionalDropDownButton(
          items: getVotingItems(gamers),
          title: AppStrings.killGamer,
          onChanged: (String gamerName) {
            killGamerByKiller(gamerName);
          },
        );
      case 9:
        return FunctionalDropDownButton(
          items: getVotingItems(gamers),
          title: AppStrings.giveAlibi,
          onChanged: (String gamerName) {
            giveAlibi(gamerName);
          },
        );
      case 10:
        return FunctionalDropDownButton(
          items: getVotingItems(gamers),
          title: AppStrings.secureGamer,
          onChanged: (String gamerName) {
            secureGamer(gamerName);
          },
        );
      default:
        return const SizedBox.shrink();
    }
  }

  WoltModalSheet.show<void>(
    context: context,
    pageListBuilder: (BuildContext modalSheetContext) =>
        <SliverWoltModalSheetPage>[
      WoltModalSheetPage(
        hasSabGradient: false,
        isTopBarLayerAlwaysVisible: true,
        hasTopBarLayer: false,
        trailingNavBarWidget: Padding(
          padding: const EdgeInsets.only(
            right: 16,
          ),
          child: IconButton(
            onPressed: Navigator.of(context).pop,
            icon: const Icon(
              Icons.close,
              size: 32,
              color: Colors.white,
            ),
          ),
        ),
        child: Column(
          children: <Widget>[
            if (isVotingStarted)
              FunctionalDropDownButton(
                items: getVotingItems(gamers),
                title: AppStrings.vote,
                onChanged: (String gamerName) {
                  addVoteToGamer(gamerName);
                },
              ),
            if (!isDay) returnWidget(),
            BaseButton(
              label: AppStrings.fol,
              textStyle: MafiaTheme.themeData.textTheme.headlineSmall,
              backgroundColor:
                  MafiaTheme.themeData.colorScheme.secondary.withOpacity(0.5),
              action: () {
                BlocProvider.of<GameBloc>(context).add(
                  AddFaultToGamer(gamerId: gamerId),
                );
                Navigator.of(context).pop();
              },
            ),
            BaseButton(
              label: AppStrings.profile,
              textStyle: MafiaTheme.themeData.textTheme.headlineSmall,
              backgroundColor:
                  MafiaTheme.themeData.colorScheme.secondary.withOpacity(0.5),
              action: () {
                Navigator.of(context).pop();
              },
            ),
            BaseButton(
              label: AppStrings.delete,
              textStyle: MafiaTheme.themeData.textTheme.headlineSmall,
              backgroundColor: MafiaTheme.themeData.colorScheme.primary,
              action: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    ],
    modalTypeBuilder: (BuildContext context) => WoltModalType.dialog,
  );
}
