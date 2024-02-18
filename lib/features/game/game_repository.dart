part of game;

class GameRepository {
  AppState saveGameDetails({
    required String gameName,
    required String typeOfGame,
    required String typeOfController,
    required int numberOfGamers,
  }) => AppState(
      game: GameState(
        gameName: gameName,
        typeOfGame: typeOfGame,
        typeOfController: typeOfController,
        numberOfGamers: numberOfGamers,
      ),
    );
}
