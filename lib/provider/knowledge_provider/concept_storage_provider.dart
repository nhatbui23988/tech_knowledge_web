import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_web/domain/entities/knowledge/concept_entity.dart';
import 'package:flutter/foundation.dart';

class ConceptStorageProvider {
  final _firebaseStorage = FirebaseFirestore.instance;

  Future<List<ConceptEntity>> getListConcept() async {
    return await _firebaseStorage
        .collection('Concept')
        .withConverter<ConceptEntity>(
          fromFirestore: (snapshot, _) =>
              ConceptEntity.fromJson(snapshot.data()!),
          toFirestore: (concept, _) => concept.toJson(),
        )
        .get()
        .then((QuerySnapshot<ConceptEntity> querySnapshot) {
      final List<ConceptEntity> listConcept = [];
      for (var element in querySnapshot.docs) {
        if (element.exists) {
          listConcept.add(element.data());
        }
      }
      listConcept
          .sort((a, b) => (a.idConcept ?? 0).compareTo((b.idConcept ?? 0)));
      return listConcept;
    });
  }

  Future<bool> addNewConcept(ConceptEntity conceptEntity) async {
    final conceptsRef =
        _firebaseStorage.collection('Concept').withConverter<ConceptEntity>(
              fromFirestore: (snapshot, _) =>
                  ConceptEntity.fromJson(snapshot.data()!),
              toFirestore: (concept, _) => concept.toJson(),
            );
    return await conceptsRef
        .doc(conceptEntity.idConcept?.toString() ?? '0')
        .set(conceptEntity)
        .then((value) => true)
        .catchError((error) {
      if (kDebugMode) {
        print('add concept error: ${error.toString()}');
      }
      return false;
    });
  }

  Future<bool> updateConcept(ConceptEntity conceptEntity) async {
    final conceptsRef =
        _firebaseStorage.collection('Concept').withConverter<ConceptEntity>(
              fromFirestore: (snapshot, _) =>
                  ConceptEntity.fromJson(snapshot.data()!),
              toFirestore: (concept, _) => concept.toJson(),
            );

    return await conceptsRef
        .doc(conceptEntity.idConcept?.toString() ?? '0')
        .set(conceptEntity)
        .then((value) => true)
        .catchError((error) {
      if (kDebugMode) {
        print('Update concept error: ${error.toString()}');
      }
      return false;
    });
  }

  Future<bool> deleteConcept(ConceptEntity conceptEntity) async {
    final conceptsRef =
        _firebaseStorage.collection('Concept').withConverter<ConceptEntity>(
              fromFirestore: (snapshot, _) =>
                  ConceptEntity.fromJson(snapshot.data()!),
              toFirestore: (concept, _) => concept.toJson(),
            );

    return await conceptsRef
        .doc(conceptEntity.idConcept?.toString()??'0')
        .delete()
        .then((value) => true)
        .catchError((error) {
      if (kDebugMode) {
        print('Update concept error: ${error.toString()}');
      }
      return false;
    });
  }
}
