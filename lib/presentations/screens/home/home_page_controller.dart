import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_web/domain/entities/knowledge/lesson_entity.dart';
import 'package:demo_web/presentations/base/base_controller.dart';
import 'package:demo_web/provider/knowledge_provider/lesson_storage_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageController extends BaseController {
  ScrollController homeScrollController = ScrollController();
  TextEditingController searchTextController = TextEditingController();
  RxList<LessonEntity> listSearchResult = RxList();
  HomePageController() {
    getData();
  }

  void getData() async {
    final document =
        await FirebaseFirestore.instance.collection('Concept').get();
    final docsLength = document.docs.length;
    // print('document.docs.length $docsLength');
    if (docsLength > 0) {
      for (var element in document.docs) {
        element.data().keys.forEach((keyData) {
          // print('keyData $keyData : ${element.get(keyData)}');
        });
      }
    }
  }

  onSearch(BuildContext context) async {
    listSearchResult.clear();
    listSearchResult.value = await LessonStorageProvider()
        .searchLesson(searchTextController.text.trim());
    if (listSearchResult.isNotEmpty) {
      homeScrollController.animateTo(MediaQuery.of(context).size.height,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    }
  }
}
