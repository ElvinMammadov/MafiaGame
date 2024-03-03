part of game;

class GameBloc extends Bloc<GameEvent, AppState> {
  GameBloc() : super(const AppState.empty()) {
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

    on<AddGamer>((AddGamer event, Emitter<AppState> emit) {
      final AppState appState = state.copyWith(
        gamers: state.gamers.copyWith(
          gamers: List<Gamer>.from(state.gamers.gamers)..add(event.gamer),
        ),
      );
      emit(appState);
    });

    on<UpdateGamerName>((UpdateGamerName event, Emitter<AppState> emit) {
      final int index = state.gamers.gamers.indexWhere(
        (Gamer gamer) => gamer.id == event.gamer.id,
      );
      if (index != -1) {
        // Create a copy of the gamers list with the updated name
        final List<Gamer> updatedGamersList =
            List<Gamer>.from(state.gamers.gamers);
        updatedGamersList[index] =
            updatedGamersList[index].copyWith(name: event.gamer.name);

        // Create an updated gamers state with the modified list
        final GamersState updatedGamersState =
            state.gamers.copyWith(gamers: updatedGamersList);

        // Create an updated app state with the modified gamers state
        final AppState updatedAppState =
            state.copyWith(gamers: updatedGamersState);

        // Emit the updated app state
        emit(updatedAppState);
      } else {
        // Gamer with the specified ID not found, emit the current state
        emit(state);
      }
    });
  }
}
