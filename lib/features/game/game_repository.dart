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
    required String gameName,
    required int numberOfGamers,
    required String gameId,
    required List<Gamer> gamers,
    required DateTime gameStartTime,
  }) async {
    try {
      await firestoreService.addGameToFirebase(
        gameName: gameName,
        numberOfGamers: numberOfGamers,
        gameId: gameId,
        gamers: gamers,
        gameStartTime: gameStartTime,
      );
    } catch (e) {
      return Future<void>.error(e);
    }
  }
}

abstract class GameRepository {
  Future<Gamer?> addGamer(Gamer gamer);
  Future<void> addGameToFirebase({
    required String gameName,
    required int numberOfGamers,
    required String gameId,
    required List<Gamer> gamers,
    required DateTime gameStartTime,
  });
}
