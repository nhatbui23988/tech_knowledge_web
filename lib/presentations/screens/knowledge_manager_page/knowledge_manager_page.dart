import 'package:demo_web/app/config/route_config.dart';
import 'package:demo_web/app/res/app_colors.dart';
import 'package:demo_web/presentations/screens/knowledge_manager_page/knowledge_manager_controller.dart';
import 'package:demo_web/presentations/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KnowledgeManagerPage extends GetView<KnowledgeManagerController> {
  const KnowledgeManagerPage({Key? key}) : super(key: key);

  final TextStyle tabTitleStyle =
      const TextStyle(color: kPrimaryText, fontWeight: FontWeight.w500);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              backgroundColor: kPrimaryBackground,
              leading: const SizedBox.shrink(),
              title: const CustomAppBar(
                isLoggedIn: false,
                currentPage: PageName.knowledgeManager,
              ),
              bottom: TabBar(controller: controller.tabController, tabs: [
                Tab(
                    child: Text(
                  'Tab One',
                  style: tabTitleStyle,
                )),
                Tab(
                    child: Text(
                  'Tab Two',
                  style: tabTitleStyle,
                )),
              ]),
            ),
          ];
        },
        body: TabBarView(
          controller: controller.tabController,
          children: [
            const Center(child: const Text('Content of Tab One')),
            const Center(child: const Text('Content of Tab Two')),
          ],
        ),
      ),
    );
  }
}
