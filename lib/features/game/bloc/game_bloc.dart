part of game;

class GameBloc extends Bloc<GameEvent, AppState> {
  final GameRepository _repository;

  GameBloc(this._repository) : super(const AppState.empty()) {
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
  }
}
