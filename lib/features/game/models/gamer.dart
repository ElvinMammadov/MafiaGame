import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Gamer extends Equatable {
  final String? name;
  final String? role;
  final String? imageUrl;
  final int? id;
  final String? documentId;

  const Gamer({
    this.name,
    this.role,
    this.imageUrl,
    this.id,
    this.documentId,
  });

  const Gamer.empty()
      : name = '',
        role = '',
        imageUrl = '',
        id = 0,
        documentId = '';

  Gamer copyWith({
    String? name,
    String? role,
    String? imageUrl,
    int? id,
    String? documentId,
  }) =>
      Gamer(
        name: name ?? this.name,
        role: role ?? this.role,
        imageUrl: imageUrl ?? this.imageUrl,
        id: id ?? this.id,
        documentId: documentId ?? this.documentId,
      );

  factory Gamer.fromFireStore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final Map<String, dynamic> data = snapshot.data()!;
    final Gamer gamer = Gamer(
      name: data['name'] as String,
      role: data['role'] as String,
      imageUrl: data['imageUrl'] as String,
      documentId: data['documentId'] as String,
    );
    return gamer;
  }

  Map<String, dynamic> toFireStore() => <String, dynamic>{
        if (name != null) "name": name,
        if (role != null) "role": role,
        if (imageUrl != null) "imageUrl": imageUrl,
        if (documentId != null) "id": documentId,
      };

  @override
  List<Object?> get props => <Object?>[
        name,
        role,
        imageUrl,
        id,
        documentId,
      ];

  @override
  String toString() => 'Gamer'
      '{name: $name, role: $role,'
      ' imageUrl: $imageUrl}, id: $id, documentId: $documentId}';
}
