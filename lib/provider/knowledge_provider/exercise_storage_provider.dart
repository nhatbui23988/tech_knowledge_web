import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_web/domain/entities/knowledge/exercise_entity.dart';
import 'package:flutter/foundation.dart';

class ExerciseStorageProvider {
  final _firebaseStorage = FirebaseFirestore.instance;

  Future<List<ExerciseEntity>> getListExercise() async {
    return await _firebaseStorage
        .collection('Exercise')
        .withConverter<ExerciseEntity>(
          fromFirestore: (snapshot, _) =>
              ExerciseEntity.fromJson(snapshot.data()!),
          toFirestore: (exercise, _) => exercise.toJson(),
        )
        .get()
        .then((QuerySnapshot<ExerciseEntity> querySnapshot) {
      final List<ExerciseEntity> listExercise = [];
      for (var element in querySnapshot.docs) {
        if (element.exists) {
          listExercise.add(element.data());
        }
      }
      listExercise.sort((a, b) => (a.idExercise ?? 0).compareTo((b.idExercise ?? 0)));
      return listExercise;
    });
  }

  Future<bool> addNewExercise(ExerciseEntity exerciseEntity) async {
    final exercisesRef =
        _firebaseStorage.collection('Exercise').withConverter<ExerciseEntity>(
              fromFirestore: (snapshot, _) =>
                  ExerciseEntity.fromJson(snapshot.data()!),
              toFirestore: (exercise, _) => exercise.toJson(),
            );
    return await exercisesRef
        .doc(exerciseEntity.idExercise?.toString() ?? '0')
        .set(exerciseEntity)
        .then((value) => true)
        .catchError((error) {
      if (kDebugMode) {
        print('add exercise error: ${error.toString()}');
      }
      return false;
    });
  }

  Future<bool> updateExercise(ExerciseEntity exerciseEntity) async {
    final exercisesRef =
        _firebaseStorage.collection('Exercise').withConverter<ExerciseEntity>(
              fromFirestore: (snapshot, _) =>
                  ExerciseEntity.fromJson(snapshot.data()!),
              toFirestore: (exercise, _) => exercise.toJson(),
            );

    return await exercisesRef
        .doc(exerciseEntity.idExercise?.toString() ?? '0')
        .set(exerciseEntity)
        .then((value) => true)
        .catchError((error) {
      if (kDebugMode) {
        print('Update exercise error: ${error.toString()}');
      }
      return false;
    });
  }

  Future<bool> deleteExercise(ExerciseEntity exerciseEntity) async {
    final exercisesRef =
        _firebaseStorage.collection('Exercise').withConverter<ExerciseEntity>(
              fromFirestore: (snapshot, _) =>
                  ExerciseEntity.fromJson(snapshot.data()!),
              toFirestore: (exercise, _) => exercise.toJson(),
            );

    return await exercisesRef
        .doc(exerciseEntity.idExercise?.toString() ?? '0')
        .delete()
        .then((value) => true)
        .catchError((error) {
      if (kDebugMode) {
        print('Delete exercise error: ${error.toString()}');
      }
      return false;
    });
  }
}
