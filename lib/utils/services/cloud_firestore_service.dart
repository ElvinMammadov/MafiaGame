import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mafia_game/features/game/models/gamer.dart';

class FirestoreService {
  final CollectionReference<Object?> _gamersCollection =
      FirebaseFirestore.instance.collection('gamers');

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

  Future<Gamer> addGamer(Gamer gamer) async {
    final DocumentReference<Object?> documentReference =
        await _gamersCollection.add(<String, dynamic>{
      'name': gamer.name,
      'role': gamer.role,
      'id': gamer.id,
    });
    final Gamer newGamer = Gamer(
      name: gamer.name,
      role: gamer.role,
      id: gamer.id,
      documentId: documentReference.id,
    );
    log("Document id is ${documentReference.id}");
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
