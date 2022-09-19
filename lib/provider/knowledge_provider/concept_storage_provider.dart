import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_web/domain/entities/knowledge/concept_entity.dart';

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
        .add(conceptEntity)
        .then((value) => true)
        .catchError((error) {
      print('add concept error: ${error.toString()}');
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

    String? documentId = await conceptsRef
        .where('idConcept', isEqualTo: conceptEntity.idConcept)
        .get()
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        final doc = snapshot.docs.first;
        return doc.id;
      }
      return null;
    }).catchError((error) {
      print('concept not found error: ${error.toString()}');
      return null;
    });

    if (documentId != null) {
      return await conceptsRef
          .doc(documentId)
          .set(conceptEntity)
          .then((value) => true)
          .catchError((error) {
        print('Update concept error: ${error.toString()}');
      });
    }
    return false;
  }
}
