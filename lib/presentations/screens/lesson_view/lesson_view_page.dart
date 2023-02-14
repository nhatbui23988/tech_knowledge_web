import 'package:demo_web/app/res/app_dimens.dart';
import 'package:demo_web/domain/entities/knowledge/lesson_entity.dart';
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
            const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
              style: kTitleColumnStyle,
            ),
          ],
        ),
      ),
    );
  }
}
