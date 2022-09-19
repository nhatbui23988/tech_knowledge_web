import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_web/domain/entities/knowledge/construct_entity.dart';
import 'package:flutter/foundation.dart';

class ConstructStorageProvider {
  final _firebaseStorage = FirebaseFirestore.instance;

  Future<List<ConstructEntity>> getListConstruct() async {
    return await _firebaseStorage
        .collection('Construct')
        .withConverter<ConstructEntity>(
          fromFirestore: (snapshot, _) =>
              ConstructEntity.fromJson(snapshot.data()!),
          toFirestore: (construct, _) => construct.toJson(),
        )
        .get()
        .then((QuerySnapshot<ConstructEntity> querySnapshot) {
      final List<ConstructEntity> listConstruct = [];
      for (var element in querySnapshot.docs) {
        if (element.exists) {
          listConstruct.add(element.data());
        }
      }
      listConstruct
          .sort((a, b) => (a.idConstruct ?? 0).compareTo((b.idConstruct ?? 0)));
      return listConstruct;
    });
  }

  Future<bool> addNewConstruct(ConstructEntity constructEntity) async {
    final constructsRef =
        _firebaseStorage.collection('Construct').withConverter<ConstructEntity>(
              fromFirestore: (snapshot, _) =>
                  ConstructEntity.fromJson(snapshot.data()!),
              toFirestore: (construct, _) => construct.toJson(),
            );
    return await constructsRef
        .doc(constructEntity.idConstruct?.toString() ?? '0')
        .set(constructEntity)
        .then((value) => true)
        .catchError((error) {
      if (kDebugMode) {
        print('add construct error: ${error.toString()}');
      }
      return false;
    });
  }

  Future<bool> updateConstruct(ConstructEntity constructEntity) async {
    final constructsRef =
        _firebaseStorage.collection('Construct').withConverter<ConstructEntity>(
              fromFirestore: (snapshot, _) =>
                  ConstructEntity.fromJson(snapshot.data()!),
              toFirestore: (construct, _) => construct.toJson(),
            );

    return await constructsRef
        .doc(constructEntity.idConstruct?.toString() ?? '0')
        .set(constructEntity)
        .then((value) => true)
        .catchError((error) {
      if (kDebugMode) {
        print('Update construct error: ${error.toString()}');
      }
      return false;
    });
  }

  Future<bool> deleteConstruct(ConstructEntity constructEntity) async {
    final constructsRef =
        _firebaseStorage.collection('Construct').withConverter<ConstructEntity>(
              fromFirestore: (snapshot, _) =>
                  ConstructEntity.fromJson(snapshot.data()!),
              toFirestore: (construct, _) => construct.toJson(),
            );
    return await constructsRef
        .doc(constructEntity.idConstruct?.toString() ?? '0')
        .delete()
        .then((value) => true)
        .catchError((error) {
      if (kDebugMode) {
        print('Update construct error: ${error.toString()}');
      }
      return false;
    });
  }
}
