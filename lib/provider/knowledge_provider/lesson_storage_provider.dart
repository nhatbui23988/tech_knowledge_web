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
        .add(lessonEntity)
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

    String? documentId = await lessonsRef
        .where('idLesson', isEqualTo: lessonEntity.idLesson)
        .get()
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        final doc = snapshot.docs.first;
        return doc.id;
      }
      return null;
    }).catchError((error) {
      if (kDebugMode) {
        print('concept not found error: ${error.toString()}');
      }
      return null;
    });

    if (documentId != null) {
      return await lessonsRef
          .doc(documentId)
          .set(lessonEntity)
          .then((value) => true)
          .catchError((error) {
        if (kDebugMode) {
          print('Update lesson error: ${error.toString()}');
        }
      });
    }
    return false;
  }
}
