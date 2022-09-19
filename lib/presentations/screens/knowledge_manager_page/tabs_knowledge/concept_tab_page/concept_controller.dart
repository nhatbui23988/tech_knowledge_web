import 'package:demo_web/domain/entities/knowledge/concept_entity.dart';
import 'package:demo_web/presentations/base/base_controller.dart';
import 'package:demo_web/presentations/widgets/dialog/app_dialog.dart';
import 'package:demo_web/presentations/widgets/dialog/dialog_edit_widget.dart';
import 'package:demo_web/provider/knowledge_provider/concept_storage_provider.dart';
import 'package:demo_web/provider/knowledge_provider/lesson_storage_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConceptTabController extends BaseController {
  final ConceptStorageProvider _knowledgeStorageProvider;
  final LessonStorageProvider _lessonStorageProvider;

  ConceptTabController(this._knowledgeStorageProvider, this._lessonStorageProvider);

  RxList<ConceptEntity> rxListConcept = RxList();

  RxnInt rxSortIndex = RxnInt();
  RxBool rxSortAscending = RxBool(true);

  @override
  void onInit() {
    super.onInit();
    _getListConcept();
  }

  void _getListConcept() async {
    List<ConceptEntity> listConcept =
        await _knowledgeStorageProvider.getListConcept();
    print('listConcept ${listConcept.length}');
    rxListConcept.value = listConcept;
  }

  void onSortChanged(int index, bool sortAscending) {
    rxSortIndex.value = index;
    rxSortAscending.value = sortAscending;
  }

  void onAddConcept() {}

  void onEditConcept(
      BuildContext context, int index, ConceptEntity conceptEntity) async {
    await AppDialog.showAppDialog(
        context,
        EditConceptDialogWidget(
          conceptStorageProvider: _knowledgeStorageProvider,
          conceptEntity: conceptEntity, lessonStorageProvider: _lessonStorageProvider,
        ));
  }
}
