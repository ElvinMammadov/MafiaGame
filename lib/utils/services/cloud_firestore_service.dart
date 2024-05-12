import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:mafia_game/features/app/app.dart';
import 'package:mafia_game/features/game/game.dart';
// import 'dart:developer' as logger;

class FirestoreService {
  final CollectionReference<Object?> _gamersCollection =
      FirebaseFirestore.instance.collection('gamers');
  final CollectionReference<Object?> _gameCollection =
      FirebaseFirestore.instance.collection('game');
  final FirebaseStorage storage = FirebaseStorage.instance;

  // Stream<List<Gamer>> getGamers() =>
  //     _gamersCollection.snapshots().map((QuerySnapshot<Object?> snapshot) =>
  //         snapshot.docs.map((QueryDocumentSnapshot<Object?> doc) {
  //           final Map<String, dynamic> data =
  //               doc.data()! as Map<String, dynamic>;
  //           return Gamer(
  //             id: doc.id,
  //             name: data['name'],
  //           );
  //         }).toList());

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
      'gamers': gameState.gamers
          .map(
            (Gamer gamer) => <String, dynamic>{
              'name': gamer.name,
              'role': gamer.role?.name,
              'roleId': gamer.role?.roleId,
              'id': gamer.id,
              'gamerId': gamer.gamerId,
              'gamerCreatedTime': gamer.gamerCreated,
              'imageUrl': gamer.imageUrl,
              'roleCount': gamer.roleCounts,
            },
          )
          .toList(),
      'gameStartTime': DateFormat('yyyy-MM-dd')
          .format(gameState.gameStartTime ?? DateTime.now()),
    });
  }

  Future<List<GameState>> getGames(DateTime dateTime) async {
    final String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
    print('Formatted Date: $formattedDate');
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
                  // role: Role(
                  //   name: gamer['role']['name'] as String,
                  //   roleId: gamer['role']['roleId'] as int,
                  // ),
                  role: gamer['role'] == null
                      ? null
                      : Role(
                          name: gamer['role'] as String,
                          roleId: gamer['roleId'] as int,
                        ),
                  id: gamer['id'] as int,
                  gamerId: gamer['gamerId'] as String,
                  gamerCreated: gamer['gamerCreatedTime'] as String,
                  imageUrl: gamer['imageUrl'] as String,
                  // roleCounts: Map<String, int>.from(
                  //   gamer['roleCount'] as Map<dynamic, dynamic>,
                  // )??<String, int>{} as Map<String, int>,
                ),
              )
              .toList(),
        );
      }).toList();

      return games;
    } catch (error) {
      print('Error fetching games: $error');
      return <GameState>[];
    }
  }

  Future<Gamer> addGamer(Gamer gamer) async {
    Gamer newGamer = const Gamer.empty();
    await _gamersCollection.doc(gamer.name).set(<String, dynamic>{
      'name': gamer.name,
      'role': gamer.role?.name,
      'roleId': gamer.role?.roleId,
      'id': gamer.id,
      'gamerId': gamer.gamerId,
      'gamerCreatedTime': DateFormat('yyyy-MM-dd').format(DateTime.now()),
      "imageUrl": gamer.imageUrl,
      'roleCounts': gamer.roleCounts,
    });
    final DocumentReference<Object?> docRef = _gamersCollection.doc(gamer.name);
    docRef.get().then(
      (DocumentSnapshot doc) {
        final Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
        newGamer = Gamer(
          name: data['name'] as String,
          role: gamer.role,
          gamerId: data['gamerId'] as String,
          gamerCreated: data['gamerCreatedTime'] as String,
          // documentId: documentReference.id,
        );
        // print("New Gamer: ${newGamer}");
        // print("Document data: ${data['name']}, gamerId: ${data['gamerId']},"
        //     " gamerCreated: ${data['gamerCreated']},"
        //     " ImageUrl: ${data['imageUrl']}, role: ${data['role']}");
      },
      onError: (e) => print("Error getting document: $e"),
    );

    return newGamer;
  }

  // Future<void> updateGamer(Gamer gamer) =>
  //     _gamersCollection.doc(gamer.id).update(<Object, Object?>{
  //       'name': gamer.name,
  //       'role': gamer.role,
  //     });

  Future<void> deleteGamer(String documentId) =>
      _gamersCollection.doc(documentId).delete();
}
