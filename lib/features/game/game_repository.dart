part of game;

class GamerRepository implements GameRepository {
  FirestoreService firestoreService = FirestoreService();

  AppState saveGameDetails({
    required String gameName,
    required String typeOfGame,
    required String typeOfController,
    required int numberOfGamers,
    required String gamerId,
  }) =>
      AppState(
        game: GameState(
          gameName: gameName,
          typeOfGame: typeOfGame,
          typeOfController: typeOfController,
          numberOfGamers: numberOfGamers,
          gameId: gamerId,
        ),
      );

  @override
  Future<Gamer?> addGamer(Gamer gamer) async{
    try {
      return await firestoreService.addGamer(gamer);
    } catch (e) {
      return Future<Gamer?>.error(e);
    }
  }

  @override
  Future<void> addGameToFirebase({
    required GameState gameState,
  }) async {
    try {
      await firestoreService.addGameToFirebase(
        gameState: gameState,
      );
    } catch (e) {
      return Future<void>.error(e);
    }
  }

  @override
  Future<List<GameState>> getGames(DateTime dateTime) async {
    try {
      return await firestoreService.getGames(dateTime);
    } catch (e) {
      return Future<List<GameState>>.error(e);
    }
  }
}

abstract class GameRepository {
  Future<Gamer?> addGamer(Gamer gamer);
  Future<void> addGameToFirebase({
    required GameState gameState,
  });
  Future<List<GameState>> getGames(DateTime dateTime);
}
