import 'package:demo_web/app/res/app_dimens.dart';
import 'package:demo_web/presentations/screens/knowledge_manager_page/tabs_knowledge/lesson_tab_page/lesson_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LessonTabPage extends GetView<LessonTabController> {
  const LessonTabPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: SingleChildScrollView(
          child: Obx(() => DataTable(
                sortColumnIndex: controller.rxSortIndex.value,
                sortAscending: controller.rxSortAscending.value,
                showBottomBorder: true,
                columns: [
                  DataColumn(
                      label: const Text('LessonID', style: kTitleColumnStyle),
                      onSort: controller.onSortChanged),
                  DataColumn(
                      label: const Text('LessonKey', style: kTitleColumnStyle),
                      onSort: controller.onSortChanged),
                  DataColumn(
                      label: const Text('LessonName', style: kTitleColumnStyle),
                      onSort: controller.onSortChanged),
                ],
                rows: List.generate(controller.rxListLesson.length, (index) {
                  final conceptEntity = controller.rxListLesson[index];
                  return DataRow(
                      cells: [
                        DataCell(Text(
                          '${conceptEntity.idLesson}',
                          style: kTitleRowStyle,
                        )),
                        DataCell(Text('${conceptEntity.keyLesson}',
                            style: kTitleRowStyle)),
                        DataCell(
                            Text('${conceptEntity.nameLesson}',
                                style: kTitleRowStyle),
                            showEditIcon: true),
                      ],
                      onLongPress: () {
                        controller.onEditLesson(context, index, conceptEntity);
                      });
                }),
              )),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.onAddLesson(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
