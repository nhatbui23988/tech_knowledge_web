

import 'package:demo_web/provider/auth_provider.dart';
import 'package:demo_web/provider/knowledge_provider/concept_storage_provider.dart';
import 'package:demo_web/provider/knowledge_provider/lesson_storage_provider.dart';
import 'package:get/get.dart';

class ProviderModule{
  static void init(){
      Get.put<AuthProvider>(AuthProvider());
      Get.put<ConceptStorageProvider>(ConceptStorageProvider());
      Get.put<LessonStorageProvider>(LessonStorageProvider());
  }
}