import 'package:demo_web/presentations/screens/knowledge_manager_page/tabs_knowledge/concept_tab_page/concept_controller.dart';
import 'package:demo_web/provider/knowledge_provider/concept_storage_provider.dart';
import 'package:demo_web/provider/knowledge_provider/lesson_storage_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddKnowledgeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<KnowledgeManagerController>(KnowledgeManagerController());
    Get.put<ConceptTabController>(ConceptTabController(Get.find<ConceptStorageProvider>(), Get.find<LessonStorageProvider>()));
  }
}

class KnowledgeManagerController extends GetxController  with GetTickerProviderStateMixin{
  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
  }
}
