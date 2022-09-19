import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_web/domain/entities/knowledge/concept_entity.dart';
import 'package:demo_web/domain/entities/knowledge/construct_entity.dart';

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
      return listConstruct;
    });
  }
}
