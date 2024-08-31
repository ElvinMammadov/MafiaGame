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
          gamePhase: GamePhase.IsReady,
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

      emit(
        state.copyWith(
          game: const GameState.empty(),
          gamers: state.gamersState.copyWith(gamers: updatedGamers),
        ),
      );
    });

    on<ChangeGameStartValue>((
      ChangeGameStartValue event,
      Emitter<AppState> emit,
    ) {
      final AppState appState = state.copyWith(
        game: state.game.copyWith(
          gamePhase: GamePhase.CouldStart,
        ),
      );
      emit(appState);
    });

    on<EndDiscussion>((EndDiscussion event, Emitter<AppState> emit) {
      final AppState appState = state.copyWith(
        game: state.game.copyWith(
          gamePhase: GamePhase.Voting,
        ),
      );
      emit(appState);
    });

    on<EndVoting>((EndVoting event, Emitter<AppState> emit) {
      final AppState appState = state.copyWith(
        game: state.game.copyWith(
          gamePhase: GamePhase.Discussion,
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
        role: gamer.role.copyWith(
          points: updatedPoints,
        ),
      );
    }

    on<AddVoteToGamer>((AddVoteToGamer event, Emitter<AppState> emit) {
      final RoleType roleGamer = event.gamer.role.roleType;

      final bool isGamerMafia = roleGamer == RoleType.Mafia ||
          roleGamer == RoleType.Don ||
          (roleGamer == RoleType.Werewolf && !event.gamer.beforeChange);
      final bool isGamerCivilian = roleGamer == RoleType.Civilian;
      final bool isGamerMainCharacter = !isGamerMafia && !isGamerCivilian;
      final bool isTargetedMainCharacter = roleGamer == RoleType.Sheriff ||
          roleGamer == RoleType.Madam ||
          roleGamer == RoleType.Medium;
      final bool isTargetedOther =
          !isTargetedMainCharacter && !isGamerCivilian && !isGamerMafia;
      log('isGamerMafia: $isGamerMafia, isGamerCivilian: $isGamerCivilian, '
          'isGamerMainCharacter: $isGamerMainCharacter,'
          ' isTargetedOther: $isTargetedOther');
      final AppState appState = state.copyWith(
        gamers: state.gamersState.copyWith(
          gamers: state.gamersState.gamers.map((Gamer gamer) {
            if (gamer.id == event.gamer.id) {
              return gamer.copyWith(votesCount: gamer.votesCount + 1);
            } else if (gamer.id == event.voter.id) {
              // log('role is ${gamer.role.roleType}');
              final Map<String, int> updatedPoints =
                  Map<String, int>.from(gamer.role.points ?? <String, int>{});
              switch (gamer.role.roleType) {
                case RoleType.Doctor:
                  return updatePoints(
                    isGamerMafia: isGamerMafia,
                    isGamerMainCharacter: isGamerMainCharacter,
                    isGamerCivilian: isGamerCivilian,
                    updatedPoints: updatedPoints,
                    againstMafia: 1,
                    againstMainCharacters: 1,
                    gamer: gamer,
                  );
                case RoleType.Mafia:
                case RoleType.Don:
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
                    role: gamer.role.copyWith(
                      points: updatedPoints,
                    ),
                  );
                case RoleType.Sheriff:
                  return updatePoints(
                    isGamerMafia: isGamerMafia,
                    isGamerMainCharacter: isGamerMainCharacter,
                    isGamerCivilian: isGamerCivilian,
                    updatedPoints: updatedPoints,
                    againstMafia: 1,
                    againstMainCharacters: 1,
                    gamer: gamer,
                  );
                case RoleType.Madam:
                  return updatePoints(
                    isGamerMafia: isGamerMafia,
                    isGamerMainCharacter: isGamerMainCharacter,
                    isGamerCivilian: isGamerCivilian,
                    updatedPoints: updatedPoints,
                    againstMafia: 1,
                    againstMainCharacters: 1,
                    gamer: gamer,
                  );
                case RoleType.Killer:
                  return updatePoints(
                    isGamerMafia: isGamerMafia,
                    isGamerMainCharacter: isGamerMainCharacter,
                    isGamerCivilian: isGamerCivilian,
                    updatedPoints: updatedPoints,
                    againstMafia: 1,
                    againstMainCharacters: 1,
                    gamer: gamer,
                  );
                case RoleType.Werewolf:
                  return updatePoints(
                    isGamerMafia: isGamerMafia,
                    isGamerMainCharacter: isGamerMainCharacter,
                    isGamerCivilian: isGamerCivilian,
                    updatedPoints: updatedPoints,
                    againstMafia: gamer.beforeChange ? 2 : 0,
                    againstMainCharacters: gamer.beforeChange ? -1 : 1,
                    gamer: gamer,
                  );
                case RoleType.Virus:
                  return updatePoints(
                    isGamerMafia: isGamerMafia,
                    isGamerMainCharacter: isGamerMainCharacter,
                    isGamerCivilian: isGamerCivilian,
                    updatedPoints: updatedPoints,
                    againstMafia: 1,
                    againstMainCharacters: 1,
                    gamer: gamer,
                  );
                case RoleType.Advocate:
                  return updatePoints(
                    isGamerMafia: isGamerMafia,
                    isGamerMainCharacter: isGamerMainCharacter,
                    isGamerCivilian: isGamerCivilian,
                    updatedPoints: updatedPoints,
                    againstMafia: 1,
                    againstMainCharacters: 1,
                    gamer: gamer,
                  );
                case RoleType.Security:
                  return updatePoints(
                    isGamerMafia: isGamerMafia,
                    isGamerMainCharacter: isGamerMainCharacter,
                    isGamerCivilian: isGamerCivilian,
                    updatedPoints: updatedPoints,
                    againstMafia: 1,
                    againstMainCharacters: 1,
                    gamer: gamer,
                  );

                case RoleType.Civilian:
                  if (roleGamer == RoleType.Mafia) {
                    updatedPoints[AppStrings.votedAgainstMainRoles] =
                        (updatedPoints[AppStrings.votedAgainstMainRoles] ?? 0) +
                            1;
                  } else if (roleGamer == RoleType.Don) {
                    updatedPoints[AppStrings.votedAgainstMafia] =
                        (updatedPoints[AppStrings.votedAgainstMafia] ?? 0) + 2;
                  } else if (isGamerMainCharacter || isGamerCivilian) {
                    updatedPoints[AppStrings.votedAgainstMainRoles] =
                        (updatedPoints[AppStrings.votedAgainstMainRoles] ?? 0) -
                            1;
                  }
                  return gamer.copyWith(
                    wasVoted: true,
                    role: gamer.role.copyWith(
                      points: updatedPoints,
                    ),
                  );
                case RoleType.Medium:
                  return updatePoints(
                    isGamerMafia: isGamerMafia,
                    isGamerMainCharacter: isGamerMainCharacter,
                    isGamerCivilian: isGamerCivilian,
                    updatedPoints: updatedPoints,
                    againstMafia: 1,
                    againstMainCharacters: 1,
                    gamer: gamer,
                  );
                case RoleType.Chameleon:
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
                case RoleType.Boomerang:
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
      // log('Voters points: ${appState.gamersState.gamers.map(
      //   (Gamer gamer) => <String, Object?>{
      //     'name': gamer.role.name,
      //     'points': gamer.role.points,
      //   },
      // )}');
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
                  gamer.role.roleType == RoleType.Mafia ||
                  gamer.role.roleType == RoleType.Don,
            )
            .toList()
            .length;
        final int civilianCount = event.gameState.gamers.length - mafiaCount;
        emit(
          state.copyWith(
            game: state.game.copyWith(
              gamePhase: GamePhase.Discussion,
              mafiaCount: mafiaCount,
              civilianCount: civilianCount,
            ),
          ),
        );
      } catch (e) {
        log('Error saving game: $e');
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
        add(const GameStatus(isGameFinished: true));
      } catch (e) {
        log('Error sending data to Firebase: $e');
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
          if (event.gameState.isMafiaWin) {
            if (gamer.role.roleType == RoleType.Mafia ||
                gamer.role.roleType == RoleType.Don) {
              final Map<String, int> updatedPoints =
                  Map<String, int>.from(gamer.role.points ?? <String, int>{});
              if (gamer.wasKilled) {
                event.gameState.victoryByWerewolf
                    ? updatedPoints[AppStrings.alivePoints] =
                        (updatedPoints[AppStrings.alivePoints] ?? 0) + 1
                    : updatedPoints[AppStrings.alivePoints] =
                        (updatedPoints[AppStrings.alivePoints] ?? 0) + 2;
              } else {
                updatedPoints[AppStrings.alivePoints] =
                    (updatedPoints[AppStrings.alivePoints] ?? 0) + 3;
              }
              updatedPoints[AppStrings.totalPoints] =
                  calculateTotalPoints(updatedPoints);
              return gamer.copyWith(
                role: gamer.role.copyWith(
                  points: updatedPoints,
                ),
              );
            }
            if (gamer.role.roleType == RoleType.Werewolf &&
                event.gameState.victoryByWerewolf) {
              final Map<String, int> updatedPoints =
                  Map<String, int>.from(gamer.role.points ?? <String, int>{});
              updatedPoints[AppStrings.alivePoints] =
                  (updatedPoints[AppStrings.alivePoints] ?? 0) + 4;
              updatedPoints[AppStrings.totalPoints] =
                  calculateTotalPoints(updatedPoints);
              return gamer.copyWith(
                role: gamer.role.copyWith(
                  points: updatedPoints,
                ),
              );
            } else {
              final Map<String, int> updatedPoints =
                  Map<String, int>.from(gamer.role.points ?? <String, int>{});
              updatedPoints[AppStrings.totalPoints] =
                  calculateTotalPoints(updatedPoints);
              return gamer.copyWith(
                role: gamer.role.copyWith(
                  points: updatedPoints,
                ),
              );
            }
          } else {
            switch (gamer.role.roleType) {
              case RoleType.Doctor:
                final Map<String, int> updatedPoints = Map<String, int>.from(
                  gamer.role.points ?? <String, int>{},
                );

                if (!gamer.wasKilled) {
                  updatedPoints[AppStrings.alivePoints] =
                      (updatedPoints[AppStrings.alivePoints] ?? 0) + 3;
                }

                updatedPoints[AppStrings.totalPoints] =
                    calculateTotalPoints(updatedPoints);
                return gamer.copyWith(
                  role: gamer.role.copyWith(
                    points: updatedPoints,
                  ),
                );
              case RoleType.Mafia:
              case RoleType.Don:
                final Map<String, int> updatedPoints = Map<String, int>.from(
                  gamer.role.points ?? <String, int>{},
                );
                updatedPoints[AppStrings.totalPoints] =
                    calculateTotalPoints(updatedPoints);
                return gamer.copyWith(
                  role: gamer.role.copyWith(
                    points: updatedPoints,
                  ),
                );
              case RoleType.Sheriff:
                final Map<String, int> updatedPoints = Map<String, int>.from(
                  gamer.role.points ?? <String, int>{},
                );
                if (!gamer.wasKilled) {
                  updatedPoints[AppStrings.alivePoints] =
                      (updatedPoints[AppStrings.alivePoints] ?? 0) + 4;
                }
                updatedPoints[AppStrings.totalPoints] =
                    calculateTotalPoints(updatedPoints);
                return gamer.copyWith(
                  role: gamer.role.copyWith(
                    points: updatedPoints,
                  ),
                );
              case RoleType.Madam:
                final Map<String, int> updatedPoints = Map<String, int>.from(
                  gamer.role.points ?? <String, int>{},
                );
                if (!gamer.wasKilled) {
                  updatedPoints[AppStrings.alivePoints] =
                      (updatedPoints[AppStrings.alivePoints] ?? 0) + 4;
                }
                updatedPoints[AppStrings.totalPoints] =
                    calculateTotalPoints(updatedPoints);
                return gamer.copyWith(
                  role: gamer.role.copyWith(
                    points: updatedPoints,
                  ),
                );
              case RoleType.Killer:
                final Map<String, int> updatedPoints = Map<String, int>.from(
                  gamer.role.points ?? <String, int>{},
                );
                if (!gamer.wasKilled) {
                  updatedPoints[AppStrings.alivePoints] =
                      (updatedPoints[AppStrings.alivePoints] ?? 0) + 3;
                }
                updatedPoints[AppStrings.totalPoints] =
                    calculateTotalPoints(updatedPoints);
                return gamer.copyWith(
                  role: gamer.role.copyWith(
                    points: updatedPoints,
                  ),
                );
              case RoleType.Virus:
                final Map<String, int> updatedPoints = Map<String, int>.from(
                  gamer.role.points ?? <String, int>{},
                );
                if (!gamer.wasKilled) {
                  updatedPoints[AppStrings.alivePoints] =
                      (updatedPoints[AppStrings.alivePoints] ?? 0) + 2;
                }
                updatedPoints[AppStrings.totalPoints] =
                    calculateTotalPoints(updatedPoints);
                return gamer.copyWith(
                  role: gamer.role.copyWith(
                    points: updatedPoints,
                  ),
                );
              case RoleType.Advocate:
                final Map<String, int> updatedPoints = Map<String, int>.from(
                  gamer.role.points ?? <String, int>{},
                );
                if (!gamer.wasKilled) {
                  updatedPoints[AppStrings.alivePoints] =
                      (updatedPoints[AppStrings.alivePoints] ?? 0) + 3;
                }
                updatedPoints[AppStrings.totalPoints] =
                    calculateTotalPoints(updatedPoints);
                return gamer.copyWith(
                  role: gamer.role.copyWith(
                    points: updatedPoints,
                  ),
                );
              case RoleType.Security:
                final Map<String, int> updatedPoints = Map<String, int>.from(
                  gamer.role.points ?? <String, int>{},
                );
                if (!gamer.wasKilled) {
                  updatedPoints[AppStrings.alivePoints] =
                      (updatedPoints[AppStrings.alivePoints] ?? 0) + 2;
                }
                updatedPoints[AppStrings.totalPoints] =
                    calculateTotalPoints(updatedPoints);
                return gamer.copyWith(
                  role: gamer.role.copyWith(
                    points: updatedPoints,
                  ),
                );

              case RoleType.Civilian:
                final Map<String, int> updatedPoints = Map<String, int>.from(
                  gamer.role.points ?? <String, int>{},
                );
                if (gamer.wasKilled) {
                  updatedPoints[AppStrings.alivePoints] =
                      (updatedPoints[AppStrings.alivePoints] ?? 0) + 1;
                  updatedPoints[AppStrings.totalPoints] =
                      calculateTotalPoints(updatedPoints);
                } else {
                  updatedPoints[AppStrings.alivePoints] =
                      (updatedPoints[AppStrings.alivePoints] ?? 0) + 2;
                  updatedPoints[AppStrings.totalPoints] =
                      calculateTotalPoints(updatedPoints);
                }
                return gamer.copyWith(
                  role: gamer.role.copyWith(
                    points: updatedPoints,
                  ),
                );
              case RoleType.Werewolf:
                final Map<String, int> updatedPoints = Map<String, int>.from(
                  gamer.role.points ?? <String, int>{},
                );
                if (gamer.beforeChange && gamer.wasKilled) {
                  updatedPoints[AppStrings.alivePoints] =
                      (updatedPoints[AppStrings.alivePoints] ?? 0) + 1;
                }
                updatedPoints[AppStrings.totalPoints] =
                    calculateTotalPoints(updatedPoints);
                return gamer.copyWith(
                  role: gamer.role.copyWith(
                    points: updatedPoints,
                  ),
                );
              case RoleType.Medium:
                final Map<String, int> updatedPoints = Map<String, int>.from(
                  gamer.role.points ?? <String, int>{},
                );
                if (!gamer.wasKilled) {
                  updatedPoints[AppStrings.alivePoints] =
                      (updatedPoints[AppStrings.alivePoints] ?? 0) + 3;
                }
                updatedPoints[AppStrings.totalPoints] =
                    calculateTotalPoints(updatedPoints);
                return gamer.copyWith(
                  role: gamer.role.copyWith(
                    points: updatedPoints,
                  ),
                );
              case RoleType.Chameleon:
                final Map<String, int> updatedPoints = Map<String, int>.from(
                  gamer.role.points ?? <String, int>{},
                );
                if (gamer.wasKilled) {
                  updatedPoints[AppStrings.alivePoints] =
                      (updatedPoints[AppStrings.alivePoints] ?? 0) + 1;
                  updatedPoints[AppStrings.totalPoints] =
                      calculateTotalPoints(updatedPoints);
                } else {
                  updatedPoints[AppStrings.alivePoints] =
                      (updatedPoints[AppStrings.alivePoints] ?? 0) + 2;
                  updatedPoints[AppStrings.totalPoints] =
                      calculateTotalPoints(updatedPoints);
                }
                return gamer.copyWith(
                  role: gamer.role.copyWith(
                    points: updatedPoints,
                  ),
                );
              case RoleType.Boomerang:
                final Map<String, int> updatedPoints = Map<String, int>.from(
                  gamer.role.points ?? <String, int>{},
                );
                if (!gamer.wasKilled) {
                  updatedPoints[AppStrings.alivePoints] =
                      (updatedPoints[AppStrings.alivePoints] ?? 0) + 2;
                }
                updatedPoints[AppStrings.totalPoints] =
                    calculateTotalPoints(updatedPoints);
                return gamer.copyWith(
                  role: gamer.role.copyWith(
                    points: updatedPoints,
                  ),
                );
              default:
                return gamer;
            }
          }
        },
      ).toList();
      add(
        SendGameToFirebase(
          gameState: state.game.copyWith(
            isMafiaWin: event.gameState.isMafiaWin,
            gamers: updatedGamers,
            victoryByWerewolf: event.gameState.victoryByWerewolf,
            werewolfWasDead: event.gameState.werewolfWasDead,
          ),
        ),
      );
      emit(
        state.copyWith(
          game: state.game.copyWith(
            isMafiaWin: event.gameState.isMafiaWin,
          ),
          gamers: state.gamersState.copyWith(gamers: updatedGamers),
        ),
      );
      event.finished();
    });

    on<GameStatus>((GameStatus event, Emitter<AppState> emit) {
      emit(
        state.copyWith(
          game: state.game.copyWith(
            gamePhase: GamePhase.Finished,
          ),
        ),
      );
    });

    on<GetGames>((GetGames event, Emitter<AppState> emit) async {
      try {
        final List<GameState> games =
            await gameRepository.getGames(event.dateTime);
        // logger.log('Games: $games');
        emit(state.copyWith(games: games));
      } catch (e) {
        log('Error getting games: $e');
      }
    });

    on<UpdateGamerPoints>(
        (UpdateGamerPoints event, Emitter<AppState> emit) async {
      try {
        await gameRepository.updateGamerPoints(
          gamerId: event.gamerId,
          gameId: event.gameId,
          points: event.points,
        );
      } catch (e) {
        log('Error updating gamer points: $e');
      }
    });

    on<AddDayNumber>((AddDayNumber event, Emitter<AppState> emit) {
      final AppState appState = state.copyWith(
        game: state.game.copyWith(
          dayNumber: state.game.dayNumber + 1,
          gamePeriod: GamePeriod.Night,
        ),
      );
      emit(appState);
    });

    on<AddNightNumber>((AddNightNumber event, Emitter<AppState> emit) {
      final AppState appState = state.copyWith(
        game: state.game.copyWith(
          nightNumber: state.game.nightNumber + 1,
          gamePeriod: GamePeriod.Day,
          gamePhase: GamePhase.Discussion,
        ),
      );
      emit(appState);
    });

    on<KillInfectedGamers>((KillInfectedGamers event, Emitter<AppState> emit) {
      // Separate mafia and other killed gamers
      final List<Gamer> mafiaGamers = event.infectedGamers
          .where(
            (Gamer gamer) =>
                gamer.role.roleType == RoleType.Mafia ||
                gamer.role.roleType == RoleType.Don,
          )
          .toList();
      final List<Gamer> otherGamers = event.infectedGamers
          .where(
            (Gamer gamer) =>
                gamer.role.roleType != RoleType.Mafia &&
                gamer.role.roleType != RoleType.Don,
          )
          .toList();

      if (mafiaGamers.isNotEmpty) {
        for (final Gamer gamer in mafiaGamers) {
          add(KillGamer(gamer: gamer));
        }
      }

      if (otherGamers.isNotEmpty) {
        for (final Gamer gamer in otherGamers) {
          add(KillGamer(gamer: gamer));
        }
      }
    });

    on<ChangeGamerCounts>((ChangeGamerCounts event, Emitter<AppState> emit) {
      final AppState appState = state.copyWith(
        game: state.game.copyWith(
          mafiaCount:
              event.isMafia ? state.game.mafiaCount - 1 : state.game.mafiaCount,
          civilianCount: event.isMafia
              ? state.game.civilianCount
              : state.game.civilianCount - 1,
        ),
      );
      emit(appState);
    });

    on<KillGamer>((KillGamer event, Emitter<AppState> emit) {
      final GamePeriod gamePeriod = state.game.gamePeriod;
      final bool isKilledMafia = event.gamer.role.roleType == RoleType.Mafia ||
          event.gamer.role.roleType == RoleType.Don ||
          (event.gamer.role.roleType == RoleType.Werewolf &&
              !event.gamer.beforeChange);
      final bool mafiaKilled =
          isKilledMafia && !event.gamer.hasAlibi && !event.gamer.wasSecured;
      final bool wasCheckedByMadam = event.gamer.wasCheckedByMadam;
      log('Killed gamer: ${event.gamer.role.name}');
      emit(
        state.copyWith(
          gamers: state.gamersState.copyWith(
            gamers: state.gamersState.gamers.map((Gamer gamer) {
              if (gamer.id == event.gamer.id) {
                if (gamePeriod == GamePeriod.Day && gamer.hasAlibi) {
                  return gamer;
                } else if (gamePeriod == GamePeriod.Night && gamer.wasSecured) {
                  return gamer;
                } else {
                  event.gamer.role.roleType == RoleType.Mafia ||
                          event.gamer.role.roleType == RoleType.Don ||
                          (event.gamer.role.roleType == RoleType.Werewolf &&
                              !event.gamer.beforeChange)
                      ? add(const ChangeGamerCounts(isMafia: true))
                      : add(const ChangeGamerCounts(isMafia: false));
                  return gamer.copyWith(wasKilled: true);
                }
              } else if (gamePeriod == GamePeriod.Day &&
                  wasCheckedByMadam &&
                  isKilledMafia &&
                  gamer.role.roleType == RoleType.Madam) {
                ///Madam points after death of gamer
                final Map<String, int> updatedPoints = Map<String, int>.from(
                  gamer.role.points ?? <String, int>{},
                );
                updatedPoints[AppStrings.mafiaTriedToKillBeforeChange] =
                    (updatedPoints[AppStrings.mafiaTriedToKillBeforeChange] ??
                            0) +
                        1;
                return gamer.copyWith(
                  role: gamer.role.copyWith(points: updatedPoints),
                );
              } else if (gamer.role.roleType == RoleType.Virus &&
                  gamer.wasKilled) {
                ///Virus points after death of gamer
                final Map<String, int> updatedPoints = Map<String, int>.from(
                  gamer.role.points ?? <String, int>{},
                );
                mafiaKilled
                    ? updatedPoints[AppStrings.infectedMafia] =
                        (updatedPoints[AppStrings.infectedMafia] ?? 0) + 1
                    : updatedPoints[AppStrings.infectedCitizens] =
                        (updatedPoints[AppStrings.infectedCitizens] ?? 0) - 1;
                return gamer.copyWith(
                  role: gamer.role.copyWith(points: updatedPoints),
                );
              } else if (gamePeriod == GamePeriod.Day &&
                  gamer.role.roleType == RoleType.Medium &&
                  event.gamer.wasCheckedByMedium) {
                ///Points for Medium if gamer was checked by Medium
                final Map<String, int> updatedPoints = Map<String, int>.from(
                  gamer.role.points ?? <String, int>{},
                );
                if (mafiaKilled) {
                  updatedPoints[AppStrings.pointsIfCheckerDead] =
                      (updatedPoints[AppStrings.pointsIfCheckerDead] ?? 0) + 2;
                }
                return gamer.copyWith(
                  role: gamer.role.copyWith(points: updatedPoints),
                );
              } else if (gamePeriod == GamePeriod.Day &&
                  gamer.role.roleType == RoleType.Werewolf &&
                  !gamer.beforeChange &&
                  !gamer.wasKilled) {
                final Map<String, int> updatedPoints = Map<String, int>.from(
                  gamer.role.points ?? <String, int>{},
                );
                updatedPoints[AppStrings.killedCitizensAfterChange] =
                    (updatedPoints[AppStrings.killedCitizensAfterChange] ?? 0) +
                        1;
                return gamer.copyWith(
                  role: gamer.role.copyWith(points: updatedPoints),
                );
              } else if (gamePeriod == GamePeriod.Night &&
                  event.gamer.wasSecured &&
                  gamer.role.roleType == RoleType.Security) {
                ///Points for Security if gamer was secured
                final Map<String, int> updatedPoints = Map<String, int>.from(
                  gamer.role.points ?? <String, int>{},
                );
                mafiaKilled
                    ? updatedPoints[AppStrings.securedMafia] =
                        (updatedPoints[AppStrings.securedMafia] ?? 0) - 1
                    : updatedPoints[AppStrings.securedCitizen] =
                        (updatedPoints[AppStrings.securedCitizen] ?? 0) + 3;
                return gamer.copyWith(
                  role: gamer.role.copyWith(points: updatedPoints),
                );
              } else if (gamePeriod == GamePeriod.Day &&
                  gamer.role.roleType == RoleType.Advocate &&
                  event.gamer.hasAlibi) {
                ///Points for Advocate if gamer has alibi
                final Map<String, int> updatedPoints = Map<String, int>.from(
                  gamer.role.points ?? <String, int>{},
                );
                isKilledMafia
                    ? updatedPoints[AppStrings.mafiaAlibiWorked] =
                        (updatedPoints[AppStrings.mafiaAlibiWorked] ?? 0) - 1
                    : updatedPoints[AppStrings.citizenAlibiWorked] =
                        (updatedPoints[AppStrings.citizenAlibiWorked] ?? 0) + 2;
                return gamer.copyWith(
                  role: gamer.role.copyWith(points: updatedPoints),
                );
              }

              ///Points for Killer if gamer was killed
              else if (gamePeriod == GamePeriod.Day &&
                  gamer.role.roleType == RoleType.Killer) {
                final Map<String, int> updatedPoints = Map<String, int>.from(
                  gamer.role.points ?? <String, int>{},
                );
                if (mafiaKilled && event.gamer.wasKilledByKiller) {
                  updatedPoints[AppStrings.killedMafias] =
                      (updatedPoints[AppStrings.killedMafias] ?? 0) + 2;
                } else if (!mafiaKilled && event.gamer.wasKilledByKiller) {
                  updatedPoints[AppStrings.killedCitizens] =
                      (updatedPoints[AppStrings.killedCitizens] ?? 0) - 1;
                }

                return gamer.copyWith(
                  role: gamer.role.copyWith(points: updatedPoints),
                );
              }

              ///Points for Sheriff if gamer was killed
              else if (gamer.role.roleType == RoleType.Sheriff) {
                final Map<String, int> updatedPoints = Map<String, int>.from(
                  gamer.role.points ?? <String, int>{},
                );
                if (mafiaKilled && event.gamer.wasCheckedBySheriff) {
                  updatedPoints[AppStrings.cityKillsMafia] =
                      (updatedPoints[AppStrings.cityKillsMafia] ?? 0) + 1;
                } else if (mafiaKilled && event.gamer.wasKilledBySheriff) {
                  updatedPoints[AppStrings.killedMafias] =
                      (updatedPoints[AppStrings.killedMafias] ?? 0) + 2;
                }
                return gamer.copyWith(
                  role: gamer.role.copyWith(points: updatedPoints),
                );
              } else {
                return gamer.copyWith(votesCount: 0);
              }
            }).toList(),

            // roles: updatedRolesState,
          ),
        ),
      );
      // log('Gamers are in KillGamer ${state.gamersState.gamers.map(
      //       (Gamer gamer) => 'gamer name ${gamer.name}, '
      //           'waskilled ${gamer.wasKilled}, ',
      //     ).toList()}');
    });

    on<HealGamer>((HealGamer event, Emitter<AppState> emit) {
      final bool isTargetingSelf = event.doctor.id == event.targetedGamer.id;
      final int targetedIndex = state.gamersState.gamers
          .indexWhere((Gamer gamer) => gamer.id == event.targetedGamer.id);
      final bool isTargetedMafia =
          event.targetedGamer.role.roleType == RoleType.Mafia ||
              event.targetedGamer.role.roleType == RoleType.Don ||
              (event.targetedGamer.role.roleType == RoleType.Werewolf &&
                  !event.targetedGamer.beforeChange);
      final int healCount = event.doctor.healCount;
      if (targetedIndex != -1 && (healCount != 0 && event.doctor.canTarget)) {
        final List<Gamer> updatedGamers =
            state.gamersState.gamers.map((Gamer gamer) {
          if (gamer.id == event.targetedGamer.id) {
            return gamer.copyWith(
              wasHealed: true,
              healCount: isTargetingSelf ? healCount - 1 : healCount,
            );
          } else if (gamer.id == event.doctor.id) {
            final Map<String, int> updatedPoints = Map<String, int>.from(
              event.doctor.role.points ?? <String, int>{},
            );
            isTargetedMafia
                ? updatedPoints[AppStrings.healedMafia] =
                    (updatedPoints[AppStrings.healedMafia] ?? 0) - 1
                : updatedPoints[AppStrings.healedCitizen] =
                    (updatedPoints[AppStrings.healedCitizen] ?? 0) + 2;

            return gamer.copyWith(
              role: gamer.role.copyWith(points: updatedPoints),
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
      log('KillGamerByMafia  ${event.targetedGamer.role.roleType}');
      final RoleType roleTargeted = event.targetedGamer.role.roleType;
      final RoleType roleGamer = event.mafiaGamer.role.roleType;
      final Gamer mafiaGamer = event.mafiaGamer;
      log('Gamer name: ${mafiaGamer.name}, role roleType: $roleGamer');
      final bool isTargetedMafia =
          roleTargeted == RoleType.Mafia || roleTargeted == RoleType.Don;
      final bool isTargetedCivilian = roleTargeted == RoleType.Civilian;
      final bool isTargetedMainCharacter = roleTargeted == RoleType.Sheriff ||
          roleTargeted == RoleType.Madam ||
          roleTargeted == RoleType.Medium;

      log('isTargetedMafia: $isTargetedMafia, '
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
            if (gamer.role.roleType == RoleType.Werewolf) {
              log('Werewolf is killed by Mafia');
              final Map<String, int> updatedPoints =
                  Map<String, int>.from(gamer.role.points ?? <String, int>{});
              updatedPoints[AppStrings.mafiaTriedToKillBeforeChange] =
                  (updatedPoints[AppStrings.mafiaTriedToKillBeforeChange] ??
                          0) +
                      1;
              return gamer.copyWith(
                role: gamer.role.copyWith(points: updatedPoints),
                wasKilledByMafia: true,
              );
            } else {
              if (gamer.role.roleType == RoleType.Mafia ||
                  gamer.role.roleType == RoleType.Don) {
                return gamer;
              }
              return gamer.copyWith(wasKilledByMafia: true);
            }
          } else if (gamer.role.roleType == RoleType.Mafia ||
              gamer.role.roleType == RoleType.Don) {
            final Map<String, int> updatedPoints =
                Map<String, int>.from(gamer.role.points ?? <String, int>{});
            if (isTargetedMainCharacter) {
              updatedPoints[AppStrings.votedAgainstMainRoles] =
                  (updatedPoints[AppStrings.votedAgainstMainRoles] ?? 0) + 2;
            } else if (!isTargetedCivilian && !isTargetedMafia) {
              updatedPoints[AppStrings.votedAgainstOthers] =
                  (updatedPoints[AppStrings.votedAgainstOthers] ?? 0) + 1;
            }
            return gamer.copyWith(
              targetId: event.targetedGamer.id,
              role: gamer.role.copyWith(points: updatedPoints),
            );
          } else if (event.mafiaGamer.role.roleType == RoleType.Werewolf &&
              gamer.role.roleType == RoleType.Werewolf) {
            final Map<String, int> updatedPoints = Map<String, int>.from(
              event.mafiaGamer.role.points ?? <String, int>{},
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
              role: gamer.role.copyWith(points: updatedPoints),
            );
          } else {
            return gamer;
          }
        }).toList();
        // log('updatedGamers mafia points: ${updatedGamers.map(
        //   (Gamer gamer) => gamer.role.points,
        // )}');
        emit(
          state.copyWith(
            gamers: state.gamersState.copyWith(gamers: updatedGamers),
          ),
        );
      }
    });

    on<ChangeWerewolf>((ChangeWerewolf event, Emitter<AppState> emit) {
      log('ChangeWerewolf');

      final List<Gamer> updatedGamers = state.gamersState.gamers.map((
        Gamer gamer,
      ) {
        if (gamer.role.roleType == RoleType.Werewolf) {
          final Map<String, int> updatedPoints =
              Map<String, int>.from(gamer.role.points ?? <String, int>{});
          updatedPoints[AppStrings.aliveUntilChange] =
              (updatedPoints[AppStrings.aliveUntilChange] ?? 0) + 1;
          return gamer.copyWith(
            beforeChange: false,
            role: gamer.role.copyWith(points: updatedPoints),
          );
        } else {
          return gamer;
        }
      }).toList();
      emit(
        state.copyWith(
          gamers: state.gamersState.copyWith(gamers: updatedGamers),
          game: state.game.copyWith(
            mafiaCount: state.game.mafiaCount + 1,
            civilianCount: state.game.civilianCount - 1,
          ),
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
          gamers: state.gamersState.gamers
              .map(
                (Gamer gamer) => gamer.copyWith(
                  wasKilledByMafia: false,
                  wasHealed: false,
                  wasKilledByKiller: false,
                  wasBoomeranged: false,
                  wasSecured: false,
                  canTarget: true,
                  foulCount: 0,
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
                (Gamer gamer) => gamer.copyWith(
                  hasAlibi: false,
                  canTarget: true,
                  wasCheckedByMadam: false,
                  wasCheckedByMedium: false,
                  wasSecured: false,
                ),
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
      final RoleType roleTargeted = event.targetedGamer.role.roleType;
      final bool isTargetedMafia = roleTargeted == RoleType.Mafia ||
          roleTargeted == RoleType.Don ||
          (roleTargeted == RoleType.Werewolf &&
              !event.targetedGamer.beforeChange);
      final bool isTargetedCivilian = roleTargeted == RoleType.Civilian;

      if (targetedIndex != -1 && !isTargetingSelf) {
        final List<Gamer> updatedGamers = state.gamersState.gamers.map((
          Gamer gamer,
        ) {
          if (gamer.id == event.targetedGamer.id) {
            //If Killer wants to kill Werewolf -1 point for Werewolf
            if (gamer.role.roleType == RoleType.Werewolf) {
              final Map<String, int> updatedPoints =
                  Map<String, int>.from(gamer.role.points ?? <String, int>{});
              updatedPoints[AppStrings.killerTriedToKillBeforeChange] =
                  (updatedPoints[AppStrings.killerTriedToKillBeforeChange] ??
                          0) -
                      1;

              return gamer.copyWith(
                role: gamer.role.copyWith(points: updatedPoints),
              );
            } else {
              return gamer.copyWith(wasKilledByKiller: true);
            }
          } else if (gamer.id == event.killer.id) {
            final Map<String, int> updatedPoints = Map<String, int>.from(
              event.killer.role.points ?? <String, int>{},
            );
            if (event.killer.role.roleType == RoleType.Chameleon) {
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
                role: gamer.role.copyWith(points: updatedPoints),
              );
            } else {
              if (isTargetedMafia) {
                updatedPoints[AppStrings.killedMafias] =
                    (updatedPoints[AppStrings.killedMafias] ?? 0) + 2;
              } else {
                updatedPoints[AppStrings.killedCitizens] =
                    (updatedPoints[AppStrings.killedCitizens] ?? 0) - 1;
              }
              log('updatedPoints killer: $updatedPoints');
              return gamer.copyWith(
                targetId: event.targetedGamer.id,
                role: gamer.role.copyWith(points: updatedPoints),
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
      final RoleType roleTargeted = event.targetedGamer.role.roleType;

      final bool isTargetedMafia = roleTargeted == RoleType.Mafia ||
          roleTargeted == RoleType.Don ||
          (roleTargeted == RoleType.Werewolf &&
              !event.targetedGamer.beforeChange);

      final AppState appState = state.copyWith(
        gamers: state.gamersState.copyWith(
          gamers: state.gamersState.gamers.map((Gamer gamer) {
            if (gamer.id == event.targetedGamer.id) {
              print('gamer.id: ${gamer.name}, gamer.wasCheckedBySheriff:'
                  ' ${gamer.wasCheckedBySheriff}');
              if (isTargetedMafia) {
                if (gamer.wasCheckedBySheriff == false) {
                  return gamer.copyWith(wasCheckedBySheriff: true);
                } else {
                  return gamer.copyWith(
                    wasKilledBySheriff: true,
                    wasCheckedBySheriff: false,
                  );
                }
              } else {
                return gamer;
              }
            } else if (gamer.id == event.sheriff.id) {
              if (isTargetedMafia) {
                if (event.sheriff.role.roleType == RoleType.Chameleon) {
                  final Map<String, int> updatedPointsChameleon =
                      Map<String, int>.from(
                    event.sheriff.role.points ?? <String, int>{},
                  );

                  updatedPointsChameleon[AppStrings.playsForSheriff] =
                      (updatedPointsChameleon[AppStrings.playsForSheriff] ??
                              0) +
                          1;
                  log('updatedPoints sheriff: $updatedPointsChameleon');
                  return gamer.copyWith(
                    role: gamer.role.copyWith(points: updatedPointsChameleon),
                  );
                }
              }

              if (isTargetedMafia) {
                final Map<String, int> updatedPoints = Map<String, int>.from(
                  event.sheriff.role.points ?? <String, int>{},
                );
                if (event.targetedGamer.wasCheckedBySheriff == false) {
                  updatedPoints[AppStrings.entersToMafia] =
                      (updatedPoints[AppStrings.entersToMafia] ?? 0) + 1;
                }
                log('updatedPoints sheriff: $updatedPoints');
                return gamer.copyWith(
                  role: gamer.role.copyWith(points: updatedPoints),
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
      final RoleType roleGamer = event.targetedGamer.role.roleType;
      final bool isGamerMafia =
          roleGamer == RoleType.Mafia || roleGamer == RoleType.Don;

      final AppState appState = state.copyWith(
        gamers: state.gamersState.copyWith(
          gamers: state.gamersState.gamers.map((Gamer gamer) {
            final Map<String, int> updatedPoints =
                Map<String, int>.from(gamer.role.points ?? <String, int>{});

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
                role: gamer.role.copyWith(
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
      final RoleType roleGamer = event.targetedGamer.role.roleType;
      final bool isGamerMafia =
          roleGamer == RoleType.Mafia || roleGamer == RoleType.Don;
      final Map<String, int> updatedPoints = Map<String, int>.from(
        event.advocate.role.points ?? <String, int>{},
      );
      final AppState appState = state.copyWith(
        gamers: state.gamersState.copyWith(
          gamers: state.gamersState.gamers.map((Gamer gamer) {
            log('mafiaGamer.id: ${gamer.id}, event.targetedGamer.id:'
                ' ${event.targetedGamer.id},'
                ' event.gamerId: ${event.advocate.id}');
            if (gamer.id == event.targetedGamer.id) {
              return gamer.copyWith(hasAlibi: true);
            } else if (gamer.id == event.advocate.id) {
              if (event.advocate.role.roleType == RoleType.Chameleon) {
                if (isGamerMafia) {
                  updatedPoints[AppStrings.playsForAdvocate] =
                      (updatedPoints[AppStrings.playsForAdvocate] ?? 0) - 1;
                } else {
                  updatedPoints[AppStrings.playsForAdvocate] =
                      (updatedPoints[AppStrings.playsForAdvocate] ?? 0) + 1;
                }

                return gamer.copyWith(
                  role: gamer.role.copyWith(
                    points: updatedPoints,
                  ),
                );
              } else {
                log('isGamerMafia: $isGamerMafia');
                if (isGamerMafia) {
                  updatedPoints[AppStrings.gaveAlibiToMafia] =
                      (updatedPoints[AppStrings.gaveAlibiToMafia] ?? 0) - 1;
                } else {
                  updatedPoints[AppStrings.gaveAlibiToCitizen] =
                      (updatedPoints[AppStrings.gaveAlibiToCitizen] ?? 0) + 1;
                }
                return gamer.copyWith(
                  role: gamer.role.copyWith(
                    points: updatedPoints,
                  ),
                );
              }
            } else {
              log("is else");
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
            if (gamer.role.roleType == RoleType.Security) {
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
      final RoleType roleGamer = event.targetedGamer.role.roleType;
      final bool isGamerMafia =
          roleGamer == RoleType.Mafia || roleGamer == RoleType.Don;
      final AppState appState = state.copyWith(
        gamers: state.gamersState.copyWith(
          gamers: state.gamersState.gamers.map((Gamer gamer) {
            if (gamer.id == event.targetedGamer.id) {
              return gamer.copyWith(
                wasBoomeranged: true,
              );
            } else if (gamer.id == event.boomerang.id) {
              final Map<String, int> updatedPoints = Map<String, int>.from(
                event.boomerang.role.points ?? <String, int>{},
              );
              if (isGamerMafia) {
                updatedPoints[AppStrings.killedMafias] =
                    (updatedPoints[AppStrings.killedMafias] ?? 0) + 2;
              } else {
                updatedPoints[AppStrings.killedCitizens] =
                    (updatedPoints[AppStrings.killedCitizens] ?? 0) - 1;
              }
              return gamer.copyWith(
                role: gamer.role.copyWith(
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
      // log('infectedCount bloc 1: ${event.infectedCount}');
      final AppState appState = state.copyWith(
        game: state.game.copyWith(
          infectedCount: event.infectedCount,
        ),
      );
      // log('infectedCount bloc 2: ${appState.game.infectedCount}');
      emit(appState);
    });

    on<TakeAbilityFromGamer>(
      (TakeAbilityFromGamer event, Emitter<AppState> emit) {
        final AppState appState = state;
        final RoleType roleGamer = event.targetedGamer.role.roleType;
        final bool isGamerMafia =
            roleGamer == RoleType.Mafia || roleGamer == RoleType.Don;
        final bool isGamerCitizen = roleGamer == RoleType.Civilian;

        void removeTargetId(int targetId, RoleType role) {
          for (int i = 0; i < appState.gamersState.gamers.length; i++) {
            final Gamer gamer = appState.gamersState.gamers[i];
            if (gamer.id == targetId) {
              switch (role) {
                case RoleType.Doctor:
                  appState.gamersState.gamers[i] =
                      gamer.copyWith(wasHealed: false);
                  break;
                case RoleType.Mafia:
                case RoleType.Don:
                  appState.gamersState.gamers[i] =
                      gamer.copyWith(wasKilledByMafia: false);
                  break;
                case RoleType.Sheriff:
                  appState.gamersState.gamers[i] =
                      gamer.copyWith(wasKilledBySheriff: false);
                  break;
                case RoleType.Killer:
                  appState.gamersState.gamers[i] =
                      gamer.copyWith(wasKilledByKiller: false);
                  break;
                case RoleType.Security:
                  appState.gamersState.gamers[i] =
                      gamer.copyWith(killSecurity: false);
                  break;
                case RoleType.Boomerang:
                  appState.gamersState.gamers[i] =
                      gamer.copyWith(wasBoomeranged: false);
                  break;
                default:
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
                    event.targetedGamer.role.roleType != RoleType.Werewolf &&
                    event.targetedGamer.wasCheckedByMadam == false &&
                    event.targetedGamer.role.roleType != RoleType.Virus &&
                    event.targetedGamer.role.roleType != RoleType.Madam) {
                  if (gamer.targetId != null) {
                    removeTargetId(gamer.targetId!, gamer.role.roleType);
                  }
                  return gamer.copyWith(
                    canTarget: false,
                    targetId: 0,
                    wasCheckedByMadam: true,
                  );
                } else if (gamer.id == event.madam.id) {
                  final Map<String, int> updatedPoints = Map<String, int>.from(
                    event.madam.role.points ?? <String, int>{},
                  );

                  /// Chameleon plays as Madam
                  if (event.madam.role.roleType == RoleType.Chameleon) {
                    if (isGamerMafia) {
                      updatedPoints[AppStrings.playsForMadam] =
                          (updatedPoints[AppStrings.playsForMadam] ?? 0) + 1;
                      return gamer.copyWith(
                        role: gamer.role.copyWith(
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
                    log('updatedPoints 1: $updatedPoints');
                    return gamer.copyWith(
                      role: gamer.role.copyWith(
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

    on<NightAction>((NightAction event, Emitter<AppState> emit) {
      final List<Gamer> gamers = state.gamersState.gamers;
      final List<Gamer> killedGamers = <Gamer>[];
      List<Gamer> newKilledGamers = <Gamer>[];

      add(const UpdateAnimation(animate: true));

      for (final Gamer gamer in gamers) {
        if (!gamer.wasKilled) {
          if (!gamer.wasHealed) {
            if (gamer.wasKilledByMafia ||
                gamer.wasKilledByKiller ||
                gamer.wasKilledBySheriff ||
                gamer.wasBoomeranged ||
                gamer.killSecurity) {
              if (gamer.role.roleType != RoleType.Boomerang &&
                  gamer.role.roleType != RoleType.Werewolf) {
                // print('gamer $gamer');
                killedGamers.add(gamer);
              }
            }
          }
        }
      }
      if (killedGamers.isNotEmpty) {
        newKilledGamers = killedGamers
            .where(
              (Gamer gamer) => !gamer.wasSecured,
            )
            .toList();
        final List<Gamer> mafiaGamers = killedGamers
            .where(
              (Gamer gamer) =>
                  gamer.role.roleType == RoleType.Mafia ||
                  gamer.role.roleType == RoleType.Don,
            )
            .toList();
        final List<Gamer> otherGamers = killedGamers
            .where(
              (Gamer gamer) =>
                  gamer.role.roleType != RoleType.Mafia &&
                  gamer.role.roleType != RoleType.Don,
            )
            .toList();

        if (mafiaGamers.isNotEmpty) {
          for (final Gamer gamer in mafiaGamers) {
            add(
              KillGamer(gamer: gamer),
            );
          }
        }

        if (otherGamers.isNotEmpty) {
          for (final Gamer gamer in otherGamers) {
            switch (gamer.role.roleType) {
              case RoleType.Virus:
                final List<Gamer> infectedGamers = state.gamersState.gamers
                    .where(
                      (Gamer gamer) =>
                          gamer.wasInfected &&
                              !gamer.wasKilled &&
                              !gamer.wasHealed ||
                          gamer.role.roleType == RoleType.Virus,
                    )
                    .toList();
                print('infectedGamers: '
                    '$infectedGamers');
                add(
                  KillInfectedGamers(
                    infectedGamers: infectedGamers,
                  ),
                );
                break;
              default:
                print('Kill not virus gamer ${gamer.role.roleType}');
                add(
                  KillGamer(gamer: gamer),
                );
                break;
            }
          }
        }
      }
      event.showKilledGamers(newKilledGamers);
      add(
        const AddNightNumber(),
      );
      add(
        const CleanGamersAfterNight(),
      );
    });

    on<VotingAction>((VotingAction event, Emitter<AppState> emit) {
      final List<Gamer> gamers = state.gamersState.gamers;
      final int dayNumber = state.game.dayNumber;
      final int maxVotes = gamers.fold(
        0,
        (int prev, Gamer gamer) =>
            gamer.votesCount > prev ? gamer.votesCount : prev,
      );

      /// To show Chameleon functionality
      // if (roleIndex == 0) {
      //   showAddFunctionality(
      //     context,
      //     isVotingStarted: true,
      //     gamerId: 1,
      //     roleId: 1,
      //     nightNumber: 1,
      //   );
      // }

      if (maxVotes == 0) {
        event.showFailureInfo!();
      } else {
        final List<Gamer> topGamers = gamers
            .where(
              (Gamer gamer) => gamer.votesCount == maxVotes && maxVotes != 0,
            )
            .map((Gamer gamer) => gamer)
            .toList();

        if (topGamers.length == 1) {
          add(
            KillGamer(gamer: topGamers[0]),
          );

          add(
            const EndVoting(),
          );
          add(
            const AddDayNumber(),
          );
          if (dayNumber == 1 && topGamers[0].role.roleType == RoleType.Virus) {
            Gamer leftGamer = const Gamer.empty();
            Gamer rightGamer = const Gamer.empty();
            if (topGamers[0].id == 1) {
              leftGamer = gamers.last;
            } else {
              leftGamer = gamers[topGamers[0].id! - 2];
            }
            rightGamer = gamers[topGamers[0].id!];

            add(
              KillGamer(gamer: leftGamer),
            );
            add(
              KillGamer(gamer: rightGamer),
            );
          }
          if (!topGamers[0].hasAlibi && !topGamers[0].wasSecured) {
            event.showKilledGamers(
              topGamers[0],
            );
          }
        } else if (topGamers.length > 1) {
          event.showPickedNumber!(
            topGamers,
          );
        }
        if (dayNumber == 2) {
          for (final Gamer gamer in gamers) {
            add(
              InfectGamer(
                targetedGamer: gamer,
                infect: false,
              ),
            );
          }
        }
        add(
          const CleanGamersAfterDay(),
        );
        add(
          const ResetVoters(),
        );
        add(
          InfectedCount(
            infectedCount: state.game.mafiaCount,
          ),
        );
        add(
          const UpdateAnimation(animate: false),
        );
      }
    });

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
            if (gamer.role.roleType == RoleType.Chameleon) {
              return gamer.copyWith(
                chameleonRoleType: event.chameleonRoleType,
              );
            }
            return gamer;
          }).toList(),
        ),
      );
      log('Chameleon id: ${appState.gamersState.gamers.map(
        (Gamer gamer) => gamer.chameleonRoleType,
      )}');
      emit(appState);
    });

    on<UpdateGamer>((UpdateGamer event, Emitter<AppState> emit) async {
      final int index = state.gamersState.gamers.indexWhere(
        (Gamer gamer) => gamer.id == event.gamer.id,
      );
      if (index != -1) {
        final List<Gamer> updatedGamersList =
            List<Gamer>.from(state.gamersState.gamers);
        updatedGamersList[index] = updatedGamersList[index].copyWith(
          name: event.gamer.name,
          gamerId: event.gamer.gamerId,
          imageUrl: event.gamer.imageUrl,
          role: event.gamer.role,
          isNameChanged: event.gamer.isNameChanged,
        );

        try {
          if (!event.isGamerExist) {
            emit(
              state.copyWith(
                game: state.game.copyWith(
                  saveStatus: FirebaseSaveStatus.Saving,
                ),
              ),
            );
            final bool response =
                await gameRepository.addGamer(updatedGamersList[index]);
            if (response) {
              emit(
                state.copyWith(
                  game: state.game.copyWith(
                    saveStatus: FirebaseSaveStatus.Saved,
                  ),
                  gamers: state.gamersState.copyWith(gamers: updatedGamersList),
                ),
              );
              event.updated!();
            } else {
              event.showErrorMessage!(AppStrings.gamerExist);
            }
          } else {
            emit(
              state.copyWith(
                gamers: state.gamersState.copyWith(gamers: updatedGamersList),
              ),
            );
          }
        } catch (e) {
          log('Error updating mafiaGamer name: $e');
          event.showErrorMessage!(AppStrings.gamerExist);
        }
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
            emit(
              state.copyWith(
                game: state.game.copyWith(
                  saveStatus: FirebaseSaveStatus.Saving,
                ),
              ),
            );
            final bool response = await gameRepository.addGamer(newGamer);
            if (response) {
              emit(
                state.copyWith(
                  gamers: state.gamersState.copyWith(gamers: updatedGamersList),
                  game: state.game.copyWith(
                    numberOfGamers: numberOfGamers + 1,
                    saveStatus: FirebaseSaveStatus.Saved,
                  ),
                ),
              );
              event.updated!();
            } else {
              event.showErrorMessage!(AppStrings.gamerExist);
            }
          } else {
            emit(
              state.copyWith(
                gamers: state.gamersState.copyWith(gamers: updatedGamersList),
                game: state.game.copyWith(
                  numberOfGamers: numberOfGamers + 1,
                ),
              ),
            );
          }
        } catch (e) {
          log('Error adding mafiaGamer: $e');
          event.showErrorMessage!(AppStrings.gamerExist);
        }
      }
    });

    on<ChangeSaveStatus>((ChangeSaveStatus event, Emitter<AppState> emit) {
      final AppState appState = state.copyWith(
        game: state.game.copyWith(
          saveStatus: event.saveStatus,
        ),
      );
      emit(appState);
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
                (Gamer gamer) => gamer.copyWith(
                  wasVoted: false,
                  votesCount: 0,
                ),
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
