import 'package:demo_web/presentations/screens/home_page.dart';
import 'package:demo_web/presentations/screens/sign_up/sign_up_controller.dart';
import 'package:demo_web/presentations/screens/sign_up/sign_up_page.dart';
import 'package:demo_web/presentations/screens/splash_screen.dart';
import 'package:demo_web/presentations/screens/unknown_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppRoute {

  static const String homePagePath = '/home';
  static const String splashPagePath = '/splash';
  static const String _auth = '/auth';
  static const String signUp = '$_auth/sign-up';


  static Route onGenerateRoute(RouteSettings routeSettings) {
    String routeName = routeSettings.name ?? '';

    if(routeName.contains(splashPagePath)){
      return MaterialPageRoute(builder: (_) => const SplashScreen());
    }

    if(routeName.contains(homePagePath)){
      return MaterialPageRoute(builder: (_) => const MyHomePage());
    }

    if(routeName.contains(_auth)){
      if(routeName.contains(signUp)){
        return GetPageRoute(page: ()=>SignUpPage(), binding: SignUpBinding());
      }
    }

    return MaterialPageRoute(builder: (_) => const UnknownPage());
  }
}
