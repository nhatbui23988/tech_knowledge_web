import 'package:demo_web/presentations/screens/knowledge_manager_page/tabs_knowledge/concept_tab_page/concept_controller.dart';
import 'package:demo_web/presentations/screens/knowledge_manager_page/tabs_knowledge/concept_tab_page/concept_tab_page.dart';
import 'package:demo_web/presentations/screens/knowledge_manager_page/tabs_knowledge/lesson_tab_page/lesson_controller.dart';
import 'package:demo_web/presentations/screens/knowledge_manager_page/tabs_knowledge/lesson_tab_page/lesson_tab_page.dart';
import 'package:demo_web/provider/knowledge_provider/concept_storage_provider.dart';
import 'package:demo_web/provider/knowledge_provider/lesson_storage_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum StorageAction { add, edit, delete }

class AddKnowledgeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<KnowledgeManagerController>(KnowledgeManagerController());
    Get.put<ConceptTabController>(ConceptTabController(
        Get.find<ConceptStorageProvider>(), Get.find<LessonStorageProvider>()));
    Get.put<LessonTabController>(
        LessonTabController(Get.find<LessonStorageProvider>()));
  }
}

class KnowledgeManagerController extends GetxController
    with GetTickerProviderStateMixin {
  late TabController tabController;
   List<Widget> listPage = const [ConceptTabPage(), LessonTabPage()];

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: listPage.length, vsync: this);
  }
}
