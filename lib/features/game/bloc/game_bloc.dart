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
      );
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

    on<AddVoteToGamer>((AddVoteToGamer event, Emitter<AppState> emit) {
      final AppState appState = state.copyWith(
        gamers: state.gamersState.copyWith(
          gamers: state.gamersState.gamers.map((Gamer gamer) {
            if (gamer.id == event.gamer.id) {
              return gamer.copyWith(votesCount: gamer.votesCount + 1);
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
          gamers: event.gamers,
        ),
      );
      emit(appState);
    });

    on<SendGameToFirebase>(
        (SendGameToFirebase event, Emitter<AppState> emit) async {
      try {
        await gameRepository.addGameToFirebase(
          gameState: event.gameState,
        );
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
        print('Error sending game to Firebase: $e');
      }
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
      emit(
        state.copyWith(
          game: event.gamer.role?.roleId == 2 || event.gamer.role?.roleId == 3
              ? state.game.copyWith(mafiaCount: state.game.mafiaCount - 1)
              : state.game
                  .copyWith(civilianCount: state.game.civilianCount - 1),
          gamers: state.gamersState.copyWith(
            gamers: state.gamersState.gamers.map((Gamer gamer) {
              if (gamer.id == event.gamer.id) {
                return gamer.copyWith(wasKilled: true, votesCount: 0);
              } else {
                return gamer.copyWith(votesCount: 0);
              }
            }).toList(),
          ),
        ),
      );
    });

    on<HealGamer>((HealGamer event, Emitter<AppState> emit) {
      final bool isTargetingSelf = event.gamerId == event.targetedGamer.id;
      final int targetedIndex = state.gamersState.gamers
          .indexWhere((Gamer gamer) => gamer.id == event.targetedGamer.id);

      // print('event.gamerId: ${event.gamerId}, '
      //     'event.targetedGamer.id: ${event.targetedGamer.id}');
      if (targetedIndex != -1 &&
          (isTargetingSelf ||
              state.gamersState.gamers[event.gamerId].canTarget)) {
        final List<Gamer> updatedGamers =
            state.gamersState.gamers.map((Gamer gamer) {
          if (gamer.id == event.targetedGamer.id) {
            return gamer.copyWith(wasHealed: true);
          } else if (gamer.id == event.gamerId) {
            return gamer.copyWith(targetId: event.targetedGamer.id);
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
      final bool isTargetingSelf = event.gamerId == event.targetedGamer.id;
      final int targetedIndex = state.gamersState.gamers
          .indexWhere((Gamer gamer) => gamer.id == event.targetedGamer.id);

      if (targetedIndex != -1 &&
          (isTargetingSelf ||
              state.gamersState.gamers[event.gamerId].canTarget)) {
        final List<Gamer> updatedGamers = state.gamersState.gamers.map((
          Gamer gamer,
        ) {
          if (gamer.id == event.targetedGamer.id) {
            return gamer.copyWith(wasKilledByMafia: true);
          } else if (gamer.id == event.gamerId) {
            return gamer.copyWith(targetId: event.targetedGamer.id);
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
                  canTarget: true,
                  targetId: 0,
                  killSecurity: false,
                ),
              )
              .toList(),
        ),
      );
      emit(appState);
    });

    on<KillGamerByKiller>((KillGamerByKiller event, Emitter<AppState> emit) {
      final bool isTargetingSelf = event.gamerId == event.targetedGamer.id;
      final int targetedIndex = state.gamersState.gamers
          .indexWhere((Gamer gamer) => gamer.id == event.targetedGamer.id);

      if (targetedIndex != -1 &&
          (isTargetingSelf ||
              state.gamersState.gamers[event.gamerId].canTarget)) {
        final List<Gamer> updatedGamers = state.gamersState.gamers.map((
          Gamer gamer,
        ) {
          if (gamer.id == event.targetedGamer.id) {
            return gamer.copyWith(wasKilledByKiller: true);
          } else if (gamer.id == event.gamerId) {
            return gamer.copyWith(targetId: event.targetedGamer.id);
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
      final AppState appState = state.copyWith(
        gamers: state.gamersState.copyWith(
          gamers: state.gamersState.gamers.map((Gamer gamer) {
            if (gamer.id == event.targetedGamer.id &&
                state.gamersState.gamers[event.gamerId].canTarget) {
              return gamer.copyWith(
                wasKilledBySheriff: true,
              );
            }
            return gamer;
          }).toList(),
        ),
      );
      emit(appState);
    });

    on<GiveAlibi>((GiveAlibi event, Emitter<AppState> emit) {
      final AppState appState = state.copyWith(
        gamers: state.gamersState.copyWith(
          gamers: state.gamersState.gamers.map((Gamer gamer) {
            if (gamer.id == event.targetedGamer.id) {
              return gamer.copyWith(hasAlibi: true);
            }
            return gamer;
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

    on<BoomerangGamer>((BoomerangGamer event, Emitter<AppState> emit) {
      final bool isTargetingSelf = event.gamerId == event.targetedGamer.id;
      final int targetedIndex = state.gamersState.gamers
          .indexWhere((Gamer gamer) => gamer.id == event.targetedGamer.id);

      if (targetedIndex != -1 &&
          (isTargetingSelf ||
              state.gamersState.gamers[event.gamerId].canTarget)) {
        final List<Gamer> updatedGamers =
            state.gamersState.gamers.map((Gamer gamer) {
          if (gamer.id == event.targetedGamer.id) {
            return gamer.copyWith(wasKilled: true, wasBoomeranged: true);
          } else if (gamer.id == event.gamerId) {
            return gamer.copyWith(targetId: event.targetedGamer.id);
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

    on<TakeAbilityFromGamer>(
      (TakeAbilityFromGamer event, Emitter<AppState> emit) {
        final AppState appState = state;

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
                case 6:
                  appState.gamersState.gamers[i] =
                      gamer.copyWith(wasKilledByKiller: false);
                  break;
                case 14:
                  appState.gamersState.gamers[i] =
                      gamer.copyWith(wasBoomeranged: false);
                  break;
              }
            }
          }
        }

        emit(
          appState.copyWith(
            gamers: appState.gamersState.copyWith(
              gamers: appState.gamersState.gamers.map((Gamer gamer) {
                if (gamer.id == event.targetedGamer.id) {
                  if (gamer.targetId != null) {
                    removeTargetId(gamer.targetId!, gamer.role!.roleId);
                  }
                  return gamer.copyWith(canTarget: false, targetId: 0);
                }
                return gamer;
              }).toList(),
            ),
          ),
        );
      },
    );

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
          final Gamer? gamer =
              await gameRepository.addGamer(updatedGamersList[index]);

          if (gamer != null) {
            // print('Result is : ${gamer}}');
          }
        } catch (e) {
          print('Error updating gamer name: $e');
        }

        final GamersState updatedGamersState =
            state.gamersState.copyWith(gamers: updatedGamersList);
        final AppState updatedAppState =
            state.copyWith(gamers: updatedGamersState);

        emit(updatedAppState);
      } else {
        emit(state);
      }
    });
  }
}
