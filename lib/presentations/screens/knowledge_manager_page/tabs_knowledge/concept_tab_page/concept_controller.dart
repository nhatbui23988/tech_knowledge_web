import 'package:demo_web/domain/entities/knowledge/concept_entity.dart';
import 'package:demo_web/presentations/base/base_controller.dart';
import 'package:demo_web/presentations/screens/knowledge_manager_page/knowledge_manager_controller.dart';
import 'package:demo_web/presentations/widgets/dialog/app_dialog.dart';
import 'package:demo_web/presentations/widgets/dialog/dialog_edit_concept_widget.dart';
import 'package:demo_web/provider/knowledge_provider/concept_storage_provider.dart';
import 'package:demo_web/provider/knowledge_provider/lesson_storage_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConceptTabController extends BaseController {
  final ConceptStorageProvider _conceptStorageProvider;
  final LessonStorageProvider _lessonStorageProvider;

  ConceptTabController(
      this._conceptStorageProvider, this._lessonStorageProvider);

  RxList<ConceptEntity> rxListConcept = RxList();
  List<ConceptEntity> listOriginal = [];

  RxnInt rxSortIndex = RxnInt();
  RxBool rxSortAscending = RxBool(true);

  RxnInt rxIndexRowSelected = RxnInt();

  @override
  void onInit() {
    super.onInit();
    _getListConcept();
  }

  void _getListConcept() async {
    List<ConceptEntity> listConcept =
        await _conceptStorageProvider.getListConcept();
    if (kDebugMode) {
      print('listConcept ${listConcept.length}');
    }
    rxListConcept.value = listConcept;
    listOriginal = listConcept;
  }

  void onSortChanged(int index, bool sortAscending) {
    rxSortIndex.value = index;
    rxSortAscending.value = sortAscending;
    rxListConcept.value = _onSortList();
  }

  List<ConceptEntity> _onSortList() {
    final listToSort = List.of(listOriginal);
    switch (rxSortIndex.value) {
      case 0:
        listToSort
            .sort((a, b) => (a.idConcept ?? 0).compareTo(b.idConcept ?? 0));
        break;
      case 1:
        listToSort.sort((a, b) => (a.idLesson ?? 0).compareTo(b.idLesson ?? 0));
        break;
      case 2:
        listToSort.sort(
            (a, b) => (a.linkConcept ?? '').compareTo(b.linkConcept ?? ''));
        break;
      case 3:
        listToSort.sort(
            (a, b) => (a.nameConcept ?? '').compareTo(b.nameConcept ?? ''));
        break;
    }
    if (!rxSortAscending.value) {
      return listToSort.reversed.toList();
    } else {
      return listToSort;
    }
  }

  void onAddConcept(BuildContext context) async {
    final newConcept = await _getNewConcept();
    Map<String, dynamic>? mapResult = await AppDialog.showAppDialog(
        context,
        EditConceptDialogWidget(
          conceptStorageProvider: _conceptStorageProvider,
          lessonStorageProvider: _lessonStorageProvider,
          storageAction: StorageAction.add,
          conceptEntity: newConcept,
        ));
    if (mapResult != null) {
      if (kDebugMode) {
        print('mapResult action ${mapResult['action']}');
        print('mapResult result ${mapResult['result']}');
      }
      _getListConcept();
    }
  }

  void onEditConcept(
      BuildContext context, int index, ConceptEntity conceptEntity) async {
    Map<String, dynamic>? mapResult = await AppDialog.showAppDialog(
        context,
        EditConceptDialogWidget(
          conceptStorageProvider: _conceptStorageProvider,
          conceptEntity: conceptEntity,
          lessonStorageProvider: _lessonStorageProvider,
          storageAction: StorageAction.edit,
        ));
    if (mapResult != null) {
      if (kDebugMode) {
        print('mapResult action ${mapResult['action']}');
        print('mapResult result ${mapResult['result']}');
      }
      _getListConcept();
    }
  }

  Future<ConceptEntity> _getNewConcept() async {
    final listConcept = await _conceptStorageProvider.getListConcept();
    if (listConcept.isNotEmpty) {
      final lastConcept = listConcept.last;
      return ConceptEntity(idConcept: (lastConcept.idConcept ?? 0) + 1);
    } else {
      return ConceptEntity(idConcept: 1);
    }
  }
}
