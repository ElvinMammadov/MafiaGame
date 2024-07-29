part of game;

class GameBloc extends Bloc<GameEvent, AppState> {
  final GameRepository gameRepository;

  GameBloc(this.gameRepository) : super(const AppState.empty()) {
    on<UpdateGameDetails>((
      UpdateGameDetails event,
      Emitter<AppState> emit,
    ) {
      final AppState appState = state.copyWith(
        game: state.game.copyWith(
          gameName: event.gameName,
          typeOfGame: event.typeOfGame,
          typeOfController: event.typeOfController,
          numberOfGamers: event.numberOfGamers,
          gameStartTime: DateTime.now(),
          gameId: event.gameId,
        ),
        gamers: state.gamersState.copyWith(
          roles: state.gamersState.roles.copyWith(
            roles: event.roles,
          ),
        ),
      );
      emit(appState);
    });

    on<EmptyGame>((EmptyGame event, Emitter<AppState> emit) {
      final List<Gamer> oldGamer = state.gamersState.gamers;
      final List<Gamer> updatedGamers = <Gamer>[];
      for (int i = 0; i < oldGamer.length; i++) {
        updatedGamers.add(
          Gamer(
            name: oldGamer[i].name,
            imageUrl: oldGamer[i].imageUrl,
            id: i + 1,
            isNameChanged: oldGamer[i].isNameChanged,
            positionOnTable: i + 1,
            gamerId: oldGamer[i].gamerId,
            role: const Mirniy.empty(),
          ),
        );
      }

      final AppState appState = state.copyWith(
        game: state.game.copyWith(
          gameName: '',
          typeOfGame: '',
          typeOfController: '',
          numberOfGamers: 0,
          gameId: '',
          gamers: const <Gamer>[],
          isGameCouldStart: false,
          isDiscussionStarted: false,
          isGameStarted: false,
          isVotingStarted: false,
          discussionTime: 30,
          votingTime: 30,
          isDay: true,
          dayNumber: 1,
          nightNumber: 1,
          mafiaCount: 0,
          civilianCount: 0,
          isMafiaWin: false,
          roleIndex: 0,
          infectedCount: 0,
          currentVoter: const Gamer.empty(),
          votedGamers: const <Gamer>[],
        ),
        gamers: state.gamersState.copyWith(gamers: updatedGamers),
      );
      log('AppState isGameCouldStart is : ${appState.game.isGameCouldStart}');
      emit(appState);
    });

    on<ChangeGameStartValue>((
      ChangeGameStartValue event,
      Emitter<AppState> emit,
    ) {
      final AppState appState = state.copyWith(
        game: state.game.copyWith(
          isGameCouldStart: event.isGameCouldStart,
        ),
      );
      emit(appState);
    });

    on<EndDiscussion>((EndDiscussion event, Emitter<AppState> emit) {
      final AppState appState = state.copyWith(
        game: state.game.copyWith(
          isDiscussionStarted: event.isDiscussionStarted,
          isVotingStarted: true,
        ),
      );
      emit(appState);
    });

    on<EndVoting>((EndVoting event, Emitter<AppState> emit) {
      final AppState appState = state.copyWith(
        game: state.game.copyWith(
          isVotingStarted: event.isVotingStarted,
          // isDiscussionStarted: true,
        ),
      );
      emit(appState);
    });

    on<ChangeDiscussionTime>(
        (ChangeDiscussionTime event, Emitter<AppState> emit) {
      final AppState appState = state.copyWith(
        game: state.game.copyWith(
          discussionTime: event.discussionTime,
        ),
      );
      emit(appState);
    });

    on<ChangeVotingTime>((ChangeVotingTime event, Emitter<AppState> emit) {
      final AppState appState = state.copyWith(
        game: state.game.copyWith(
          votingTime: event.votingTime,
        ),
      );
      emit(appState);
    });

    Gamer updatePoints({
      required bool isGamerMafia,
      required bool isGamerMainCharacter,
      required bool isGamerCivilian,
      required Map<String, int> updatedPoints,
      required int againstMafia,
      required int againstMainCharacters,
      required Gamer gamer,
    }) {
      if (isGamerMafia) {
        updatedPoints[AppStrings.votedAgainstMafia] =
            (updatedPoints[AppStrings.votedAgainstMafia] ?? 0) + againstMafia;
      }
      if (isGamerMainCharacter || isGamerCivilian) {
        updatedPoints[AppStrings.votedAgainstMainRoles] =
            (updatedPoints[AppStrings.votedAgainstMainRoles] ?? 0) -
                againstMainCharacters;
      }

      return gamer.copyWith(
        wasVoted: true,
        role: gamer.role?.copyWith(
          points: updatedPoints,
        ),
      );
    }

    on<AddVoteToGamer>((AddVoteToGamer event, Emitter<AppState> emit) {
      final int? roleVoterId = event.voter.role?.roleId;
      final int? roleGamerId = event.gamer.role?.roleId;

      final bool isVoterMafia = roleVoterId == 2 || roleVoterId == 3;
      final bool isVoterCivilian = roleVoterId == 11;
      final bool isVoterMainCharacter =
          roleVoterId != 2 && roleVoterId != 3 && roleVoterId != 11;

      final bool isGamerMafia = roleGamerId == 2 || roleGamerId == 3;
      final bool isGamerCivilian = roleGamerId == 11;
      final bool isGamerMainCharacter =
          roleGamerId != 2 && roleGamerId != 3 && roleGamerId != 11;
      final bool isTargetedMainCharacter =
          roleGamerId == 4 || roleGamerId == 5 || roleGamerId == 12;
      final bool isTargetedOther =
          !isTargetedMainCharacter && !isGamerCivilian && !isGamerMafia;
      print('isTargetedMafia: $isVoterMafia, '
          'isTargetedCivilian: $isVoterCivilian, '
          'isTargetedMainCharacter: $isVoterMainCharacter');
      print('isGamerMafia: $isGamerMafia, isGamerCivilian: $isGamerCivilian, '
          'isGamerMainCharacter: $isGamerMainCharacter,'
          ' isTargetedOther: $isTargetedOther');
      final AppState appState = state.copyWith(
        gamers: state.gamersState.copyWith(
          gamers: state.gamersState.gamers.map((Gamer gamer) {
            if (gamer.id == event.gamer.id) {
              return gamer.copyWith(votesCount: gamer.votesCount + 1);
            } else if (gamer.id == event.voter.id) {
              print('role id is ${gamer.role?.roleId}');
              final Map<String, int> updatedPoints =
                  Map<String, int>.from(gamer.role!.points ?? <String, int>{});
              switch (gamer.role?.roleId) {
                case 1:
                  return updatePoints(
                    isGamerMafia: isGamerMafia,
                    isGamerMainCharacter: isGamerMainCharacter,
                    isGamerCivilian: isGamerCivilian,
                    updatedPoints: updatedPoints,
                    againstMafia: 1,
                    againstMainCharacters: 1,
                    gamer: gamer,
                  );
                case 2:
                case 3:
                  if (isGamerMafia) {
                    updatedPoints[AppStrings.votedAgainstMafia] =
                        (updatedPoints[AppStrings.votedAgainstMafia] ?? 0) - 1;
                  }
                  if (isTargetedMainCharacter) {
                    updatedPoints[AppStrings.votedAgainstMainRoles] =
                        (updatedPoints[AppStrings.votedAgainstMainRoles] ?? 0) +
                            2;
                  }
                  if (isTargetedOther) {
                    updatedPoints[AppStrings.votedAgainstOthers] =
                        (updatedPoints[AppStrings.votedAgainstOthers] ?? 0) + 1;
                  }
                  return gamer.copyWith(
                    wasVoted: true,
                    role: gamer.role?.copyWith(
                      points: updatedPoints,
                    ),
                  );
                case 4:
                  return updatePoints(
                    isGamerMafia: isGamerMafia,
                    isGamerMainCharacter: isGamerMainCharacter,
                    isGamerCivilian: isGamerCivilian,
                    updatedPoints: updatedPoints,
                    againstMafia: 1,
                    againstMainCharacters: 1,
                    gamer: gamer,
                  );
                case 5:
                  return updatePoints(
                    isGamerMafia: isGamerMafia,
                    isGamerMainCharacter: isGamerMainCharacter,
                    isGamerCivilian: isGamerCivilian,
                    updatedPoints: updatedPoints,
                    againstMafia: 1,
                    againstMainCharacters: 1,
                    gamer: gamer,
                  );
                case 6:
                  return updatePoints(
                    isGamerMafia: isGamerMafia,
                    isGamerMainCharacter: isGamerMainCharacter,
                    isGamerCivilian: isGamerCivilian,
                    updatedPoints: updatedPoints,
                    againstMafia: 1,
                    againstMainCharacters: 1,
                    gamer: gamer,
                  );
                case 7:
                  return updatePoints(
                    isGamerMafia: isGamerMafia,
                    isGamerMainCharacter: isGamerMainCharacter,
                    isGamerCivilian: isGamerCivilian,
                    updatedPoints: updatedPoints,
                    againstMafia: gamer.beforeChange ? 2 : 0,
                    againstMainCharacters: gamer.beforeChange ? -1 : 0,
                    gamer: gamer,
                  );
                case 8:
                  return updatePoints(
                    isGamerMafia: isGamerMafia,
                    isGamerMainCharacter: isGamerMainCharacter,
                    isGamerCivilian: isGamerCivilian,
                    updatedPoints: updatedPoints,
                    againstMafia: 1,
                    againstMainCharacters: 1,
                    gamer: gamer,
                  );
                case 9:
                  return updatePoints(
                    isGamerMafia: isGamerMafia,
                    isGamerMainCharacter: isGamerMainCharacter,
                    isGamerCivilian: isGamerCivilian,
                    updatedPoints: updatedPoints,
                    againstMafia: 1,
                    againstMainCharacters: 1,
                    gamer: gamer,
                  );
                case 10:
                  return updatePoints(
                    isGamerMafia: isGamerMafia,
                    isGamerMainCharacter: isGamerMainCharacter,
                    isGamerCivilian: isGamerCivilian,
                    updatedPoints: updatedPoints,
                    againstMafia: 1,
                    againstMainCharacters: 1,
                    gamer: gamer,
                  );

                case 11:
                  if (roleGamerId == 2) {
                    updatedPoints[AppStrings.votedAgainstMainRoles] =
                        (updatedPoints[AppStrings.votedAgainstMainRoles] ?? 0) +
                            2;
                  } else if (roleGamerId == 3) {
                    updatedPoints[AppStrings.votedAgainstMafia] =
                        (updatedPoints[AppStrings.votedAgainstMafia] ?? 0) + 1;
                  } else if (isGamerMainCharacter || isGamerCivilian) {
                    updatedPoints[AppStrings.votedAgainstMainRoles] =
                        (updatedPoints[AppStrings.votedAgainstMainRoles] ?? 0) -
                            1;
                  }
                  return gamer.copyWith(
                    wasVoted: true,
                    role: gamer.role?.copyWith(
                      points: updatedPoints,
                    ),
                  );
                case 12:
                  return updatePoints(
                    isGamerMafia: isGamerMafia,
                    isGamerMainCharacter: isGamerMainCharacter,
                    isGamerCivilian: isGamerCivilian,
                    updatedPoints: updatedPoints,
                    againstMafia: 1,
                    againstMainCharacters: 1,
                    gamer: gamer,
                  );
                case 13:
                  return updatePoints(
                    isGamerMafia: isGamerMafia,
                    isGamerMainCharacter: isGamerMainCharacter,
                    isGamerCivilian: isGamerCivilian,
                    updatedPoints: updatedPoints,
                    againstMafia: gamer.playsAsCitizen ? 1 : -1,
                    againstMainCharacters: gamer.playsAsCitizen
                        ? 1
                        : isGamerCivilian
                            ? 0
                            : -2,
                    gamer: gamer,
                  );
                case 14:
                  return updatePoints(
                    isGamerMafia: isGamerMafia,
                    isGamerMainCharacter: isGamerMainCharacter,
                    isGamerCivilian: isGamerCivilian,
                    updatedPoints: updatedPoints,
                    againstMafia: 1,
                    againstMainCharacters: 1,
                    gamer: gamer,
                  );
                default:
                  return gamer;
              }
            }
            return gamer;
          }).toList(),
        ),
      );
      log('Voters points: ${appState.gamersState.gamers.map(
        (Gamer gamer) => <String, Object?>{
          'name': gamer.role?.name,
          'points': gamer.role?.points,
        },
      )}');
      emit(appState);
    });

