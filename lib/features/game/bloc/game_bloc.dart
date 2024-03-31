part of game;

class GameBloc extends Bloc<GameEvent, AppState> {
  final GameRepository gameRepository;

  GameBloc(this.gameRepository) : super(const AppState.empty()) {
    on<UpdateGameDetails>((UpdateGameDetails event, Emitter<AppState> emit) {
      final AppState appState = state.copyWith(
        game: state.game.copyWith(
          gameName: event.gameName,
          typeOfGame: event.typeOfGame,
          typeOfController: event.typeOfController,
          numberOfGamers: event.numberOfGamers,
        ),
      );
      emit(appState);
    });

    on<ChangeGameStartValue>(
        (ChangeGameStartValue event, Emitter<AppState> emit) {
      final AppState appState = state.copyWith(
        game: state.game.copyWith(
          isGameStarted: event.isGameStarted,
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

    on<CleanGamers>((CleanGamers event, Emitter<AppState> emit) {
      final AppState appState = state.copyWith(
        gamers: state.gamersState.copyWith(
          gamers: event.gamers,
        ),
      );
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
          final Gamer? gamer =
              await gameRepository.addGamer(updatedGamersList[index]);

          if (gamer != null) {
            print('Result is : ${gamer}}');
          }
        } catch (e) {
          print('Error updating gamer name: $e');
        }

        final GamersState updatedGamersState =
            state.gamersState.copyWith(gamers: updatedGamersList);
        print('gamer is : ${updatedGamersState.gamers[index]}}');
        final AppState updatedAppState =
            state.copyWith(gamers: updatedGamersState);

        emit(updatedAppState);
      } else {
        emit(state);
      }
    });
  }
}
