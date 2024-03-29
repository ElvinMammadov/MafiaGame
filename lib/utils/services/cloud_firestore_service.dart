import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mafia_game/features/game/models/gamer.dart';

class FirestoreService {
  final CollectionReference<Object?> _gamersCollection =
      FirebaseFirestore.instance.collection('gamers');
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
    log('Image Url: $imageUrl');
    return imageUrl;
  }

  Future<Gamer> addGamer(Gamer gamer) async {
    Gamer newGamer = const Gamer.empty();
    await _gamersCollection.doc(gamer.gamerId).set(<String, dynamic>{
      'name': gamer.name,
      'role': gamer.role,
      'id': gamer.id,
      'gamerId': gamer.gamerId,
      'gamerCreated': DateTime.now().toString(),
      "imageUrl": gamer.imageUrl,
    });
    final DocumentReference<Object?> docRef =
        _gamersCollection.doc(gamer.gamerId);
    docRef.get().then(
      (DocumentSnapshot doc) {
        final Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
        newGamer = Gamer(
          name: data['name'] as String,
          role: gamer.role,
          gamerId: data['gamerId'] as String,
          gamerCreated: data['gamerCreated'] as String,
          // documentId: documentReference.id,
        );
        print("Document data: ${data['name']}, gamerId: ${data['gamerId']},"
            " gamerCreated: ${data['gamerCreated']},"
            " ImageUrl: ${data['imageUrl']}, role: ${data['role']}");
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
