import 'dart:ui';

import 'package:demo_web/app/config/route_config.dart';
import 'package:demo_web/app/res/app_colors.dart';
import 'package:demo_web/app/res/app_dimens.dart';
import 'package:demo_web/domain/entities/knowledge/lesson_entity.dart';
import 'package:demo_web/presentations/screens/home/home_page_controller.dart';
import 'package:demo_web/presentations/widgets/custom_app_bar.dart';
import 'package:demo_web/res/app_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();

  static void showMe(BuildContext context) {
    Navigator.pushReplacementNamed(context, AppRoute.homePage);
  }
}

class _MyHomePageState extends State<MyHomePage> {
  final HomePageController controller = HomePageController();
  bool isLoadingImage = true;

  final GlobalKey key = GlobalKey();

  double? _dropdownPos;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 250), () {
      setState(() {
        isLoadingImage = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: controller.listSearchResult.isNotEmpty
            ? Colors.white
            : Colors.black,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              const SliverAppBar(
                pinned: true,
                backgroundColor: kPrimaryBackground,
                leading: SizedBox.shrink(),
                title: CustomAppBar(
                  isLoggedIn: false,
                  currentPage: PageName.home,
                ),
              ),
            ];
          },
          body: SizedBox.expand(
            child: SingleChildScrollView(
              controller: controller.homeScrollController,
              child: Column(
                children: [
                  AnimatedOpacity(
                    opacity: isLoadingImage ? 0.1 : 1,
                    duration: const Duration(milliseconds: 200),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.transparent,
                      alignment: Alignment.center,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          // original img
                          Image(
                            width: MediaQuery.of(context).size.width,
                            image: AppImages.imgHomeBg1,
                            fit: BoxFit.fitWidth,
                          ),
                          // faded effect
                          BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: .5),
                            child: Container(
                              color: Colors.black.withOpacity(0.1),
                              alignment: Alignment.center,
                              // to get size equal original img
                              child: Image(
                                width: MediaQuery.of(context).size.width,
                                image: AppImages.imgHomeBg1,
                                fit: BoxFit.fitWidth,
                                color: Colors.transparent,
                              ),
                            ),
                          ),

                          /// Content
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 20),
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width / 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height / 4),
                                const Text(
                                  'Easy learning',
                                  style: TextStyle(
                                      fontSize: 60,
                                      color: kSecondaryText,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Helvetica'),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  'Search lesson about technology, definitions, operators, \nexample exercises to absorb knowledge_provider more easily.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20, color: kSecondaryText),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Container(
                                      height: 48,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 80),
                                      child: TextFormField(
                                        controller:
                                            controller.searchTextController,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(36)),
                                            fillColor: Colors.white,
                                            filled: true,
                                            hintText: 'Search lesson you want',
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(36)),
                                            hintStyle: TextStyle(
                                                color: kPrimaryText
                                                    .withOpacity(0.5)),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 24),
                                            suffixIcon: InkWell(
                                              onTap: () {
                                                // search
                                                controller.onSearch(context);
                                              },
                                              child: Container(
                                                height: kToolbarHeight,
                                                width: 70,
                                                decoration: const ShapeDecoration(
                                                    color: kButtonColor,
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        36),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        36)))),
                                                child: const Icon(
                                                  Icons.search_rounded,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )),
                                      ),
                                    ))
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  //Lesson search result
                  Visibility(
                    visible: controller.listSearchResult.isNotEmpty,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        LayoutBuilder(builder: (context, cons) {
                          return Wrap(
                            runSpacing: 10,
                            spacing: 10,
                            children: List.generate(
                                controller.listSearchResult.length,
                                (index) => _buildLessonItemWidget(
                                    cons.maxWidth / 4,
                                    controller.listSearchResult[index])),
                          );
                        }),
                        const SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildLessonItemWidget(double width, LessonEntity lesson) {
    return InkWell(
      onTap: () {
        //view lesson
        Navigator.pushReplacementNamed(context, AppRoute.lessonViewPage,
            arguments: lesson);
      },
      child: Container(
        width: width,
        height: width * 0.7,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5)),
        child: Center(
            child: Text(
          lesson.nameLesson ?? 'Undefine name',
          style: kButtonStyle,
        )),
      ),
    );
  }
}
