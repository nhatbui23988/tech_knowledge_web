import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_web/domain/entities/knowledge/lesson_entity.dart';
import 'package:flutter/foundation.dart';

class LessonStorageProvider {
  final _firebaseStorage = FirebaseFirestore.instance;

  Future<List<LessonEntity>> getListLesson() async {
    return await _firebaseStorage
        .collection('Lesson')
        .withConverter<LessonEntity>(
          fromFirestore: (snapshot, _) =>
              LessonEntity.fromJson(snapshot.data()!),
          toFirestore: (lesson, _) => lesson.toJson(),
        )
        .get()
        .then((QuerySnapshot<LessonEntity> querySnapshot) {
      final List<LessonEntity> listLesson = [];
      for (var element in querySnapshot.docs) {
        if (element.exists) {
          listLesson.add(element.data());
        }
      }
      if(listLesson.isNotEmpty) {
        listLesson.sort((a, b) => (a.idLesson ?? 0).compareTo((b.idLesson ?? 0)));
      }
      return listLesson;
    });
  }

  Future<bool> addNewLesson(LessonEntity lessonEntity) async {
    final lessonsRef =
        _firebaseStorage.collection('Lesson').withConverter<LessonEntity>(
              fromFirestore: (snapshot, _) =>
                  LessonEntity.fromJson(snapshot.data()!),
              toFirestore: (lesson, _) => lesson.toJson(),
            );
    return await lessonsRef
        .doc(lessonEntity.idLesson?.toString() ?? '0')
        .set(lessonEntity)
        .then((value) => true)
        .catchError((error) {
      if (kDebugMode) {
        print('add lesson error: ${error.toString()}');
      }
      return false;
    });
  }

  Future<bool> updateLesson(LessonEntity lessonEntity) async {
    final lessonsRef =
        _firebaseStorage.collection('Lesson').withConverter<LessonEntity>(
              fromFirestore: (snapshot, _) =>
                  LessonEntity.fromJson(snapshot.data()!),
              toFirestore: (lesson, _) => lesson.toJson(),
            );

    return await lessonsRef
        .doc(lessonEntity.idLesson?.toString() ?? '0')
        .set(lessonEntity)
        .then((value) => true)
        .catchError((error) {
      if (kDebugMode) {
        print('Update lesson error: ${error.toString()}');
      }
      return false;
    });
  }

  Future<bool> deleteLesson(LessonEntity lessonEntity) async {
    final lessonsRef =
        _firebaseStorage.collection('Lesson').withConverter<LessonEntity>(
              fromFirestore: (snapshot, _) =>
                  LessonEntity.fromJson(snapshot.data()!),
              toFirestore: (lesson, _) => lesson.toJson(),
            );

    return await lessonsRef
        .doc(lessonEntity.idLesson?.toString() ?? '0')
        .delete()
        .then((value) => true)
        .catchError((error) {
      if (kDebugMode) {
        print('Delete lesson error: ${error.toString()}');
      }
      return false;
    });
  }
}
