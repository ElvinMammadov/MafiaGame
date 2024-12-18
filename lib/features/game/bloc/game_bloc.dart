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
          gameRoles: state.game.gameRoles.copyWith(
            roles: event.roles,
          ),
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
      final List<Gamer> changedGamersAnimation = state.gamersState.gamers
          .map(
            (Gamer gamer) => gamer.copyWith(
              isAnimated: false,
            ),
          )
          .toList();
      final AppState appState = state.copyWith(
        gamers: state.gamersState.copyWith(
          gamers: changedGamersAnimation,
        ),
        game: state.game.copyWith(
          gamePhase: GamePhase.Voting,
        ),
      );
      emit(appState);
    });

    on<EndVoting>((EndVoting event, Emitter<AppState> emit) {
      final AppState appState = state.copyWith(
        game: state.game.copyWith(
          gamePhase: GamePhase.Sleeping,
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

    on<SetFirstGamerVoted>((SetFirstGamerVoted event, Emitter<AppState> emit) {
      final AppState appState = state.copyWith(
        game: state.game.copyWith(
          firstGamerVoted: !state.game.firstGamerVoted,
        ),
      );
      emit(appState);
    });

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
        final List<Role> roles = event.gameState.gamers
            .map(
              (Gamer gamer) => gamer.role,
            )
            .toList();
        final List<Role> mainRoles = state.gamersState.roles.roles;
        final List<Role> filteredMainRoles = mainRoles
            .where(
              (Role mainRole) =>
                  roles.any((Role role) => role.name == mainRole.name) &&
                  mainRole.roleType != RoleType.Werewolf &&
                  mainRole.roleType != RoleType.Don,
            )
            .toList();
        final int civilianCount = event.gameState.gamers.length - mafiaCount;
        emit(
          state.copyWith(
            game: state.game.copyWith(
              gamePhase: GamePhase.Discussion,
              mafiaCount: mafiaCount,
              civilianCount: civilianCount,
            ),
            gamers: state.gamersState.copyWith(
              roles: state.gamersState.roles.copyWith(
                roles: filteredMainRoles,
              ),
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
                        (updatedPoints[AppStrings.alivePoints] ?? 0) + 0;
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
          infectedCount:
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
      final List<Role> roles = state.gamersState.roles.roles;
      final RoleType roleGamer = event.gamer.role.roleType;
      final int mafiaCount = state.game.mafiaCount;
      emit(
        state.copyWith(
          gamers: state.gamersState.copyWith(
            roles: state.gamersState.roles.copyWith(roles: roles),
            gamers: state.gamersState.gamers.map((Gamer gamer) {
              if (gamer.id == event.gamer.id) {
                ///Kill gamer if he was infected
                if (gamer.wasInfected) {
                  event.gamer.role.roleType == RoleType.Mafia ||
                          event.gamer.role.roleType == RoleType.Don ||
                          (event.gamer.role.roleType == RoleType.Werewolf &&
                              !event.gamer.beforeChange)
                      ? add(const ChangeGamerCounts(isMafia: true))
                      : add(const ChangeGamerCounts(isMafia: false));

                  if (roleGamer != RoleType.Don &&
                      roleGamer != RoleType.Mafia) {
                    roles.removeWhere(
                      (Role role) => role.roleType == roleGamer,
                    );
                  } else if (mafiaCount == 1) {
                    roles.removeWhere(
                      (Role role) => role.roleType == RoleType.Mafia,
                    );
                  }
                  return gamer.copyWith(wasKilled: true);
                } else if (gamePeriod == GamePeriod.Day && gamer.hasAlibi) {
                  return gamer;
                } else if (gamePeriod == GamePeriod.Night && gamer.wasSecured) {
                  return gamer;
                } else {
                  print('Gamer was killed, name: ${gamer.name}');
                  event.gamer.role.roleType == RoleType.Mafia ||
                          event.gamer.role.roleType == RoleType.Don ||
                          (event.gamer.role.roleType == RoleType.Werewolf &&
                              !event.gamer.beforeChange)
                      ? add(const ChangeGamerCounts(isMafia: true))
                      : add(const ChangeGamerCounts(isMafia: false));

                  if (roleGamer != RoleType.Don &&
                      roleGamer != RoleType.Mafia) {
                    roles.removeWhere(
                      (Role role) => role.roleType == roleGamer,
                    );
                  } else if (mafiaCount == 1) {
                    roles.removeWhere(
                      (Role role) => role.roleType == RoleType.Mafia,
                    );
                  }
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
                  event.gamer.wasInfected) {
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
      final RoleType roleTargeted = event.targetedGamer.role.roleType;
      final RoleType roleGamer = event.mafiaGamer.role.roleType;
      final bool isTargetedMafia =
          roleTargeted == RoleType.Mafia || roleTargeted == RoleType.Don;
      final bool isTargetedCivilian = roleTargeted == RoleType.Civilian;
      final bool isTargetedMainCharacter = roleTargeted == RoleType.Sheriff ||
          roleTargeted == RoleType.Madam ||
          roleTargeted == RoleType.Medium;
      final List<Gamer> mafiaGamers = state.gamersState.gamers
          .where(
            (Gamer gamer) =>
                gamer.role.roleType == RoleType.Mafia ||
                gamer.role.roleType == RoleType.Don,
          )
          .toList();
      final bool canMafiaTarget =
          mafiaGamers.every((Gamer gamer) => gamer.canTarget);

      final int targetedIndex = state.gamersState.gamers
          .indexWhere((Gamer gamer) => gamer.id == event.targetedGamer.id);

      if (targetedIndex != -1 && canMafiaTarget) {
        final List<Gamer> updatedGamers = state.gamersState.gamers.map((
          Gamer gamer,
        ) {
          if (gamer.id == event.targetedGamer.id) {
            //If Mafia wants to kill Werewolf +1 point for Werewolf
            if (gamer.role.roleType == RoleType.Werewolf) {
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
              if (roleGamer == RoleType.Werewolf) {
                return gamer.copyWith(wasKilledByWerewolf: true);
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
              targetId: event.targetedGamer.id,
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

    on<ChangeWerewolf>((ChangeWerewolf event, Emitter<AppState> emit) {
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
      final List<Role> roles = state.gamersState.roles.roles;
      roles.insert(0, const Werewolf.empty());
      emit(
        state.copyWith(
          gamers: state.gamersState.copyWith(
            gamers: updatedGamers,
            roles: state.gamersState.roles.copyWith(roles: roles),
          ),
          game: state.game.copyWith(
            mafiaCount: state.game.mafiaCount + 1,
            civilianCount: state.game.civilianCount - 1,
          ),
        ),
      );
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
                  wasKilledByWerewolf: false,
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
      final bool canKillerTarget = event.killer.canTarget;

      if (targetedIndex != -1 && !isTargetingSelf) {
        final List<Gamer> updatedGamers = state.gamersState.gamers.map((
          Gamer gamer,
        ) {
          if (gamer.id == event.targetedGamer.id && canKillerTarget) {
            //If Killer wants to kill Werewolf -1 point for Werewolf
            if (gamer.role.roleType == RoleType.Werewolf &&
                !event.targetedGamer.beforeChange) {
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
      final bool canSheriffTarget = event.sheriff.canTarget;

      final AppState appState = state.copyWith(
        gamers: state.gamersState.copyWith(
          gamers: state.gamersState.gamers.map((Gamer gamer) {
            if (gamer.id == event.targetedGamer.id && canSheriffTarget) {
              if (isTargetedMafia) {
                if (gamer.wasCheckedBySheriff == false) {
                  return gamer.copyWith(wasCheckedBySheriff: true);
                } else {
                  return gamer.copyWith(
                    wasKilledBySheriff: true,
                    wasCheckedBySheriff: false,
                    targetId: event.targetedGamer.id,
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

    on<GiveAlibi>((GiveAlibi event, Emitter<AppState> emit) {
      final RoleType roleGamer = event.targetedGamer.role.roleType;
      final bool isGamerMafia =
          roleGamer == RoleType.Mafia || roleGamer == RoleType.Don;
      final Map<String, int> updatedPoints = Map<String, int>.from(
        event.advocate.role.points ?? <String, int>{},
      );
      final bool canAdvocateTarget = event.advocate.canTarget;
      final AppState appState = state.copyWith(
        gamers: state.gamersState.copyWith(
          gamers: state.gamersState.gamers.map((Gamer gamer) {
            if (gamer.id == event.targetedGamer.id && canAdvocateTarget) {
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
                  targetId: event.targetedGamer.id,
                );
              }
            } else {
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
      final bool canBoomerangTarget = event.boomerang.canTarget;
      final AppState appState = state.copyWith(
        gamers: state.gamersState.copyWith(
          gamers: state.gamersState.gamers.map((Gamer gamer) {
            if (event.boomerang.wasKilledByKiller ||
                event.boomerang.wasKilledByMafia) {
              if (gamer.id == event.targetedGamer.id && canBoomerangTarget) {
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
                  targetId: event.targetedGamer.id,
                  role: gamer.role.copyWith(
                    points: updatedPoints,
                  ),
                );
              }
            }
            return gamer;
          }).toList(),
        ),
      );
      emit(appState);
    });

    on<InfectGamer>((InfectGamer event, Emitter<AppState> emit) {
      final int infectedCount = state.game.infectedCount;
      final AppState appState = state.copyWith(
        gamers: state.gamersState.copyWith(
          gamers: state.gamersState.gamers.map((Gamer gamer) {
            if (gamer.id == event.targetedGamer.id) {
              return gamer.copyWith(
                newlyInfected: event.infect,
                wasInfected: event.changeInfected,
              );
            }
            return gamer;
          }).toList(),
        ),
      );
      if (infectedCount == 1) {
        final List<Gamer> newlyInfectedGamers = appState.gamersState.gamers
            .where((Gamer gamer) => gamer.newlyInfected && !gamer.wasKilled)
            .toList();
        final List<Gamer> infectedGamers = appState.gamersState.gamers
            .where(
              (Gamer gamer) => gamer.wasInfected && !gamer.wasKilled,
            )
            .toList();

        if (newlyInfectedGamers.isNotEmpty) {
          for (final Gamer newGamer in infectedGamers) {
            add(
              InfectGamer(
                targetedGamer: newGamer,
                infect: false,
              ),
            );
          }
          for (final Gamer newGamer in newlyInfectedGamers) {
            add(
              InfectGamer(
                targetedGamer: newGamer,
                infect: false,
                changeInfected: true,
              ),
            );
          }
        }
      }
      emit(appState);
    });

    on<InfectedCount>((InfectedCount event, Emitter<AppState> emit) {
      final AppState appState = state.copyWith(
        game: state.game.copyWith(
          infectedCount: event.infectedCount,
        ),
      );
      emit(appState);
    });

    // Helper function for updating gamer state
    Gamer updateGamerState(Gamer gamer, RoleType role) {
      switch (role) {
        case RoleType.Doctor:
          return gamer.copyWith(wasHealed: false);
        case RoleType.Mafia:
        case RoleType.Don:
          return gamer.copyWith(wasKilledByMafia: false);
        case RoleType.Sheriff:
          return gamer.copyWith(wasKilledBySheriff: false);
        case RoleType.Killer:
          return gamer.copyWith(wasKilledByKiller: false);
        case RoleType.Security:
          return gamer.copyWith(killSecurity: false);
        case RoleType.Boomerang:
          return gamer.copyWith(wasBoomeranged: false);
        case RoleType.Advocate:
          return gamer.copyWith(hasAlibi: false);
        case RoleType.Werewolf:
          return gamer.copyWith(wasKilledByWerewolf: false);
        default:
          return gamer;
      }
    }

    on<TakeAbilityFromGamer>(
      (TakeAbilityFromGamer event, Emitter<AppState> emit) {
        final AppState appState = state.copyWith();
        final RoleType roleGamer = event.targetedGamer.role.roleType;
        final bool isGamerMafia =
            roleGamer == RoleType.Mafia || roleGamer == RoleType.Don;
        final bool isGamerCitizen = roleGamer == RoleType.Civilian;
        final List<Gamer> mafiaGamers = appState.gamersState.gamers
            .where(
              (Gamer gamer) =>
                  gamer.role.roleType == RoleType.Mafia ||
                  gamer.role.roleType == RoleType.Don,
            )
            .toList();

        void removeTargetId(int targetId, RoleType role) {
          final int index = appState.gamersState.gamers
              .indexWhere((Gamer gamer) => gamer.id == targetId);
          if (index != -1) {
            final Gamer gamer = appState.gamersState.gamers[index];
            final Gamer updatedGamer = updateGamerState(gamer, role);
            appState.gamersState.gamers[index] = updatedGamer;
          }
        }

        void updateMafiaGamers(Gamer mafiaGamer) {
          if (mafiaGamer.targetId != null) {
            removeTargetId(mafiaGamer.targetId!, mafiaGamer.role.roleType);
          } else {
            final int index = appState.gamersState.gamers
                .indexWhere((Gamer gamer) => gamer.id == mafiaGamer.id);
            if (index != -1) {
              appState.gamersState.gamers[index] = mafiaGamer.copyWith(
                canTarget: false,
                targetId: 0,
                wasCheckedByMadam: true,
              );
            }
          }
        }

        if (event.targetedGamer.wasCheckedByMadam == false &&
            event.targetedGamer.role.roleType != RoleType.Virus &&
            event.targetedGamer.role.roleType != RoleType.Madam) {
          if (isGamerMafia) {
            for (final mafiaGamer in mafiaGamers) {
              updateMafiaGamers(mafiaGamer);
            }
          } else {
            if (event.targetedGamer.targetId != null) {
              removeTargetId(
                event.targetedGamer.targetId!,
                event.targetedGamer.role.roleType,
              );
            }
            final int index = appState.gamersState.gamers.indexWhere(
              (Gamer gamer) => gamer.id == event.targetedGamer.id,
            );
            if (index != -1) {
              appState.gamersState.gamers[index] = event.targetedGamer.copyWith(
                canTarget: false,
                targetId: 0,
                wasCheckedByMadam: true,
              );
            }
          }

          emit(
            appState.copyWith(
              gamers: appState.gamersState.copyWith(
                gamers: appState.gamersState.gamers.map((Gamer gamer) {
                  if (gamer.id == event.madam.id) {
                    final Map<String, int> updatedPoints =
                        Map<String, int>.from(
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
                            (updatedPoints[AppStrings.entersToAnother] ?? 0) -
                                1;
                      } else if (isGamerMafia) {
                        updatedPoints[AppStrings.entersToMafia] =
                            (updatedPoints[AppStrings.entersToMafia] ?? 0) + 2;
                      }
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
        }
      },
    );

    on<NightAction>((NightAction event, Emitter<AppState> emit) {
      final List<Gamer> gamers = state.gamersState.gamers;
      final List<Gamer> killedGamers = <Gamer>[];

      for (final Gamer gamer in gamers) {
        if (!gamer.wasKilled) {
          if (!gamer.wasHealed && !gamer.wasSecured) {
            if (gamer.wasKilledByMafia ||
                gamer.wasKilledByKiller ||
                gamer.wasKilledBySheriff ||
                gamer.wasBoomeranged ||
                gamer.killSecurity ||
                gamer.wasKilledByWerewolf) {
              if (gamer.role.roleType != RoleType.Boomerang) {
                if (gamer.role.roleType == RoleType.Werewolf &&
                    gamer.beforeChange) {
                } else {
                  killedGamers.add(gamer);
                }
              }
              if (gamer.role.roleType == RoleType.Virus) {
                final List<Gamer> infectedGamers = state.gamersState.gamers
                    .where(
                      (Gamer gamer) => gamer.wasInfected && !gamer.wasKilled,
                    )
                    .toList();
                infectedGamers.forEach(killedGamers.add);
              }
            }
          }
        }
      }
      if (killedGamers.isNotEmpty) {
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
          for (final Gamer otherGamers in otherGamers) {
            add(
              KillGamer(gamer: otherGamers),
            );
          }
        }
      }
      event.showKilledGamers(killedGamers);
      add(
        const AddNightNumber(),
      );
      add(
        const CleanGamersAfterNight(),
      );
      add(
        const UpdateAnimation(animate: false),
      );
    });

    on<SleepingAction>((SleepingAction event, Emitter<AppState> emit) {
      add(
        const AddDayNumber(),
      );
      final AppState appState = state.copyWith(
        game: state.game.copyWith(
          gamePhase: GamePhase.Discussion,
        ),
      );
      emit(appState);
    });

    on<VotingAction>((VotingAction event, Emitter<AppState> emit) {
      final List<Gamer> gamers = state.gamersState.gamers;
      final int dayNumber = state.game.dayNumber;
      final int maxVotes = gamers.fold(
        0,
        (int prev, Gamer gamer) =>
            gamer.votesCount > prev ? gamer.votesCount : prev,
      );
      final List<Gamer> killedGamers = <Gamer>[];

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
            const EndVoting(),
          );
          add(
            const SetFirstGamerVoted(),
          );
          if (dayNumber == 1 && topGamers[0].role.roleType == RoleType.Virus) {
            Gamer leftGamer = const Gamer.empty();
            Gamer rightGamer = const Gamer.empty();
            final int middleGamerIndex = gamers.indexOf(topGamers[0]);

            // Handle edge cases
            if (middleGamerIndex == 0) {
              // Middle gamer is first in the list
              leftGamer = gamers.last; // Left gamer is the last element
              rightGamer = gamers[1]; // Right gamer is the second element
            } else if (middleGamerIndex == gamers.length - 1) {
              // Middle gamer is last in the list
              leftGamer = gamers[gamers.length -
                  2]; // Left gamer is the second to last element
              rightGamer = gamers[0]; // Right gamer is the first element
            } else {
              // Middle gamer is somewhere in the middle
              leftGamer = gamers[middleGamerIndex - 1];
              rightGamer = gamers[middleGamerIndex + 1];
            }
            killedGamers.add(leftGamer);
            killedGamers.add(rightGamer);
            killedGamers.add(topGamers[0]);
            add(
              KillGamer(gamer: leftGamer),
            );
            add(
              KillGamer(gamer: rightGamer),
            );
            add(
              KillGamer(gamer: topGamers[0]),
            );
            event.showKilledGamers(
              killedGamers,
            );
          } else {
            if (!topGamers[0].hasAlibi) {
              if (topGamers[0].role.roleType == RoleType.Virus) {
                final List<Gamer> infectedGamers = state.gamersState.gamers
                    .where(
                      (Gamer gamer) => gamer.wasInfected && !gamer.wasKilled,
                    )
                    .toList();
                print('Infected gamers: '
                    '${infectedGamers.map((Gamer e) => e.name)}');
                infectedGamers.forEach(killedGamers.add);
                killedGamers.add(topGamers[0]);
              } else {
                killedGamers.add(topGamers[0]);
              }
              if (killedGamers.isNotEmpty) {
                print('Killed gamers name:'
                    ' ${killedGamers.map((Gamer e) => e.name)}');
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
                  for (final Gamer otherGamer in otherGamers) {
                    add(
                      KillGamer(gamer: otherGamer),
                    );
                  }
                }
              }
              event.showKilledGamers(
                killedGamers,
              );
            } else if (topGamers[0].hasAlibi) {
              event.gamerHasAlibi!(topGamers[0]);
            }
          }
          add(
            const CleanGamersAfterDay(),
          );
          add(
            const ResetVoters(),
          );
          add(
            const ResetVoter(),
          );
          add(
            const SetVotingDirection(votingDirection: VoteDirection.NotSet),
          );
          add(
            const UpdateAnimation(animate: false),
          );
        } else if (topGamers.length > 1) {
          event.showPickedNumber!(
            topGamers,
          );
        }
      }
    });

    on<RemoveVote>((RemoveVote event, Emitter<AppState> emit) {
      final AppState appState = state.copyWith(
        gamers: state.gamersState.copyWith(
          gamers: state.gamersState.gamers.map((Gamer gamer) {
            if (gamer.id == event.gamer.id) {
              return gamer.copyWith(votesCount: 0);
            }
            return gamer;
          }).toList(),
        ),
      );
      emit(appState);
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

    on<RestoreGamer>(
      (RestoreGamer event, Emitter<AppState> emit) {
        final List<Role> roles = state.gamersState.roles.roles;
        final bool isGamerMafia =
            event.targetedGamer.role.roleType == RoleType.Mafia ||
                event.targetedGamer.role.roleType == RoleType.Don;
        final int mafiaCount = state.game.mafiaCount;
        if (isGamerMafia && mafiaCount == 0) {
          roles.insert(0, const Mafia.empty());
        } else {
          roles.add(event.targetedGamer.role);
        }
        final AppState appState = state.copyWith(
          gamers: state.gamersState.copyWith(
            roles: state.gamersState.roles.copyWith(
              roles: roles,
            ),
            gamers: state.gamersState.gamers.map((Gamer gamer) {
              if (gamer.id == event.targetedGamer.id) {
                return gamer.copyWith(
                  wasKilled: false,
                  wasHealed: false,
                  wasSecured: false,
                  wasKilledByMafia: false,
                  wasKilledByKiller: false,
                  wasKilledBySheriff: false,
                  wasBoomeranged: false,
                  wasCheckedByMadam: false,
                  wasCheckedByMedium: false,
                  wasKilledByWerewolf: false,
                  canTarget: true,
                  hasAlibi: false,
                  newlyInfected: false,
                  wasInfected: false,
                  isAnimated: false,
                  targetId: 0,
                  killSecurity: false,
                  votesCount: 0,
                );
              }
              return gamer;
            }).toList(),
          ),
          game: state.game.copyWith(
            mafiaCount: isGamerMafia ? mafiaCount + 1 : mafiaCount,
            civilianCount: !isGamerMafia
                ? state.game.civilianCount + 1
                : state.game.civilianCount,
          ),
        );
        emit(appState);
      },
    );

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
          hasImage: event.gamer.hasImage,
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

    on<SetVotingDirection>((SetVotingDirection event, Emitter<AppState> emit) {
      final AppState appState = state.copyWith(
        game: state.game.copyWith(
          voteDirection: event.votingDirection,
        ),
      );
      emit(appState);
    });

    on<SetStarterId>((SetStarterId event, Emitter<AppState> emit) {
      final AppState appState = state.copyWith(
        game: state.game.copyWith(
          starterId: event.starterId,
        ),
      );
      emit(appState);
    });
  }
}