    on<AddFaultToGamer>((AddFaultToGamer event, Emitter<AppState> emit) {
      final AppState appState = state.copyWith(
        gamers: state.gamersState.copyWith(
          gamers: state.gamersState.gamers.map((Gamer gamer) {
            if (gamer.id == event.gamerId) {
              return gamer.copyWith(foulCount: gamer.foulCount + 1);
            }
            return gamer;
          }).toList(),
        ),
      );
      emit(appState);
    });

    on<AddGamer>((AddGamer event, Emitter<AppState> emit) {
      final AppState appState = state.copyWith(
        gamers: state.gamersState.copyWith(
          gamers: List<Gamer>.from(state.gamersState.gamers)..add(event.gamer),
        ),
      );
      emit(appState);
    });

    on<RearrangeGamersPosition>(
        (RearrangeGamersPosition event, Emitter<AppState> emit) {
      final List<Gamer> updatedGamersList =
          List<Gamer>.from(state.gamersState.gamers);
      int currentPosition = 1;
      for (int i = event.newPosition - 1; i < updatedGamersList.length; i++) {
        updatedGamersList[i] =
            updatedGamersList[i].copyWith(positionOnTable: currentPosition);
        currentPosition++;
      }
      for (int i = 0; i < event.newPosition - 1; i++) {
        updatedGamersList[i] =
            updatedGamersList[i].copyWith(positionOnTable: currentPosition);
        currentPosition++;
      }
      emit(
        state.copyWith(
          gamers: state.gamersState.copyWith(gamers: updatedGamersList),
        ),
      );
    });

