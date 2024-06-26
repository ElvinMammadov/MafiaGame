import 'package:mafia_game/features/game/game.dart';
import 'package:mafia_game/utils/services/cloud_firestore_service.dart';

abstract class StatisticsRepository {
  Future<List<Gamer>> getGamers(String searchQuery);
}

class StatisticsRepositoryImpl implements StatisticsRepository {
  FirestoreService firestoreService = FirestoreService();
  @override
  Future<List<Gamer>> getGamers(String searchQuery) {
    return firestoreService.getGamers(searchQuery);
  }

}