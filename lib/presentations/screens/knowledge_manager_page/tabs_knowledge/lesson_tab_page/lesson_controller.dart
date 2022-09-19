import 'package:demo_web/domain/entities/knowledge/lesson_entity.dart';
import 'package:demo_web/presentations/base/base_controller.dart';
import 'package:demo_web/presentations/screens/knowledge_manager_page/knowledge_manager_controller.dart';
import 'package:demo_web/presentations/widgets/dialog/app_dialog.dart';
import 'package:demo_web/presentations/widgets/dialog/dialog_edit_lesson_widget.dart';
import 'package:demo_web/provider/knowledge_provider/lesson_storage_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LessonTabController extends BaseController {
  final LessonStorageProvider _lessonStorageProvider;

  LessonTabController(this._lessonStorageProvider);

  RxList<LessonEntity> rxListLesson = RxList();

  RxnInt rxSortIndex = RxnInt();
  RxBool rxSortAscending = RxBool(true);

  RxnInt rxIndexRowSelected = RxnInt();

  @override
  void onInit() {
    super.onInit();
    _getListLesson();
  }

  void _getListLesson() async {
    List<LessonEntity> listLesson =
        await _lessonStorageProvider.getListLesson();
    if (kDebugMode) {
      print('listLesson ${listLesson.length}');
    }
    rxListLesson.value = listLesson;
  }

  void onSortChanged(int index, bool sortAscending) {
    rxSortIndex.value = index;
    rxSortAscending.value = sortAscending;
  }

  void onAddLesson(BuildContext context) async {
    final newLesson = await _getNewLesson();
    Map<String, dynamic>? mapResult = await AppDialog.showAppDialog(
        context,
        EditLessonDialogWidget(
          lessonStorageProvider: _lessonStorageProvider,
          storageAction: StorageAction.add,
          lessonEntity: newLesson,
        ));
    if (mapResult != null) {
      if (kDebugMode) {
        print('mapResult action ${mapResult['action']}');
        print('mapResult result ${mapResult['result']}');
      }
      _getListLesson();
    }
  }

  void onEditLesson(
      BuildContext context, int index, LessonEntity lessonEntity) async {
    Map<String, dynamic>? mapResult = await AppDialog.showAppDialog(
        context,
        EditLessonDialogWidget(
          lessonEntity: lessonEntity,
          lessonStorageProvider: _lessonStorageProvider,
          storageAction: StorageAction.edit,
        ));
    if (mapResult != null) {
      if (kDebugMode) {
        print('mapResult action ${mapResult['action']}');
        print('mapResult result ${mapResult['result']}');
      }
      _getListLesson();
    }
  }

  Future<LessonEntity> _getNewLesson() async {
    final listLesson = await _lessonStorageProvider.getListLesson();
    if (listLesson.isNotEmpty) {
      final lastLesson = listLesson.last;
      return LessonEntity(idLesson: (lastLesson.idLesson ?? 0) + 1);
    } else {
      return LessonEntity(idLesson: 1);
    }
  }
}
