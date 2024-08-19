import 'package:mafia_game/features/game/game.dart';
import 'package:mafia_game/utils/services/cloud_firestore_service.dart';

abstract class StatisticsRepository {
  Future<List<Gamer>> getGamers(String searchQuery);
  Future<List<Gamer>> getTop3Gamers(
      DateTime startDate,
      DateTime endDate,
      );
}

class StatisticsRepositoryImpl implements StatisticsRepository {
  FirestoreService firestoreService = FirestoreService();

  @override
  Future<List<Gamer>> getGamers(String searchQuery) =>
      firestoreService.getGamers(searchQuery);

  @override
  Future<List<Gamer>> getTop3Gamers(
      DateTime startDate,
      DateTime endDate,
      ) {
    try {
      return firestoreService.getTop3Gamers(
        startDate: startDate,
        endDate: endDate,
      );
    } catch (e) {
      return Future<List<Gamer>>.error(e);
    }
  }
}
