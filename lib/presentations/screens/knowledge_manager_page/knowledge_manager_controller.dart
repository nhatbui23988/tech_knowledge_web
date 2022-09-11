import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddKnowledgeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<KnowledgeManagerController>(KnowledgeManagerController());
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