    on<CleanGamers>((CleanGamers event, Emitter<AppState> emit) {
      final AppState appState = state.copyWith(
        gamers: state.gamersState.copyWith(
          gamers: <Gamer>[],
        ),
      );
      emit(appState);
    });

    on<SaveGame>((SaveGame event, Emitter<AppState> emit) async {
      try {
        final int mafiaCount = event.gameState.gamers
            .where(
              (Gamer gamer) =>
                  gamer.role?.roleId == 2 || gamer.role?.roleId == 3,
            )
            .toList()
            .length;
        final int civilianCount = event.gameState.gamers.length - mafiaCount;
        // print('mafiaCount: $mafiaCount, civilianCount: $civilianCount');
        emit(
          state.copyWith(
            game: state.game.copyWith(
              isGameStarted: true,
              isDiscussionStarted: true,
              mafiaCount: mafiaCount,
              civilianCount: civilianCount,
            ),
          ),
        );
      } catch (e) {
        print('Error saving game: $e');
      }
    });

    on<SendGameToFirebase>(
        (SendGameToFirebase event, Emitter<AppState> emit) async {
      try {
        await gameRepository.addGameToFirebase(
          gameState: event.gameState,
        );

        emit(
          state.copyWith(
            game: event.gameState,
          ),
        );
      } catch (e) {
        print('Error sending data to Firebase: $e');
      }
    });

    on<CalculatePoints>((CalculatePoints event, Emitter<AppState> emit) {
      int calculateTotalPoints(Map<String, int> points) => points.entries
          .where(
            (MapEntry<String, int> entry) =>
                entry.key != AppStrings.totalPoints,
          )
          .fold<int>(
            0,
            (int sum, MapEntry<String, int> entry) => sum + entry.value,
          );

      final List<Gamer> updatedGamers = state.gamersState.gamers.map(
        (Gamer gamer) {
          final Map<String, int> updatedPoints =
              Map<String, int>.from(gamer.role!.points ?? <String, int>{});
          if (event.gameState.isMafiaWin) {
            if ((gamer.role?.roleId == 2 && !gamer.wasKilled) ||
                (gamer.role?.roleId == 3 && !gamer.wasKilled)) {
              if (gamer.wasKilled) {
                updatedPoints[AppStrings.alivePoints] =
                    (updatedPoints[AppStrings.alivePoints] ?? 0) + 2;
              } else {
                updatedPoints[AppStrings.alivePoints] =
                    (updatedPoints[AppStrings.alivePoints] ?? 0) + 3;
              }
              updatedPoints[AppStrings.totalPoints] =
                  calculateTotalPoints(updatedPoints);
            }
            if(gamer.role?.roleId == 7){
              updatedPoints[AppStrings.alivePoints] =
                  (updatedPoints[AppStrings.alivePoints] ?? 0) + 4;
              updatedPoints[AppStrings.totalPoints] =
                  calculateTotalPoints(updatedPoints);
            }
          } else {
            switch (gamer.role?.roleId) {
              case 1:
                updatedPoints[AppStrings.alivePoints] =
                    (updatedPoints[AppStrings.alivePoints] ?? 0) + 3;
                updatedPoints[AppStrings.totalPoints] =
                    calculateTotalPoints(updatedPoints);
                break;
              case 4:
                updatedPoints[AppStrings.alivePoints] =
                    (updatedPoints[AppStrings.alivePoints] ?? 0) + 4;
                updatedPoints[AppStrings.totalPoints] =
                    calculateTotalPoints(updatedPoints);
                break;
              case 5:
                updatedPoints[AppStrings.alivePoints] =
                    (updatedPoints[AppStrings.alivePoints] ?? 0) + 4;
                updatedPoints[AppStrings.totalPoints] =
                    calculateTotalPoints(updatedPoints);
                break;
              case 6:
                updatedPoints[AppStrings.alivePoints] =
                    (updatedPoints[AppStrings.alivePoints] ?? 0) + 3;
                updatedPoints[AppStrings.totalPoints] =
                    calculateTotalPoints(updatedPoints);
                break;
              case 8:
                updatedPoints[AppStrings.alivePoints] =
                    (updatedPoints[AppStrings.alivePoints] ?? 0) + 2;
                updatedPoints[AppStrings.totalPoints] =
                    calculateTotalPoints(updatedPoints);
                break;
              case 9:
                updatedPoints[AppStrings.alivePoints] =
                    (updatedPoints[AppStrings.alivePoints] ?? 0) + 3;
                updatedPoints[AppStrings.totalPoints] =
                    calculateTotalPoints(updatedPoints);
                break;
              case 10:
                updatedPoints[AppStrings.alivePoints] =
                    (updatedPoints[AppStrings.alivePoints] ?? 0) + 2;
                updatedPoints[AppStrings.totalPoints] =
                    calculateTotalPoints(updatedPoints);
                break;

              case 11: if(gamer.wasKilled){
                updatedPoints[AppStrings.alivePoints] =
                    (updatedPoints[AppStrings.alivePoints] ?? 0) + 1;
                updatedPoints[AppStrings.totalPoints] =
                    calculateTotalPoints(updatedPoints);
              } else{
                updatedPoints[AppStrings.alivePoints] =
                    (updatedPoints[AppStrings.alivePoints] ?? 0) + 2;
                updatedPoints[AppStrings.totalPoints] =
                    calculateTotalPoints(updatedPoints);
              }
                break;
              case 12:
                updatedPoints[AppStrings.alivePoints] =
                    (updatedPoints[AppStrings.alivePoints] ?? 0) + 3;
                updatedPoints[AppStrings.totalPoints] =
                    calculateTotalPoints(updatedPoints);
                break;
              case 13: if(gamer.wasKilled){
                updatedPoints[AppStrings.alivePoints] =
                    (updatedPoints[AppStrings.alivePoints] ?? 0) + 1;
                updatedPoints[AppStrings.totalPoints] =
                    calculateTotalPoints(updatedPoints);
              } else{
                updatedPoints[AppStrings.alivePoints] =
                    (updatedPoints[AppStrings.alivePoints] ?? 0) + 2;
                updatedPoints[AppStrings.totalPoints] =
                    calculateTotalPoints(updatedPoints);
              }
                break;
              case 14:
                updatedPoints[AppStrings.alivePoints] =
                    (updatedPoints[AppStrings.alivePoints] ?? 0) + 2;
                updatedPoints[AppStrings.totalPoints] =
                    calculateTotalPoints(updatedPoints);
                break;
            }
          }
          return gamer.copyWith(
            role: gamer.role?.copyWith(
              points: updatedPoints,
            ),
          );
        },
      ).toList();
      emit(
        state.copyWith(
          gamers: state.gamersState.copyWith(gamers: updatedGamers),
        ),
      );
      add(CalculatePoints(gameState: event.gameState));
    });

    on<GetGames>((GetGames event, Emitter<AppState> emit) async {
      try {
        final List<GameState> games =
            await gameRepository.getGames(event.dateTime);
        // logger.log('Games: $games');
        emit(state.copyWith(games: games));
      } catch (e) {
        print('Error getting games: $e');
      }
    });

