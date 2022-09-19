import 'package:demo_web/app/res/app_dimens.dart';
import 'package:demo_web/presentations/screens/knowledge_manager_page/tabs_knowledge/concept_tab_page/concept_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//   int? idConcept;
//   int? idLesson;
//   String? linkConcept;
//   String? nameConcept;
class ConceptTabPage extends GetView<ConceptTabController> {
  const ConceptTabPage({Key? key}) : super(key: key);

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
                      label: const Text('ConceptID', style: kTitleColumnStyle),
                      onSort: controller.onSortChanged),
                  DataColumn(
                      label: const Text('LessonID', style: kTitleColumnStyle),
                      onSort: controller.onSortChanged),
                  DataColumn(
                      label: const Text('ConceptLink', style: kTitleColumnStyle),
                      onSort: controller.onSortChanged),
                  DataColumn(
                      label: const Text('ConceptName', style: kTitleColumnStyle),
                      onSort: controller.onSortChanged),
                ],
                rows: List.generate(controller.rxListConcept.length, (index) {
                  final conceptEntity = controller.rxListConcept[index];
                  return DataRow(cells: [
                    DataCell(Text(
                      '${conceptEntity.idConcept}',
                      style: kTitleRowStyle,
                    )),
                    DataCell(Text('${conceptEntity.idLesson}',
                        style: kTitleRowStyle)),
                    DataCell(Text('${conceptEntity.linkConcept}',
                        style: kTitleRowStyle)),
                    DataCell(
                        Text('${conceptEntity.nameConcept}',
                            style: kTitleRowStyle),
                        showEditIcon: true),
                  ], onLongPress: (){
                    controller.onEditConcept(context, index, conceptEntity);
                  });
                }),
              )),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>controller.onAddConcept(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
