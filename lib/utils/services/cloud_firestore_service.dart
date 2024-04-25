import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:mafia_game/features/game/game.dart';

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
    required String gameName,
    required int numberOfGamers,
    required String gameId,
    required List<Gamer> gamers,
    required DateTime gameStartTime,
  }) async {
    await _gameCollection.doc(gameId).set(<String, Object>{
      'gameName': gameName,
      'numberOfGamers': numberOfGamers,
      'gameId': gameId,
      'gamers': gamers.map((Gamer gamer) => gamer.toJson()).toList(),
      'gameStartTime': DateFormat('yyyy-MM-dd').format(gameStartTime),
    });
  }

  Future<Gamer> addGamer(Gamer gamer) async {
    // print("Gamer: ${gamer}");
    Gamer newGamer = const Gamer.empty();
    await _gamersCollection.doc(gamer.name).set(<String, dynamic>{
      'name': gamer.name,
      'role': gamer.role,
      'id': gamer.id,
      'gamerId': gamer.gamerId,
      'gamerCreatedTime': DateFormat('yyyy-MM-dd').format(DateTime.now()),
      "imageUrl": gamer.imageUrl,
    });
    final DocumentReference<Object?> docRef =
        _gamersCollection.doc(gamer.name);
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
