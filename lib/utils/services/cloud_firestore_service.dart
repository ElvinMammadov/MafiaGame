import 'dart:collection';
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
          final List<Map<String, dynamic>> gamerPointsList = gamerPoints.entries
              .map(
                (MapEntry<String, int> entry) => <String, Object>{
                  'key': entry.key,
                  'value': entry.value,
                },
              )
              .toList();
          final bool isGamerMafia = gamer.role.roleType == RoleType.Mafia ||
              gamer.role.roleType == RoleType.Don;
          final int totalPoints = gamerPoints[AppStrings.totalPoints] ?? 0;
          final String uniqueId = UniqueKey().toString();
          final Map<String, Object> newPointEntry = <String, Object>{
            'pointsId': uniqueId,
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
            'points': gamerPointsList,
            'pointsId': uniqueId,
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
          gamers: (data['gamers'] as List<dynamic>).map((dynamic gamerData) {
            final Map<String, dynamic> gamer =
                gamerData as Map<String, dynamic>;
            final String name = gamer['name'] as String;
            final String roleName = gamer['role'] as String;
            final String gamerId = gamer['gamerId'] as String;
            final String gamerCreated = gamer['gamerCreatedTime'] as String;
            final String imageUrl = gamer['imageUrl'] as String;
            final String roleType = gamer['roleType'] as String;

            // Convert points list back to map
            final List<dynamic> pointsList = gamer['points'] as List<dynamic>;
            final Map<String, int> pointsMap = <String, int>{
              for (final dynamic item in pointsList)
                item['key'] as String: item['value'] as int,
            };

            return Gamer(
              name: name,
              role: Role(
                name: roleName,
                points: pointsMap,
                roleType: RoleType.values.firstWhere(
                  (RoleType type) => type.toString() == roleType,
                ),
              ),
              gamerId: gamerId,
              gamerCreated: gamerCreated,
              imageUrl: imageUrl,
            );
          }).toList(),
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
          'pointsId': "",
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

  Future<void> updateGamerPoints({
    required String gameId,
    required String gamerId,
    required Map<String, int> points,
  }) async {
    try {
      final DocumentReference<Object?> gameRef = _gameCollection.doc(gameId);
      final DocumentSnapshot<Object?> gameSnapshot = await gameRef.get();

      if (gameSnapshot.exists) {
        final Map<String, dynamic> gameData =
            gameSnapshot.data()! as Map<String, dynamic>;
        final List<dynamic> gamers = gameData['gamers'];
        final int gamerIndex =
            gamers.indexWhere((dynamic gamer) => gamer['gamerId'] == gamerId);

        if (gamerIndex != -1) {
          final Map<String, dynamic> gamer = gamers[gamerIndex];
          final List<Map<String, dynamic>> gamerPointsList = points.entries
              .map(
                (MapEntry<String, int> entry) => <String, Object>{
                  'key': entry.key,
                  'value': entry.value,
                },
              )
              .toList();
          gamer['points'] = gamerPointsList;
          gamers[gamerIndex] = gamer;
          await gameRef.update(<Object, Object?>{'gamers': gamers});
          log('Gamer points updated successfully');

          // Update gamer's total points and points history
          final int totalPoints = points[AppStrings.totalPoints] ?? 0;
          final DocumentReference<Object?> gamerRef =
              _gamersCollection.doc(gamer['name']);
          final DocumentSnapshot<Object?> gamerSnapshot = await gamerRef.get();

          if (gamerSnapshot.exists) {
            final Map<String, dynamic> gamerData =
                gamerSnapshot.data()! as Map<String, dynamic>;
            final List<dynamic> pointsHistory = gamerData['pointsHistory'];
            final int oldTotalPoints = gamerData['totalPoints'] ?? 0;
            print('Old total points: $oldTotalPoints');

            if (pointsHistory.isNotEmpty) {
              // Find the existing points entry and update its values
              final int pointsIndex = pointsHistory.indexWhere(
                (dynamic p) => p['pointsId'] == gamer['pointsId'],
              );
              if (pointsIndex != -1) {
                final Map<String, dynamic> pointsEntry =
                    pointsHistory[pointsIndex];
                pointsEntry['points'] = totalPoints;
                pointsHistory[pointsIndex] = pointsEntry;
                await gamerRef.update(<Object, Object?>{
                  'pointsHistory': pointsHistory,
                });
                log('Gamer points history updated successfully');
              } else {
                log('Points entry not found for gamer');
              }
            } else {
              log('Gamer has no points history');
            }

            // Calculate the difference in total points
            final int pointsDifference = totalPoints - oldTotalPoints;

            print('New total points: $pointsDifference');

            // Update total points only if there's a difference
            if (pointsDifference != 0) {
              await gamerRef.update(<Object, Object?>{
                'totalPoints': FieldValue.increment(pointsDifference),
              });
              log('Gamer total points updated successfully');
            } else {
              log('No change in total points');
            }
          } else {
            log('Gamer not found');
          }
        } else {
          log('Gamer not found in the game');
        }
      } else {
        log('Game not found');
      }
    } catch (e) {
      log('Error updating gamer points: $e');
    }
  }

  Future<List<Gamer>> getTop3Gamers({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    print('Start date: ${DateFormat('yyyy-MM-dd').format(startDate)}, End date: ${DateFormat('yyyy-MM-dd').format(endDate)}');
    try {
      final QuerySnapshot gamersSnapshot = await _gamersCollection.get();

      print('Gamers snapshot: ${gamersSnapshot.docs}');

      final List<Map<String, dynamic>> gamersWithPoints =
          <Map<String, dynamic>>[];
      for (final QueryDocumentSnapshot gamerDoc in gamersSnapshot.docs) {
        final Map<String, dynamic> gamerData =
            gamerDoc.data()! as Map<String, dynamic>;

        final List<dynamic> pointsHistory = gamerData['pointsHistory'];

        int totalPoints = 0;
        for (final dynamic pointEntry in pointsHistory) {
          final DateTime timestamp =
              DateFormat('yyyy-MM-dd').parse(pointEntry['timestamp']);
          if (timestamp.isAfter(startDate) && timestamp.isBefore(endDate)) {
            totalPoints += pointEntry['points'] as int;
          }
        }

        gamersWithPoints.add(<String, dynamic>{
          'name': gamerData['name'],
          'totalPoints': totalPoints,
        });
      }

      gamersWithPoints.sort(
        (Map<String, dynamic> a, Map<String, dynamic> b) =>
            b['totalPoints'] - a['totalPoints'],
      );

      // Convert to List<Gamer>
      final List<Gamer> topGamers = gamersWithPoints
          .sublist(0, 3)
          .map(
            (Map<String, dynamic> gamerData) => Gamer(
              name: gamerData['name'] as String,
              imageUrl: gamerData['imageUrl'] as String,
              gamerId: gamerData['gamerId'] as String,
              gamerCreated: gamerData['gamerCreatedTime'] as String,
              gamerCounts: GamerCounts(
                citizenCount: gamerData['citizen'] as int,
                mafiaCount: gamerData['mafia'] as int,
                losingCount: gamerData['lost'] as int,
                winnerCount: gamerData['won'] as int,
                totalPlayedGames: gamerData['totalPlayedGames'] as int,
                totalPoints: gamerData['totalPoints'] as int,
              ),
            ),
          )
          .toList();
      return topGamers;
    } catch (e) {
      log('Error getting top 3 gamers in Firebase 1 : $e');
      return <Gamer>[];
    }
  }

  Future<void> deleteGamer(String documentId) =>
      _gamersCollection.doc(documentId).delete();
}
