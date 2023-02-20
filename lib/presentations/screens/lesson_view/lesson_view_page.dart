import 'package:demo_web/app/config/route_config.dart';
import 'package:demo_web/app/res/app_colors.dart';
import 'package:demo_web/app/res/app_dimens.dart';
import 'package:demo_web/domain/entities/knowledge/lesson_entity.dart';
import 'package:demo_web/presentations/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class LessonViewPage extends StatefulWidget {
  const LessonViewPage({Key? key, this.lesson}) : super(key: key);
  final LessonEntity? lesson;

  @override
  State<LessonViewPage> createState() => _LessonViewPageState();
}

class _LessonViewPageState extends State<LessonViewPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
        body: Container(
          padding: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: size.width > 800 ? (size.width - 800) / 2 : 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.lesson?.nameLesson ?? '',
                style: const TextStyle(fontSize: 30),
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                widget.lesson?.data?.first ?? 'Lesson has no content',
                style: kTitleColumnStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
