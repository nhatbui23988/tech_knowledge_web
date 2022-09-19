import 'package:demo_web/app/res/app_colors.dart';
import 'package:demo_web/app/res/app_dimens.dart';
import 'package:demo_web/domain/entities/knowledge/concept_entity.dart';
import 'package:demo_web/domain/entities/knowledge/lesson_entity.dart';
import 'package:demo_web/presentations/screens/knowledge_manager_page/knowledge_manager_controller.dart';
import 'package:demo_web/presentations/widgets/dropdown_widget.dart';
import 'package:demo_web/presentations/widgets/snackbar/app_snack_bar.dart';
import 'package:demo_web/provider/knowledge_provider/concept_storage_provider.dart';
import 'package:demo_web/provider/knowledge_provider/lesson_storage_provider.dart';
import 'package:flutter/material.dart';

class EditConceptDialogWidget extends StatefulWidget {
  const EditConceptDialogWidget(
      {Key? key,
      this.conceptEntity,
      required this.conceptStorageProvider,
      required this.lessonStorageProvider,
      required this.storageAction})
      : super(key: key);
  final ConceptEntity? conceptEntity;
  final ConceptStorageProvider conceptStorageProvider;
  final LessonStorageProvider lessonStorageProvider;
  final StorageAction storageAction;

  @override
  State<EditConceptDialogWidget> createState() =>
      _EditConceptDialogWidgetState();
}

class _EditConceptDialogWidgetState extends State<EditConceptDialogWidget> {
  late final ConceptEntity? _conceptEntity = widget.conceptEntity;

  StorageAction get _storageAction => widget.storageAction;

  ConceptStorageProvider get _conceptStorageProvider =>
      widget.conceptStorageProvider;

  LessonStorageProvider get _lessonStorageProvider =>
      widget.lessonStorageProvider;
  final List<LessonEntity> _listLesson = [];
  bool isInitialized = false;
  late String? _currentLessonID = _conceptEntity?.idLesson?.toString();
  final TextEditingController _conceptLinkController = TextEditingController();
  final TextEditingController _conceptNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getListLessonId();
    _conceptLinkController.text = _conceptEntity?.linkConcept ?? '';
    _conceptNameController.text = _conceptEntity?.nameConcept ?? '';
  }

  void _getListLessonId() async {
    final listLesson = await _lessonStorageProvider.getListLesson();
    setState(() {
      _listLesson.addAll(listLesson);
      print('_listLesson ${_listLesson.length}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DataTable(
          columns: const [
            DataColumn(label: Text('ConceptID', style: kTitleColumnStyle)),
            DataColumn(label: Text('LessonID', style: kTitleColumnStyle)),
            DataColumn(label: Text('ConceptLink', style: kTitleColumnStyle)),
            DataColumn(label: Text('ConceptName', style: kTitleColumnStyle)),
          ],
          rows: [
            DataRow(cells: [
              DataCell(
                  Text('${_conceptEntity?.idConcept}', style: kTitleRowStyle)),
              DataCell(_lessonIdDropdown(_listLesson, _currentLessonID)),
              DataCell(TextField(
                  controller: _conceptLinkController, style: kTitleRowStyle)),
              DataCell(TextField(
                  controller: _conceptNameController, style: kTitleRowStyle)),
            ])
          ],
        ),
        const SizedBox(height: 24),
        // OutlinedButton(
        //   onPressed: () => _onDelete(context),
        //   child: const Text('Delete'),
        //   style: OutlinedButton.styleFrom(backgroundColor: kErrorColor),
        // ),
        _storageAction == StorageAction.edit
            ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          OutlinedButton(
            onPressed: () => _onDelete(context),
            child:  Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Delete', style: kButtonStyle.copyWith(color: Colors.white)),
            ),
            style: OutlinedButton.styleFrom(backgroundColor: kErrorColor),
          ),
          const SizedBox(width: 24,),
          OutlinedButton(
            onPressed: () => _onSave(context),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Save', style: kButtonStyle),
            ),
          )
        ],)
            : OutlinedButton(
                onPressed: () => _onAddedNew(context),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Add', style: kButtonStyle),
                ),
              ),
      ],
    );
  }

  Widget _lessonIdDropdown(
      List<LessonEntity> listLesson, String? currentLessonId) {
    return DropdownWidget(
      listItem: List.generate(listLesson.length,
          (index) => listLesson[index].idLesson?.toString() ?? '$index}'),
      onChanged: (lessonID) {
        setState(() {
          _currentLessonID = lessonID;
        });
      },
      currentValue: currentLessonId,
    );
  }

  void _onSave(BuildContext context) async {
    final ConceptEntity editedConcept = ConceptEntity(
        idConcept: _conceptEntity?.idConcept,
        idLesson: int.parse(_currentLessonID ?? '1'),
        linkConcept: _conceptLinkController.text,
        nameConcept: _conceptNameController.text);
    final result = await _conceptStorageProvider.updateConcept(editedConcept);
    if (result) {
      AppSnackBar.showCommonSnackBar(context, content: 'Edited successfully', state: SnackBarState.succeed);
    } else {
      AppSnackBar.showCommonSnackBar(context, content: 'An error has occurred', state: SnackBarState.error);
    }
    Navigator.pop(context, {'action': StorageAction.edit, 'result': result});
  }

  void _onAddedNew(BuildContext context) async {
    if (_conceptEntity != null) {
      _conceptEntity?.linkConcept = _conceptLinkController.text;
      _conceptEntity?.nameConcept = _conceptNameController.text;
      _conceptEntity?.idLesson = int.parse(_currentLessonID ?? '1');
      final result =
          await _conceptStorageProvider.addNewConcept(_conceptEntity!);
      if (result) {
        AppSnackBar.showCommonSnackBar(context, content: 'Added successfully', state: SnackBarState.succeed);
      } else {
        AppSnackBar.showCommonSnackBar(context,
            content: 'An error has occurred', state: SnackBarState.error);
      }
      Navigator.pop(context, {'action': StorageAction.add, 'result': result});
    }
  }

  void _onDelete(BuildContext context) async {
    if (_conceptEntity != null) {
      final result =
          await _conceptStorageProvider.deleteConcept(_conceptEntity!);
      if (result) {
        AppSnackBar.showCommonSnackBar(context,
            content: 'Deleted successfully', state: SnackBarState.succeed);
      } else {
        AppSnackBar.showCommonSnackBar(context,
            content: 'An error has occurred', state: SnackBarState.error);
      }
      Navigator.pop(
          context, {'action': StorageAction.delete, 'result': result});
    }
  }
}
