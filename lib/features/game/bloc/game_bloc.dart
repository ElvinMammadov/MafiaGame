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
      for (int i = event.newPosition; i < updatedGamersList.length; i++) {
        updatedGamersList[i] =
            updatedGamersList[i].copyWith(positionOnTable: currentPosition);
        currentPosition++;
      }
      for (int i = 0; i < event.newPosition; i++) {
        updatedGamersList[i] =
            updatedGamersList[i].copyWith(positionOnTable: currentPosition);
        currentPosition++;
      }
      final AppState appState = state.copyWith(
        gamers: state.gamersState.copyWith(gamers: updatedGamersList),
      );
      // print('appState is : ${appState.gamersState.gamers}');
      emit(appState);
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
          gameName: event.gameName,
          numberOfGamers: event.numberOfGamers,
          gameId: event.gameId,
          gamers: event.gamers,
          gameStartTime: event.gameStartTime,
        );
        final AppState appState = state.copyWith(
          game: state.game.copyWith(
            isGameStarted: true,
            isDiscussionStarted: true,
          ),
        );
        // print('appState is : ${appState}');
        emit(appState);
      } catch (e) {
        print('Error sending game to Firebase: $e');
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
      final AppState appState = state.copyWith(
        gamers: state.gamersState.copyWith(
          gamers: state.gamersState.gamers.map((Gamer gamer) {
            if (gamer.id == event.gamer.id) {
              return gamer.copyWith(wasKilled: true, votesCount: 0);
            } else {
              return gamer.copyWith(votesCount: 0);
            }
          }).toList(),
        ),
      );
      emit(appState);
    });

    on<HealGamer>((HealGamer event, Emitter<AppState> emit) {
      final bool isTargetingSelf = event.gamerId == event.targetedGamer.id;
      final int targetedIndex = state.gamersState.gamers
          .indexWhere((Gamer gamer) => gamer.id == event.targetedGamer.id);

      print('targetedIndex: $targetedIndex, isTargetingSelf: $isTargetingSelf');
      if (targetedIndex != -1 &&
          (isTargetingSelf ||
              state.gamersState.gamers[event.gamerId].canTarget)) {
        final List<Gamer> updatedGamers =
            state.gamersState.gamers.map((Gamer gamer) {
          if (gamer.id == event.targetedGamer.id) {
            return gamer.copyWith(wasHealed: true);
          } else if (isTargetingSelf) {
            return gamer.copyWith(targetId: event.targetedGamer.id);
          } else {
            return gamer;
          }
        }).toList();
        print('updatedGamers: $updatedGamers');
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
          } else if (isTargetingSelf) {
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
          } else if (isTargetingSelf) {
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
            if (gamer.id == event.targetedGamer.id && gamer.canTarget) {
              return gamer.copyWith(
                // wasKilled: true,
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
                // wasKilled: false,
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
          } else if (isTargetingSelf) {
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

        void removeTargetId(int targetId) {
          for (int i = 0; i < appState.gamersState.gamers.length; i++) {
            final Gamer gamer = appState.gamersState.gamers[i];
            if (gamer.id == targetId) {
              if (gamer.wasKilledByKiller ||
                  gamer.wasKilledByMafia ||
                  gamer.wasBoomeranged) {
                appState.gamersState.gamers[i] =
                    gamer.copyWith(wasKilled: false);
              }
              if (gamer.wasHealed) {
                appState.gamersState.gamers[i] =
                    gamer.copyWith(wasHealed: false);
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
                    removeTargetId(gamer.targetId!);
                  }
                  return gamer.copyWith(canTarget: false);
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