    on<AddDayNumber>((AddDayNumber event, Emitter<AppState> emit) {
      final AppState appState = state.copyWith(
        game: state.game.copyWith(
          dayNumber: state.game.dayNumber + 1,
          isDay: false,
        ),
      );
      emit(appState);
    });

    on<AddNightNumber>((AddNightNumber event, Emitter<AppState> emit) {
      final AppState appState = state.copyWith(
        game: state.game.copyWith(
          nightNumber: state.game.nightNumber + 1,
          isDay: true,
          isDiscussionStarted: true,
        ),
      );
      emit(appState);
    });

    on<KillGamer>((KillGamer event, Emitter<AppState> emit) {
      final int roleToRemoveId = event.gamer.role?.roleId ?? 0;

      final List<Role> updatedRoles = state.gamersState.roles.roles
          .where((Role role) => role.roleId != roleToRemoveId)
          .toList();
      final Roles updatedRolesState = state.gamersState.roles.copyWith(
        roles: updatedRoles,
      );
      final bool isVirus = event.gamer.role?.roleId == 8;
      final bool isDay = state.game.isDay;
      final bool isKilledMafia =
          event.gamer.role?.roleId == 2 || event.gamer.role?.roleId == 3;
      final bool wasCheckedByMadam = event.gamer.wasCheckedByMadam;

      emit(
        state.copyWith(
          game: event.gamer.role?.roleId == 2 || event.gamer.role?.roleId == 3
              ? state.game.copyWith(mafiaCount: state.game.mafiaCount - 1)
              : state.game
                  .copyWith(civilianCount: state.game.civilianCount - 1),
          gamers: state.gamersState.copyWith(
            gamers: state.gamersState.gamers.map((Gamer gamer) {
              if (gamer.id == event.gamer.id) {
                if (isDay && gamer.hasAlibi) {
                  return gamer;
                } else if (!isDay && gamer.wasSecured) {
                  return gamer;
                } else {
                  return gamer.copyWith(wasKilled: true);
                }
              } else if (isVirus && gamer.wasInfected) {
                return gamer.copyWith(wasKilled: true);
              } else if (isDay &&
                  wasCheckedByMadam &&
                  isKilledMafia &&
                  gamer.role?.roleId == 5) {
                ///Madam points after death of gamer
                final Map<String, int> updatedPoints = Map<String, int>.from(
                  gamer.role!.points ?? <String, int>{},
                );
                updatedPoints[AppStrings.mafiaTriedToKillBeforeChange] =
                    (updatedPoints[AppStrings.mafiaTriedToKillBeforeChange] ??
                            0) +
                        1;
                return gamer.copyWith(
                  role: gamer.role?.copyWith(points: updatedPoints),
                );
              } else if (gamer.role?.roleId == 8 && gamer.wasKilled) {
                ///Virus points after death of gamer
                final Map<String, int> updatedPoints = Map<String, int>.from(
                  gamer.role!.points ?? <String, int>{},
                );
                isKilledMafia
                    ? updatedPoints[AppStrings.infectedMafia] =
                        (updatedPoints[AppStrings.infectedMafia] ?? 0) + 1
                    : updatedPoints[AppStrings.killedCitizens] =
                        (updatedPoints[AppStrings.killedCitizens] ?? 0) - 1;
                return gamer.copyWith(
                  role: gamer.role?.copyWith(points: updatedPoints),
                );
              } else if (isDay &&
                  gamer.role?.roleId == 12 &&
                  gamer.wasCheckedByMedium) {
                ///Points for Medium if gamer was checked by Medium
                final Map<String, int> updatedPoints = Map<String, int>.from(
                  gamer.role!.points ?? <String, int>{},
                );
                if (isKilledMafia) {
                  updatedPoints[AppStrings.pointsIfCheckerDead] =
                      (updatedPoints[AppStrings.pointsIfCheckerDead] ?? 0) + 2;
                }
                return gamer.copyWith(
                  role: gamer.role?.copyWith(points: updatedPoints),
                );
              } else if (isDay && gamer.role?.roleId == 7) {
                final Map<String, int> updatedPoints = Map<String, int>.from(
                  gamer.role!.points ?? <String, int>{},
                );
                updatedPoints[AppStrings.killedCitizensAfterChange] =
                    (updatedPoints[AppStrings.killedCitizensAfterChange] ?? 0) +
                        1;
                return gamer.copyWith(
                  role: gamer.role?.copyWith(points: updatedPoints),
                );
              } else if (!isDay &&
                  event.gamer.wasSecured &&
                  gamer.role?.roleId == 10) {
                ///Points for Security if gamer was secured
                final Map<String, int> updatedPoints = Map<String, int>.from(
                  gamer.role!.points ?? <String, int>{},
                );
                isKilledMafia
                    ? updatedPoints[AppStrings.securedMafia] =
                        (updatedPoints[AppStrings.securedMafia] ?? 0) - 1
                    : updatedPoints[AppStrings.securedCitizen] =
                        (updatedPoints[AppStrings.securedCitizen] ?? 0) + 3;
                return gamer.copyWith(
                  role: gamer.role?.copyWith(points: updatedPoints),
                );
              } else if (isDay &&
                  gamer.role?.roleId == 9 &&
                  event.gamer.hasAlibi) {
                //Points for Advocate if gamer has alibi
                final Map<String, int> updatedPoints = Map<String, int>.from(
                  gamer.role!.points ?? <String, int>{},
                );
                isKilledMafia
                    ? updatedPoints[AppStrings.mafiaAlibiWorked] =
                        (updatedPoints[AppStrings.mafiaAlibiWorked] ?? 0) - 1
                    : updatedPoints[AppStrings.citizenAlibiWorked] =
                        (updatedPoints[AppStrings.citizenAlibiWorked] ?? 0) + 2;
                return gamer.copyWith(
                  role: gamer.role?.copyWith(points: updatedPoints),
                );
              } else if (isDay && gamer.role?.roleId == 6) {
                final Map<String, int> updatedPoints = Map<String, int>.from(
                  gamer.role!.points ?? <String, int>{},
                );
                isKilledMafia
                    ? updatedPoints[AppStrings.killedMafias] =
                        (updatedPoints[AppStrings.killedMafias] ?? 0) + 2
                    : updatedPoints[AppStrings.killedCitizens] =
                        (updatedPoints[AppStrings.killedCitizens] ?? 0) - 1;
                return gamer.copyWith(
                  role: gamer.role?.copyWith(points: updatedPoints),
                );
              } else {
                return gamer.copyWith(votesCount: 0);
              }
            }).toList(),
            roles: updatedRolesState,
          ),
        ),
      );
    });

