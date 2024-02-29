part of game;

class GameBloc extends Bloc<GameEvent, AppState> {
  GameBloc() : super( const AppState.empty()) {
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
  }
}
