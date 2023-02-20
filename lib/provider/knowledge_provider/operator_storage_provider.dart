import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_web/domain/entities/knowledge/operator_entity.dart';
import 'package:flutter/foundation.dart';

class OperatorStorageProvider {
  final _firebaseStorage = FirebaseFirestore.instance;

  Future<List<OperatorEntity>> getListOperator() async {
    return await _firebaseStorage
        .collection('Operator')
        .withConverter<OperatorEntity>(
          fromFirestore: (snapshot, _) =>
              OperatorEntity.fromJson(snapshot.data()!),
          toFirestore: (operator, _) => operator.toJson(),
        )
        .get()
        .then((QuerySnapshot<OperatorEntity> querySnapshot) {
      final List<OperatorEntity> listOperator = [];
      for (var element in querySnapshot.docs) {
        if (element.exists) {
          listOperator.add(element.data());
        }
      }
      listOperator.sort((a, b) => (a.idOperator ?? 0).compareTo((b.idOperator ?? 0)));
      return listOperator;
    });
  }

  Future<bool> addNewOperator(OperatorEntity operatorEntity) async {
    final operatorsRef =
        _firebaseStorage.collection('Operator').withConverter<OperatorEntity>(
              fromFirestore: (snapshot, _) =>
                  OperatorEntity.fromJson(snapshot.data()!),
              toFirestore: (operator, _) => operator.toJson(),
            );
    return await operatorsRef
        .doc(operatorEntity.idOperator?.toString() ?? '0')
        .set(operatorEntity)
        .then((value) => true)
        .catchError((error) {
      if (kDebugMode) {
        print('add operator error: ${error.toString()}');
      }
      return false;
    });
  }

  Future<bool> updateOperator(OperatorEntity operatorEntity) async {
    final operatorsRef =
        _firebaseStorage.collection('Operator').withConverter<OperatorEntity>(
              fromFirestore: (snapshot, _) =>
                  OperatorEntity.fromJson(snapshot.data()!),
              toFirestore: (operator, _) => operator.toJson(),
            );

    return await operatorsRef
        .doc(operatorEntity.idOperator?.toString() ?? '0')
        .set(operatorEntity)
        .then((value) => true)
        .catchError((error) {
      if (kDebugMode) {
        print('Update operator error: ${error.toString()}');
      }
      return false;
    });
  }

  Future<bool> deleteOperator(OperatorEntity operatorEntity) async {
    final operatorsRef =
        _firebaseStorage.collection('Operator').withConverter<OperatorEntity>(
              fromFirestore: (snapshot, _) =>
                  OperatorEntity.fromJson(snapshot.data()!),
              toFirestore: (operator, _) => operator.toJson(),
            );

    return await operatorsRef
        .doc(operatorEntity.idOperator?.toString() ?? '0')
        .delete()
        .then((value) => true)
        .catchError((error) {
      if (kDebugMode) {
        print('Delete operator error: ${error.toString()}');
      }
      return false;
    });
  }
}
