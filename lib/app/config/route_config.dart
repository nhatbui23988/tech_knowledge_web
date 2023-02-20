import 'package:demo_web/domain/entities/knowledge/lesson_entity.dart';
import 'package:demo_web/presentations/screens/home/home_page.dart';
import 'package:demo_web/presentations/screens/knowledge_manager_page/knowledge_manager_controller.dart';
import 'package:demo_web/presentations/screens/knowledge_manager_page/knowledge_manager_page.dart';
import 'package:demo_web/presentations/screens/lesson_view/lesson_view_page.dart';
import 'package:demo_web/presentations/screens/sign_in/sign_in_controller.dart';
import 'package:demo_web/presentations/screens/sign_in/sign_in_page.dart';
import 'package:demo_web/presentations/screens/sign_up/sign_up_controller.dart';
import 'package:demo_web/presentations/screens/sign_up/sign_up_page.dart';
import 'package:demo_web/presentations/screens/splash_screen.dart';
import 'package:demo_web/provider/local_storage_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum PageName {
  home,
  knowledgeManager,
  concept,
  lesson,
  construct,
  exercise,
  operator,
  lessonView,
}

class AppRoute {
  static const String homePage = '/home';
  static const String splashPage = '/splash';
  static const String addKnowledgePage = '/add-knowledge_provider';
  //
  static const String _auth = '/auth';
  static const String signUp = '$_auth/sign-up';
  static const String signIn = '$_auth/sign-in';

  static const String lessonViewPage = '/lesson-view-page';

  static Route onGenerateRoute(RouteSettings routeSettings) {
    String routeName = routeSettings.name ?? '';

    if (routeName.contains(splashPage)) {
      return MaterialPageRoute(builder: (_) => const SplashScreen());
    }

    if (routeName.contains(homePage)) {
      LocalStorageProviderImpl().setCurrentRoute(homePage);
      return MaterialPageRoute(builder: (_) => const MyHomePage());
    }
    if (routeName.contains(addKnowledgePage)) {
      LocalStorageProviderImpl().setCurrentRoute(addKnowledgePage);
      return GetPageRoute(
          page: () => const KnowledgeManagerPage(),
          binding: AddKnowledgeBinding());
    }

    if (routeName.contains(_auth)) {
      if (routeName.contains(signUp)) {
        return GetPageRoute(
            page: () => const SignUpPage(), binding: SignUpBinding());
      }

      if (routeName.contains(signIn)) {
        return GetPageRoute(
            page: () => const SignInPage(), binding: SignInBinding());
      }
    }

    if (routeName.contains(lessonViewPage)) {
      return MaterialPageRoute(
          builder: (_) => LessonViewPage(
                lesson: routeSettings.arguments as LessonEntity,
              ));
    }

    return MaterialPageRoute(
        settings: const RouteSettings(name: homePage),
        builder: (_) => const MyHomePage());
  }

  // static Map<String, Widget Function(BuildContext)> appRoute(
  //     BuildContext context) {
  //   Map<String, Widget Function(BuildContext)> map = {};
  //   map.addEntries(toRoute(homePage, const MyHomePage()).entries);
  //   map.addEntries(toRoute(lessonViewPage, const LessonViewPage()).entries);
  //   return map;
  // }

  // static Map<String, Widget Function(BuildContext)> toRoute(
  //     String route, Widget page,
  //     {VoidCallback? excute}) {
  //   if (excute != null) {
  //     excute();
  //   }
  //   LocalStorageProviderImpl().setCurrentRoute(route);
  //   return {
  //     route: (context) => page,
  //   };
  // }
}
