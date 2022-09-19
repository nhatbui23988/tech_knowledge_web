import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_web/domain/entities/knowledge/relationship_entity.dart';
import 'package:demo_web/domain/entities/knowledge/relationship_entity.dart';
import 'package:demo_web/domain/entities/knowledge/relationship_entity.dart';
import 'package:flutter/foundation.dart';

class RelationshipStorageProvider {
  final _firebaseStorage = FirebaseFirestore.instance;

  Future<List<RelationshipEntity>> getListRelationship() async {
    return await _firebaseStorage
        .collection('Relationship')
        .withConverter<RelationshipEntity>(
          fromFirestore: (snapshot, _) =>
              RelationshipEntity.fromJson(snapshot.data()!),
          toFirestore: (relationship, _) => relationship.toJson(),
        )
        .get()
        .then((QuerySnapshot<RelationshipEntity> querySnapshot) {
      final List<RelationshipEntity> listRelationship = [];
      for (var element in querySnapshot.docs) {
        if (element.exists) {
          listRelationship.add(element.data());
        }
      }
      listRelationship.sort(
          (a, b) => (a.idRelationship ?? 0).compareTo((b.idRelationship ?? 0)));
      return listRelationship;
    });
  }

  Future<bool> addNewRelationship(RelationshipEntity relationshipEntity) async {
    final relationshipsRef = _firebaseStorage
        .collection('Relationship')
        .withConverter<RelationshipEntity>(
          fromFirestore: (snapshot, _) =>
              RelationshipEntity.fromJson(snapshot.data()!),
          toFirestore: (relationship, _) => relationship.toJson(),
        );
    return await relationshipsRef
        .doc(relationshipEntity.idRelationship?.toString() ?? '0')
        .set(relationshipEntity)
        .then((value) => true)
        .catchError((error) {
      if (kDebugMode) {
        print('add relationship error: ${error.toString()}');
      }
      return false;
    });
  }

  Future<bool> updateRelationship(RelationshipEntity relationshipEntity) async {
    final relationshipsRef = _firebaseStorage
        .collection('Relationship')
        .withConverter<RelationshipEntity>(
          fromFirestore: (snapshot, _) =>
              RelationshipEntity.fromJson(snapshot.data()!),
          toFirestore: (relationship, _) => relationship.toJson(),
        );

    return await relationshipsRef
        .doc(relationshipEntity.idRelationship?.toString() ?? '0')
        .set(relationshipEntity)
        .then((value) => true)
        .catchError((error) {
      if (kDebugMode) {
        print('Update relationship error: ${error.toString()}');
      }
      return false;
    });
  }

  Future<bool> deleteRelationship(RelationshipEntity relationshipEntity) async {
    final relationshipsRef = _firebaseStorage
        .collection('Relationship')
        .withConverter<RelationshipEntity>(
          fromFirestore: (snapshot, _) =>
              RelationshipEntity.fromJson(snapshot.data()!),
          toFirestore: (relationship, _) => relationship.toJson(),
        );

    return await relationshipsRef
        .doc(relationshipEntity.idRelationship?.toString() ?? '0')
        .delete()
        .then((value) => true)
        .catchError((error) {
      if (kDebugMode) {
        print('Delete relationship error: ${error.toString()}');
      }
      return false;
    });
  }
}
