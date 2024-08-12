import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:mafia_game/features/app/app.dart';
import 'package:mafia_game/features/game/game.dart';
import 'package:mafia_game/utils/app_strings.dart';

class FirestoreService {
  final CollectionReference<Object?> _gamersCollection =
      FirebaseFirestore.instance.collection('gamers');
  final CollectionReference<Object?> _gameCollection =
      FirebaseFirestore.instance.collection('game');
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<String> uploadImageToFirebaseStorage(
    File imageFile,
    String fileName,
  ) async {
    final Reference ref = storage.ref().child('images/$fileName');
    final UploadTask uploadTask = ref.putFile(imageFile);
    final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    final String imageUrl = await taskSnapshot.ref.getDownloadURL();
    return imageUrl;
  }

  Future<void> addGameToFirebase({
    required GameState gameState,
  }) async {
    log('addGameToFirebase called');
    await _gameCollection.doc(gameState.gameId).set(<String, Object>{
      'gameName': gameState.gameName,
      'numberOfGamers': gameState.numberOfGamers,
      'gameId': gameState.gameId,
      'isMafiaWin': gameState.isMafiaWin,
      'gamers': gameState.gamers.map(
        (Gamer gamer) {
          final Map<String, int> gamerPoints = Map<String, int>.from(
            gamer.role.points ?? <String, int>{},
          );
          final bool isGamerMafia = gamer.role.roleType == RoleType.Mafia ||
              gamer.role.roleType == RoleType.Don;
          // final bool isGamerWerewolf = gamer.role!.roleId == 7;
          final int totalPoints = gamerPoints[AppStrings.totalPoints] ?? 0;
          final String uniqueId = UniqueKey().toString();
          log('Total points: $totalPoints');
          final Map<String, Object> newPointEntry = <String, Object>{
            'id': uniqueId,
            'points': totalPoints,
            'timestamp': DateFormat('yyyy-MM-dd').format(DateTime.now()),
          };
          _gamersCollection.doc(gamer.name).update(
            <Object, Object?>{
              'totalPlayedGames': FieldValue.increment(1),
              'won': FieldValue.increment(
                (isGamerMafia && gameState.isMafiaWin)
                    ? 1
                    : (!isGamerMafia && !gameState.isMafiaWin)
                        ? 1
                        : 0,
              ),
              'lost': FieldValue.increment(
                (isGamerMafia && !gameState.isMafiaWin)
                    ? 1
                    : (!isGamerMafia && gameState.isMafiaWin)
                        ? 1
                        : 0,
              ),
              'totalPoints': FieldValue.increment(totalPoints),
              'pointsHistory':
                  FieldValue.arrayUnion(<Map<String, Object>>[newPointEntry]),
            },
          );
          return <String, dynamic>{
            'name': gamer.name,
            'role': gamer.role.name,
            'roleType': gamer.role.roleType.toString(),
            'gamerId': gamer.gamerId,
            'gamerCreatedTime': gamer.gamerCreated,
            'imageUrl': gamer.imageUrl,
            'points': gamer.role.points?.map(
              (String key, int value) => MapEntry<String, int>(key, value),
            ),
          };
        },
      ).toList(),
      'gameStartTime': DateFormat('yyyy-MM-dd')
          .format(gameState.gameStartTime ?? DateTime.now()),
    });
  }

  Future<List<GameState>> getGames(DateTime dateTime) async {
    final String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('game')
              .where('gameStartTime', isEqualTo: formattedDate)
              .get();

      final List<GameState> games = querySnapshot.docs
          .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
        final Map<String, dynamic> data = doc.data();
        return GameState(
          gameName: data['gameName'] as String,
          numberOfGamers: data['numberOfGamers'] as int,
          gameId: data['gameId'] as String,
          isMafiaWin: data['isMafiaWin'] as bool,
          gameStartTime: DateTime.parse(data['gameStartTime'] as String),
          gamers: (data['gamers'] as List<dynamic>)
              .map(
                (dynamic gamer) => Gamer(
                  name: gamer['name'] as String,
                  role: Role(
                    name: gamer['role'] as String,
                    points: gamer['points'] as Map<String, int>,
                  ),
                  gamerId: gamer['gamerId'] as String,
                  gamerCreated: gamer['gamerCreatedTime'] as String,
                  imageUrl: gamer['imageUrl'] as String,
                ),
              )
              .toList(),
        );
      }).toList();
      // logger.log('Games from Firebase: $games');
      return games;
    } catch (error) {
      log('Error fetching games after: $error');
      return <GameState>[];
    }
  }

  Future<Gamer> addGamer(Gamer gamer) async {
    print('Trying to save');
    Gamer newGamer = const Gamer.empty();
    await _gamersCollection.doc(gamer.name).set(<String, dynamic>{
      'name': gamer.name,
      'gamerId': gamer.gamerId,
      'gamerCreatedTime': DateFormat('yyyy-MM-dd').format(DateTime.now()),
      "imageUrl": gamer.imageUrl,
      'citizen': 0,
      'mafia': 0,
      'werewolf': 0,
      'won': 0,
      'lost': 0,
      'totalPoints': 0,
      'totalPlayedGames': 0,
      'pointsHistory': <Map<String, Object>>[
        <String, Object>{
          'id': "",
          'points': 0,
          'timestamp': DateFormat('yyyy-MM-dd').format(DateTime.now()),
        },
      ],
    });
    final DocumentReference<Object?> docRef = _gamersCollection.doc(gamer.name);
    docRef.get().then(
      (DocumentSnapshot<dynamic> doc) {
        final Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
        newGamer = Gamer(
          name: data['name'] as String,
          gamerId: data['gamerId'] as String,
          gamerCreated: data['gamerCreatedTime'] as String,
          // documentId: documentReference.id,
        );
      },
      onError: (dynamic e) => log("Error getting document: $e"),
    );

    return newGamer;
  }

  Future<List<Gamer>> getGamers(String search) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot;
      if (search.isEmpty) {
        querySnapshot = await FirebaseFirestore.instance
            .collection('gamers')
            .limit(10)
            .get();
      } else {
        final String endString = '$search\uf8ff';
        querySnapshot = await FirebaseFirestore.instance
            .collection('gamers')
            .where('name', isGreaterThanOrEqualTo: search)
            .where('name', isLessThanOrEqualTo: endString)
            .get();
      }
      final List<Gamer> gamers = querySnapshot.docs
          .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
        final Map<String, dynamic> data = doc.data();
        return Gamer(
          name: data['name'] as String,
          imageUrl: data['imageUrl'] as String,
          gamerId: data['gamerId'] as String,
          gamerCreated: data['gamerCreatedTime'] as String,
          gamerCounts: GamerCounts(
            citizenCount: data['citizen'] as int,
            mafiaCount: data['mafia'] as int,
            othersCount: data['others'] as int,
            losingCount: data['lost'] as int,
            winnerCount: data['won'] as int,
            totalPlayedGames: data['totalPlayedGames'] as int,
            totalPoints: data['totalPoints'] as int,
          ),
        );
      }).toList();

      return gamers;
    } catch (error) {
      log('Error fetching gamers: $error');
      return <Gamer>[];
    }
  }

  // Future<void> updateGamer(Gamer gamer) =>
  //     _gamersCollection.doc(gamer.id).update(<Object, Object?>{
  //       'name': gamer.name,
  //       'role': gamer.role,
  //     });

  Future<void> deleteGamer(String documentId) =>
      _gamersCollection.doc(documentId).delete();
}