    on<HealGamer>((HealGamer event, Emitter<AppState> emit) {
      final bool isTargetingSelf = event.doctor.id == event.targetedGamer.id;
      final int targetedIndex = state.gamersState.gamers
          .indexWhere((Gamer gamer) => gamer.id == event.targetedGamer.id);
      final bool isTargetedMafia = event.targetedGamer.role?.roleId == 2 ||
          event.targetedGamer.role?.roleId == 3;
      final int healCount = event.targetedGamer.healCount;
      if (targetedIndex != -1 && (healCount != 0 && event.doctor.canTarget)) {
        final List<Gamer> updatedGamers =
            state.gamersState.gamers.map((Gamer gamer) {
          print('mafiaGamer.id  ${gamer.id}, '
              'event.targetedGamer.id '
              '${event.targetedGamer.id},'
              'event.gamerId  ${event.doctor.id},');
          if (gamer.id == event.targetedGamer.id) {
            return gamer.copyWith(
              wasHealed: true,
              healCount: isTargetingSelf ? healCount - 1 : healCount,
            );
          } else if (gamer.id == event.doctor.id) {
            final Map<String, int> updatedPoints = Map<String, int>.from(
              event.doctor.role!.points ?? <String, int>{},
            );
            isTargetedMafia
                ? updatedPoints[AppStrings.healedMafia] =
                    (updatedPoints[AppStrings.healedMafia] ?? 0) - 1
                : updatedPoints[AppStrings.healedCitizen] =
                    (updatedPoints[AppStrings.healedCitizen] ?? 0) + 2;

            return gamer.copyWith(
              role: gamer.role?.copyWith(points: updatedPoints),
            );
          } else {
            return gamer;
          }
        }).toList();
        emit(
          state.copyWith(
            gamers: state.gamersState.copyWith(gamers: updatedGamers),
          ),
        );
      }
    });

