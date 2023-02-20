import 'package:demo_web/app/res/app_colors.dart';
import 'package:demo_web/app/res/app_dimens.dart';
import 'package:demo_web/domain/entities/knowledge/lesson_entity.dart';
import 'package:demo_web/presentations/screens/knowledge_manager_page/knowledge_manager_controller.dart';
import 'package:demo_web/presentations/widgets/snackbar/app_snack_bar.dart';
import 'package:demo_web/provider/knowledge_provider/lesson_storage_provider.dart';
import 'package:flutter/material.dart';

class EditLessonDialogWidget extends StatefulWidget {
  const EditLessonDialogWidget(
      {Key? key,
      this.lessonEntity,
      required this.lessonStorageProvider,
      required this.storageAction})
      : super(key: key);
  final LessonEntity? lessonEntity;
  final LessonStorageProvider lessonStorageProvider;
  final StorageAction storageAction;

  @override
  State<EditLessonDialogWidget> createState() => _EditLessonDialogWidgetState();
}

class _EditLessonDialogWidgetState extends State<EditLessonDialogWidget> {
  late final LessonEntity? _lessonEntity = widget.lessonEntity;

  StorageAction get _storageAction => widget.storageAction;

  LessonStorageProvider get _lessonStorageProvider =>
      widget.lessonStorageProvider;

  bool isInitialized = false;
  final TextEditingController _lessonKeyController = TextEditingController();
  final TextEditingController _lessonNameController = TextEditingController();
  final TextEditingController _lessonDataController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _lessonKeyController.text = _lessonEntity?.keyLesson ?? '';
    _lessonNameController.text = _lessonEntity?.nameLesson ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DataTable(
          columns: const [
            DataColumn(label: Text('LessonID', style: kTitleColumnStyle)),
            DataColumn(label: Text('LessonKey', style: kTitleColumnStyle)),
            DataColumn(label: Text('LessonName', style: kTitleColumnStyle)),
          ],
          rows: [
            DataRow(cells: [
              DataCell(
                  Text('${_lessonEntity?.idLesson}', style: kTitleRowStyle)),
              DataCell(TextField(
                  controller: _lessonKeyController, style: kTitleRowStyle)),
              DataCell(TextField(
                  controller: _lessonNameController, style: kTitleRowStyle)),
            ])
          ],
        ),
        const SizedBox(height: 24),
        Text('Lesson content'),
        const SizedBox(height: 12),
        TextField(
          controller: _lessonDataController,
          maxLines: 10,
        ),
        const SizedBox(height: 24),
        _storageAction == StorageAction.edit
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () => _onDelete(context),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Delete',
                          style: kButtonStyle.copyWith(color: Colors.white)),
                    ),
                    style:
                        OutlinedButton.styleFrom(backgroundColor: kErrorColor),
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  OutlinedButton(
                    onPressed: () => _onSave(context),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Save', style: kButtonStyle),
                    ),
                  )
                ],
              )
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

  void _onSave(BuildContext context) async {
    final LessonEntity editedLesson = LessonEntity(
        idLesson: _lessonEntity?.idLesson,
        keyLesson: _lessonKeyController.text,
        nameLesson: _lessonNameController.text,
        data: [_lessonDataController.text]);
    final result = await _lessonStorageProvider.updateLesson(editedLesson);
    if (result) {
      AppSnackBar.showCommonSnackBar(context,
          content: 'Edited successfully', state: SnackBarState.succeed);
    } else {
      AppSnackBar.showCommonSnackBar(context,
          content: 'An error has occurred', state: SnackBarState.error);
    }
    Navigator.pop(context, {'action': StorageAction.edit, 'result': result});
  }

  void _onAddedNew(BuildContext context) async {
    if (_lessonEntity != null) {
      _lessonEntity?.keyLesson = _lessonKeyController.text;
      _lessonEntity?.nameLesson = _lessonNameController.text;
      _lessonEntity?.data = [_lessonDataController.text];
      final result = await _lessonStorageProvider.addNewLesson(_lessonEntity!);
      if (result) {
        AppSnackBar.showCommonSnackBar(context,
            content: 'Added successfully', state: SnackBarState.succeed);
      } else {
        AppSnackBar.showCommonSnackBar(context,
            content: 'An error has occurred', state: SnackBarState.error);
      }
      Navigator.pop(context, {'action': StorageAction.add, 'result': result});
    }
  }

  void _onDelete(BuildContext context) async {
    if (_lessonEntity != null) {
      final result = await _lessonStorageProvider.deleteLesson(_lessonEntity!);
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
