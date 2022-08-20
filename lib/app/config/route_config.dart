import 'package:demo_web/presentations/screens/home_page.dart';
import 'package:demo_web/presentations/screens/splash_screen.dart';
import 'package:demo_web/presentations/screens/unknown_page.dart';
import 'package:flutter/material.dart';

class AppRoute {

  static String homePagePath = '/home';
  static String splashPagePath = '/splash';

  static Route onGenerateRoute(RouteSettings routeSettings) {
    String routeName = routeSettings.name ?? '';

    if(routeName.contains('/splash')){
      return MaterialPageRoute(builder: (_) => const SplashScreen());
    }

    if(routeName.contains('/home')){
      return MaterialPageRoute(builder: (_) => const MyHomePage());
    }

    return MaterialPageRoute(builder: (_) => UnknownPage());
  }
}
