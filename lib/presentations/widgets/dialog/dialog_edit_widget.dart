import 'package:demo_web/app/res/app_colors.dart';
import 'package:demo_web/app/res/app_dimens.dart';
import 'package:demo_web/domain/entities/knowledge/concept_entity.dart';
import 'package:demo_web/domain/entities/knowledge/lesson_entity.dart';
import 'package:demo_web/presentations/widgets/dropdown_widget.dart';
import 'package:demo_web/provider/knowledge_provider/concept_storage_provider.dart';
import 'package:demo_web/provider/knowledge_provider/lesson_storage_provider.dart';
import 'package:flutter/material.dart';

class EditConceptDialogWidget extends StatefulWidget {
  const EditConceptDialogWidget(
      {Key? key,
      required this.conceptEntity,
      required this.conceptStorageProvider,
      required this.lessonStorageProvider})
      : super(key: key);
  final ConceptEntity conceptEntity;
  final ConceptStorageProvider conceptStorageProvider;
  final LessonStorageProvider lessonStorageProvider;

  @override
  State<EditConceptDialogWidget> createState() =>
      _EditConceptDialogWidgetState();
}

class _EditConceptDialogWidgetState extends State<EditConceptDialogWidget> {
  ConceptEntity get _conceptEntity => widget.conceptEntity;

  ConceptStorageProvider get _conceptStorageProvider =>
      widget.conceptStorageProvider;

  LessonStorageProvider get _lessonStorageProvider =>
      widget.lessonStorageProvider;
  final List<LessonEntity> _listLesson = [];
  bool isInitialized = false;
  late String? _currentLessonID = _conceptEntity.idLesson?.toString();
  final TextEditingController _conceptLinkController = TextEditingController();
  final TextEditingController _conceptNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getListLessonId();
    _conceptLinkController.text = _conceptEntity.linkConcept ?? '';
    _conceptNameController.text = _conceptEntity.nameConcept ?? '';
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   if (!isInitialized) {
    //     isInitialized = true;
    //
    //     setState(() {
    //       _currentLessonID = _conceptEntity.idLesson?.toString();
    //       print('_currentLessonID $_currentLessonID');
    //     });
    //   }
    // });
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
                  Text('${_conceptEntity.idConcept}', style: kTitleRowStyle)),
              DataCell(_lessonIdDropdown(_listLesson, _currentLessonID)),
              DataCell(TextField(
                  controller: _conceptLinkController, style: kTitleRowStyle)),
              DataCell(TextField(
                  controller: _conceptNameController, style: kTitleRowStyle)),
            ])
          ],
        ),
        const SizedBox(height: 24),
        OutlinedButton(onPressed: _onSave, child: const Text('Save'))
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

  void _onSave() async {
    final ConceptEntity editedConcept = ConceptEntity(
      idConcept: _conceptEntity.idConcept,
      idLesson: int.parse(_currentLessonID??'0'),
      linkConcept: _conceptLinkController.text,
      nameConcept: _conceptNameController.text
    );
    await _conceptStorageProvider.updateConcept(editedConcept);
  }

  void _onDelete() {}
}