    on<KillGamerByMafia>((KillGamerByMafia event, Emitter<AppState> emit) {
      print('KillGamerByMafia  ${event.targetedGamer.role?.roleId}');
      final int? roleTargetedId = event.targetedGamer.role?.roleId;
      final int? roleGamerId = event.mafiaGamer.role?.roleId;
      final Gamer mafiaGamer = event.mafiaGamer;
      print('Gamer name: ${mafiaGamer.name}, role id: $roleGamerId');
      final bool isTargetedMafia = roleTargetedId == 2 || roleTargetedId == 3;
      final bool isTargetedCivilian = roleTargetedId == 11;
      final bool isTargetedMainCharacter =
          roleTargetedId == 4 || roleTargetedId == 5 || roleTargetedId == 12;

      print('isTargetedMafia: $isTargetedMafia, '
          'isTargetedCivilian: $isTargetedCivilian, '
          'isTargetedMainCharacter: $isTargetedMainCharacter');
      final bool isTargetingSelf =
          event.mafiaGamer.id == event.targetedGamer.id;
      final int targetedIndex = state.gamersState.gamers
          .indexWhere((Gamer gamer) => gamer.id == event.targetedGamer.id);

      if (targetedIndex != -1 && (isTargetingSelf || mafiaGamer.canTarget)) {
        final List<Gamer> updatedGamers = state.gamersState.gamers.map((
          Gamer gamer,
        ) {
          if (gamer.id == event.targetedGamer.id) {
            //If Mafia wants to kill Werewolf +1 point for Werewolf
            if (gamer.id == 7) {
              print('Werewolf is killed by Mafia');
              final Map<String, int> updatedPoints =
                  Map<String, int>.from(gamer.role!.points ?? <String, int>{});
              updatedPoints[AppStrings.mafiaTriedToKillBeforeChange] =
                  (updatedPoints[AppStrings.mafiaTriedToKillBeforeChange] ??
                          0) +
                      1;
              return gamer.copyWith(
                role: gamer.role?.copyWith(points: updatedPoints),
              );
            } else {
              return gamer.copyWith(wasKilledByMafia: true);
            }
          } else if (gamer.role?.roleId == 2 || gamer.role?.roleId == 3) {
            final Map<String, int> updatedPoints =
                Map<String, int>.from(gamer.role!.points ?? <String, int>{});
            print('updatedPoints 1: $updatedPoints');
            if (isTargetedMainCharacter) {
              updatedPoints[AppStrings.votedAgainstMainRoles] =
                  (updatedPoints[AppStrings.votedAgainstMainRoles] ?? 0) + 2;
            } else if (!isTargetedCivilian && !isTargetedMafia) {
              updatedPoints[AppStrings.votedAgainstOthers] =
                  (updatedPoints[AppStrings.votedAgainstOthers] ?? 0) + 1;
            }
            print('updatedPoints 2: $updatedPoints');
            return gamer.copyWith(
              targetId: event.targetedGamer.id,
              role: gamer.role?.copyWith(points: updatedPoints),
            );
          } else if (event.mafiaGamer.role?.roleId == 7 &&
              gamer.role?.roleId == 7) {
            final Map<String, int> updatedPoints = Map<String, int>.from(
              event.mafiaGamer.role!.points ?? <String, int>{},
            );
            isTargetedCivilian
                ? updatedPoints[AppStrings.killedCitizensAfterChange] =
                    (updatedPoints[AppStrings.killedCitizensAfterChange] ?? 0) +
                        1
                : updatedPoints[AppStrings.killedMainCharactersAfterChange] =
                    (updatedPoints[
                                AppStrings.killedMainCharactersAfterChange] ??
                            0) +
                        1;
            return gamer.copyWith(
              role: gamer.role?.copyWith(points: updatedPoints),
            );
          } else {
            return gamer;
          }
        }).toList();
        print('updatedGamers mafia points: ${updatedGamers.map(
          (Gamer gamer) => gamer.role?.points,
        )}');
        emit(
          state.copyWith(
            gamers: state.gamersState.copyWith(gamers: updatedGamers),
          ),
        );
      }
    });

    on<ChangeWerewolf>((ChangeWerewolf event, Emitter<AppState> emit) {
      print('ChangeWerewolf');

      final List<Gamer> updatedGamers = state.gamersState.gamers.map((
        Gamer gamer,
      ) {
        if (gamer.role?.roleId == 7) {
          final Map<String, int> updatedPoints =
              Map<String, int>.from(gamer.role!.points ?? <String, int>{});
          updatedPoints[AppStrings.aliveUntilChange] =
              (updatedPoints[AppStrings.aliveUntilChange] ?? 0) + 1;
          return gamer.copyWith(
            beforeChange: false,
            role: gamer.role?.copyWith(points: updatedPoints),
          );
        } else {
          return gamer;
        }
      }).toList();
      emit(
        state.copyWith(
          gamers: state.gamersState.copyWith(gamers: updatedGamers),
        ),
      );
      log('Werewolf changed: ${state.gamersState.gamers.map(
        (Gamer gamer) => <String, Object?>{
          'name': gamer.name,
          'beforeChange': gamer.beforeChange,
        },
      )}');
    });

    on<CleanGamersAfterNight>(
        (CleanGamersAfterNight event, Emitter<AppState> emit) {
      final AppState appState = state.copyWith(
        gamers: state.gamersState.copyWith(
          gamers: event.gamers
              .map(
                (Gamer gamer) => gamer.copyWith(
                  wasHealed: false,
                  wasKilledByMafia: false,
                  wasKilledByKiller: false,
                  wasKilledBySheriff: false,
                  wasBoomeranged: false,
                  wasSecured: false,
                  // canTarget: true,
                  targetId: 0,
                  killSecurity: false,
                ),
              )
              .toList(),
        ),
      );
      emit(appState);
    });

    on<CleanGamersAfterDay>(
        (CleanGamersAfterDay event, Emitter<AppState> emit) {
      final AppState appState = state.copyWith(
        gamers: state.gamersState.copyWith(
          gamers: state.gamersState.gamers
              .map(
                (Gamer gamer) =>
                    gamer.copyWith(hasAlibi: false, canTarget: true),
              )
              .toList(),
        ),
      );

      emit(appState);
    });

    on<KillGamerByKiller>((KillGamerByKiller event, Emitter<AppState> emit) {
      final bool isTargetingSelf = event.killer.id == event.targetedGamer.id;
      final int targetedIndex = state.gamersState.gamers
          .indexWhere((Gamer gamer) => gamer.id == event.targetedGamer.id);
      final int? roleTargetedId = event.targetedGamer.role?.roleId;
      final bool isTargetedMafia = roleTargetedId == 2 || roleTargetedId == 3;
      final bool isTargetedCivilian = roleTargetedId == 11;
      final bool isTargetedMainCharacter =
          !isTargetedMafia || !isTargetedCivilian;

      if (targetedIndex != -1 && isTargetingSelf) {
        final List<Gamer> updatedGamers = state.gamersState.gamers.map((
          Gamer gamer,
        ) {
          if (gamer.id == event.targetedGamer.id) {
            //If Killer wants to kill Werewolf -1 point for Werewolf
            if (gamer.id == 7) {
              final Map<String, int> updatedPoints =
                  Map<String, int>.from(gamer.role!.points ?? <String, int>{});
              updatedPoints[AppStrings.killerTriedToKillBeforeChange] =
                  (updatedPoints[AppStrings.killerTriedToKillBeforeChange] ??
                          0) -
                      1;

              return gamer.copyWith(
                role: gamer.role?.copyWith(points: updatedPoints),
              );
            } else {
              return gamer.copyWith(wasKilledByKiller: true);
            }
          } else if (gamer.id == event.killer.id) {
            final Map<String, int> updatedPoints = Map<String, int>.from(
              event.killer.role!.points ?? <String, int>{},
            );
            if (event.killer.role?.roleId == 13) {
              if (isTargetedMafia) {
                updatedPoints[AppStrings.playsForKiller] =
                    (updatedPoints[AppStrings.playsForKiller] ?? 0) + 1;
              } else if (isTargetedCivilian) {
                updatedPoints[AppStrings.playsForKiller] =
                    (updatedPoints[AppStrings.playsForKiller] ?? 0) - 1;
              } else {
                updatedPoints[AppStrings.playsForKiller] =
                    (updatedPoints[AppStrings.playsForKiller] ?? 0) - 2;
              }
              return gamer.copyWith(
                targetId: event.targetedGamer.id,
                role: gamer.role?.copyWith(points: updatedPoints),
              );
            } else {
              if (isTargetedMafia) {
                updatedPoints[AppStrings.killedMafias] =
                    (updatedPoints[AppStrings.killedMafias] ?? 0) + 2;
              } else {
                updatedPoints[AppStrings.killedCitizens] =
                    (updatedPoints[AppStrings.killedCitizens] ?? 0) - 1;
              }
              print('updatedPoints killer: $updatedPoints');
              return gamer.copyWith(
                targetId: event.targetedGamer.id,
                role: gamer.role?.copyWith(points: updatedPoints),
              );
            }
          } else {
            return gamer;
          }
        }).toList();
        emit(
          state.copyWith(
            gamers: state.gamersState.copyWith(gamers: updatedGamers),
          ),
        );
      }
    });

    on<KillGamerBySheriff>((KillGamerBySheriff event, Emitter<AppState> emit) {
      final int nightNumber = state.game.nightNumber;
      final int? roleTargetedId = event.targetedGamer.role?.roleId;

      final bool isTargetedMafia = roleTargetedId == 2 || roleTargetedId == 3;
      print('nightNumber: $nightNumber, iseven: ${nightNumber.isEven}');

      final AppState appState = state.copyWith(
        gamers: state.gamersState.copyWith(
          gamers: state.gamersState.gamers.map((Gamer gamer) {
            if (gamer.id == event.targetedGamer.id) {
              if (isTargetedMafia) {
                if (nightNumber.isEven) {
                  return gamer.copyWith(
                    wasKilledBySheriff: true,
                  );
                } else {
                  return gamer.copyWith(
                    wasCheckedBySheriff: true,
                  );
                }
              } else {
                return gamer;
              }
            } else if (gamer.id == event.sheriff.id) {
              if (isTargetedMafia) {
                if (event.sheriff.role?.roleId == 13) {
                  final Map<String, int> updatedPointsChameleon =
                      Map<String, int>.from(
                    event.sheriff.role!.points ?? <String, int>{},
                  );
                  updatedPointsChameleon[AppStrings.playsForSheriff] =
                      (updatedPointsChameleon[AppStrings.playsForSheriff] ??
                              0) +
                          1;
                  print('updatedPoints sheriff: $updatedPointsChameleon');
                  return gamer.copyWith(
                    role: gamer.role?.copyWith(points: updatedPointsChameleon),
                  );
                }
              }

              if (isTargetedMafia && !nightNumber.isEven) {
                final Map<String, int> updatedPoints = Map<String, int>.from(
                  event.sheriff.role!.points ?? <String, int>{},
                );
                updatedPoints[AppStrings.entersToMafia] =
                    (updatedPoints[AppStrings.entersToMafia] ?? 0) + 1;
                print('updatedPoints sheriff: $updatedPoints');
                return gamer.copyWith(
                  role: gamer.role?.copyWith(points: updatedPoints),
                );
              } else {
                return gamer;
              }
            } else {
              return gamer;
            }
          }).toList(),
        ),
      );
      emit(appState);
    });

    on<CheckGamerBySheriff>(
        (CheckGamerBySheriff event, Emitter<AppState> emit) {
      final int? roleGamerId = event.targetedGamer.role?.roleId;
      final bool isGamerMafia = roleGamerId == 2 || roleGamerId == 3;

      final AppState appState = state.copyWith(
        gamers: state.gamersState.copyWith(
          gamers: state.gamersState.gamers.map((Gamer gamer) {
            final Map<String, int> updatedPoints =
                Map<String, int>.from(gamer.role!.points ?? <String, int>{});

            if (gamer.id == event.targetedGamer.id) {
              return gamer.copyWith(
                wasCheckedBySheriff: true,
              );
            }
            if (gamer.id == event.gamerId) {
              if (isGamerMafia) {
                updatedPoints[AppStrings.entersToMafia] =
                    (updatedPoints[AppStrings.entersToMafia] ?? 0) + 1;
              }
              return gamer.copyWith(
                role: gamer.role?.copyWith(
                  points: updatedPoints,
                ),
              );
            }
            return gamer;
          }).toList(),
        ),
      );
      emit(appState);
    });

    on<GiveAlibi>((GiveAlibi event, Emitter<AppState> emit) {
      final int? roleGamerId = event.targetedGamer.role?.roleId;
      final bool isGamerMafia = roleGamerId == 2 || roleGamerId == 3;
      final Map<String, int> updatedPoints = Map<String, int>.from(
        event.advocate.role!.points ?? <String, int>{},
      );
      final AppState appState = state.copyWith(
        gamers: state.gamersState.copyWith(
          gamers: state.gamersState.gamers.map((Gamer gamer) {
            print('mafiaGamer.id: ${gamer.id}, event.targetedGamer.id:'
                ' ${event.targetedGamer.id},'
                ' event.gamerId: ${event.advocate.id}');
            if (gamer.id == event.targetedGamer.id) {
              return gamer.copyWith(hasAlibi: true);
            } else if (gamer.id == event.advocate.id) {
              if (event.advocate.role?.roleId == 13) {
                if (isGamerMafia) {
                  updatedPoints[AppStrings.playsForAdvocate] =
                      (updatedPoints[AppStrings.playsForAdvocate] ?? 0) - 1;
                } else {
                  updatedPoints[AppStrings.playsForAdvocate] =
                      (updatedPoints[AppStrings.playsForAdvocate] ?? 0) + 1;
                }

                return gamer.copyWith(
                  role: gamer.role?.copyWith(
                    points: updatedPoints,
                  ),
                );
              } else {
                print('isGamerMafia: $isGamerMafia');
                if (isGamerMafia) {
                  updatedPoints[AppStrings.gaveAlibiToMafia] =
                      (updatedPoints[AppStrings.gaveAlibiToMafia] ?? 0) - 1;
                } else {
                  updatedPoints[AppStrings.gaveAlibiToCitizen] =
                      (updatedPoints[AppStrings.gaveAlibiToCitizen] ?? 0) + 1;
                }
                return gamer.copyWith(
                  role: gamer.role?.copyWith(
                    points: updatedPoints,
                  ),
                );
              }
            } else {
              print("is else");
              return gamer;
            }
          }).toList(),
        ),
      );
      emit(appState);
    });

    on<SecureGamer>((SecureGamer event, Emitter<AppState> emit) {
      final AppState appState = state.copyWith(
        gamers: state.gamersState.copyWith(
          gamers: state.gamersState.gamers.map((Gamer gamer) {
            if (gamer.id == event.targetedGamer.id) {
              return gamer.copyWith(
                wasSecured: true,
              );
            }
            if (gamer.role?.roleId == 10) {
              return gamer.copyWith(killSecurity: true);
            }
            return gamer;
          }).toList(),
        ),
      );
      emit(appState);
    });

    on<MediumChecked>((MediumChecked event, Emitter<AppState> emit) {
      final AppState appState = state.copyWith(
        gamers: state.gamersState.copyWith(
          gamers: state.gamersState.gamers.map((Gamer gamer) {
            if (gamer.id == event.targetedGamer.id) {
              return gamer.copyWith(
                wasCheckedByMedium: true,
              );
            }
            return gamer;
          }).toList(),
        ),
      );
      emit(appState);
    });

    on<BoomerangGamer>((BoomerangGamer event, Emitter<AppState> emit) {
      final int? roleGamerId = event.targetedGamer.role?.roleId;
      final bool isGamerMafia = roleGamerId == 2 || roleGamerId == 3;
      final AppState appState = state.copyWith(
        gamers: state.gamersState.copyWith(
          gamers: state.gamersState.gamers.map((Gamer gamer) {
            if (gamer.id == event.targetedGamer.id) {
              return gamer.copyWith(
                wasBoomeranged: true,
              );
            } else if (gamer.id == event.boomerang.id) {
              final Map<String, int> updatedPoints = Map<String, int>.from(
                event.boomerang.role!.points ?? <String, int>{},
              );
              if (isGamerMafia) {
                updatedPoints[AppStrings.killedMafias] =
                    (updatedPoints[AppStrings.killedMafias] ?? 0) + 2;
              } else {
                updatedPoints[AppStrings.killedCitizens] =
                    (updatedPoints[AppStrings.killedCitizens] ?? 0) - 1;
              }
              return gamer.copyWith(
                role: gamer.role?.copyWith(
                  points: updatedPoints,
                ),
              );
            }
            return gamer;
          }).toList(),
        ),
      );
      emit(appState);
    });

    on<InfectGamer>((InfectGamer event, Emitter<AppState> emit) {
      final AppState appState = state.copyWith(
        gamers: state.gamersState.copyWith(
          gamers: state.gamersState.gamers.map((Gamer gamer) {
            if (gamer.id == event.targetedGamer.id) {
              return gamer.copyWith(
                wasInfected: event.infect,
              );
            }
            return gamer;
          }).toList(),
        ),
      );
      emit(appState);
    });

    on<InfectedCount>((InfectedCount event, Emitter<AppState> emit) {
      print('infectedCount bloc 1: ${event.infectedCount}');
      final AppState appState = state.copyWith(
        game: state.game.copyWith(
          infectedCount: event.infectedCount,
        ),
      );
      print('infectedCount bloc 2: ${appState.game.infectedCount}');
      emit(appState);
    });

    on<TakeAbilityFromGamer>(
      (TakeAbilityFromGamer event, Emitter<AppState> emit) {
        final AppState appState = state;
        final int? roleGamerId = event.targetedGamer.role?.roleId;
        final bool isGamerMafia = roleGamerId == 2 || roleGamerId == 3;
        final bool isGamerCitizen = roleGamerId == 11;

        void removeTargetId(int targetId, int roleId) {
          for (int i = 0; i < appState.gamersState.gamers.length; i++) {
            final Gamer gamer = appState.gamersState.gamers[i];
            if (gamer.id == targetId) {
              switch (roleId) {
                case 1:
                  appState.gamersState.gamers[i] =
                      gamer.copyWith(wasHealed: false);
                  break;
                case 2:
                case 3:
                  appState.gamersState.gamers[i] =
                      gamer.copyWith(wasKilledByMafia: false);
                  break;
                case 4:
                  appState.gamersState.gamers[i] =
                      gamer.copyWith(wasKilledBySheriff: false);
                  break;
                case 6:
                  appState.gamersState.gamers[i] =
                      gamer.copyWith(wasKilledByKiller: false);
                  break;
                case 10:
                  appState.gamersState.gamers[i] =
                      gamer.copyWith(killSecurity: false);
                  break;
                case 14:
                  appState.gamersState.gamers[i] =
                      gamer.copyWith(wasBoomeranged: false);
                  break;
              }
            }
          }
        }

        // Madam can't take abilities from Virus and Werewolf
        emit(
          appState.copyWith(
            gamers: appState.gamersState.copyWith(
              gamers: appState.gamersState.gamers.map((Gamer gamer) {
                if (gamer.id == event.targetedGamer.id &&
                    event.targetedGamer.role?.roleId != 7 &&
                    event.targetedGamer.wasCheckedByMadam == false &&
                    event.targetedGamer.role?.roleId != 8) {
                  if (gamer.targetId != null) {
                    removeTargetId(gamer.targetId!, gamer.role!.roleId);
                  }
                  return gamer.copyWith(
                    canTarget: false,
                    targetId: 0,
                    wasCheckedByMadam: true,
                  );
                } else if (gamer.id == event.madam.id) {
                  final Map<String, int> updatedPoints = Map<String, int>.from(
                    event.madam.role!.points ?? <String, int>{},
                  );
                  if (event.madam.id == 13) {
                    if (isGamerMafia) {
                      updatedPoints[AppStrings.playsForMadam] =
                          (updatedPoints[AppStrings.playsForMadam] ?? 0) + 1;
                      return gamer.copyWith(
                        role: gamer.role?.copyWith(
                          points: updatedPoints,
                        ),
                      );
                    }
                  } else {
                    if (!isGamerCitizen && !isGamerMafia) {
                      updatedPoints[AppStrings.entersToAnother] =
                          (updatedPoints[AppStrings.entersToAnother] ?? 0) - 1;
                    } else if (isGamerMafia) {
                      updatedPoints[AppStrings.entersToMafia] =
                          (updatedPoints[AppStrings.entersToMafia] ?? 0) + 2;
                    }
                    print('updatedPoints 1: $updatedPoints');
                    return gamer.copyWith(
                      role: gamer.role?.copyWith(
                        points: updatedPoints,
                      ),
                    );
                  }
                }
                return gamer;
              }).toList(),
            ),
          ),
        );
      },
    );

    on<AddRoleToGamer>((AddRoleToGamer event, Emitter<AppState> emit) {
      final AppState appState = state.copyWith(
        gamers: state.gamersState.copyWith(
          gamers: state.gamersState.gamers.map((Gamer gamer) {
            if (gamer.gamerId == event.targetedGamer.gamerId) {
              return gamer.copyWith(
                role: event.targetedGamer.role,
                isRoleGiven: true,
              );
            }
            return gamer;
          }).toList(),
        ),
      );
      emit(appState);
    });

    on<ChangeRoleIndex>((ChangeRoleIndex event, Emitter<AppState> emit) {
      final AppState appState = state.copyWith(
        game: state.game.copyWith(
          roleIndex: event.roleIndex,
        ),
      );
      emit(appState);
    });

    on<ChameleonChangeRole>(
        (ChameleonChangeRole event, Emitter<AppState> emit) {
      final AppState appState = state.copyWith(
        gamers: state.gamersState.copyWith(
          gamers: state.gamersState.gamers.map((Gamer gamer) {
            if (gamer.role?.roleId == 13) {
              return gamer.copyWith(
                chameleonId: event.chameleonId,
              );
            }
            return gamer;
          }).toList(),
        ),
      );
      print('Chameleon id: ${appState.gamersState.gamers.map(
        (Gamer gamer) => gamer.chameleonId,
      )}');
      emit(appState);
    });

    on<UpdateGamer>((UpdateGamer event, Emitter<AppState> emit) async {
      final int index = state.gamersState.gamers.indexWhere(
        (Gamer gamer) => gamer.id == event.gamer.id,
      );
      final Gamer gamer = event.gamer;
      if (index != -1) {
        final List<Gamer> updatedGamersList =
            List<Gamer>.from(state.gamersState.gamers);
        updatedGamersList[index] = updatedGamersList[index].copyWith(
          name: event.gamer.name,
          gamerId: event.gamer.gamerId,
          imageUrl: event.gamer.imageUrl,
          role: event.gamer.role,
          isNameChanged: event.gamer.isNameChanged,
          roleCounts: <String, int>{
            ...gamer.roleCounts,
            '${gamer.role!.roleId}':
                (gamer.roleCounts[gamer.role!.roleId.toString()] ?? 0) + 1,
          },
        );

        try {
          if (!event.isGamerExist) {
            print('Adding mafiaGamer to Firebase: ${event.gamer}');
            await gameRepository.addGamer(updatedGamersList[index]);
          }
        } catch (e) {
          print('Error updating mafiaGamer name: $e');
        }

        final GamersState updatedGamersState =
            state.gamersState.copyWith(gamers: updatedGamersList);
        final AppState updatedAppState =
            state.copyWith(gamers: updatedGamersState);
        emit(updatedAppState);
      } else {
        final List<Gamer> updatedGamersList =
            List<Gamer>.from(state.gamersState.gamers);
        final Gamer newGamer = event.gamer;
        final int newPosition = event.gamer.positionOnTable;
        final int numberOfGamers = state.game.numberOfGamers;

        updatedGamersList.insert(
          newPosition - 1,
          newGamer.copyWith(positionOnTable: newPosition),
        );

        for (int i = newPosition; i < updatedGamersList.length; i++) {
          updatedGamersList[i] = updatedGamersList[i].copyWith(
            positionOnTable: updatedGamersList[i].positionOnTable + 1,
          );
        }

        try {
          if (!event.isGamerExist) {
            print('Adding mafiaGamer to Firebase: ${event.gamer}');
            await gameRepository.addGamer(newGamer);
          }
        } catch (e) {
          print('Error adding mafiaGamer: $e');
        }
        // print('Gamers name are :'
        //     ' ${updatedGamersList.map((Gamer mafiaGamer) => mafiaGamer.name)}');
        emit(
          state.copyWith(
            gamers: state.gamersState.copyWith(gamers: updatedGamersList),
            game: state.game.copyWith(
              numberOfGamers: numberOfGamers + 1,
            ),
          ),
        );
      }
    });

    on<ChangeAnimation>((ChangeAnimation event, Emitter<AppState> emit) {
      final AppState appState = state.copyWith(
        gamers: state.gamersState.copyWith(
          gamers: state.gamersState.gamers.map((Gamer gamer) {
            if (gamer.gamerId == event.gamerId) {
              return gamer.copyWith(isAnimated: event.animate);
            }
            return gamer;
          }).toList(),
        ),
      );
      emit(appState);
    });

    on<UpdateAnimation>((UpdateAnimation event, Emitter<AppState> emit) {
      final AppState appState = state.copyWith(
        gamers: state.gamersState.copyWith(
          gamers: state.gamersState.gamers
              .map(
                (Gamer gamer) => gamer.copyWith(isAnimated: event.animate),
              )
              .toList(),
        ),
      );
      emit(appState);
    });

    on<SetVoter>((SetVoter event, Emitter<AppState> emit) {
      final AppState appState = state.copyWith(
        game: state.game.copyWith(
          currentVoter: event.voter,
        ),
      );
      emit(appState);
    });

    on<ResetVoters>((ResetVoters event, Emitter<AppState> emit) {
      final AppState appState = state.copyWith(
        gamers: state.gamersState.copyWith(
          gamers: state.gamersState.gamers
              .map(
                (Gamer gamer) => gamer.copyWith(wasVoted: false),
              )
              .toList(),
        ),
      );
      emit(appState);
    });

    on<ResetVoter>((ResetVoter event, Emitter<AppState> emit) {
      final AppState appState = state.copyWith(
        game: state.game.copyWith(
          currentVoter: const Gamer.empty(),
        ),
      );
      emit(appState);
    });
  }
}
